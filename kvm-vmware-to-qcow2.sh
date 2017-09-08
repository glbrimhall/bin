SRC=$1
DST=$2
kvm-img convert  -O qcow2 -o preallocation=metadata $SRC $DST

