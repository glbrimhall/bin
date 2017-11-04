#!/bin/sh
BRANCH=$1
FORCE=$2
DELETE_FLAG="-d"

if [ "$BRANCH" == "" ]; then
  echo "Must specify a branch to delete"
  echo "Usage: ./gbranch-delete.sh <branch_name> [optional_force_delete_without_merge]"
  exit 1
fi

# Note, to force deletion of a branch without being merged, use $DELETE_FLAG

if [ "$FORCE" != "" ]; then
  DELETE_FLAG="-D"
fi

git branch $DELETE_FLAG $BRANCH
git push $DELETE_FLAG origin $BRANCH
