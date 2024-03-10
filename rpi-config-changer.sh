#! /bin/bash

if [ ! -e "/bin/dialog" ]; then

    echo "Dialog utility not found!"
    echo "Please install dialog package before"
    exit -1

fi

if [ ! -e "/bin/mc" ]; then
   
   echo "Midnight commander not found!"
   echo "Please install midnight command package first"
   exit -1
fi

if [ ! -e "./available-configs" ]; then

    echo "Configs folder not found, creating then..."
    mkdir ./available-configs
    mkdir ./available-configs/default
    mkdir ./available-configs/35tcdspi
    mkdir ./current-config

fi

if [ ! -e "./available-configs/default/config.txt" ]; then
   
    echo "No configs yet, backuping the current config..."
    cp -r -f /boot/firmware/config.txt ./available-configs/default
    cp -r -f /boot/firmware/cmdline.txt ./available-configs/default
    cp -r -f /boot/firmware/config.txt ./current-config
    cp -r -f /boot/firmware/cmdline.txt ./current-config

fi

AVAILABLE_CONFIGS=`ls ./available-configs/ -a | awk '{ print $0,NR-2; }' | tail -n +3`

sleep 2
MAIN_MENU=`/bin/dialog  \
            --title 'RPi Config change' \
            --menu 'Available configs' \
            0 0 0 \
            ${AVAILABLE_CONFIGS} \
            exit 'No changes' 2>&1 > /dev/tty` 
clear

if [ "$MAIN_MENU" == "exit" ] || [ "$MAIN_MENU" == "cancel" ] || [ "$MAIN_MENU" == "" ]; then

    /bin/dialog --stdout \
            --title 'Info' \
            --infobox '\nNothing will be changed!' \
            0 0

    /bin/sleep 1
    
    clear
    exit 0
    
fi


sudo rm -rf ./current-config/*
sudo cp -r -f ./available-configs/$MAIN_MENU/cmdline.txt /boot/firmware/cmdline.txt
sudo cp -r -f ./available-configs/$MAIN_MENU/config.txt /boot/firmware/config.txt
sudo cp -r -f ./available-configs/$MAIN_MENU/cmdline.txt ./current-config/cmdline.txt
sudo cp -r -f ./available-configs/$MAIN_MENU/config.txt ./current-config/config.txt


/bin/dialog --stdout \
            --title 'Changes applyied' \
            --infobox '\nRPI will be rebooted...' \
            0 0
/bin/sleep 5

sudo reboot
