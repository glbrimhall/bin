## MYSQL ULIMIT SETTINGS:

addgroup --system dba
adduser --system --ingroup docker --disabled-password --home=/home/mysql --shell /bin/bash mysql
adduser mysql dba

SECURITY_DOCKER_DIR=/etc/security/limits.d
MYSQL_SECURITY_CONF=$SECURITY_DOCKER_DIR/mysql.conf

mkdir -p $SECURITY_DOCKER_DIR
rm $MYSQL_SECURITY_CONF

cat <<EOF >> $MYSQL_SECURITY_CONF
mysql          soft    nproc           2047
mysql          hard    nproc           16384
mysql          soft    nofile          1024
mysql          hard    nofile          65536

EOF

