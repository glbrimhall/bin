#!/bin/sh

SSH_PUB=.ssh/id_rsa.pub
HOSTNAME=`hostname`

if [ ! -f $SSH_PUB ]; then
   echo "SSH: generating keys - upload the public key to https://github.com/"

   ssh-keygen
   cp $SSH_PUB $SSH_PUB-$HOSTNAME

   echo "SSH: publish $SSH_PUB-$HOSTNAME into github"
   cat $SSH_PUB-$HOSTNAME
   exit
fi

echo "GIT: cloning bin.git"

git clone git@github.com:glbrimhall/bin.git

if [ ! `which gcommit.sh` ]; then

echo >> ~/.bashrc
echo "# set PATH so it includes user\'s private bin if it exists" >> ~/.bashrc
echo 'if [ -d "$HOME/bin" ] ; then' >> ~/.bashrc
echo '   PATH="$HOME/bin:$PATH"' >> ~/.bashrc
echo 'fi' >> ~/.bashrc
    
fi

if [ ! ~/.gitconfig ]; then
   ln -s ~/bin/dot.gitconfig-glb-linux ~/.gitconfig
fi

echo "GIT: cloning dot.emacs.d.git"

git clone git@github.com:glbrimhall/dot.emacs.d.git

rm -fr ~/.emacs.d
rm -f ~/.emacs
ln -s dot.emacs.d ~/.emacs.d
ln dot.emacs.d/dot.emacs ~/.emacs
