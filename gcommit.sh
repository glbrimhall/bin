#!/bin/sh
git commit -am "$1"
git push
git push --tags
