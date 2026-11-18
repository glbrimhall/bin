#!/bin/bash

#From https://rootlesscontaine.rs/getting-started/containerd/
#From https://github.com/containerd/nerdctl/discussions/3030
#Maybe https://context7.com/containerd/nerdctl

sudo loginctl disable-linger $USER 
systemctl --user stop containerd
containerd-rootless-setuptool.sh uninstall

rootlesskit rm -rf ~/.local/share/containerd ~/.local/share/nerdctl ~/.config/containerd ~/.config/systemd/user/containerd.service

rm -vf ~/.config/systemd/user/*

#sudo rm /usr/local/buildkit* /usr/local/nerdctl
#sudo apt purge containerd
#rm -r ~/.local/share/nerdctl/
#sudo rm -r /etc/nerdctl
#sudo /var/lib/{containerd,nerdctl,cni,buildkit}
#sudo ip link delete nerdctl
