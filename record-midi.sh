FILE=`date +%F_%H%M%S`
cd ~/Compose/midi
arecordmidi --port 32:0 $FILE.midi
