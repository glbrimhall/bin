#!/bin/sh
set -x

NFS_SERVER=$1
NFS_SHARE=$2
NFS_DIR=$3
DIR_UID=$4
DIR_GID=$5
DATETIME=`date +%Y-%m-%d.%H.%M.%S`

if [ "`id | grep ^uid=0`" == "" ]; then
   echo "ERROR: This script must be run as root"
   echo "USAGE: osx-mount-nfs-share.sh <nfs_server> <nfs_share> <nfs_dir> [dir_uid] [dir_gid]"
   exit 0
fi

if [ "`grep -F "$NFS_DIR" /etc/fstab 2>/dev/null`" != "" ]; then
   echo "NFS: /etc/fstab appears to already have $NFS_DIR listed. Exiting"
   exit 0
fi

if [ ! -d "$NFS_DIR" ]; then
   mkdir -p "$NFS_DIR"        
fi

if [ "$DIR_UID" != "" ]; then
   chown $DIR_UID "$NFS_DIR"
fi

if [ "$DIR_GID" != "" ]; then
   chgrp $DIR_GID "$NFS_DIR"
fi

if [ "$NFS_SERVER" != "" && "$NFS_SHARE" != "" && "NFS_DIR" ]; then
    echo "ERROR: missing needed parameters"
    echo "USAGE: osx-mount-nfs-share.sh <nfs_server> <nfs_share> <nfs_dir> [dir_uid] [dir_gid]"
    exit 1
fi

cp /etc/fstab /etc/fstab-$DATETIME
echo "$NFS_SERVER:/$NFS_SHARE $NFS_DIR nfs proto=tcp,hard,resvport 0 0" >> /etc/fstab
mount $NFS_DIR
