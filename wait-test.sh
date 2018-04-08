#!/bin/bash

MAX_PARALLEL=$((4))
PARALLEL=$((0))

for SECS_TIME in 10 9 8 6 5 4 2 1; do
  ./wait-sleep.sh $SECS_TIME &
  PARALLEL=$(($PARALLEL + 1))
  if [ "$PARALLEL" -gt "$MAX_PARALLEL" ]; then
    wait -n
    PARALLEL=$(($PARALLEL - 1))
  fi
done

wait
echo "All jobs finished"
