TARDIR=$1
tar -vc --atime-preserve -f $TARDIR.tar $TARDIR
7z a -p $TARDIR.tar.7z $TARDIR.tar
