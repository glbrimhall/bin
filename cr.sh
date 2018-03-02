#!/bin/sh
URL=${1:-http://localhost/upload}
CHROME=${2:-google-chrome}
#DATETIME=`date +%Y-%m-%d.%H.%M.%S`
DATETIME=${3:-"chrome-debug"}
TMP=/tmp
 
mkdir -p $TMP/$DATETIME

#$CHROME --auto-open-devtools-for-tabs $URL
#    --disable-infobars \

if [ "`hostname`" = "glb-linux" ]; then
SIZED_POSITION="\
 --window-position=100,900 \
 --window-size=1200,1224"
fi

$CHROME $SIZED_POSITION \
    --user-data-dir=$TMP/$DATETIME \
    --no-default-browser-check \
    --auto-open-devtools-for-tabs \
    -incognito \
    $URL 2>/dev/null
