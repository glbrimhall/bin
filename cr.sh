#!/bin/sh
URL=${1:-http://localhost}
CHROME=${2:-google-chrome}
#DATETIME=`date +%Y-%m-%d.%H.%M.%S`
DATETIME=${3:-"chrome-debug"}
TMP=/tmp
 
mkdir -p $TMP/$DATETIME

#$CHROME --auto-open-devtools-for-tabs $URL
#    --disable-infobars \

$CHROME \
    --window-position=300,800 \
    --window-size="1200,1224" \
    --user-data-dir=$TMP/$DATETIME \
    --no-default-browser-check \
    --auto-open-devtools-for-tabs \
    -incognito \
    $URL 2>/dev/null
