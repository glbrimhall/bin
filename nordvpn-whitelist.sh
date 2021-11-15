#!/bin/sh 

nordvpn set technology nordlynx
nordvpn set dns off

nordvpn whitelist add port 21    # ftp
nordvpn whitelist add port 22    # ssh
nordvpn whitelist add port 80    # http 
nordvpn whitelist add port 443   # https 
nordvpn whitelist add port 515   # lpr (printer)
nordvpn whitelist add port 631   # ipp (printer)
nordvpn whitelist add port 2049  # nfs
nordvpn whitelist add port 5357  # canon wsdapi 
nordvpn whitelist add port 6566  # sane (printer)
nordvpn whitelist add port 8007  # 192.168.0.67 ?? 
nordvpn whitelist add port 8008  # ?? 
nordvpn whitelist add port 8009  # ?? 
nordvpn whitelist add port 8611  # canon bjnp print
nordvpn whitelist add port 8612  # canon bjnp scan
nordvpn whitelist add port 8613  # canon bjnp fax
nordvpn whitelist add port 9100  # raw (printer)
nordvpn whitelist add subnet 192.168.0.0/24

