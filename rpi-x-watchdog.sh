#! /bin/bash

while [ 1 == 1  ];
do
    PROCESS_CMD=`ps -ef | grep ${1} | grep -v grep | grep -v rpi-x-watchdog.sh`
    /bin/sleep 2
    if [ "$PROCESS_CMD" == "" ]; then

        echo "Closing X Session.."
        
        pkill -15 x

        exit 0

    fi 
done