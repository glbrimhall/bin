TARDIR=${1%%.*}
echo "DECRYPT $1 to $TARDIR"

7z x $TARDIR.tar.7z
tar -vx --atime-preserve -f $TARDIR.tar
rm -f $TARDIR.tar
