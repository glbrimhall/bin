#!/bin/sh

BRANCH=$1
ROOT_DIR="`git rev-parse --show-toplevel`"

if [ "$?" != "0" ]; then
    echo "Not in a git repository, exiting"
    exit $?
fi

cd "$ROOT_DIR"

HEAD_DIFF="`git diff --name-only`"

if [ "$HEAD_DIFF" != "" ]; then
  echo "Branch has uncommitted changes, aborting..."
  echo $HEAD_DIFF
  echo
  exit 1
fi

git merge --no-commit --no-ff $BRANCH

