#!/bin/sh
DAYS=${1-365}
find . -type d -atime +$DAYS
