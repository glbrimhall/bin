# From https://askubuntu.com/questions/2719/how-do-i-output-my-audio-input

  350  pacat -r --device=alsa_input.pci-0000_00_1f.3.analog-stereo | pacat -p --latency-msec=1
  351  pacat -r --device=alsa_input.pci-0000_00_1f.3.analog-stereo | pacat -p 
  352  man pcat
  353  man pacat
  354  pactl list short | egrep "alsa_(input|output)" | fgrep -v ".monitor"
  355  pactl list short

# pipes privia to bluetooth
pacat -r --device=alsa_input.pci-0000_00_1f.3.analog-stereo | pacat -p --latency-msec=1

# Works with jackd running, piping alsa:hw.0 to bluetooth (noticable latency):
pacat -r --device=jack_in | pacat -p --latency-msec=1 --process-time-msec=1
