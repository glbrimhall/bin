#!/bin/bash

SRCDIR=${1%/}
DSTDIR=${2%/}

if [ ! -d "$SRCDIR" ]; then
    echo "ERROR: src dir $SRCDIR does not exist"
    exit 1
fi

if [ ! -d "$DSTDIR" ]; then
    echo "ERROR: dst dir $DSTDIR does not exist"
    exit 1
fi

. "$( dirname "${BASH_SOURCE[0]}" )/get-dspace-home-dir.sh"

DSTDIR_DEPTH=".."

function calculate_dstdir_depth() {
   local SUBDIR="$( cd "$1" && pwd )"

   if [ "$SUBDIR" != "$DSPACE_HOME_DIR" ]; then
       DSTDIR_DEPTH="$DSTDIR_DEPTH/.."
       calculate_dstdir_depth "$SUBDIR/.."
   fi
}

function traverse() {
   local SRC="$1"
   local DST="$2"
   local DEPTH="$3"

   echo "cd $DST ; ln -s $DEPTH/$SRC/* . 2>/dev/null; cd - >/dev/null"
   cd "$DST" ; ln -s "$DEPTH"/"$SRC"/* . 2>/dev/null; cd - >/dev/null
   #rm -f "$DST/"\*

   for file in $(ls "$SRC")
   do
       if [ -d "${SRC}/${file}" ] && [ ! -L "${DST}/${file}" ] && [ -d "${DST}/${file}" ]; then
               traverse "${SRC}/${file}" "${DST}/${file}" "$DEPTH/.."
       fi
   done
}

calculate_dstdir_depth "$DSTDIR/.."

traverse "$SRCDIR" "$DSTDIR" "$DSTDIR_DEPTH"
