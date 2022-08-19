DISK=$1
SIZE=$2
qemu-img create  -opreallocation=metadata -o cluster_size=2M,size=$SIZE -f qcow2 $DISK 
