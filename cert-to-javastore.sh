#!/bin/bash
set -x

DEVICE=${1%.*}
PASSWORD=${2:-jenkinskeystorepassword}
CACERT=${3}

if [ "$CACERT" != "" ]; then
   USE_CACERT="-certfile $CACERT"
fi

echo "CERT: creating keystore for $DEVICE"

openssl pkcs12 -export -out $DEVICE.p12 \
        -passout "pass:$PASSWORD" -inkey $DEVICE.key \
        -in $DEVICE.crt $USE_CACERT -name $DEVICE

keytool -importkeystore -srckeystore $DEVICE.p12 \
        -srcstorepass "$PASSWORD" -srcstoretype PKCS12 \
        -srcalias $DEVICE -deststoretype JKS \
        -destkeystore $DEVICE.jks -deststorepass "$PASSWORD" \
        -destalias $DEVICE
