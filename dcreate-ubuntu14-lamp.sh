#!/bin/sh
docker pull linode/lamp
docker run -p 80:8080 -t --name ubuntu14-lamp -i linode/lamp /bin/bash
