if [ "$1" = "" ]; then
   docker exec -it mysql-linux-10.1.21 bash
else
   docker exec mysql-linux-10.1.21 sh -c "exec $1"
fi
