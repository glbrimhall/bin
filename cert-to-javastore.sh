#!/bin/bash
set -x

DEVICE=${1%.*}

echo "CERT: creating keystore for $DEVICE"
exit

openssl pkcs12 -export -out $DEVICE.p12 \
        -passout 'pass:changeit' -inkey example.com.key \
        -in example.com.crt -certfile ca.crt -name example.com.key


openssl x509 -in $DEVICE -text -noout

echo "CERT: SHA-1 hash of cert"
openssl x509 -fingerprint -sha1 -noout -in $DEVICE
