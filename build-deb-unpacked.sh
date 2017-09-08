#debian/rules clean
dpkg-source -b
debian/rules build
fakeroot debian/rules binary
