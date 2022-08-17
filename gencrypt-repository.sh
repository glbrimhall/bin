#!/bin/sh

REPO=crypt7

git init
git remote add cryptremote gcrypt::git@github.com:glbrimhall/$REPO.git
gpg --list-secret-keys --keyid-format LONG
git config remote.cryptremote.gcrypt-participants ADD273BD68FEA2D1
git config remote.cryptremote.gcrypt-signingkey ADD273BD68FEA2D1

echo "Hi" > hello.txt
git add hello.txt 
git commit -m "Created"
git push -u cryptremote master

