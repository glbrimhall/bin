ACTION=${1:-stop}

sudo systemctl $ACTION nordvpnd
systemctl $ACTION --user containerd

