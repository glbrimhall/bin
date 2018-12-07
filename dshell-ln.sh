#!/bin/bash

USER=gbrimhall

LNENTRIES="\
Documents \
Downloads \
abr \
bin \
.gitconfig \
github"

cd /
mv /home /home.orig
ln -s /win/Users/ /home

cd /root
ln -s /home/gbrimhall gbrimhall

foreach ENTRY in $LNENTRIES; do
  ln -s /home/$USER/$ENTRY $ENTRY
done

