#!/bin/bash
DEV=${1:-sr0}
DISK=${2:-01}
#exit
ripit \
--device /dev/$DEV \
--outputdir /win/music \
--cdtoc 1 --inf 1 \
--loop 1 \
--eject \
--threads 4 \
--uppercasefirst \
--underscore \
--chars '.#|\:*?$' \
--dirtemplate '"mp3/$artist/$album"' \
--dirtemplate '"ogg/$artist/$album"' \
--dirtemplate '"flac/$artist/$album"' \
--tracktemplate '"'$DISK' $tracknum $trackname"' \
--coder 0,1,2 --quality off,6,3 \
--bitrate off --preset standard --vbrmode new \
--overwrite y \
--nointeraction \
--genre Game \
--verbose 5 

#--merge $MERGE+ \
#--merge 1+ \
#--oggencopt "--managed -b 192 -M 224 -m 96" --quality "off" \ #ogg options

