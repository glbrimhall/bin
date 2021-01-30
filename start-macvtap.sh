#!/bin/bash
# let host and guests talk to each other over macvlan
# configures a macvlan interface on the hypervisor
# run this on the hypervisor (e.g. in /etc/rc.local)
# made for IPv4; need modification for IPv6
# meant for a simple network setup with only eno1,
# and a static (manual) ip config
# Evert Mouw, 2013

#exit 0

MACVLN=macvlan0
TESTHOST=www.google.com
HWADDR="address 26:b7:fc:b3:8c:ae"

# ------------
# wait for network availability
# ------------

while ! ping -q -c 1 $TESTHOST > /dev/null
do
echo "$0: Cannot ping $TESTHOST, waiting another 5 secs..."
sleep 5
done

# ------------
# get network config
# ------------

HWLINK="`/sbin/route | grep '^default' | grep -o '[^ ]*$'`"

#1/11/2017 Enabling host-guest networking with KVM, Macvlan and Macvtap ♎ Furor Teutonicus
#https://www.furorteutonicus.eu/2013/08/04/enabling-host-guest-networking-with-kvm-macvlan-and-macvtap/ 4/12

IP=$(ip address show dev $HWLINK | grep "inet " | awk '{print $2}')
NETWORK=$(ip -o route | grep "dev $HWLINK" | grep "proto kernel" | awk '{print $1}')
GATEWAY=$(ip -o route | grep default | awk '{print $3}')

echo "HWLINK=$HWLINK"
echo "IP=$IP"
echo "NETWORK=$NETWORK"
echo "GATEWAY=$GATEWAY"
#exit

# ------------
# setting up $MACVLN interface
# ------------

#ip link add link $HWLINK $MACVLN type macvlan mode bridge
ip link add link $HWLINK $HWADDR $MACVLN type macvlan mode bridge
ip address add $IP dev $MACVLN
ip link set dev $MACVLN up

# ------------
# routing table
# ------------
# empty routes

ip route flush dev $HWLINK
ip route flush dev $MACVLN

# add routes
ip route add $NETWORK dev $MACVLN metric 0

# add the default gateway
ip route add default via $GATEWAY

