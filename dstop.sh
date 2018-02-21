#!/bin/bash

if [ -f docker-compose.yml ] && [ "$1" = ""]; then
  docker-compose stop
else

. $HOME/bin/docker-default-container.sh

CONTAINER=${1:-$DEFAULT_CONTAINER}
docker stop "$CONTAINER"
docker logs "$CONTAINER"

fi
