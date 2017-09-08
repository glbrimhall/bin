#!/bin/sh

. $HOME/bin/docker-default-container.sh

REPOSITORY="$1"
CONTAINER=${2:-$DEFAULT_CONTAINER}

if [ "$REPOSITORY" == "" ] || [ "$CONTAINER" == "" ]; then
   echo "ERROR:   Missing container or repository parameter"
   echo "USAGE:   ./dcommit.sh <repository> <container>"
   echo "EXAMPLE: ./dcommit.sh repository/dba dbclient"
   exit 1
fi

docker commit --author "glBrimhall" $CONTAINER $REPOSITORY
