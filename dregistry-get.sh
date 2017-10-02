#!/bin/bash

IMAGE=$1
TAG=$2
REGISTRY=${3:-https://dockerepo.library.arizona.edu:5000}

if [ "$IMAGE" == "" ]; then
    curl -X GET $REGISTRY/v2/_catalog
else
if [ "$TAG" == "" ]; then
    curl -X GET $REGISTRY/v2/$IMAGE/tags/list
else
    curl -X GET -vvv --stderr - \
        -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
        -k $REGISTRY/v2/$IMAGE/manifests/$TAG | \
    grep etag
fi
fi
