#!/bin/sh
set -x

GROUPNAME=$1
GROUPID=$2

dscl . -create /Groups/$GROUPNAME
dscl . -create /Groups/$GROUPNAME name $GROUPNAME
dscl . -create /Groups/$GROUPNAME passwd "*"
dscl . -create /Groups/$GROUPNAME gid $GROUPID

