#! /bin/bash
#
if [ ! -e "/bin/docker" ]; then
   
   echo "Docker not found! Install it first!"
   exit -1

fi

docker stop uverkisto-webrx
docker rm uverkisto-webrx

/bin/sleep 2

exit 0
