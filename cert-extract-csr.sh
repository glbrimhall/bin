#!/bin/bash
set -x

DEVICE=${1:-localhost-proxy}

openssl x509 -in $DEVICE.crt -signkey $DEVICE.key -x509toreq -out $DEVICE.csr
