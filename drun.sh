#!/bin/bash

. $HOME/bin/docker-default-container.sh

CONSOLE_ROWS=`tput lines`
CONSOLE_COLS=`tput cols`

echo "TTY: tput cols=$CONSOLE_COLS lines=$CONSOLE_ROWS"
echo "RUN: stty cols $CONSOLE_COLS rows $CONSOLE_ROWS"

CONTAINER=${1:-$DEFAULT_CONTAINER}
SHELL=${2:-bash}

docker start "$CONTAINER"

if [ "$SHELL" = "bash" ] || [ "$SHELL" = "sh" ]; then

    if [ "xx$MSYSTEM" != "xx" ]; then
       WINPTY=winpty
    fi
    $WINPTY docker exec -it "$CONTAINER" $SHELL -i

else

    shift
    docker exec "$CONTAINER" $@

fi

#docker exec -it "$CONTAINER" bash -c "stty cols $CONSOLE_COLS rows $CONSOLE_ROWS"
