#!/bin/sh
cd /etc/systemd/system
ln -s /home/geoff/bin/set-wakup-alarm.service .
systemctl daemon-reload
systemctl enable set-wakup-alarm.service

