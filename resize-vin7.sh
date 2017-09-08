#!/bin/sh
HOST=vin7
wmctrl -r "QEMU ($HOST)" -e 0,0,0,1919,1199
#wmctrl -r "QEMU ($HOST)" -e 0,0,0,1679,1049
wmctrl -r "QEMU ($HOST)" -t 2
