#!/bin/sh
sudo apt-get install python3-pip python3-qtpy python3-superqt libxcb-cursor0
pip install --break-system-packages --upgrade tidal-dl-ng[gui]
mkdir -p ~/Music/tidal
mkdir -p ~/.config/tidal_dl_ng
cp tidal-settings.json ~/.config/tidal_dl_ng/settings.json

