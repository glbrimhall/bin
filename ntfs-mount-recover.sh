#!/bin/sh

DEVICE=${1:-/dev/sda2}
DIR=${2:-/win10}

mount -t ntfs-3g -o recover,remove_hiberfile $DEVICE $DIR
