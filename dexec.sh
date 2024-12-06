#!/bin/bash

#set -x

CONTAINER=${1:-xrdp-pyphp-test}
COMMAND="${2}"

if [ "XX$CONTAINER" = "XXxrdp-pyphp-test" ] && [ "XX$COMMAND" = "XX" ]; then
  COMMAND="su --login geoff"
fi

echo "docker exec -it $CONTAINER env \"TERM=xterm-256color\" $COMMAND" 
docker exec -it $CONTAINER env "TERM=xterm-256color" $COMMAND

