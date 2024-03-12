#! /bin/bash
#
if [ ! -e "/bin/docker" ]; then
   
   echo "Docker not found! Install it first!"
   exit -1

fi

docker start uverkisto-webrx

echo "Checking container status..."
DOCKER_CONTAINER_RUNNING=`docker ps | grep uverkisto-webrx`
if [ "$DOCKER_CONTAINER_RUNNING" == "" ]; then

   /bin/dialog --title 'Install error' \
           --msgbox 'It was not possible to run openwebrx container,\n please check docker settings!' \
          0 0
   clear
   exit -1

fi

/bin/dialog --title 'SDR Server' \
	--infobox 'Server running...' \
	0 0
/bin/sleep 2

clear
exit 0
