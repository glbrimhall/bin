DATE_PREFIX="`date +%F-%H.%M`"
SAVE_DIR=/home/geoff/Compose/ardour3
NEW_SESSION="$SAVE_DIR/$DATE_PREFIX-jordan"

a2jmidid -e &

alsa_out -d iec958:CARD=SB,DEV=0 -j spdif &
alsa_out -d hw:CARD=Headset,DEV=0 -r 48000 -j headset &


sleep 2

ardour3 --new $NEW_SESSION &

