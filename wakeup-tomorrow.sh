#!/bin/sh

ALARM=/sys/class/rtc/rtc0/wakealarm

if [ "$1" != "info" ]; then
sleep 5
echo 0 > $ALARM
date '+%s' -d "tomorrow 5:50" > $ALARM
fi

#systemctl status wakeup-tomorrow.service

#journalctl -u wakeup-tomorrow.service -b

cat $ALARM

