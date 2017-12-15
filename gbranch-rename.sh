#!/bin/sh

# From https://stackoverflow.com/questions/6591213/how-do-i-rename-a-local-git-branch

OLDNAME=$1
NEWNAME=$2

if [ "$OLDNAME" = "" ] || [ "$NEWNAME" = "" ]; then
  echo "ERROR: requires old-branch-name and new-branch-name"
  echo "USAGE: ./gbranch-rename.sh <old-branch-name> <new-branch-name>"
  exit 1
fi

#1. Rename branch locally
git branch -m $OLDNAME $NEWNAME

#2. Delete the $OLDNAME remote branch and push the $NEWNAME local branch
git push origin :$OLDNAME $NEWNAME

#3. Reset the upstream branch for the $NEWNAME local branch
git push origin -u $NEWNAME
