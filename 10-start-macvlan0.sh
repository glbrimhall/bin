#!/usr/bin/bash

interface=$1
event=$2

LOG=/home/geoff/bin/start-macvlan.log

date >> $LOG
echo $1 $2 >> $LOG

if [[ $interface != "eno1" ]] || [[ $event != "up" ]]; then
  exit 0
fi

# place your commands bellow this line
sudo /home/geoff/bin/start-macvtap.sh
