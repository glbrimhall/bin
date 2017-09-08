#!/bin/sh

# Script built from:
# http://www.webupd8.org/2017/06/why-oracle-java-7-and-6-installers-no.html
# http://www.webupd8.org/2014/03/how-to-install-oracle-java-8-in-debian.html

mkdir -p /var/cache/oracle-jdk7-installer/
cp jdk-7u80-linux-x64.tar.gz /var/cache/oracle-jdk7-installer/
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
echo oracle-java7-installer shared/accepted-oracle-licence-v1-1 boolean true | sudo /usr/bin/debconf-set-selections
apt-get install oracle-java7-installer
apt-get install oracle-java7-set-default
java -version
