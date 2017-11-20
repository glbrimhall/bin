#!/bin/sh
HOST=${1:-intranet}
rdesktop -g 1920x1080 -a 24 -z -u geoffreyb $HOST
