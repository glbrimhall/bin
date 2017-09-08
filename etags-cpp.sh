#!/bin/sh
index_file=$1
path=$2
#etags -R --sort=1 --c++-kinds=+px --fields=+fksaiS --extra=+q --language-force=C++ -f $index_file $path
ctags -R --language-force=C++ -f $index_file $path
