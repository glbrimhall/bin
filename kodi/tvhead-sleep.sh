#!/bin/sh

# install instructions:
# ln -s /home/muse/bin/tvhead-sleep.sh /lib/systemd/system-sleep/tvhead-sleep.sh

set -v

LOG=/home/muse/bin/tvhead-sleep-$1-$2.log

date +"%Y-%m-%d %H:%M:%S.%N" > $LOG


case $1/$2 in
  pre/*)
    echo "Going to $2..." >> $LOG
    #su - muse -c 'killall kodi'
    #su - muse -c 'killall -KILL kodi-x11'
    systemctl stop tvheadend
    sleep 1
    modprobe -r saa7164
    modprobe -r cx23885
    modprobe -r cx25840
    ;;
  post/*)
    echo "Waking up from $2..." >> $LOG
    modprobe cx23885
    modprobe cx25840
    modprobe saa7164
    sleep 1
    systemctl start tvheadend
    su - muse -c '/home/muse/bin/kodi-set-audio.sh'
    ;;
esac

