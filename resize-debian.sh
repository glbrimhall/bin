#!/bin/sh
HOST=debian
wmctrl -r "QEMU ($HOST)" -e 0,0,0,1679,1049
wmctrl -r "QEMU ($HOST)" -t 1
