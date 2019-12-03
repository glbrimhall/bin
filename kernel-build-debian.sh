#!/bin/sh

# from https://kernel-handbook.alioth.debian.org/ch-common-tasks.html#s-common-building

#tar -xf /usr/src/linux-source-5.3.tar.xz 
#make menuconfig
#scripts/config --disable MODULE_SIG
#scripts/config --disable DEBUG_INFO
#make -j16 clean
#make -j16 deb-pkg

rm -vfr linux-5.3.9
apt-get source linux-image-5.3.0-0.bpo.2-amd64-unsigned
cd linux-5.3.9

fakeroot debian/rules source
fakeroot make -f debian/rules.gen setup_amd64_none_amd64
make -C debian/build/build_amd64_none_amd64 menuconfig
#fakeroot debian/rules debian/control-real
fakeroot make -j `nproc` -f debian/rules.gen binary-arch_amd64_none_amd64 > ../debian.rules.out 2>&1 &

