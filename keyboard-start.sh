fluidsynth -a pulseaudio -m alsa_seq -l -i /usr/share/sounds/sf2/FluidR3_GM.sf2 -s &
sleep 2
aconnect 24:0 128:0

