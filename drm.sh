#!/bin/sh
docker-compose rm -fsv
echo "y" | docker volume prune
