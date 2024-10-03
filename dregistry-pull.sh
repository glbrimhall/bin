IMG="$1"
HOST=${2:-$HOSTNAME}
IMG_REPO="$HOST:5000/$IMG"

docker image pull "$IMG_REPO"
docker image tag "$IMG_REPO" "$IMG"
docker image rm "$IMG_REPO"
#docker pull --insecure-registry "$IMG_REPO"

