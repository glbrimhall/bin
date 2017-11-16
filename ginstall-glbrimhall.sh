#!/bin/bash

USERNAME=${1:-glbrimhall}

git clone git@github.com:$USERNAME/bin.git
git clone git@github.com:$USERNAME/dot.emacs.d.git
ln -s /home/$USERNAME/dot.emacs.d /home/$USERNAME/.emacs.d
ln -s /home/$USERNAME/dot.emacs.d/dot.emacs /home/$USERNAME/.emacs
