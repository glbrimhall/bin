#!/bin/bash

. $HOME/bin/docker-default-container.sh

CONTAINER=${2:-$DEFAULT_CONTAINER}
IMAGE=${1:-dspace-dev}

docker build -t dspace-dev .
