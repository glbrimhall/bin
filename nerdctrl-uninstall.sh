#!/bin/sh
cd /usr/local/
rm -vfr share/doc/nerdctl
rm -vfr lib/systemd/
mv -v bin/v .
rm -vf bin/*
mv -v v bin
rm -vfr libexec/cni/
rm -vfr share/doc/nerdctl-full/

