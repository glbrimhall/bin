#!/bin/sh
docker stop oracle-linux-12c &
docker stop mssql-linux-2016 &
docker stop mysql-linux-10.1.21 &
docker stop dbclient
wait
