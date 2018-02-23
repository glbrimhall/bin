#!/bin/bash

. $HOME/bin/docker-default-container.sh

CONTAINER=${1:-$DEFAULT_CONTAINER}

if [ -f docker-compose.yml ] && [ "$1" = "" ]; then
  docker-compose rm -fsv
  echo "y" | docker volume prune
else
  docker stop $CONTAINER
  docker rm $CONTAINER
fi
