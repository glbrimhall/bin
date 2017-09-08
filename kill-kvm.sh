#!/usr/bin/perl
my $app = $ARGV[0];

exit 0 if length( $app ) <= 0;

my $ps_out = `ps -elf | grep kvm | grep -v grep | grep -v perl | grep $app`;
my @ps_arg = split( ' ', $ps_out );

exit 1 if length( $ps_arg[3] ) > 0;
exit 0;

#foreach my $arg ( @ps_arg )
#   { print $arg."\n"; }
my $kill_cmd = `kill KILL $ps_arg[3] 2>&1`;

if ( $kill_cmd eq "" )
   { sleep 2; }
else
   { print $kill_cmd }
