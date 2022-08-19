#!/bin/sh 

sudo apt install wireguard-dkms

nordvpn set cybersec off 
nordvpn set killswitch off 
nordvpn set obfuscate off 
#nordvpn set technology protocol tcp 
nordvpn set technology nordlynx


nordvpn whitelist add subnet 192.168.0.0/24
nordvpn whitelist add port 21
nordvpn whitelist add port 22
nordvpn whitelist add port 2049

