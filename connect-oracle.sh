if [ "$1" = "" ]; then
   docker exec -it oracle-docker bash
else
   docker exec oracle-docker sh -c "exec $1"
fi
