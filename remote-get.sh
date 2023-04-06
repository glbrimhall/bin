
set -x

REMOTE_SH=~/idirect/bin/remote-ip.sh 

if [ "xx$2" != "xx" ]; then
echo "REMOTE_IP=$2" > "$REMOTE_SH" 
fi

if [ -e "$REMOTE_SH" ]; then
. "$REMOTE_SH" 
fi

IP=${2:-$REMOTE_IP}

#scp root@$IP:/common/gbrimhall/$1 .

#rm ~/.ssh/known_hosts 2 > /dev/null

remote-expect-scp.sh "root@$IP:/common/gbrimhall/$1" "."

