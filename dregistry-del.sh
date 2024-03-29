#!/bin/sh
IMAGE=$1
DIGEST=$2
REGISTRY=${3:-http://dock:5000}

curl -vvv \
     -X DELETE \
     -k $REGISTRY/v2/$IMAGE/manifests/$DIGEST
