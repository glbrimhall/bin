 349  pact -r --device=alsa_input.pci-0000_00_1f.3.analog-stereo | pact -p --latency-msec=1
  350  pacat -r --device=alsa_input.pci-0000_00_1f.3.analog-stereo | pacat -p --latency-msec=1
  351  pacat -r --device=alsa_input.pci-0000_00_1f.3.analog-stereo | pacat -p 
  352  man pcat
  353  man pacat
  354  pactl list short | egrep "alsa_(input|output)" | fgrep -v ".monitor"
  355  pactl list short
