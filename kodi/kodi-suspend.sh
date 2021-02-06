#! /bin/sh

echo 0 > /sys/class/rtc/rtc0/wakealarm
echo $1 > /sys/class/rtc/rtc0/wakealarm

exit 0



systemctl stop tvheadend
sleep 1
modprobe -r saa7164
sleep 1 

rtcwake -m mem -t $1

sleep 1
modprobe saa7164
sleep 1
systemctl start tvheadend
sleep 1
