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
		 curl -H "Authorization: Bearer ${CB_TOKEN}" "${CB_AMOUNT_BASE_URL}?from=EUR&to=BRL&amount=1.0" -o /tmp/cb-eur-brl.tmp
 
		 touch /tmp/cb-updated.lock
		 exit -1

fi


DASHBOARD_NUM=0
INDEXBVMF_COUNT=9
INDEXBVMF=( \
	"^BVSP" \
	"^DJI" \
  "BBAS3.SA" \
  "BHIA3.SA" \
	"MGLU3.SA" \
	"PBR-A" \
	"BTC-USD" \
  "USDBRL=X" \
	"SHIB-USD" \
)

while [ 1 == 1 ];
do

	if [ $DASHBOARD_NUM -eq 0 ]; then
	  if [ -e "/tmp/cb-updated.lock" ]; then

			BTC_VALUE=`jq .response.value /tmp/cb-btc-usd.tmp`
		  USD_VALUE=`jq .response.value /tmp/cb-usd-brl.tmp`
			DOGE_VALUE=`jq .response.value /tmp/cb-doge-usd.tmp`
			ETH_VALUE=`jq .response.value /tmp/cb-eth-usd.tmp`
			EUR_VALUE=`jq .response.value /tmp/cb-eur-brl.tmp`

    	REPORT="\n1 BTC = "$( printf "%.2f" ${BTC_VALUE})" USD\n"
			REPORT=${REPORT}"\n1 USD = "$( printf "%.2f" ${USD_VALUE})" BRL\n"
			REPORT=${REPORT}"\n1 EUR = "$( printf "%.2f" ${EUR_VALUE})" BRL\n"
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

  else
		
		let "INDEXBVMF_POS=0"
		let "INDEXBVMF_POS = DASHBOARD_NUM - 1"

		${HOME}/go/bin/stonks ${INDEXBVMF[$INDEXBVMF_POS]} -W 45
		sleep 15
		clear

	fi


	timeout --foreground 30 /bin/tty-clock -Sc
	sleep  1
 
  let "DASHBOARD_NUM = DASHBOARD_NUM + 1"

	if [ $DASHBOARD_NUM -eq $INDEXBVMF_COUNT ]; then
	
		let "DASHBOARD_NUM=0"

	fi

done
