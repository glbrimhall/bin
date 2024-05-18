n#!/bin/bash
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

if [ ! -d $DESTDIR ]; then
    mkdir -p $DESTDIR
fi

if [ "$ROOTCAPEM" != "" ] || [ "$ROOTCAPEM" != "self" ]; then
if [ ! -f $DESTDIR/$ROOTCA.pem ]; then

echo
echo "CERT: generating rootca $ROOTCA.pem"
echo

# Create RootCA private key
openssl genrsa -out $DESTDIR/$ROOTCA.key 2048

# creates a passwd protected root key, unwanted. Use above unless submitting to a RootAuthority !
# openssl genrsa -des3 -out $DESTDIR/$ROOTCA.key 2048

# Create RootCA public key, in pem format
openssl req -x509 -new -nodes -key $DESTDIR/$ROOTCA.key -subj "$SUBJECT$ROOTCA" -sha256 -days $DAYS -out $DESTDIR/$ROOTCA.pem

# Needed if installing into apache as an intermediate CA
#openssl x509 -in $DESTDIR/$ROOTCA.pem -inform PEM -outform DER -out $DESTDIR/$ROOTCA.crt
openssl x509 -in $DESTDIR/$ROOTCA.pem -inform PEM -out $DESTDIR/$ROOTCA.crt

if [ ! -f /usr/local/share/ca-certificates/$ROOTCA.crt ]; then
  echo "REGISTER /usr/local/share/ca-certificates/$ROOTCA.crt"
  cp -v $DESTDIR/$ROOTCA.crt /usr/local/share/ca-certificates/$ROOTCA.crt
  sudo update-ca-certificates
fi

fi

openssl x509 -in $DESTDIR/$ROOTCA.pem -text -noout

SIGNING_KEY="-CA $DESTDIR/$ROOTCA.pem -CAkey $DESTDIR/$ROOTCA.key -CAcreateserial"

fi

if [ ! -f $DESTDIR/$DEVICE.csr ]; then

echo
echo "CERT: generating $DEVICE.csr"
echo

# Create device private key. Note disabled because combined below in csr:
#openssl genrsa -out $DESTDIR/$DEVICE.key 2048

# Create device public key:
openssl req -nodes -newkey rsa:2048 -keyout $DESTDIR/$DEVICE.key -subj "$SUBJECT$DEVICE" -out $DESTDIR/$DEVICE.csr

fi

if [ "$ROOTCA" == "self" ]; then
    SIGNING_KEY="-signkey $DESTDIR/$DEVICE.key"
fi

if [ "$SIGNING_KEY" != "" ]; then

echo
echo "CERT: generating $DEVICE.crt by signing $DEVICE.csr with $SIGNING_KEY"
echo

openssl x509 -req -extfile <(printf "subjectAltName=DNS:$DEVICE") -in $DESTDIR/$DEVICE.csr $SIGNING_KEY -out $DESTDIR/$DEVICE.crt -days $DAYS -sha256

openssl x509 -in $DESTDIR/$DEVICE.crt -text -noout

echo "CREATE $DEVICE.pem"
# From https://medium.com/@deekonda.ajay/create-your-own-secured-docker-private-registry-with-ssl-6a44539f74b8
cat $DESTDIR/$DEVICE.key $DESTDIR/$DEVICE.crt $DESTDIR/$ROOTCA.crt > $DESTDIR/$DEVICE.pem

echo "CERT: SHA-256 hash of cert"
openssl x509 -fingerprint -sha256 -noout -in $DESTDIR/$DEVICE.crt

fi
