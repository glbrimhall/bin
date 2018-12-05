#!/bin/bash

. $HOME/bin/docker-default-container.sh

CONTAINER=${1:-$DEFAULT_CONTAINER}
SHELL=${2:-bash}

if [ "$2" = "" ]; then
    if [ "xx$MSYSTEM" != "xx" ]; then
       WINPTY=winpty
    fi
    $WINPTY docker exec -it "$CONTAINER" $SHELL -i
else
   docker exec $CONTAINER sh -c "exec $1"
fi
