#!/bin/bash

NAME=${1:-dspace-v5-mirage2}
REPOSITORY=mirage2:latest

# Required host environment for docker image
DSPACE_GUEST_DIR=/opt/tomcat/dspace/assetstore
DSPACE_HOST_DIR=$HOME/dspace/assetstore
DOCKER_LOG_DIR=/var/log
DAEMONIZE=-d
HOSTPORT=8090
GUESTPORT=8090
#export ADMIN_EMAIL=glbrimhall@email.arizona.edu
#export POSTGRES_USER=postgres
#export POSTGRES_PASSWORD=postgrespassword
#export POSTGRES_HOST=dspace-dbdev.library.arizona.edu

export CATALINA_OPTS="$JAVA_OPTS \
-XX:PermSize=256m \
-XX:MaxPermSize=512m"
#-Xms8192m \
#-Xmx16384m \

# Host setup:
#rm -fr $HOSTREPO
#mkdir -p $HOSTREPO

# Docker setup;
#docker pull $REPOSITORY
docker run \
$DAEMONIZE \
-e "CATALINA_OPTS=$CATALINA_OPTS" \
-v $DSPACE_HOST_DIR:$DSPACE_GUEST_DIR \
--net=host \
--restart=unless-stopped \
--name $NAME $REPOSITORY 

#-v $DSPACE_HOST_DIR:$DSPACE_GUEST_DIR \
#-v /var/log/dspace:$DOCKER_LOG_DIR \
#-v /var/log/dspace:$DOCKER_LOG_DIR $DAEMONIZE \

# -v $HOME/dspace:/dspace
# -e DSPACE_WEBAPPS="xmlui rest"
#-p $HOSTPORT:$GUESTPORT \

#docker run -e ADMIN_EMAIL -e POSTGRES_USER -e POSTGRES_PASSWORD -v $HOME/dspace:/dspace  $DAEMONIZE --name $NAME -i $REPOSITORY
