#!/bin/sh

cp -v macvlan.system /lib/systemd/system
systemctl enable macvlan
systemctl daemon-reload
systemctl start macvlan
