DOWNLOAD_DIR=~/Download/oracle-docker
mkdir -p $DOWNLOAD_DIR
cd $DOWNLOAD_DIR

# download install scripts
wget https://github.com/oracle/docker-images/archive/master.zip

# download oracle zip files
LANG=C
export LANG

# SSO username and password
SSO_USERNAME='maclinvin@gmail.com'
SSO_PASSWORD='IMRizIe9mlP8TN9cJeTs'

# Path to wget command
WGET=/usr/bin/wget
# Location of cookie file
COOKIE_FILE=/tmp/$$.cookies

# Log directory and file
LOGDIR=.
LOGFILE=$LOGDIR/wgetlog-`date +%m-%d-%y-%H:%M`.log
# Output directory and file
OUTPUT_DIR=.
#
# End of user configurable variable
#

if [ "$SSO_PASSWORD " = " " ]
then
 echo "Please edit script and set SSO_PASSWORD"
 exit
fi

# Contact osdc site so that we can get SSO Params for logging in
SSO_RESPONSE=`$WGET --user-agent="Mozilla/5.0" --no-check-certificate https://edelivery.oracle.com/osdc/faces/SearchSoftware 2>&1|grep Location`

# Extract request parameters for SSO
SSO_TOKEN=`echo $SSO_RESPONSE| cut -d '=' -f 2|cut -d ' ' -f 1`
SSO_SERVER=`echo $SSO_RESPONSE| cut -d ' ' -f 2|cut -d '/' -f 1,2,3`
SSO_AUTH_URL=/sso/auth
AUTH_DATA="ssousername=$SSO_USERNAME&password=$SSO_PASSWORD&site2pstoretoken=$SSO_TOKEN"

# The following command to authenticate uses HTTPS. This will work only if the wget in the environment
# where this script will be executed was compiled with OpenSSL. Remove the --secure-protocol option
# if wget was not compiled with OpenSSL
# Depending on the preference, the other options are --secure-protocol= auto|SSLv2|SSLv3|TLSv1

# TRY:
# wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie;" http://download.oracle.com/otn-pub/java/jdk/8u40-b26/jdk-8u40-linux-x64.rpm
# wget --no-check-certificate --no-cookies --header "Cookie: gpw_e24=yippi ka yei madafaka;" http://download.oracle.com/blahblah..

$WGET --user-agent="Mozilla/5.0" --secure-protocol=auto --post-data $AUTH_DATA --save-cookies=$COOKIE_FILE --keep-session-cookies $SSO_SERVER$SSO_AUTH_URL -O sso.out >> $LOGFILE 2>&1

$WGET  --user-agent="Mozilla/5.0" --no-check-certificate --load-cookies=$COOKIE_FILE --save-cookies=$COOKIE_FILE --keep-session-cookies http://download.oracle.com/otn/linux/oracle12c/121020/linuxamd64_12102_database_1of2.zip -O >> $LOGFILE 2>&1 

$WGET  --user-agent="Mozilla/5.0" --no-check-certificate --load-cookies=$COOKIE_FILE --save-cookies=$COOKIE_FILE --keep-session-cookies http://download.oracle.com/otn/linux/oracle12c/121020/linuxamd64_12102_database_2of2.zip -O >> $LOGFILE 2>&1 

rm -f sso.out

docker run -p 1521:1521 --name oracle-docker oracle/database:12.1.0.2-ee
