## java ##
alternatives --install /usr/bin/java java /usr/java/default/jre/bin/java 20000
## javaws ##
alternatives --install /usr/bin/javaws javaws /usr/java/default/jre/bin/javaws 20000
 
## Java Browser (Mozilla) Plugin 32-bit ##
alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so libjavaplugin.so /usr/java/default/jre/lib/i386/libnpjp2.so 20000
 
## Java Browser (Mozilla) Plugin 64-bit ##
alternatives --install /usr/lib64/mozilla/plugins/libjavaplugin.so libjavaplugin.so.x86_64 /usr/java/default/jre/lib/amd64/libnpjp2.so 20000
 
## Install javac only if you installed JDK (Java Development Kit) package ##
alternatives --install /usr/bin/javac javac /usr/java/default/bin/javac 20000
alternatives --install /usr/bin/jar jar /usr/java/default/bin/jar 20000

## java ##
alternatives --install /usr/bin/java java /usr/java/default/bin/java 20000
 
## javaws ##
alternatives --install /usr/bin/javaws javaws /usr/java/default/bin/javaws 20000
 
## Java Browser (Mozilla) Plugin 32-bit ##
alternatives --install /usr/lib/mozilla/plugins/libjavaplugin.so libjavaplugin.so /usr/java/default/lib/i386/libnpjp2.so 20000
 
## Java Browser (Mozilla) Plugin 64-bit ##
alternatives --install /usr/lib64/mozilla/plugins/libjavaplugin.so libjavaplugin.so.x86_64 /usr/java/default/lib/amd64/libnpjp2.so 20000
