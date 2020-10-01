#!/bin/bash

# From `xrandr`
SCREEN="eDP-1-1"
# From `xinput --list`
KEYBOARD="AT Translated Set 2 keyboard"
TOUCHSCREEN="SYNAPTICS Synaptics Touch Digitizer V04"
TOUCHSTICK="AlpsPS/2 ALPS DualPoint Stick"
TOUCHPAD="AlpsPS/2 ALPS DualPoint TouchPad"

# From https://www.reddit.com/r/linux4noobs/comments/539fw5/how_would_i_rotate_the_touch_screen_in_linux/
isEnabled=$(xinput --list-props "$TOUCHPAD" | awk '/Device Enabled/{print $NF}')

if [ $isEnabled == 1 ] 
then
   ~/bin/rotate-left.sh
else
   ~/bin/rotate-normal.sh
fi
