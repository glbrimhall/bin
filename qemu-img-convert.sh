qemu-img convert -O qcow2 -opreallocation=metadata -ocluster_size=2M $INPUT $OUTPUT
