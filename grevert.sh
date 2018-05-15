#!/bin/sh
ROOT_DIR="`git rev-parse --show-toplevel`"

if [ "$?" != "0" ]; then
    echo "Not in a git repository, exiting"
    exit $?
fi

cd "$ROOT_DIR"
git reset --hard
#git checkout .
git clean -fdx
