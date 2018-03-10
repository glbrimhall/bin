#!/bin/sh
SITE=${1:-config}
ROOTDIR=${2:-backup}

amserverconfig $SITE \
   --template=harddisk
   --tapedev=file://$ROOTDIR/amanda/vtapes/$SITE \
   --dumpcycle=52 \
   --runspercycle=13 \
   --tapecycle=52 \
   --mailto=LCU-WATCHDOG-1A@email.arizona.edu \

exit 0
   
