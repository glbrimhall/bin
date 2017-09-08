#fluidsynth -a alsa /usr/share/sounds/sf2/FluidR3_GM.sf2 $1
fluidsynth -a jack /home/geoff/Midi/soundfonts/Steinway_Grand_Piano_1.2.SF2 -g 0.8 $1
#fluidsynth -a alsa -o audio.alsa.device='hw:0,0' /usr/share/sounds/sf2/merlin_vienna.sf2 -g 0.8 $1
