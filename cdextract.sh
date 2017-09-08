#!/bin/bash
DEV=${1:-sr0}
TRACKOFFSET=${2:-0}
DISK=${3:-}

if [ "x$DISK" != "x" ]; then

ripit \
--device /dev/$DEV \
--outputdir /home/geoff/Music/$DEV \
--cdtoc 1 --inf 1 \
--loop 1 \
--eject \
--threads 4 \
--uppercasefirst \
--underscore \
--chars "'"'.#|\:,*?$@()' \
--dirtemplate '"mp3/$artist/$album"' \
--dirtemplate '"flac/$artist/$album"' \
--tracktemplate '"'$DISK' $tracknum $trackname"' \
--trackoffset $TRACKOFFSET
--coder 0,2 --quality off,3 \
--bitrate off --preset standard --vbrmode new \
--overwrite y \
--mb \
--isrc 1 \
--mbname vinyvat \
--mbpass pas6word \
--verbose 5 

else

ripit \
--device /dev/$DEV \
--outputdir /home/geoff/Music/$DEV \
--mb \
--mbname vinyvat \
--mbpass pas6word \
--loop 1 \
--eject \
--threads 4 \
--uppercasefirst \
--underscore \
--chars "'"'.#|\:,*?$@()' \
--dirtemplate '"mp3/$artist/$album"' \
--dirtemplate '"flac/$artist/$album"' \
--tracktemplate '"$tracknum $trackname"' \
--trackoffset $TRACKOFFSET
--comment discid
--coder 0,2 --quality off,3 \
--bitrate off --preset standard --vbrmode new \
--overwrite y \
--verbose 5 

fi

exit 0

#--merge $MERGE+ \
#--merge 1+ \
#--oggencopt "--managed -b 192 -M 224 -m 96" --quality "off" \ #ogg options
#Enabling ogg: --coder 0,1,2 --quality off,7,3 \

--cdtoc 1 --inf 1 \

--cddbserver musicbrainz.org \
--transfer http \
--isrc 1 \

    --cddbserver musicbrainz.org \
--transfer http \

--utftag \

--nointeraction \
--year 1990 \


ripit \
--device /dev/$DEV \
--outputdir /home/geoff/Music \
--cdtoc 1 --inf 1 \
--eject \
--threads 4 \
--uppercasefirst \
--underscore \
--chars "'"'.#|\:,*?$@()' \
--dirtemplate '"mp3/$artist/$album"' \
--dirtemplate '"flac/$artist/$album"' \
--tracktemplate '"'$DISK' $tracknum $trackname"' \
--coder 0,2 --quality off,3 \
--bitrate off --preset standard --vbrmode new \
--protocol 5 \
--utftag \
--overwrite y \
--nointeraction \
--genre Game \
--verbose 5 
