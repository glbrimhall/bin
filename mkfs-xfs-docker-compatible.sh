# From  https://docs.docker.com/engine/storage/drivers/overlayfs-driver/
DEVICE=$1
mkfs.xfs -f -n ftype=1 $DEVICE
xfs_info $DEVICE
xfs_info $DEVICE 2>&1 | grep --color=yes ftype
blkid $DEVICE


