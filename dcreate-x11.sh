NAME=${1:-dclient}

#REPOSITORY=repository/ubuntu-xclock
REPOSITORY=x11-oracle-client
# NOTE: do not add -h $NAME (ie --hostname $name), this breaks the X client communication

docker run -e DISPLAY -v $HOME/.Xauthority:/root/.Xauthority --net=host --name $NAME --user dba --workdir=/home/dba -it $REPOSITORY bash
