#!/bin/bash

source ./rotate-devices.sh

# From https://www.reddit.com/r/linux4noobs/comments/539fw5/how_would_i_rotate_the_touch_screen_in_linux/
isEnabled=$(xinput --list-props "$TOUCHPAD" | awk '/Device Enabled/{print $NF}')

if [ $isEnabled == 1 ] 
then
   $HOME/bin/rotate-left.sh
else
   $HOME/bin/rotate-normal.sh
fi
