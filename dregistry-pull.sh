IMG="$1"
IMG_REPO="$HOSTNAME:5000/$IMG"

docker pull --insecure-registry "$IMG_REPO"

