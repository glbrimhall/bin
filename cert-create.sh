#!/bin/bash
set -x

# This script built from steps outlined at:
# https://datacenteroverlords.com/2012/03/01/creating-your-own-ssl-certificate-authority/

DAYS=1095        # 3 * 365
DESTDIR=certs
ROOTCAPEM=${2}
ROOTCA=${ROOTCAPEM%%.pem}
DEVICE=${1:-localhost-proxy}
SUBJECT="/C=US/postalCode=85721/ST=Arizona/L=Tucson/streetAddress=The University of Arizona/O=The University of Arizona/OU=The University of Arizona Library/CN="
#SUBJECT="/C=US/ST=Arizona/L=Tucson/O=UALib-TESS/CN="

if [ ! -d $DESTDIR ]; then
    mkdir -p $DESTDIR
fi

if [ "$ROOTCAPEM" != "" ]; then
if [ ! -f $DESTDIR/$ROOTCA.pem ]; then

echo
echo "CERT: generating rootca $ROOTCA.pem"
echo

# Create RootCA private key
openssl genrsa -out $DESTDIR/$ROOTCA.key 2048

# creates a passwd protected root key, unwanted. Use above unless submitting to a RootAuthority !
# openssl genrsa -des3 -out $DESTDIR/$ROOTCA.key 2048

# Create RootCA public key, in pem format
openssl req -x509 -new -nodes -key $ROOTCA.key -subj "$SUBJECT$ROOTCA" -sha256 -days 1024 -out $DESTDIR/$ROOTCA.pem

# Needed if installing into apache as an intermediate CA
#openssl x509 -in $DESTDIR/$ROOTCA.pem -inform PEM -outform DER -out $DESTDIR/$ROOTCA.crt
openssl x509 -in $DESTDIR/$ROOTCA.pem -inform PEM -out $DESTDIR/$ROOTCA.crt

fi

openssl x509 -in $DESTDIR/$ROOTCA.pem -text -noout
 
INCLUDE_ROOTCA="-CA $DESTDIR/$ROOTCA.pem -CAkey $DESTDIR/$ROOTCA.key -CAcreateserial"

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

if [ "$INCLUDE_ROOTCA" != "" ]; then

echo
echo "CERT: generating $DEVICE.crt by signing $DEVICE.csr with $ROOTCA.pem"
echo

openssl x509 -req -extfile <(printf "subjectAltName=DNS:$DEVICE") -in $DESTDIR/$DEVICE.csr $INCLUDE_ROOTCA -out $DESTDIR/$DEVICE.crt -days $DAYS -sha256

openssl x509 -in $DESTDIR/$DEVICE.crt -text -noout

fi
