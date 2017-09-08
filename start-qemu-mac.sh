/usr/bin/qemu-system-x86_64 -enable-kvm -m 2048 \
                       -cpu core2duo,vendor=GenuineIntel \
                       -machine q35 \
                       -usb -device usb-kbd -device usb-mouse \
                       -device isa-applesmc,osk="insert-real-64-char-OSK-string-here" \
                       -kernel ./chameleon_svn2783_boot \
                       -smbios type=2 \
                       -netdev user,id=hub0port0 \
                       -device e1000-82545em,netdev=hub0port0,id=mac_vnet0 \
                       -monitor stdio
