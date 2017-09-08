#!/bin/bash
DEV=${1:-sr0}
DISK=${2:-1}
ripit \
--device /dev/$DEV \
--outputdir /win/music \
--cdtoc 1 --inf 1 \
--book $DISK \
--threads 4 \
--uppercasefirst \
--underscore \
--chars '.#|\:*?$' \
--dirtemplate '"ebook"' \
--coder 3 --quality 300 \


#--merge 1+ \
#--oggencopt "--managed -b 192 -M 224 -m 96" --quality "off" \ #ogg options

