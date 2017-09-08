QEMU_DIR=/data1/qemu

if [ "$1" == "" ]; then
    echo "ERROR: Must specify vm name"
    echo "USAGE: qcow-create.sh <vm-name> [size:-20G]"
    exit 1
else
NAME=$1
fi

SIZE=${1:-20g}

if [ "$2" == "" ]; then
    SIZE=20G
else
    SIZE=$2
fi

qemu-img create -f qcow2 $QEMU_DIR/$NAME.qcow2 $SIZE
