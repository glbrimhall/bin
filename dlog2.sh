#!/bin/bash
LINES=${1:-10}
DOCKER_PS_ID=$(docker ps -lq)

if [ "xx$LINES" == "xx0" ]; then
  TAIL=""
else
  TAIL="--follow --tail $LINES"
fi

echo "STACK docker logs --timestamps $TAIL $DOCKER_PS_ID"
docker logs --timestamps $TAIL $DOCKER_PS_ID

