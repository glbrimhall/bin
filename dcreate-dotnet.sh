#!/bin/bash

NAME=${1:-dotnet5}
REPOSITORY=mcr.microsoft.com/dotnet/sdk:5.0
GUEST_DIR=/src
HOST_DIR=/home/geoff/github/dipWebscrape

# Docker setup;
#docker pull $REPOSITORY
docker run \
$DAEMONIZE \
-v $HOST_DIR:$GUEST_DIR \
--net=host \
-it \
--name $NAME $REPOSITORY


#--restart=unless-stopped \
#-v $DSPACE_HOST_DIR:$DSPACE_GUEST_DIR \
#-v /var/log/dspace:$DOCKER_LOG_DIR \
#-v /var/log/dspace:$DOCKER_LOG_DIR $DAEMONIZE \

# -v $HOME/dspace:/dspace
# -e DSPACE_WEBAPPS="xmlui rest"
#-p $HOSTPORT:$GUESTPORT \

#docker run -e ADMIN_EMAIL -e POSTGRES_USER -e POSTGRES_PASSWORD -v $HOME/dspace:/dspace  $DAEMONIZE --name $NAME -i $REPOSITORY
