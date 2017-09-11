#!/bin/sh

NAME=${1:-docker-registry-2.6}
REPOSITORY=registry:2.6

# Required host environment for docker image
HOSTPORT=443
GUESTPORT=443
HOSTCERTS=/repo1/registry-certs
HOSTREPO=/repo1/registry
GUESTREPO=/var/lib/registry

# !! IMPORTANT !! docker matches on the CN, ie an image's name must match CN/mysql
DOMAIN=dockerepo.library.arizona.edu
DAEMONIZE=-d

# Docker setup;
test !-d $HOSTREPO && mkdir $HOSTREPO

if [ ! -f $HOSTCERTS/$DOMAIN.crt ]; then
    openssl req \
       -newkey rsa:4096 -nodes -sha256 -keyout $HOSTCERTS/$DOMAIN.key \
       -subj "/C=US/ST=Arizona/L=Tucson/O=UALib-TESS/CN=$DOMAIN" \
       -x509 -days 1024 -out $HOSTCERTS/$DOMAIN.crt
fi

docker pull $REPOSITORY
docker run $DAEMONIZE \
  --restart=always \
  -v $HOSTCERTS:/certs \
  -e REGISTRY_HTTP_ADDR=0.0.0.0:$GUESTPORT \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/$DOMAIN.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/$DOMAIN.key \
  -p $HOSTPORT:$GUESTPORT \
  -v $HOSTREPO:$GUESTREPO \
  -v /etc/passwd:/passwd \
  -u $REGUSER \
  --name $NAME \
  $REPOSITORY

#docker run -e "REGISTRY_USER=$REGISTRY_USER" -e "REGISTRY_PASSWORD=$REGISTRY_PASSWORD" -e PGDATA=$GUESTREPO -v $HOSTREPO:$GUESTREPO --net=bridge $DAEMONIZE --name $NAME -i $REPOSITORY
