#!/bin/sh

echo "IPTABLES: protecting host system"

IPTABLE_DIR=.

cp -v $IPTABLE_DIR/iptables.* /etc/

if [ -f "$IPTABLE_DIR/firewall" ]; then
  cp -v $IPTABLE_DIR/firewall /etc/network/if-pre-up.d/firewall
  /etc/network/if-pre-up.d/firewall
  /etc/init.d/docker restart
fi

echo "IPTABLES: protecting docker"
if [ -f "$IPTABLE_DIR/docker-firewall.service" ]; then
  cp -v $IPTABLE_DIR/docker-firewall.service /lib/systemd/system
  systemctl enable docker-firewall
  systemctl daemon-reload
  systemctl start docker-firewall
fi

# From https://github.com/moby/moby/issues/16816
iptables -L

# debug with setting logging to 'debug' in /etc/systemd/system.conf
#journalctl -xe
