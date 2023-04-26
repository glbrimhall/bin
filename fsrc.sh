find . -type f \( -iname \*.h -o -iname \*.hpp -o -iname \*.cpp  \) -exec       grep -nH --color $1 {} \;
#find . -type f \( ! -name \*.o ! -name \*.a ! -name index ! -iname sabine      \) -exec grep -nH --color $1 {} \;

