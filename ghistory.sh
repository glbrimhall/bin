#!/bin/sh
DIRFILE="${1:-.}"

git log -p -- $DIRFILE
