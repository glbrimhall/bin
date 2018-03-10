#!/bin/sh

HOSTNAME=`hostname -f`
NAS="$1"
SMB_DIR="$2"
NFS_DIR="$3"

if [ "$NAS" = "" ] || [ "$NFS_DIR" = "" ] || [ "$SMB_DIR" = "" ]; then
  echo "ERROR: missing params"
  echo "Usage: $0 <nas_server> <smb_root> <nfs_root>"
fi

if [ -f /etc/fstab.org ]; then
  cp -v /etc/fstab /etc/fstab.orig
fi

cp -v /etc/fstab.orig /etc/fstab

NFS_SHARES="\
nfs_share1"

SMB_SHARES="\
data1"

if [ "$SMB_DIR" != "" ]; then

  echo "SMB: setting up $NAS shares"
  echo >> /etc/fstab
  echo "# $NAS smb shares" >> /etc/fstab
  
  for SMB in $SMB_SHARES; do
    echo "SMB: processing $SMB"
  
    if [ ! -d "$SMB_DIR/$SMB" ]; then
      mkdir -vp "$SMB_DIR/$SMB"
    fi
    
    echo >> /etc/fstab
    echo "//$NAS/$SMB $SMB_DIR/$SMB cifs noauto,serverino,credentials=/root/.smbcredentials,uid=5,gid=100,file_mode=0664,dir_mode=0775,iocharset=utf8,sec=ntlmssp 0 0" >> /etc/fstab
    
    mount $SMB_DIR/$SMB
  
  done
fi

if [ "$NFS_DIR" != "" ]; then

  echo "NFS: setting up $NAS shares"
  echo >> /etc/fstab
  echo "# $NAS nfs shares" >> /etc/fstab
  
  for NFS in $NFS_SHARES; do
    echo "NFS: processing $NFS"
  
    if [ ! -d "$NFS_DIR/$NFS" ]; then
      mkdir -vp "$NFS_DIR/$NFS"
    fi
    
    echo >> /etc/fstab
    echo "$NAS:/$NFS $NFS_DIR/$NFS nfs nfsvers=3,proto=tcp,hard,intr 0 0" >> /etc/fstab
  
    mount $NFS_DIR/$NFS
  
  done

fi
