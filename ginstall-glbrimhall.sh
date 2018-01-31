#!/bin/bash

USERNAME=${1:-glbrimhall}

git clone git@github.com:$USERNAME/bin.git
ln -s /home/$USERNAME/bin/dot.gitconfig-glb-linux /home/$USERNAME/.gitconfig

git clone git@github.com:$USERNAME/dot.emacs.d.git
ln -s /home/$USERNAME/dot.emacs.d /home/$USERNAME/.emacs.d
ln -s /home/$USERNAME/dot.emacs.d/dot.emacs /home/$USERNAME/.emacs
