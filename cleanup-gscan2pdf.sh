tar -xf *.gs2f
cat session | perl -ne '++$i; /gscan2pdf-jzoi\/(\S+.pnm)/ && print "$1\n"' > pnm.list
cat session | perl -ne '++$i; /dir....(\d+)/ && printf( "mv   %.03d.pnm\n", $1 )' > cleanup.sh
