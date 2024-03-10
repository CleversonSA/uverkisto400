#! /bin/bash

if [ ! -e "/bin/dialog" ]; then

    echo "Dialog utility not found!"
    echo "Please install dialog package before"
    exit -1

fi


while [ 1 == 1 ]
do

sleep 2
MAIN_MENU=`/bin/dialog  \
            --title 'Builin Web SDR' \
            --menu 'Commands' \
            0 0 0 \
            "A" "Install server" \
	    "B" "Start server" \
	    "C" "Stop server" \
	    "D" "Remove server" \
            "exit" 'Quit app' 2>&1 > /dev/tty` 
clear

if [ "$MAIN_MENU" == "A" ]; then

   /bin/dialog --stdout \
	   --title 'Web SDR' \
	   --infobox 'Server will be installed!' \
	   0 0
   /bin/sleep 1

   clear
   ./install-sdr.sh

fi

if [ "$MAIN_MENU" == "B" ]; then

  /bin/dialog --stdout \
	 --title 'Web SDR' \
  	 --infobox 'Starting Web SDR at port 8086' \
	 0 0
  /bin/sleep 1

  clear
  ./start-sdr.sh
fi


if [ "$MAIN_MENU" == "C" ]; then

  /bin/dialog --stdout \
	  --title 'Web SDR' \
  	  --infobox 'Stopping Web SDR' \
	  0 0
  /bin/sleep 1

  clear
  ./stop-sdr.sh

fi


if [ "$MAIN_MENU" == "D" ]; then

  /bin/dialog --stdout \
	  --title 'Web SDR' \
  	  --infobox 'Removing the server instance!' \
	  0 0
   /bin/sleep 1

   clear
  ./remove-sdr.sh
fi


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
done
