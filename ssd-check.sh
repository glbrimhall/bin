#!/bin/sh

echo "SSD: Checking for relatime"
cat /proc/mounts 2>&1 | grep relatime

echo "SSD: Checking for discard"
findmnt -O discard

echo "SSD: Enabling weekly trim"
if [ ! -f /etc/systemd/system/fstrim.timer ]; then
sudo cp /usr/share/doc/util-linux/examples/fstrim.service /etc/systemd/system
sudo cp /usr/share/doc/util-linux/examples/fstrim.timer /etc/systemd/system

sudo systemctl enable fstrim.timer
fi
