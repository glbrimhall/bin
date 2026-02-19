#!/bin/bash

set +x

if [ -f docker-compose.yml ] && [ "$1" = "" ]; then
  docker-compose start
else

. $HOME/bin/docker-default-container.sh

CONTAINER=${1:-$DEFAULT_CONTAINER}
docker update --restart=always "$CONTAINER"
echo -n "docker start "
docker start "$CONTAINER"
sleep 3
echo "docker logs $CONTAINER"
docker logs "$CONTAINER"

fi
