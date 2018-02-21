#!/bin/sh
NEW_BRANCH=$1
BASED_OFF_OF_BRANCH=$2

if [ "$NEW_BRANCH" = "" ]; then
  echo "Must specify a branch to create"
  echo "Usage: ./gbranch-create.sh <branch_name> [optional based off of branch]"
  exit 1
fi

# Create branch locally
git checkout -b $NEW_BRANCH $BASED_OFF_OF_BRANCH

# Push new branch to master server
git push -u origin $NEW_BRANCH
