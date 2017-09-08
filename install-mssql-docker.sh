#!/bin/sh

docker run --name mssql-linux-2016 -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Pas6^word' -p 1433:1433 -d microsoft/mssql-server-linux 

exit


## MSSQL ULIMIT SETTINGS:

addgroup --system dba
adduser --system --ingroup docker --disabled-password --home=/home/mssql --shell /bin/bash mssql
adduser mssql dba

SECURITY_DOCKER_DIR=/etc/security/limits.d
MSSQL_SECURITY_CONF=$SECURITY_DOCKER_DIR/mssql.conf

mkdir -p $SECURITY_DOCKER_DIR
rm $MSSQL_SECURITY_CONF

cat <<EOF >> $MSSQL_SECURITY_CONF
mssql          soft    nproc           2047
mssql          hard    nproc           16384
mssql          soft    nofile          1024
mssql          hard    nofile          65536

EOF

