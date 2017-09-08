#!/bin/bash
MP3="$1"
SONG="${MP3%.*}"
FLAC="$SONG.flac"
BITRATE=96000

echo "EXEC: avconv -i $MP3 -ar $BITRATE $FLAC"
avconv -i "$MP3" -ar $BITRATE "$FLAC"
