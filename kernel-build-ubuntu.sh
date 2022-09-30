#!/usr/bin/bash

# NO LONGER WORKS !!
# From https://wiki.ubuntu.com/Kernel/BuildYourOwnKernel
#
#fakeroot debian/rules clean
#fakeroot debian/rules binary-headers binary-generic

# Works ! From https://www.maketecheasier.com/build-custom-kernel-ubuntu/
FLAVOR=${1:-k8}

echo "RUN inside a clean, just exploded linux src tarball !"
make clean
fakeroot make -j `getconf _NPROCESSORS_ONLN`
rm -vf vmlinux-gdb.py
mv -v scripts/gdb/vmlinux-gdb.py scripts/gdb/vmlinux-gdb.py-disable
fakeroot make -j `getconf _NPROCESSORS_ONLN` deb-pkg LOCALVERSION=-$FLAVOR

