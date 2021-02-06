#! /bin/sh

date > /home/muse/bin/kodi-shutdown.log
sync.sh

exit 0

sudo systemctl stop tvheadend
sleep 1
sudo modprobe -r saa7164

exit 0

echo 0 > /sys/class/rtc/rtc0/wakealarm
#echo $1 > /sys/class/rtc/rtc0/wakealarm

case "$2" in
    1)
        #shutdown -h now "TVHManager shutdown the system"
        modprobe -r saa7164
        sleep 1 

        rtcwake -m mem -t $1

        sleep 1
        modprobe saa7164
    ;;
esac
sleep 1
exit 0
