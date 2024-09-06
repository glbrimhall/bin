#!/bin/bash

IMAGE=$1
TAG=$2
REGISTRY=${3:-https://$HOSTNAME:5000}

if [ "$IMAGE" == "" ]; then
    echo "GET $REGISTRY/v2/_catalog"
    curl -X GET $REGISTRY/v2/_catalog
else
if [ "$TAG" == "" ]; then
    echo "GET $REGISTRY/v2/$IMAGE/tags/list"
    curl -X GET $REGISTRY/v2/$IMAGE/tags/list
else
    echo "GET $REGISTRY/v2/$IMAGE/manifests/$TAG"
    OUT=$( curl -X GET -vvv --stderr - \
        -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
        -k $REGISTRY/v2/$IMAGE/manifests/$TAG )
    echo "$OUT"
    echo "$OUT" | grep --color=auto -i etag
fi
fi
