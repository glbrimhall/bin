#!/bin/sh
HOST=$1
REPO_PATH=$2

ssh $HOST "cd $REPO_PATH && git count-objects -vH"
