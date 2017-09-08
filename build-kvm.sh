cd /usr/src
sudo apt-get source qemu-kvm
sudo apt-get build-dep qemu-kvm
sudo apt-get install libvdeplug2-dev libvde0 vde2 libvdeplug2
cd qemu-kvm-1.0+noroms/
Edit configure file and enable the vde option:

vde="yes"
Then you can build the pakage:

dpkg-buildpackage -j8 -rfakeroot -uc -b
