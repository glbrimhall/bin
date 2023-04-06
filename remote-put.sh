
REMOTE_SH=~/idirect/bin/remote-ip.sh 

if [ "xx$2" != "xx" ]; then
echo "REMOTE_IP=$2" > "$REMOTE_SH" 
fi

if [ -e "$REMOTE_SH" ]; then
. "$REMOTE_SH" 
fi

IP=${2:-$REMOTE_IP}

#scp $1 root@$IP:/common/gbrimhall/

#rm ~/.ssh/known_hosts 2 > /dev/null

# Note NOT using "$1" causes bash to eval a glob to a list of files

remote-expect-scp.sh $1 "root@$IP:/common/gbrimhall/"

