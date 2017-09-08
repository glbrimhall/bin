#!/bin/bash

. $HOME/bin/docker-default-container.sh

CONTAINER=${1:-$DEFAULT_CONTAINER}
docker start "$CONTAINER"
docker exec -it "$CONTAINER" bash

