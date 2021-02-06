#!/bin/bash
curl -v -H "Content-type: application/json" -X POST -d \
'{"jsonrpc":"2.0","method":"Settings.SetSettingValue", "params":{"setting":"audiooutput.audiodevice","value":"ALSA:hdmi:CARD=NVidia,DEV='$1'"},"id":1}' \
http://localhost:8180/jsonrpc

curl -v -H "Content-type: application/json" -X POST -d \
'{"jsonrpc":"2.0","method":"Settings.SetSettingValue", "params":{"setting":"audiooutput.passthroughdevice","value":"ALSA:hdmi:CARD=NVidia,DEV='$1'"},"id":1}' \
http://localhost:8180/jsonrpc
