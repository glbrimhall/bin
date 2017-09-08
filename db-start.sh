#!/bin/sh
docker start oracle-linux-12c
docker start mssql-linux-2016
docker start mysql-linux-10.1.21
~/bin/drun.sh dbclient
