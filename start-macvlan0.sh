#!/usr/bin/bash

LOG=/home/geoff/bin/start-macvlan0.log

date > $LOG
echo $1 $2 >> $LOG

sudo /home/geoff/bin/start-macvtap.sh

exit 0


interface=$1
event=$2

if [[ $interface != "eno1" ]] || [[ $event != "up" ]]; then
  exit 0
fi

# place your commands bellow this line
