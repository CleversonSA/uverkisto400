#! /bin/bash

if [ ! -e "/bin/cvt" ]; then

    echo "No xcvt package found! Install it first!"
    exit -1

fi

CMD1=`/bin/cvt 600 1024 60 | tail -n 1 | sed "s/Modeline/sudo xrandr --newmode /"`
CMD2=`/bin/cvt 600 1024 60 | tail -n 1 | awk -F ' ' '{ print $2 }'`
CMD3="sudo xrandr --addmode Virtual1 "${CMD2}

$CMD1
$CMD3

exit 0