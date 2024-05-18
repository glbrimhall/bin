#!/bin/bash
set -x

DEVICE=${1:-$HOSTNAME}

openssl x509 -in $DEVICE.crt -signkey $DEVICE.key -x509toreq -out $DEVICE.csr
