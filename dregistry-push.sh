IMG="$1"
HOST=${2:-$HOSTNAME}
IMG_REPO="$HOST:5000/$IMG"

docker tag "$IMG" "$IMG_REPO"
docker push "$IMG_REPO"
docker rmi "$IMG_REPO"

