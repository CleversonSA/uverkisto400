#! /bin/bash

if [ ! -e "/bin/dialog" ]; then

    echo "Dialog utility not found!"
    echo "Please install dialog package before"
    exit -1

fi

if [ ! -e "/bin/vim" ]; then

    echo "VIM not found!"
    echo "Please install vim first!"
    exit -1

fi

if [ ! -e "./daily_notes" ]; then

    echo "Daily notes folder not found, creating then..."
    mkdir ./daily_notes

fi


while [ 1 == 1 ]
do

AVAILABLE_NOTES=`ls ./daily_notes/ -a | awk '{ print $0,NR-2; }' | tail -n +3`

sleep 2
MAIN_MENU=`/bin/dialog  \
            --title 'Daily notes' \
            --menu 'Available notes' \
            0 0 0 \
	    "new" '(New daily note)' \
	    "clear" '(Remove temp files)' \
            ${AVAILABLE_NOTES} \
            "exit" 'Quit App' 2>&1 > /dev/tty` 
clear


if [ "$MAIN_MENU" == "exit" ] || [ "$MAIN_MENU" == "cancel" ] || [ "$MAIN_MENU" == "" ]; then

    /bin/dialog --stdout \
            --title 'Daily notes' \
            --infobox '\nBye!' \
            0 0

    /bin/sleep 1
    
    clear
    exit 0
    
fi

if [ "$MAIN_MENU" == "clear" ]; then

	/bin/dialog --title 'Clear' \
		--infobox '\nCleaning temporary files...\n' \
		0 0
	/bin/sleep 1
	rm -f ./daily_notes/.*.swp
	clear
	continue
fi


if [ "$MAIN_MENU" == "new" ]; then

	CURRENT_DATE_FILE=`date +"%b-%d-%y.txt"`

	/bin/dialog --stdout \
            --title 'Creating new file' \
            --infobox '\nWait...' \
            0 0
	/bin/sleep 1

	/bin/vim ./daily_notes/$CURRENT_DATE_FILE

	clear
	continue

fi


/bin/vim ./daily_notes/$MAIN_MENU

clear
done
