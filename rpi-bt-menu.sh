#! /bin/bash

if [ ! -e "/bin/dialog" ]; then

    echo "Dialog utility not found!"
    echo "Please install dialog package before"
    exit -1

fi

if [ ! -e "/bin/bluetoothctl" ]; then
   
   echo "Bluetooth Control  not found!"
   echo "Please install bluetoothctl package first"
   exit -1
fi


if [ ! -e "/bin/expect" ]; then
   
   echo "Expect package not found!"
   echo "Please install expect package first"
   exit -1
fi


if [ ! -e "./available-bt-devices" ]; then

    echo "Configs folder not found, creating then..."
    mkdir ./available-bt-devices

fi

while [ 1 == 1 ];
do

AVAILABLE_BT_DEVICES=`ls ./available-bt-devices -a | grep ".sh" | awk '{ print $0,NR; }'`

sleep 2
MAIN_MENU=`/bin/dialog  \
            --title 'Bluetooth menu' \
            --menu 'Registered devices' \
            0 0 0 \
            scan 'Search for new devices' \
            disable 'Disable bluetooth' \
            enable 'Enable bluetooth' \
            ${AVAILABLE_BT_DEVICES} \
            exit 'Quit app' 2>&1 > /dev/tty` 
clear

if [ "$MAIN_MENU" == "exit" ] || [ "$MAIN_MENU" == "cancel" ] || [ "$MAIN_MENU" == "" ]; then

    /bin/dialog --stdout \
            --title 'Info' \
            --infobox '\nBye!' \
            0 0

    /bin/sleep 1
    
    clear
    exit 0
    
fi

if [ "$MAIN_MENU" == "disable" ]; then

    /bin/dialog --stdout \
            --title 'Bluetooth' \
            --infobox '\nDisabling bluetooth...' \
            0 0

    /bin/sleep 1

    sudo rfkill block bluetooth

    clear
    
fi

if [ "$MAIN_MENU" == "enable" ]; then

    /bin/dialog --stdout \
            --title 'Bluetooth' \
            --infobox '\nEnabling bluetooth...' \
            0 0

    /bin/sleep 1

    sudo rfkill unblock bluetooth
    
    clear
    
fi


if [ "$MAIN_MENU" == "scan" ]; then
    
    clear

    /bin/bluetoothctl scan on
    /bin/bluetoothctl scan off
    
    continue
    
fi

./available-bt-devices/$MAIN_MENU

clear
done
