#!/bin/sh

SF=/usr/share/sounds/sf3/MuseScore_General_Full.sf3
#SF=/usr/share/sounds/sf2/FluidR3_GM.sf2

fluidsynth -a alsa -o audio.alsa.device='hw:0' $SF $1 
#fluidsynth -a alsa -o audio.alsa.device='hw:0,0' /usr/share/sounds/sf2/merlin_vienna.sf2 -g 0.8 $1
