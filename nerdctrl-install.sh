containerd-rootless-setuptool.sh install
containerd-rootless-setuptool.sh install-buildkit
containerd-rootless-setuptool.sh install-buildkit-containerd

containerd-rootless-setuptool.sh install-bypass4netnsd
nerdctl run --label nerdctl/bypass4netns=true
systemctl --user restart bypass4netnsd.service

mkdir -p ~/.docker/ 2>/dev/null
# From https://stackoverflow.com/questions/42211380/add-insecure-registry-to-docker
cat <<EOF >>~/.docker/config.json
{
    "insecure-registries" : [ "hostname.cloudapp.net:5000" ]
}
EOF

# From https://github.com/containerd/nerdctl/discussions/1536 
sudo ln -s /usr/sbin/iptables /usr/local/bin/iptables 
sudo ln -s /usr/sbin/ip6tables /usr/local/bin/ip6tables 
docker run -d -p 5000:5000 --name registry registry:2.7

