#!/bin/bash
FLAC="$1"
SONG="${FLAC%.*}"
MP3="$SONG.mp3"
BITRATE=96000

echo "EXEC: avconv -i $FLAC $MP3"
avconv -i "$FLAC" "$MP3"
