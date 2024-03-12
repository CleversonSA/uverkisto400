#! /bin/bash
#
if [ ! -e "/bin/docker" ]; then
   
   echo "Docker not found! Install it first!"
   exit -1

fi

echo "Installing openwebrx docker container..."
docker run --device /dev/bus/usb \
        -p 8086:8073 \
        -v "${PWD}/:/var/lib/openwebrx/" \
        -d \
        --restart no \
        --name uverkisto-webrx \
        --memory=256M \
        jketterl/openwebrx:stable
docker start uverkisto-webrx


echo "Checking container status..."
DOCKER_CONTAINER_RUNNING=`docker ps | grep uverkisto-webrx`
if [ "$DOCKER_CONTAINER_RUNNING" == "" ]; then
  
   /bin/dialog --title 'Install error' \
	   --msgbox 'It was not possible to install and run openwebrx container, please check docker settings!' \
   	  0 0
   clear 
   exit -1
   
fi

echo "Adding administrator user..."
ADMIN_USER_STATUS=`docker exec -t uverkisto-webrx ./openwebrx.py admin listusers | grep uverkisto`
if [ "$ADMIN_USER_STATUS" == "" ]; then

   echo "Creating uverkisto user..."
   /bin/sleep 1
   docker exec -i -t uverkisto-webrx ./openwebrx.py admin adduser uverkisto

else

   echo "Resetting uverkisto password..."
   /bin/sleep 1
   docker exec -i -t uverkisto-webrx ./openwebrx.py admin resetpassword uverkisto

fi

echo "Checking uverkisto user..."
ADMIN_USER_CREATED=`docker exec -t uverkisto-webrx ./openwebrx.py admin listusers | grep uverkisto`
if [ "$ADMIN_USER_CREATED" == "" ]; then

   /bin/dialog --title 'Install error' \
           --msgbox 'It was not possible to create the\nadmin user, please try again!!' \
          0 0
   clear 
   exit -1

fi



echo "Done"

/bin/sleep 2
exit 0

