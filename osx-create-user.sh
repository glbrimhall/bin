#!/bin/sh
set -x

USERNAME=$1
USERID=$2
FULLNAME="$3"
PASSWORD="$4"

if [ "$USERNAME" == "" ]; then
   echo "ERROR: Must pass in at least the username."
   echo "USAGE: ./osx-create-user.sh <username> <userid> \"<full name>\" <password>."
   exit 1;
fi

dscl . -create /Users/$USERNAME

if [ "$FULLNAME" != "" ]; then
dscl . -create /Users/$USERNAME RealName "$FULLNAME"
fi

if [ "$USERID" != "" ]; then
dscl . -create /Users/$USERNAME UniqueID "$USERID"
dscl . -create /Users/$USERNAME PrimaryGroupID "$USERID"
fi

if [ "$PASSWORD" != "" ]; then
dscl . -create /Users/$USERNAME password "$PASSWORD"
fi

dscl . -create /Users/$USERNAME UserShell /bin/bash
dscl . -create /Users/$USERNAME NFSHomeDirectory /Users/$USERNAME
dscl . -create /Users/$USERNAME PrimaryGroupID "$USERID"
dscl . -append /Groups/admin GroupMembership $USERNAME
