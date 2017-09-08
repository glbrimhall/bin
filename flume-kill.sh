#!/usr/bin/perl
my $ps_out = `ps -elf | grep flume | grep /usr/bin/java | grep -v grep`;
my @ps_arg = split( ' ', $ps_out );

#foreach my $arg ( @ps_arg )
#   { print $arg."\n"; }
my $flume_kill = `kill $ps_arg[3] 2>&1`;

if ( $flume_kill eq "" )
   { sleep 2; }
else
   { print $flume_kill }

