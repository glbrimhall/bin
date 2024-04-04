TARDIR=$1
echo "ENCRYPT to $TARDIR to $TARDIR.tar.7z"

tar -vc --atime-preserve -f $TARDIR.tar $TARDIR
7z a -p $TARDIR.tar.7z $TARDIR.tar
rm -f $TARDIR.tar
