#!/bin/bash
DOCKER_PS_ID=$(docker ps -lq)
echo "STACK $DOCKER_PS_ID connect..."
docker exec -it $DOCKER_PS_ID sh
