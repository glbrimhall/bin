#!/bin/sh
GROUPNAME=$1
GROUPID=$2
USER=$3

dscl . -create /Groups/$GROUPNAME
dscl . -create /Groups/$GROUPNAME name $GROUPNAME
dscl . -create /Groups/$GROUPNAME passwd "*"
dscl . -create /Groups/$GROUPNAME gid $GROUPID

if [ "$USER" != "" ]; then
   dscl . -create /Groups/$GROUPNAME GroupMembership $USER
fi
