#!/bin/sh
# Documentation for this registry web gui is at 

NAME=${1:-docker-registry-web-2.6}
REPOSITORY=hyper/docker-registry-web
REGISTRY_URL=dockerepo.library.arizona.edu:5000

# Required host environment for docker image
HOSTPORT=8080
HOSTVOL=/repo1/docker/registry/web
HOSTCACERT=/repo1/docker/registry/certs/java-cacerts
READ_ONLY="-e READ_ONLY=true"
DAEMONIZE=-d

# Docker setup;

docker pull $REPOSITORY
docker run $DAEMONIZE \
  --restart=always \
  --net=host \
  -e REGISTRY_URL=https://$REGISTRY_URL/v2 \
  -e REGISTRY_NAME=$REGISTRY_URL \
  -p $HOSTPOST:8080 \
  -v $HOSTCACERT:/etc/ssl/certs/java/cacerts \
  --name $NAME \
  $REPOSITORY

#  -e REGISTRY_TRUST_ANY_SSL=true \

#  -v $HOSTVOL:/var/lib/h2 \

#  -e REGISTRY_PROXY_REMOTEURL=https://registry-1.docker.io \
#  -v $HOSTCERTS:/auth \
#  -e "REGISTRY_AUTH=htpasswd" \
#  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
#  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/users.conf \
