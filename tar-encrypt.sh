TARDIR=$1
7z x -p $TARDIR.tar.7z
tar -vx --xz --atime-preserve -f $TARDIR.tar 
