#!/usr/bin/bash

# BAD !
#chmod a+x debian/scripts/*
#chmod a+x debian/scripts/misc/*
#fakeroot debian/rules clean
#fakeroot debian/rules editconfigs


cp /boot/config-`uname -r` .config
make olddefconfig
make menuconfig

