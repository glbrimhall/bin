#!/bin/sh

PRIMARY="$1"
INTERMEDIATE="$2"

if [ ! -f "$PRIMARY" ] || [ ! -f "$INTERMEDIATE" ]; then
    echo "USAGE: ./cert-chain.sh <PRIMARY.crt> <INTERMEDIATE-CHAIN.crt>"
    exit 1
fi

cat $PRIMARY
echo
cat $INTERMEDIATE
echo
