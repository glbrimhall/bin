#!/bin/sh
dps.sh | perl -ne '/^(\S+)/ && print "$1 "'
