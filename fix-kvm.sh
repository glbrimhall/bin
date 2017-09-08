apt-get source -b -t experimental kvm

# To rebuild entire deb:
#dpkg-buildpackage -rfakeroot

cd kvm-85+dfsg

# Just edit the sdl.c portion of the patch:
emacs ../../altgr-capslock-numkeysym-extendedkb.dff qemu/sdl.c 
fakeroot debian/rules binary
