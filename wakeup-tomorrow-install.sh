#!/bin/sh
cd /lib/systemd/system
cp -f /home/geoff/bin/wakeup-tomorrow.service .
systemctl daemon-reload
systemctl enable wakeup-tomorrow
systemctl start wakeup-tomorrow
systemctl status wakeup-tomorrow.service

journalctl -u wakeup-tomorrow.service -b
