#!/bin/sh
#gmplayer -vo gl2 -ao alsa -fps 30000/1001 -demuxer lavf $1
#gmplayer -vo gl2 -ao alsa -fps 30000/1001 -demuxer lavf -ac ffeac3 -vc ffvc1 $1
#gmplayer -vo gl2 -ao alsa -fps 30000/1001 -demuxer lavf -ni  $1
#gmplayer -vo gl2 -ao alsa -fps 30000/1001 -demuxer lavf -ni -vc ffmpeg12,mpeg12 $1
#gmplayer -vo gl2 -ao alsa -fps 30000/1001 -demuxer lavf -vc ffvc1 $1
#gmplayer -vo gl2 -ao alsa -fps 30000/1001 -demuxer lavf -ac ffac3 $1
#gmplayer -vo gl2 -ao alsa -fps 30000/1001 -demuxer lavf -ac ffac3 -ni $1
mplayer -nogui -cache 8192 -demuxer lavf -aid 1 -lavdopts threads=2:fast:skiploopfilter=all -channels 6 -ao alsa:device=hw=4.0 $1
