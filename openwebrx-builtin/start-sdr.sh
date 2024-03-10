#! /bin/bash
#
if [ ! -e "/bin/docker" ]; then
   
   echo "Docker not found! Install it first!"
   exit -1

fi

docker start uverkisto-webrx

docker ps 

/bin/sleep 2

exit 0
