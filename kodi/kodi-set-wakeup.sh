#! /bin/sh

date +"%Y-%m-%d %H:%M:%S.%N" > /home/muse/bin/kodi-set-wakeup.log
echo "$0 $1 $2 $3 $4 $5" >> /home/muse/bin/kodi-set-wakeup.log
sync

#exit 0

sudo /home/muse/bin/kodi-suspend.sh $1

