#!/bin/bash

KEY=$1
VALUE=$2

echo
echo "KODI_JSON_CMD: $KEY $VALUE"
echo

curl -v -H "Content-type: application/json" -X POST -d \
'{"jsonrpc":"2.0","method":"Settings.SetSettingValue", "params":{"setting":"'$KEY'","value":"'$VALUE'"},"id":1}' \
http://localhost:8180/jsonrpc

