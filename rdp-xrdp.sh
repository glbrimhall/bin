HOST=${1:-localhost}
rdesktop -g 1400x800 -r clipboard:off -a 16 -u geoff $HOST 
#rdesktop -g 1400x800 -a 16 -r clipboard:PRIMARYCLIPBOARD -u geoff $HOST 

