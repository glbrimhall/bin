#!/bin/sh
set -x

GROUPNAME=$1
USER=$2

dscl . -create /Groups/$GROUPNAME GroupMembership $USER
