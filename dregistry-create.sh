# From https://hub.docker.com/r/joxit/docker-registry-ui
sed -e s/#HOSTNAME#/$HOSTNAME/g dregistry-create.template > dregistry-create.yaml
docker compose --file=dregistry-create.yaml down
docker compose --file=dregistry-create.yaml up -d
rm -f dregistry-create.yaml

