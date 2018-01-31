#!/bin/sh
/usr/bin/qemu-system-x86_64 \
 -name guest=OS-X-10.12-Sierra,debug-threads=on \
 -S \
 -object secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-2-OS-X-10.12-Sierra/master-key.aes \
 -machine pc-q35-2.8,accel=kvm,usb=off,dump-guest-core=off \
 -cpu Penryn,vendor=GenuineIntel,kvm=off \
 -m 4096 \
 -realtime mlock=off \
 -smp 2,sockets=2,cores=1,threads=1 \
 -uuid 8756b90d-109a-4ef6-80ab-c56c7e8b17a0 \
 -no-user-config \
 -nodefaults \
 -chardev socket,id=charmonitor,path=/var/lib/libvirt/qemu/domain-2-OS-X-10.12-Sierra/monitor.sock,server,nowait \
 -mon chardev=charmonitor,id=monitor,mode=control \
 -rtc base=utc \
 -no-shutdown \
 -boot strict=on \
 -kernel /qemu/enoch_rev2839_boot \
 -device i82801b11-bridge,id=pci.1,bus=pcie.0,addr=0x1e \
 -device pci-bridge,chassis_nr=2,id=pci.2,bus=pci.1,addr=0x1 \
 -device ich9-usb-ehci1,id=usb,bus=pcie.0,addr=0x1d.0x7 \
 -device ich9-usb-uhci1,masterbus=usb.0,firstport=0,bus=pcie.0,multifunction=on,addr=0x1d \
 -device ich9-usb-uhci2,masterbus=usb.0,firstport=2,bus=pcie.0,addr=0x1d.0x1 \
 -device ich9-usb-uhci3,masterbus=usb.0,firstport=4,bus=pcie.0,addr=0x1d.0x2 \
 -drive file=/qemu/OS-X-10.12-Sierra.qcow2,format=qcow2,if=none,id=drive-sata0-0-0 \
 -device ide-hd,bus=ide.0,drive=drive-sata0-0-0,id=sata0-0-0,bootindex=2 \
 -drive file=/vol1/qemu/vmware-tools-darwin.iso,format=raw,if=none,media=cdrom,id=drive-sata0-0-1,readonly=on \
 -device ide-cd,bus=ide.1,drive=drive-sata0-0-1,id=sata0-0-1 \
 -netdev tap,fd=26,id=hostnet0 \
 -device e1000-82545em,netdev=hostnet0,id=net0,mac=52:54:00:af:eb:3f,bus=pci.2,addr=0x2 \
 -device usb-mouse,id=input0,bus=usb.0,port=1 \
 -device usb-kbd,id=input1,bus=usb.0,port=2 \
 -spice port=5901,addr=127.0.0.1,disable-ticketing,seamless-migration=on \
 -device vmware-svga,id=video0,vgamem_mb=16,bus=pcie.0,addr=0x1 \
 -device isa-applesmc,osk=ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc \
 -smbios type=2 \
 -cpu Penryn,vendor=GenuineIntel \
 -msg timestamp=on

