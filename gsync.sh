#!/bin/bash
# Sync all code from remote into local checked out branches
git fetch --all
# Sync ( maybe merge ) the current branch
git pull
