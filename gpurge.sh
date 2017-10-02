#!/bin/sh

# These steps taken from https://dalibornasevic.com/posts/2-permanently-remove-files-and-folders-from-git-repo

FILEDIR=$1

if [ "$FILEDIR" == "" ]; then
    echo "Must specify a directory to permantely purge from your git repository"
fi


if [ -d "$FILEDIR" ]; then
   echo "GIT: purging directory $FILEDIR"

   # Remove all traces of directory
   time git filter-branch --tree-filter "rm -rf $FILEDIR" --prune-empty HEAD
else
   echo "GIT: purging file $FILEDIR"

   # Remove all traces of a file
   time git filter-branch --index-filter "git rm --cached --ignore-unmatch $FILEDIR" --prune-empty HEAD
fi

echo "GIT: pushing purge to master"
time git push origin master --force

echo "GIT: purge garbage collect local repo BEFORE "
git for-each-ref --format='delete %(refname)' refs/original

echo "GIT: purge garbage collect local repo"
time git for-each-ref --format='delete %(refname)' refs/original | git update-ref --stdin
git reflog expire --expire=now --all
git gc --prune=now

echo "GIT: purge garbage collect local repo AFTER"
git for-each-ref --format='delete %(refname)' refs/original

echo "GIT: purge garbage collect push to master"
git push origin --force --all
git push origin --force --tags
