#!/bin/bash
BRANCH=${1:-master}
git pull
git pull origin $BRANCH
