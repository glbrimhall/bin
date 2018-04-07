#!/bin/sh

HOSTNAME=amanda.library.arizona.edu
STRATEGY=gnutar
DISKLIST=/etc/amanda/qumulo/disklist

USER_LIST=" archivematica dspace"
USER_ID=333

for USER in $USER_LIST; do
  if [ "`id $USER 2>/dev/null`" = "" ]; then
    echo "CREATEUSER: $USER with uid:gid $USER_ID:$USER_ID"
    sudo addgroup $USER --force-badname --gid $USER_ID
    sudo adduser --system $USER --force-badname --uid $USER_ID --gid $USER_ID --home /home/$USER --shell /bin/false
  fi
  USER_ID=800
done

if [ -f /etc/fstab.org ]; then
  cp -v /etc/fstab /etc/fstab.orig
fi

cp -v /etc/fstab.orig /etc/fstab
echo > $DISKLIST

NFS_SHARES="\
afghan \
archivematica-stg-AIPsStore \
binrepo-d1 \
build-d1 \
dspace-assetstore-dev \
dspace-assetstore-stg \
dspace-assetstore-tst \
gigaword-LDC2012T21 \
globus1-data \
preservation-dev-storage \
preservation-tst-storage \
preservation-stg-storage \
preserve \
test-webserver-data \
textmining-disk1"

SMB_SHARES="\
ad-smb-tst \
archivematica-dev-home \
ops-software \
preservation-afghan \
preservation-dev-workspace \
preservation-oral-history \
preservation-stg-workspace \
preservation-tst-workspace \
test-webserver-data"

echo "SMB: setting up qumulo shares"
echo >> /etc/fstab
echo "# qumulo smb shares" >> /etc/fstab

for SMB in $SMB_SHARES; do
  echo "SMB: processing $SMB"

  if [ ! -d "/mnt/smb/$SMB" ]; then
    mkdir -vp "/mnt/smb/$SMB"
  fi
  
  echo >> /etc/fstab
  echo "//qnas1.library.arizona.edu/$SMB /mnt/smb/$SMB cifs vers=2.1,serverino,credentials=/.smbcredentials,uid=333,gid=333,file_mode=0664,dir_mode=0775,nounix,iocharset=utf8,sec=ntlmssp 0 0" >> /etc/fstab
  
  mount /mnt/smb/$SMB

  echo "$HOSTNAME /mnt/smb/$SMB $STRATEGY" >> $DISKLIST
done

echo "NFS: setting up qumulo shares"
echo >> /etc/fstab
echo "# qumulo nfs shares" >> /etc/fstab

for NFS in $NFS_SHARES; do
  echo "NFS: processing $NFS"

  if [ ! -d "/mnt/nfs/$NFS" ]; then
    mkdir -vp "/mnt/nfs/$NFS"
  fi
  
  echo >> /etc/fstab
  echo "qnas1.library.arizona.edu:/$NFS /mnt/nfs/$NFS nfs nfsvers=3,proto=tcp,hard,intr 0 0" >> /etc/fstab

  mount /mnt/nfs/$NFS

  echo "$HOSTNAME /mnt/nfs/$NFS $STRATEGY" >> $DISKLIST
done

