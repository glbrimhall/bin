#!/bin/bash
DEV=${1:-sr0}
DISK=${2:-}

ripit \
--device /dev/$DEV \
--outputdir /win/music \
--cdtoc 1 --inf 1 \
--loop 1 \
--eject \
--threads 4 \
--uppercasefirst \
--underscore \
--chars "'"'.#|\:,*?$@()' \
--dirtemplate '"mp3/$artist/$album"' \
--dirtemplate '"flac/$artist/$album"' \
--tracktemplate '"$tracknum $trackname"' \
--coder 0,2 --quality off,3 \
--bitrate off --preset standard --vbrmode new \
--overwrite y \
--verbose 5 
