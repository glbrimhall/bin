#!/bin/sh

SHARE=${1:-preserve}

cd /backup
find $SHARE/vtapes -type f -exec ls -lh {} \;
