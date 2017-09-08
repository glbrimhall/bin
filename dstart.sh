#!/bin/bash

. $HOME/bin/docker-default-container.sh

CONTAINER=${1:-$DEFAULT_CONTAINER}

if [ "$2" = "" ]; then
   docker exec -it $CONTAINER bash
else
   docker exec $CONTAINER sh -c "exec $1"
fi
