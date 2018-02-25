#!/bin/sh

# from https://kernel-handbook.alioth.debian.org/ch-common-tasks.html#s-common-building

make menuconfig
scripts/config --disable DEBUG_INFO
make -j16 clean
make -j16 deb-pkg
