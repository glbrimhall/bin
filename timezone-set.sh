#!/bin/sh

if [ "xx$1" = "xx" ]; then
   timedatectl list-timezones
else
   sudo timedatectl set-timezone $1 
fi

