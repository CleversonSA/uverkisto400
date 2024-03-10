#! /bin/bash
#
if [ ! -e "/bin/docker" ]; then
   
   echo "Docker not found! Install it first!"
   exit -1

fi

docker run --device /dev/bus/usb \
        -p 8085:8073 \
        -v "${PWD}/:/var/lib/openwebrx/" \
        -d \
        --restart no \
        --name uverkisto-webrx \
        --memory=256M \
        jketterl/openwebrx:stable
