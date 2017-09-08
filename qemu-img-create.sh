DISK=$1
SIZE=$2
qemu-img create  -opreallocation=metadata -ocluster_size=2M -f qcow2 $DISK $SIZE
