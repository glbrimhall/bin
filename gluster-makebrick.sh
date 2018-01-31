#!/bin/sh

parted /dev/sdb mklabel gpt
parted /dev/sdb mkpart brick001 xfs 1 1100GB

# From http://docs.gluster.org/en/latest/Quick-Start-Guide/Quickstart/

mkfs.xfs -i size=512 /dev/sdb1
mkdir /brick-ua1001
echo '/dev/sdb1 /brick-ua1001 xfs defaults 1 2' >> /etc/fstab
mount -a && mount
mkdir /brick-ua1001/store

add-apt-repository -y ppa:gluster/glusterfs-3.10 && apt-get update
apt-get install -y glusterfs-server

# Setup gluster
gluster volume create preservation-store-ua gluster-brick1:/brick-ua1001/store gluster-brick2:/brick-ua2001/store
#Creation of test-volume has been successful
#Please start the volume to access data
gluster volume start preservation-store-ua
gluster volume info

# on client machine:
apt-get install glusterfs-client

echo 'gluster-brick1:/preservation-store-ua /var/archivematica/sharedDirectory/www/AIPsStore/ glusterfs defaults,_netdev 0 ' >> /etc/fstab
mount gluster-brick1:/preservation-store-ua

