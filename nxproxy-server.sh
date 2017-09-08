rm -f /tmp/.X11-unix/X8
nxproxy -C link=isdn type=unix-application  connect=127.0.0.1 127.0.0.1:8 &
export DISPLAY=:8
