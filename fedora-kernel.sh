#yum install -y rpmdevtools yum-utils ncurses-devel
VERSION=3.9.5-301.fc19

rpmbuild -bb --with baseonly --with firmware \
--without debuginfo \
--target=`uname -m` kernel.spec 

exit

cd /home/geoff/rpmbuild/SPECS
rpmbuild -bp --target=$(uname -m) kernel.spec

exit

rpmdev-setuptree
yumdownloader --source kernel-$VERSION
yum-builddep kernel-$VERSION.src.rpm
rpm -Uvh kernel-$VERSION.src.rpm
