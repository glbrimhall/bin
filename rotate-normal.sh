#!/bin/bash

source ./rotate-devices.sh

# From https://www.reddit.com/r/linux4noobs/comments/539fw5/how_would_i_rotate_the_touch_screen_in_linux/
echo "Screen is rotated normal"
xrandr --output "$SCREEN" --rotate normal

#for invert: xinput set-prop 'ELAN Touchscreen' 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1
xinput enable "$TOUCHPAD"
xinput enable "$TOUCHMOUSE"
xinput enable "$KEYBOARD"
# Remove hashtag below if you want pop-up the virtual keyboard  
# onboard &
    
# From https://askubuntu.com/questions/368317/rotate-touch-input-with-touchscreen-and-or-touchpad
xinput set-prop "$TOUCHSCREEN" --type=float "Coordinate Transformation Matrix" 0 0 0 0 0 0 0 0 0
xinput set-prop "$TOUCHERASER" --type=float "Coordinate Transformation Matrix" 0 0 0 0 0 0 0 0 0
xinput set-prop "$TOUCHPEN" --type=float "Coordinate Transformation Matrix" 0 0 0 0 0 0 0 0 0

#xinput set-int-prop 9 "Atmel Axes Swap" 8 0
#xinput set-int-prop 9 "Atmel Axis Calibration" 16 2179 -22 3995"
#xinput set-prop 'ImPS/2 Generic Wheel Mouse' 'Evdev Axes Swap' 1
#xinput set-int-prop 12 "ImPS/2 Axis Calibration" 32 -5 4100 59 4100
