#!/bin/bash

NAME=${1:-jfrog-artifactory}
REPOSITORY=docker.bintray.io/jfrog/artifactory-oss:latest
#REPOSITORY=docker.bintray.io/jfrog/artifactory-pro:latest

# Required host environment for docker image
HOSTREPO=$HOME/jfrog/artifactory
DAEMONIZE=-d
HOSTPORT=8081
GUESTPORT=8081

export ADMIN_EMAIL=glbrimhall@email.arizona.edu
export DB_USER=db
export DB_PASSWORD=dbpassword
export DB_HOST=localhost

# Host setup:
#rm -fr $HOSTREPO
mkdir -p $HOSTREPO

# Docker setup;
docker pull $REPOSITORY
docker run \
       -v $HOSTREPO:/var/opt/jfrog/artifactory \
       -p $HOSTPORT:$GUESTPORT \
       $DAEMONIZE \
       --name $NAME \
       $REPOSITORY

#       -e "DB_DB_HOST=$DB_HOST" \
#       -e "DB_ADMIN_USER=$DB_USER" \
#       -e "DB_ADMIN_PASSWORD=$DB_PASSWORD" \
