#! /bin/bash

# This is a currency clock client for https://currencybeacon.com
# you need create a token to use is
#
#
CB_AMOUNT_BASE_URL="https://api.currencybeacon.com/v1/convert"

if [ "$CB_TOKEN" == "" ]; then
   echo "You have to set yout Currency Beacon token in CB_TOKEN enviroment variable!"
   exit -1
fi

if [ ! -e "/bin/dialog" ]; then

    echo "Dialog utility not found!"
    echo "Please install dialog package before"
    exit -1

fi

if [ ! -e "/usr/bin/tty-clock" ]; then

   echo "tty-clock not found!"
   echo "Please install tty-clock package first"
   exit -1

fi

if [ "$1" == "--update" ] || [ "$1" == "-u" ]; then

		 rm -f /tmp/cb-updated.lock
		 curl -H "Authorization: Bearer ${CB_TOKEN}" "${CB_AMOUNT_BASE_URL}?from=BTC&to=USD&amount=1.0" -o /tmp/cb-btc-usd.tmp
 		 curl -H "Authorization: Bearer ${CB_TOKEN}" "${CB_AMOUNT_BASE_URL}?from=USD&to=BRL&amount=1.0" -o /tmp/cb-usd-brl.tmp
		 curl -H "Authorization: Bearer ${CB_TOKEN}" "${CB_AMOUNT_BASE_URL}?from=DOGE&to=USD&amount=1.0" -o /tmp/cb-doge-usd.tmp
		 curl -H "Authorization: Bearer ${CB_TOKEN}" "${CB_AMOUNT_BASE_URL}?from=ETH&to=USD&amount=1.0" -o /tmp/cb-eth-usd.tmp

 
		 touch /tmp/cb-updated.lock
		 exit -1

fi


while [ 1 == 1 ];
do

	  if [ -e "/tmp/cb-updated.lock" ]; then

			BTC_VALUE=`jq .response.value /tmp/cb-btc-usd.tmp`
		  USD_VALUE=`jq .response.value /tmp/cb-usd-brl.tmp`
			DOGE_VALUE=`jq .response.value /tmp/cb-doge-usd.tmp`
			ETH_VALUE=`jq .response.value /tmp/cb-eth-usd.tmp`

    	REPORT="\n1 BTC = "$( printf "%.2f" ${BTC_VALUE})" USD\n"
			REPORT=${REPORT}"\n1 USD = "$( printf "%.2f" ${USD_VALUE})" BRL\n"
			REPORT=${REPORT}"\n1 DOGE = "$( printf "%.5f" ${DOGE_VALUE})" USD\n"
 			REPORT=${REPORT}"\n1 ETH = "$( printf "%.2f" ${ETH_VALUE})" USD\n\n"

    
    	/bin/dialog --stdout \
            --title 'Currency status' \
            --infobox "${REPORT}" \
            0 0

			sleep 10
			reset
			clear

		fi

		timeout --foreground 30 /bin/tty-clock -Sc
		sleep  1
 
done
