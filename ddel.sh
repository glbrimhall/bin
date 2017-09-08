#!/bin/bash

. $HOME/bin/docker-default-container.sh

CONTAINER=${1:-$DEFAULT_CONTAINER}

docker stop $CONTAINER
docker rm $CONTAINER
