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
rm -vfr /root/.SpaceVim.d
ln -vs /home/$USER/.SpaceVim.d/ .SpaceVim.d
ln -vs /home/$USER $USER

for ENTRY in $LNENTRIES; do
  ln -vs /home/$USER/$ENTRY $ENTRY
done

cat <<EOF >> /root/.bashrc

stty -ixon

export PATH="/root/bin:$PATH"

EOF

