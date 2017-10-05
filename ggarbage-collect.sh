#!/bin/sh

echo "GIT: purge garbage collect local repo BEFORE "
git for-each-ref --format='delete %(refname)' refs/original

echo "GIT: purge garbage collect local repo"
time git for-each-ref --format='delete %(refname)' refs/original | git update-ref --stdin
git reflog expire --expire=now --all
git gc --prune=now

echo "GIT: purge garbage collect local repo AFTER"
git for-each-ref --format='delete %(refname)' refs/original
