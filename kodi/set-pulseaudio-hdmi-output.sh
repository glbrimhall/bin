#!/bin/sh

while true; do
  if `pulseaudio --check`; then
    pulseaudio -k
  fi
  sleep 2
done

exit 0


#https://gitlab.freedesktop.org/pulseaudio/pulseaudio/-/issues/445
#https://askubuntu.com/questions/1204000/wrong-audio-output-after-unlocking
#Get default sink:

while true; do
   # From https://wiki.archlinux.org/index.php/PulseAudio/Examples#Set_the_default_output_sink
   pacmd set-default-sink alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1
   pacmd set-card-profile alsa_card.pci-0000_01_00.1 output:hdmi-stereo-extra1
   sleep 2
done

