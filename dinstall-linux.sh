#!/bin/bash
set -x

DOCKERDIR=${1}

if [ -f /etc/issue ]; then
    PACKAGER='apt'
    OSNAME=`cat /etc/issue | perl -ne '/(\w+)/ && print lc( $1 )'`
else
    PACKAGER='yum'
    OSNAME=`cat /etc/issue | perl -ne '/(\w+)/ && print lc( $1 )'`
fi

if [ "$PACKAGER" == "apt" ]; then
    
apt-get remove docker docker-engine docker.io

#        linux-image-extra-$(uname -r) \
#        linux-image-extra-virtual \

apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common \
        colordiff

curl -fsSL https://download.docker.com/linux/$OSNAME/gpg | sudo apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$OSNAME \
   $(lsb_release -cs) \
   stable"

apt-get update
apt-get install -y docker-ce

if [ "$SUDO_USER" != "" ]; then
   usermod -a -G docker $SUDO_USER
fi

else

echo "TODO: write docker installer for yum based systems"
    
fi

cat <<EOF > /etc/docker/daemon.json
{
    "registry-mirrors": ["https://dockerepo.library.arizona.edu"]
}
EOF

if [ -e ~/etc.docker.tar.gz ]; then
    cd /etc/ ; tar -xzvf ~/etc.docker.tar.gz; cd -
    service docker restart
fi

if [ -d "$DOCKERDIR" && ! -d "$DOCKERDIR/docker-engine" ]; then
    service docker stop
    cp -a /var/lib/docker $DOCKERDIR/docker-engine
    rm -fr /var/lib/docker
    ln -s $DOCKERDIR/docker-engine /var/lib/docker
    service docker start
fi

echo "INSTALL docker-compose"

apt-get install -y python-pip
pip install docker-compose

