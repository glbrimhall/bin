REPO_NAME=repo-img

docker network create -d bridge repo-img-network
docker run -d --restart always --network=repo-img-network -p 5000:5000 --name $REPO_NAME -e REGISTRY_STORAGE_DELETE_ENABLED=TRUE registry:2
docker run -d --restart always --network=repo-img-network -p 8080:8080 --name repo-web -e REGISTRY_URL=http://$REPO_NAME:5000/v2 -e REGISTRY_NAME=$HOSTNAME:5000 hyper/docker-registry-web

