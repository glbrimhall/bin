#!/bin/bash

NAME=${1:-dspace-v5-xmlui}
REPOSITORY=mirage2:latest
#REPOSITORY=dspace-xmlui-nfs:latest
#REPOSITORY=1science/dspace:5.4

# Required host environment for docker image
DSPACE_REPO_DIR=/opt/tomcat/dspace/assetstore
DOCKER_LOG_DIR=/var/log
DAEMONIZE=-d
HOSTPORT=8080
GUESTPORT=8080
#export ADMIN_EMAIL=glbrimhall@email.arizona.edu
#export POSTGRES_USER=postgres
#export POSTGRES_PASSWORD=postgrespassword
#export POSTGRES_HOST=dspace-dbdev.library.arizona.edu

export CATALINA_OPTS="$JAVA_OPTS \
-Xms8192m \
-Xmx16384m \
-XX:PermSize=256m \
-XX:MaxPermSize=512m"

# Host setup:
#rm -fr $HOSTREPO
#mkdir -p $HOSTREPO

# Docker setup;
#docker pull $REPOSITORY
docker run \
-e "CATALINA_OPTS=$CATALINA_OPTS" \
-e "CATALINA_OPTS=$CATALINA_OPTS" \
-v /dspace-assetstore:$DSPACE_REPO_DIR \
-v /var/log/dspace:$DOCKER_LOG_DIR $DAEMONIZE \
--net=host \
--restart=unless-stopped \
--name $NAME $REPOSITORY 

# -v $HOME/dspace:/dspace
# -e DSPACE_WEBAPPS="xmlui rest"
#-p $HOSTPORT:$GUESTPORT \

#docker run -e ADMIN_EMAIL -e POSTGRES_USER -e POSTGRES_PASSWORD -v $HOME/dspace:/dspace  $DAEMONIZE --name $NAME -i $REPOSITORY
