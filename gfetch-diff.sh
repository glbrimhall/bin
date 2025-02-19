BRANCH="${1:-master}"

git fetch --all --prune

echo "COMMITS..."
echo

git log $BRANCH..origin/$BRANCH 

echo
echo "DIFF ..."
echo
git diff $BRANCH origin/$BRANCH 
