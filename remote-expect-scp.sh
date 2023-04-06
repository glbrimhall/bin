#!/usr/bin/expect

# From https://gist.github.com/michiel/c477face7c2b289c982c470b24d39184
#Usage sshsudologin.expect <host> <ssh user> <ssh password> <su user> <su password>

set timeout 300

#scp root@$IP:/common/gbrimhall/$1 .
#scp $1 root@$IP:/common/gbrimhall/

# From https://www.middlewareinventory.com/blog/how-to-ignore-ssh-host-key-verification/

#spawn scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no [lindex $argv 0] [lindex $argv 1]

# From https://comp.lang.tcl.narkive.com/m6mdvsZ1/expect-how-to-pass-all-of-argv-as-separate-elements-to-a-command-i-ve-spawn-ed

set PSWD BLAHBLAH

eval spawn scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $argv 

expect "yes/no" { 
	send "yes\r"
	expect "*?assword" { send "$PSWD\r" }
	} "*?assword" { send "$PSWD\r" }

# From https://stackoverflow.com/questions/16563070/how-to-wait-for-a-process-to-complete-using-tcl-expect

expect eof
catch wait result
exit

