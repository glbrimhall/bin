#!/bin/bash
set -x

DEVICE=${1:-localhost-proxy}

openssl x509 -in $DEVICE -text -noout

echo "CERT: SHA-1 hash of cert"
openssl x509 -fingerprint -sha1 -noout -in $DEVICE
