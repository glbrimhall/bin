#!/bin/bash
set -x

DOMAIN_NAME="$1"
MACHINE_NAME=${DOMAIN_NAME%%.*}

echo "SETTING DOMAIN_NAME=$DOMAIN_NAME"
echo "SETTING MACHINE_NAME=$MACHINE_NAME"

scutil --set HostName $DOMAIN_NAME
scutil --set LocalHostName $MACHINE_NAME.local
scutil --set ComputerName $MACHINE_NAME
dscacheutil -flushcache
