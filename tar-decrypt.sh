TARDIR=${1%%.*}
echo "DECRYPT $1 to $TARDIR"

# Note using streaming disables password prompt
# 7z x -p -so $TARDIR.tar.7z | tar -vx --atime-preserve -f -

7z x $TARDIR.tar.7z
tar -vx --atime-preserve -f $TARDIR.tar
rm -f $TARDIR.tar
