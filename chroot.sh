mount -o bind /proc /t/proc
mount -o bind /dev  /t/dev
mount -o bind /dev/pts  /t/dev/pts
mount -o bind /sys  /t/sys
#sudo cp /etc/resolv.conf  /t/etc/resolv.conf
chroot  /t /bin/bash