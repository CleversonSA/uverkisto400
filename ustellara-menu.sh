#! /bin/bash

#*************************************
# GLOBAL VARIABLES
#*************************************
MA_MENU_ST_REC="Start receiver"
MA_MENU_MP3="Start MP3 Player"
MA_MENU_BT_DEV="Bluetooth devices"
MA_MENU_NB_UTILS="Network/BT Utils"
MA_MENU_AOFF="Auto power off"
MA_MENU_SHUT="Shutdown"
MA_MENU_EXIT="Exit"

AO_MENU_CANCEL="Cancel timer"

NB_MENU_SH_IP="Show IP"
NB_MENU_RF_ST="RF status"
NB_MENU_WI_EN="Enable Wireless"
NB_MENU_WI_DI="Disable Wireless"
NB_MENU_BT_EN="Enable Bluetooth"
NB_MENU_BT_DI="Disable Bluetooth"

BT_DEV_1_NAME="Mi BT Speaker"
BT_DEV_1_MAC="FC:58:FA:37:DF:5C"
BT_DEV_1_SINK="bluez_sink.FC_58_FA_37_DF_5C.a2dp_sink"

BT_DEV_2_NAME="Mi Air Dots"
BT_DEV_2_MAC="1C:52:16:A6:5D:A6"
BT_DEV_2_SINK="bluez_sink.1C_52_16_A6_5D_A6.a2dp_sink"



#*************************************
# CUSTOM BT DEVICES
#*************************************
connect_device () {
 
  clear  
  pactl unload-module module-bluetooth-discover
  pactl load-module module-bluetooth-discover
  sleep 1
  bluetoothctl connect $1
  sleep 1
  pactl set-default-sink $2

  sleep 10
}



#*************************************
# AUTO POWER OFF
#*************************************
cancel_timer () {

  clear
  sudo shutdown -c --no-wall
  echo "Shutdown cancelled"
  sleep 5

}

create_timer () {

  clear

  cancel_timer

  sudo shutdown -h $1 --no-wall

  sleep 5

}


#*************************************
# SUBMENUS
#*************************************
nb_utils_menu () {
  
  local OPT=''

  while [ "${OPT}" != "7" ]
  do
  	OPT=$(dialog --menu "${MA_MENU_NB_UTILS}" 20 35 15 \
		1 "${NB_MENU_RF_ST}" \
		2 "${NB_MENU_WI_EN}" \
		3 "${NB_MENU_WI_DI}" \
		4 "${NB_MENU_BT_EN}" \
		5 "${NB_MENU_BT_DI}" \
		6 "${NB_MENU_SH_IP}" \
		7 "${MA_MENU_EXIT}" \
		--stdout)
	
	case "${OPT}" in


		"1")
			clear
			sudo rfkill
			sleep 5
			;;
		"2")
			clear
			sudo rfkill unblock wlan
			sleep 5
			;;
		"3")	
			clear
			sudo rfkill block wlan
			sleep 5
			;;
		"4")	
			clear
			sudo rfkill unblock bluetooth
			sleep 5
			;;
		"5")    
			clear
			sudo rfkill block bluetooth
			sleep 5
			;;
		"6")
			sh_ip
			;;
		*)
			break
			;;
	esac


  done



}

aoff_menu () {
  
  local OPT=''

  while [ "${OPT}" != "10" ]
  do
  	OPT=$(dialog --menu "${MA_MENU_AOFF}" 20 35 15 \
		1 "${AO_MENU_CANCEL}" \
		2 "10 min" \
		3 "30 min" \
		4 "60 min" \
		5 "90 min" \
		6 "120 min" \
		10 "${MA_MENU_EXIT}" \
		--stdout)
	
	case "${OPT}" in


		"1")
			cancel_timer
			;;
		"2")
			create_timer 10
			;;
		"3")	
			create_timer 30
			;;
		"4")	
			create_timer 60
			;;
		"5")    
			create_timer 90
			;;
		"6")
			create_timer 120
			;;
		*)
			break
			;;
	esac


  done



}

bt_devices_menu () {
  
  local OPT=''

  while [ "${OPT}" != "3" ]
  do
  	OPT=$(dialog --menu "${MA_MENU_BT_DEV}" 20 35 15 \
		1 "${BT_DEV_1_NAME}" \
		2 "${BT_DEV_2_NAME}" \
		3 "${MA_MENU_EXIT}" \
		--stdout)
	
	case "${OPT}" in

		"1")
			connect_device ${BT_DEV_1_MAC} ${BT_DEV_1_SINK}
			;;
		"2")
			connect_device ${BT_DEV_2_MAC} ${BT_DEV_2_SINK}
			;;
		*)
			break
			;;
	esac


  done



}

st_receiver() {
  ustellara ${USTELLARA_OPTS}
}

sh_ip() { 
  clear
  ifconfig | more
  sleep 10
}

#*************************************
# MAIN MENU
#*************************************
main_menu () {
  
  local OPT=''

  while [ "${OPT}" != "7" ]
  do
  	OPT=$(dialog --menu "Ustellara Launch Menu" 20 35 15 \
		1 "${MA_MENU_ST_REC}" \
		2 "${MA_MENU_MP3}" \
		3 "${MA_MENU_BT_DEV}" \
		4 "${MA_MENU_NB_UTILS}"  \
		5 "${MA_MENU_AOFF}" \
		6 "${MA_MENU_SHUT}" \
		7 "${MA_MENU_EXIT}" \
		--stdout)
	
	case "${OPT}" in

		"1")
			st_receiver
			;;
		"2")
			cd ~/Music
			cmus
			;;
		"3")
			bt_devices_menu
			;;
		"4")
			nb_utils_menu
			;;
		"5")
			aoff_menu
			;;
		"6")
			sudo shutdown -h now
			;;
		*)
			break
			;;
	esac


  done

  clear

}

main_menu

