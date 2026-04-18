#find . -type f \( -iname \*.h -o -iname \*.hpp -o -iname \*.cpp  \) -print0 | xargs -0 grep -nH --color $1

find . -type f \
-a -not -path '*.git*' -prune \
-a -not \( -name '*~' -name '*.o' \) \
-print0 | xargs -0 grep -nH --color $1

