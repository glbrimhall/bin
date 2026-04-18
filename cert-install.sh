#!/bin/bash
set -x

# This script built from steps outlined at:
# https://datacenteroverlords.com/2012/03/01/creating-your-own-ssl-certificate-authority/

# Another reference https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development/

DAYS=3650        # 10 * 365
DESTDIR=${2:-web}
ROOTCAPEM=${3:-dervish}
ROOTCA=${ROOTCAPEM%%.pem}
DEVICE=${1:-$HOSTNAME}
SUBJECT="/C=US/postalCode=93445/ST=California/L=Oceano/streetAddress=1732 19th/O=1732 19th/OU=1732 19th St/CN="
#SUBJECT="/C=US/ST=Arizona/L=Tucson/O=UALib-TESS/CN="

if [ ! -f $DESTDIR/$DEVICE.crt ]; then
  echo "MISSING $DESTDIR/$DEVICE.crt, exiting..."
  exit 1
fi

if [ ! -f /usr/local/share/ca-certificates/$ROOTCA.crt ]; then
  echo "REGISTER /usr/local/share/ca-certificates/$ROOTCA.crt"
  cp -v $DESTDIR/$ROOTCA.crt /usr/local/share/ca-certificates/$ROOTCA.crt
  sudo update-ca-certificates
fi

mkdir -p ~/.docker/certs.d/$DEVICE\:5000
cp -v $DESTDIR/$DEVICE.pem ~/.docker/certs.d/$DEVICE\:5000/ca.crt
cp -v $DESTDIR/$DEVICE.key ~/.docker/certs.d/$DEVICE\:5000/ca.key

echo "CERT: SHA-256 hash of cert"
openssl x509 -fingerprint -sha256 -noout -in $DESTDIR/$DEVICE.crt

