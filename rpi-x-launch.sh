#! /bin/bash

if [ ! -e "/bin/dialog" ]; then

    echo "Dialog utility not found!"
    echo "Please install dialog package before"
    exit -1

fi


while [ 1 == 1 ];
do

AVAILABLE_SCRIPTS=`ls ./user-scripts -a | grep ".sh" | awk '{ print $0,NR; }'`

sleep 2
MAIN_MENU=`/bin/dialog  \
            --title 'X Autolaunch menu' \
            --menu 'User scripts' \
            0 0 0 \
            ${AVAILABLE_SCRIPTS} \
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

clear
echo "Preparing autolaunch..."
rm -f ~/.config/lxsession/LXDE-pi/autostart
echo ${PWD}/user-scripts/$MAIN_MENU > ~/.config/lxsession/LXDE-pi/autostart
echo ${PWD}/rpi-x-watchdog.sh $MAIN_MENU >> ~/.config/lxsession/LXDE-pi/autostart

startx
clear
done
