#!/bin/bash

LOG=/home/muse/bin/kodi-set-audio.log

date +"%Y-%m-%d %H:%M:%S.%N" > $LOG

if [ "$1" == "search" ]; then

HDMI_DEVICE=/proc/asound/card1/eld*

for ELD in `ls $HDMI_DEVICE`
do
  echo "Searching if $ELD is active in $HDMI_DEVICE"
  if grep marantz $ELD; then
  echo SUCCESS
  fi
done

fi

if grep marantz /proc/asound/card1/eld#0.0; then
   ~/bin/kodi-json-cmd.sh audiooutput.audiodevice ALSA:hdmi:CARD=NVidia,DEV=0 >> $LOG 2>&1 
   ~/bin/kodi-json-cmd.sh audiooutput.passthroughdevice ALSA:hdmi:CARD=NVidia,DEV=0 >> $LOG 2>&1
else
   ~/bin/kodi-json-cmd.sh audiooutput.audiodevice ALSA:hdmi:CARD=NVidia,DEV=1 >> $LOG 2>&1 
   ~/bin/kodi-json-cmd.sh audiooutput.passthroughdevice ALSA:hdmi:CARD=NVidia,DEV=1 >> $LOG 2>&1
fi

exit 0

# research:

root@reaper:/proc/asound/card1# cat eld#0.0 
monitor_present         1
eld_valid               1
monitor_name            marantz-AVR
 
connection_type         HDMI


