#!/bin/sh

DEVICE=$1

if [ "$DEVICE" = "" ]; then
    DEVICE=/dev/sr0
fi

CMD="abcde \
-c /home/geoff/bin/abcde.conf \
-d $DEVICE \
-x \
-N"

echo "EXEC: cd ~/Music; $CMD; cd --"
#cd ~/Music ; `$CMD` ; cd --
