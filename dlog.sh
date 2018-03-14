#!/bin/sh

if [ -f "$HOME/bin/docker-default-container.sh" ]; then
  . $HOME/bin/docker-default-container.sh
fi

CONTAINER=${1:-$DEFAULT_CONTAINER}

if [ -f docker-compose.yml ] && [ "$1" = "" ]; then
  docker-compose logs --follow
else
  docker logs --follow $1
fi
