#!/bin/sh

sudo apt-get install -y python-pip

sudo pip install --upgrade pip

# Instructions taken from:
# https://docs.aws.amazon.com/cli/latest/userguide/awscli-install-linux.html
sudo pip install awscli --upgrade

# Instructions taken from:
# https://github.com/awslabs/aws-shell
sudo pip install aws-shell --upgrade
sudo pip install glacier-tool --upgrade
