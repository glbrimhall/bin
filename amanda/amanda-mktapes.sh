#!/bin/sh
SITE=${1:-qumulo}
ROOTDIR=${2:-backup}

export PATH=$PATH:/usr/sbin

amstatus $SITE
amtape $SITE reset

# to do backup:
amdump $SITE

# info
amadmin config find storage1.library.arizona.edu
