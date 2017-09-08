apt-get install apt-transport-https                        ca-certificates
curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -
add-apt-repository        "deb https://apt.dockerproject.org/repo/ \
 ubuntu-$(lsb_release -cs) \
 main"
apt-cache policy docker
cat /etc/apt/sources.list.d/official-package-repositories.list
add-apt-repository        "deb https://apt.dockerproject.org/repo/ \
 ubuntu-xenial main
add-apt-repository        "deb https://apt.dockerproject.org/repo/ \
               ubuntu-xenial main"
apt-get update
emacs /etc/apt/sources.list
emacs /etc/apt/sources.list.d/additional-repositories.list 
apt-get update
apt-get install docker-engine
docker run hello-world
docker run -it ubuntu bash
ls
docker run -it --rm dockerfile/java:oracle-java8 java -version
docker pull dockerfile/java
docker build -t="dockerfile/java" github.com/dockerfile/java)
docker build -t="dockerfile/java" github.com/dockerfile/java
docker pull dockerfile/oracle-java8
docker run -it --rm dockerfile/java:oracle-java8 java -version
uname -0a
uname -a
systemctrl status docker

usermod -aG docker geoff
