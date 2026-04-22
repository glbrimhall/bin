#!/bin/bash
SCRIPTDIR="$( dirname "$(readlink -f "$0")" )"
cd "$SCRIPTDIR/.."

set -x

NERD_VER=2.2.1
export NERD_VER

if [ "xx$WSLENV" != "xx" ]; then
if $(grep croup /etc/fstab > /dev/null); then
# for wsl2:
  sudo cp -v ~/bin/wsl/etc-wsl.conf /etc/wsl.conf
  cp -v ~/bin/wsl/win-userprofile-dot.wslconfig ~/windows/.wslconfig
  # From https://stackoverflow.com/questions/73021599/how-to-enable-cgroup-v2-in-wsl2 
  sudo echo "cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate 0 0" >> /etc/fstab
  echo "RESTART wsl, then rerun script"
  exit
fi
fi

sudo apt-get install fuse-overlayfs dbus-user-session slirp4netns rootlesskit iptables uidmap wget curl

# From https://rootlesscontaine.rs/getting-started/common/cgroup2/

if [ ! -f  /etc/systemd/system/user@.service.d/delegate.conf ]; then 
sudo mkdir -p /etc/systemd/system/user@.service.d
cat <<EOF | sudo tee /etc/systemd/system/user@.service.d/delegate.conf
[Service]
Delegate=cpu cpuset io memory pids
EOF
sudo systemctl daemon-reload
fi

if [ ! -f "/tmp/nerdctl-$NERD_VER-linux-amd64.tar.gz" ]; then
wget --no-check-certificate -P /tmp "https://github.com/containerd/nerdctl/releases/download/v$NERD_VER/nerdctl-full-$NERD_VER-linux-amd64.tar.gz"

find /usr/local -type d -print0 | sudo xargs -0 chmod 2775
sudo chown -R root:adm /usr/local
sudo usermod -a -G adm $USER

tar Cxzvvf /usr/local "/tmp/nerdctl-full-$NERD_VER-linux-amd64.tar.gz"

  if [ ! -f /usr/local/bin/nerdctl ]; then
  echo "Failed to install /usr/local/bin/nerdctl"
  exit 1
  fi
fi

containerd-rootless-setuptool.sh install
containerd-rootless-setuptool.sh install-buildkit
containerd-rootless-setuptool.sh install-buildkit-containerd

containerd-rootless-setuptool.sh install-bypass4netnsd
nerdctl run --label nerdctl/bypass4netns=true
systemctl --user restart bypass4netnsd.service

mkdir -p ~/.docker/ 2>/dev/null
# From https://stackoverflow.com/questions/42211380/add-insecure-registry-to-docker
# cat <<EOF >>~/.docker/config.json
# {
#     "insecure-registries" : [ "hostname.cloudapp.net:5000" ]
# }
# EOF

# From https://github.com/containerd/nerdctl/discussions/1536 
sudo ln -s /usr/sbin/iptables /usr/local/bin/iptables 
sudo ln -s /usr/sbin/ip6tables /usr/local/bin/ip6tables 
sudo ln -s /usr/local/bin/nerdctl /usr/local/bin/docker 

# docker run -d --restart always -p 5000:5000 --name registry registry:2.7
cd ~/bin
./dregistry-create.sh
