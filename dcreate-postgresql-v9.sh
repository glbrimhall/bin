#!/bin/bash

NAME=${1:-postgresql-v9.6}
REPOSITORY=postgres:9.6

# Required host environment for docker image
HOSTPORT=5432
GUESTPORT=5432
export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgrespassword
HOSTREPO=$HOME/postgres
GUESTREPO=/var/lib/postgresql/data/pgdata
mkdir $HOSTREPO
#DAEMONIZE=-d

# Docker setup;
docker pull $REPOSITORY
docker run -e "POSTGRES_USER=$POSTGRES_USER" -e "POSTGRES_PASSWORD=$POSTGRES_PASSWORD" -e PGDATA=$GUESTREPO -p $HOSTPORT:$GUESTPORT -v $HOSTREPO:$GUESTREPO $DAEMONIZE --name $NAME -i $REPOSITORY

#docker run -e "POSTGRES_USER=$POSTGRES_USER" -e "POSTGRES_PASSWORD=$POSTGRES_PASSWORD" -e PGDATA=$GUESTREPO -v $HOSTREPO:$GUESTREPO --net=bridge $DAEMONIZE --name $NAME -i $REPOSITORY
