HOST=${1:-localhost}
RDP_USER=${2:-duser}

# NOTE: "-a 16" bit color depth necessary for java GUI
rdesktop -g 1400x800 -r clipboard:off -a 16 -u $RDP_USER $HOST
#rdesktop -g 1400x800 -a 16 -r clipboard:PRIMARYCLIPBOARD -u $RDP_USER $HOST

