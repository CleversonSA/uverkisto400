#! /bin/bash

if [ ! -e "/bin/dialog" ]; then

    echo "Dialog utility not found!"
    echo "Please install dialog package before"
    exit -1

fi

if [ ! -e "/bin/cmus" ]; then

    echo "CMus not found!"
    echo "Please install cmus first!"
    exit -1

fi

/bin/cmus-remote -C clear
/bin/cmus-remote -C "add ~/Music"
/bin/cmus-remote -C "update-cache -f"

exit 0
