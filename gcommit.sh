#!/bin/sh

git commit -am "$1"

if [ "$#" = "1" ]; then
    git push
fi

#git push --tags
