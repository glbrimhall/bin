#!/bin/bash

export KODI_AE_SINK=ALSA 

/usr/bin/kodi &

sleep 2

/home/muse/bin/kodi-set-audio.sh

exit 0

