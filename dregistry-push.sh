IMG="$1"
IMG_REPO="$HOSTNAME:5000/$IMG"

docker tag "$IMG" "$IMG_REPO"
docker push --insecure-registry "$IMG_REPO"
docker rmi "$IMG_REPO"

