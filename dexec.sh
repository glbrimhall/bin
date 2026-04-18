#!/bin/bash

#set -x

. $HOME/bin/docker-default-container.sh

CONTAINER=${1:-$DEFAULT_CONTAINER}
COMMAND="${2}"
SHELL=${3:-bash}

if [ "xx$3" != "xx" ]; then
    if [ "xx$MSYSTEM" != "xx" ]; then
       WINPTY=winpty
    fi
    $WINPTY docker exec -it "$CONTAINER" $SHELL -i
    exit 0
fi

if [ "XX$CONTAINER" = "XXxrdp-pyphp-test" ] && [ "XX$COMMAND" = "XX" ]; then
  COMMAND="su --login geoff"
fi

echo "docker exec -it $CONTAINER env \"TERM=xterm-256color\" $COMMAND" 
docker exec -it $CONTAINER env "TERM=xterm-256color" $COMMAND

