#!/usr/bin/perl

my $GROUPS=`id`;

my @G = split(",", $GROUPS); 

foreach my $g( @G ) 
{
   my ($groupnum, $groupname) = ( $g =~ /^(\d+)(.+)$/ );

   print "$groupname $groupnum\n";
}

