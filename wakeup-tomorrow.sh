#!/bin/sh

ALARM=/sys/class/rtc/rtc0/wakealarm

echo 0 > $ALARM
date '+%s' -d "tomorrow 5:50" > $ALARM
cat $ALARM

