#!/bin/sh
dls.sh | perl -ne '/^\S+\s+\S+\s+(\S+)/ && print "$1 "'
