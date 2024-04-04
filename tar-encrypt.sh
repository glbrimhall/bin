TARDIR=$1
echo "ENCRYPT to $TARDIR to $TARDIR.tar.7z"

tar -vc --atime-preserve -f - $TARDIR | 7z a -si -p $TARDIR.tar.7z
