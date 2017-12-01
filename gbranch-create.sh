#!/bin/sh
BRANCH=$1

if [ "$BRANCH" == "" ]; then
  echo "Must specify a branch to create"
  echo "Usage: ./gbranch-create.sh <branch_name>"
  exit 1
fi

# Create branch locally
git checkout -b $BRANCH

# Push new branch to master server
git push -u origin $BRANCH
