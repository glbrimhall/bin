#!/bin/sh

BACKUP_SET=${1:-preserve}
HOST=${2:-localhost}
AMANDA_CMD="amdump $BACKUP_SET $HOST"
MAX_PARALLEL=$((4))
PARALLEL=$((0))

for DISK in 05 04 01 07 03 02 06 08 ; do
  TIME_FILE=/tmp/$BACKUP_SET-dsk$DISK.txt
  echo > $TIME_FILE
  time -o $TIME_FILE -a $AMANDA_CMD /mnt/nfs/preserve/dsk$DISK &
  PARALLEL=$(($PARALLEL + 1))
  sleep 10
  # Calling amtape to simluate putting in a vtape in the next slot
  # is what allows multiple amdumps to be launched
  amtape preserve slot next >/dev/null 2>&1
  
  if [ "$PARALLEL" -gt "$MAX_PARALLEL" ]; then
    wait
    PARALLEL=$(($PARALLEL - 1))
  fi
done
