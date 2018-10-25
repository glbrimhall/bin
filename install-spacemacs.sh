#!/bin/bash

EMACS_DIR="projects/emacs"

mkdir -p "$EMACS_DIR"
cd "$EMACS_DIR"

git clone https://github.com/syl20bnr/spacemacs
git clone git@github.com:glbrimhall/dot.emacs.d.git

sudo $HOME/bin/install-nodejs.sh

cd $HOME
rm -vf .emacs.d
rm -vf .spacemacs

ln -vs "$EMACS_DIR/spacemacs" .emacs.d
ln -vs "$EMACS_DIR/dot.emacs.d/dot.spacemacs" .spacemacs
