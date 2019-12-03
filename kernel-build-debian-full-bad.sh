#!/bin/sh

# from https://kernel-handbook.alioth.debian.org/ch-common-tasks.html#s-common-building

tar -xf /usr/src/linux-source-5.3.tar.xz 
cd linux-source-5.3
cp /boot/config-5.3.0-0.bpo.2-amd64 .config
make menuconfig
scripts/config --disable MODULE_SIG
#scripts/config --disable DEBUG_INFO
make -j16 clean
make -j16 deb-pkg

