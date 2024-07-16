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

if [ ! -e "/bin/cmatrix" ]; then

   echo "CMatrix not found!"
   echo "Please install cmatrix command package first"
   exit -1

fi

if [ ! -e "/usr/bin/tty-clock" ]; then
   echo "tty-clock not found!"
   echo "Please install tty-clock package first"
   exit -1
fi

if [ ! -e "/bin/cmus" ]; then
   
   echo "CMUS not found!"
   echo "Please install cmus package first"
   exit -1

fi

while [ 1 == 1 ]
do

sleep 2
MAIN_MENU=`/bin/dialog  \
            --title 'uVerkisto Menu' \
            --menu 'Shortcuts' \
            0 0 0 \
            "A" "Midnight commander" \
	    "B" "Config changes" \
	    "C" "Bluetooth menu" \
	    "D" "Start X session" \
	    "E" "Daily notes" \
	    "F" "Music player" \
	    "G" "SDR Server" \
	    "H" "SDR Receiver" \
      "I" "Launch X app" \
			"J" "Currency clock" \
			"V" "Custom scripts launcher" \
	    "W" "Clock" \
	    "X" "Cmatrix" \
	    "Y" "Reboot system" \
	    "Z" "Shutdown system" \
            "exit" 'Quit to console' 2>&1 > /dev/tty` 
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


/bin/dialog --stdout \
            --title 'Initializing' \
            --infobox '\nPlease wait...' \
            0 0
/bin/sleep 1


if [ "$MAIN_MENU" == "A" ]; then

   /bin/mc

fi

if [ "$MAIN_MENU" == "B" ]; then

   ./rpi-config-changer.sh

fi

if [ "$MAIN_MENU" == "C" ]; then

   ./rpi-bt-menu.sh

fi

if [ "$MAIN_MENU" == "D" ]; then

   rm -f ~/.config/lxsession/LXDE-pi/autostart
   startx

fi

if [ "$MAIN_MENU" == "E" ]; then

   ./daily-notes.sh

fi

if [ "$MAIN_MENU" == "F" ]; then

   /bin/cmus

fi

if [ "$MAIN_MENU" == "G" ]; then

   cd ${PWD}/openwebrx-builtin
   ./startup.sh
   cd ..

fi

if [ "$MAIN_MENU" == "H" ]; then

   rm -f /tmp/data.tmp

   if [ ! -e "/bin/espeak" ]; then
	   
       /usr/local/bin/ustellara -e /tmp/data.tmp

   else

       /usr/local/bin/ustellara -v 100 -e /tmp/data.tmp

   fi

fi


if [ "$MAIN_MENU" == "I" ]; then

   rm -f ~/.config/lxsession/LXDE-pi/autostart
   ./rpi-x-launch.sh

fi

if [ "$MAIN_MENU" == "J" ]; then

		./rpi-cb-clock.sh --update
    ./rpi-cb-clock.sh

fi

if [ "$MAIN_MENU" == "V" ]; then

   ./rpi-launcher.sh

fi

if [ "$MAIN_MENU" == "W" ]; then

   /usr/bin/tty-clock -Sc 

fi

if [ "$MAIN_MENU" == "X" ]; then

   /bin/cmatrix

fi

if [ "$MAIN_MENU" == "Y" ]; then

   sudo reboot

fi

if [ "$MAIN_MENU" == "Z" ]; then

   sudo shutdown -h now

fi


clear
done
