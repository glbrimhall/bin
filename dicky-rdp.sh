ssh -C -L 9999:localhost:3389 -N -f -o ExitOnForwardFailure=yes -p 2021 geoff@dicky.ddns.net
#SSH_PID=$!
#echo "SSH_PID=$SSH_PID"
#sleep 1
#ssh -l geoff -C -N -L 9999:localhost:3389 -p 2021 dicky.ddns.net &
rdesktop -z -g 1400x800 -r clipboard:off -a 16 -u duser localhost:9999
lsof -ti:9999 | xargs kill
#ssh -O cancel -L 9999:localhost:3389 -N -f -p 2021 geoff@dicky.ddns.net
