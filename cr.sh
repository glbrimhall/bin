#!/bin/sh
URL=${1:-http://localhost}
CHROME=${2:-google-chrome}
DATETIME=${3:-"chrome-debug"}
TMP=/tmp
 
mkdir -p $TMP/$DATETIME

#$CHROME --auto-open-devtools-for-tabs $URL
$CHROME \
    --user-data-dir=$TMP/$DATETIME \
    --disable-infobars \
    --no-default-browser-check \
    --auto-open-devtools-for-tabs \
    -incognito \
    $URL
