#!/bin/bash

. $HOME/bin/docker-default-container.sh

CONTAINER=${1:-$DEFAULT_CONTAINER}
docker cp --follow-link $CONTAINER:$1 $2
