#!/bin/sh
# on server side
exportfs -v
exportfs -rv

# on client side
showmount -e dspace-nfsdev
