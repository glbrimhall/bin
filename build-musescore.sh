#!/bin/bash
#apt-get install -f git cmake g++
#apt-get install -f  libasound2-dev portaudio19-dev libmp3lame-dev libsndfile1-dev libportaudio-doc  libjack-jackd2-0 portaudio19-doc libpulse-dev pulseaudio-module-jack

make revision
make PREFIX=$HOME/musescore
make PREFIX=$HOME/musescore install

# above taken from http://musescore.org/en/developers-handbook/compilation/compile-instructions-ubuntu-14.10-git
