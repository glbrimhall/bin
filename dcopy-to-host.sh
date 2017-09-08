#!/bin/sh
DOCKER_IMAGE=$1
DST_HOST=${2:-150.135.119.22}
docker save $DOCKER_IMAGE | pv | \
    ssh $DST_HOST 'docker load'

#docker save $DOCKER_IMAGE | gzip | pv | \
#    ssh $DST_HOST 'gunzip | docker load'
