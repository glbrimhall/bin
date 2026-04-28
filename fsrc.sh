#find . -type f \( -iname \*.h -o -iname \*.hpp -o -iname \*.cpp  \) -print0 | xargs -0 grep -nH --color $1

find . -type f \
-a \( -not -path '*.git*' -not -path '*cpp*' -not -path '*vendor*' \) -prune \
-a \( -not -name '*~' -not -name '*.o' -not -iname '*.log' \) \
-print0 | xargs -0 grep -nH --color $1

