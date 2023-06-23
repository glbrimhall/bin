#!/bin/bash

source ./rotate-devices.sh

# From https://www.reddit.com/r/linux4noobs/comments/539fw5/how_would_i_rotate_the_touch_screen_in_linux/
echo "Screen is rotated left"
xrandr --output "$SCREEN" --rotate left 

#for invert: xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1
xinput disable "$TOUCHPAD"
xinput disable "$TOUCHMOUSE"
xinput disable "$KEYBOARD"
#xinput disable "$TOUCHSTICK"
# Remove hashtag below if you want pop-up the virtual keyboard  
onboard &
    
# From https://askubuntu.com/questions/368317/rotate-touch-input-with-touchscreen-and-or-touchpad
xinput set-prop "$TOUCHSCREEN" --type=float "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1
xinput set-prop "$TOUCHERASER" --type=float "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1
xinput set-prop "$TOUCHPEN" --type=float "Coordinate Transformation Matrix" 0 -1 1 1 0 0 0 0 1

#xinput set-int-prop 9 "Atmel Axes Swap" 8 1
#xinput set-int-prop 9 "Atmel Axis Calibration" 32 4052 36 35 4156
#xinput set-prop 'ImPS/2 Generic Wheel Mouse' 'Evdev Axes Swap' 0
#xinput set-int-prop "ImPS/2 Axis Calibration" 32 4052 36 35 4156

