#!/bin/bash
IMAGE=$1
TAG_UNUSED=$2
DIGEST=$3
REGISTRY=${4:-https://$HOSTNAME:5000}

echo "DEL $REGISTRY $IMAGE $DIGEST"
curl -vvv \
     -X DELETE \
     -k $REGISTRY/v2/$IMAGE/manifests/$DIGEST
