#!/bin/sh
CONSOLE_ROWS=`tput lines`
CONSOLE_COLS=`tput cols`

echo "TTY: tput cols=$CONSOLE_COLS lines=$CONSOLE_ROWS"
echo "RUN: stty cols $CONSOLE_COLS rows $CONSOLE_ROWS"
