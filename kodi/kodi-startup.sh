#! /bin/sh

date > /home/muse/bin/kodi-startup.log
sync

exit 0

sudo modprobe saa7164
sleep 1
sudo systemctl start tvheadend

exit 0
