#!/bin/bash

apt-get purge -y emacs-nox
apt-get autoremove -y --purge
apt-get install emacs25-nox

curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh

sudo bash nodesource_setup.sh

rm nodesource_setup.sh

sudo apt-get install nodejs

nodejs -v

NPM_MODULES="\
tern \
js-beautify \
eslint
"

for MODULE in $NPM_MODULES; do
  npm install -g $MODULE
done
