#!/bin/bash

if [ -f "$HOME/bin/docker-default-container.sh" ]; then
  . $HOME/bin/docker-default-container.sh
fi

CONTAINER=${1:-$DEFAULT_CONTAINER}

if [ -f docker-compose.yml ] && [ "$1" = "" ]; then
  docker-compose down --volumes --remove-orphans --rmi local
  #docker-compose rm -fsv
  echo "y" | docker volume prune
else
  docker stop $CONTAINER
  docker rm $CONTAINER
fi
