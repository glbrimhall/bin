#!/bin/sh
SITE=${1:-config}

amserverconfig $SITE \
   --template=harddisk
   --tapedev=file://d1/amanda/vtapes/$SITE \
   --dumpcycle=7 \
   --tapecycle=30 \
   --mailto root@email.arizona.edu \


#for ((i=1;$i<=30;i++)); do amlabel $SITE $SITE-0$i slot $i; done


amstatus $SITE
amtape $SITE reset

# to do backup:
amdump $SITE

# info
amadmin config find storage1.library.arizona.edu
