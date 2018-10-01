#!/bin/sh
docker run -d --restart=unless-stopped -p 4847:80 -p 4848:443 rancher/rancher
