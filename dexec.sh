#!/bin/bash

#set -x

. $HOME/bin/docker-default-container.sh

CONTAINER=${1:-$DEFAULT_CONTAINER}
COMMAND="${2}"

if [ "XX$CONTAINER" = "XXxrdp-pyphp-test" ] && [ "XX$COMMAND" = "XX" ]; then
  COMMAND="su --login geoff"
fi

echo "docker exec -it $CONTAINER env \"TERM=xterm-256color\" $COMMAND" 
docker exec -it $CONTAINER env "TERM=xterm-256color" $COMMAND

