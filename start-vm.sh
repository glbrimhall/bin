#!/bin/bash

BASEDIR=~
VM=${1:-debian}
#echo $BASEDIR $VM

$BASEDIR/bin/kill-kvm.sh $VM || exit 0

#sudo $BASEDIR/bin/reset-tun0.sh

cd $BASEDIR/qemu
./start-$VM.sh &

sleep 10

$BASEDIR/bin/resize-$VM.sh
