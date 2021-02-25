#!/usr/bin/perl

use strict;
use Getopt::Long;
use File::Copy;

my $regex_src     = shift @ARGV;
my $regex_dst     = shift @ARGV;
my $file_glob     = shift @ARGV;
my @file_list     = ();

# Catch some signals:
$SIG{'INT'} = 'signal_exit';
$SIG{'KILL'} = 'signal_exit';
$SIG{'TERM'} = 'signal_exit';

printf ( "EDITING $file_glob, REPLACING $regex_src WITH $regex_dst\n" );

if ($file_glob && $regex_src && $regex_dst) 
{ 
  &walk_files();
}
 
exit 0;

#### Code

sub get_subdirs
{
   opendir(DIR, $_[0]) or die "can't opendir $_[0]: $!\n";
   my $fname = "";

   @file_list = ();

   while ( defined ( $fname = readdir( DIR ) ) )
      {
      if ( ! ( $fname =~ /^\..*/ ) )
         {
         push @file_list, "$fname";
         print "GET_SUBDIR $fname\n";
         }
      }

   @file_list = sort @file_list;

   closedir (DIR);
}

sub walk_files
{
   if ( -f $file_glob )
      {
      local *LIST;
      open( LIST, "< $file_glob") || die "FAILED_EDIT $file_glob: $!";
      @file_list = <LIST>;
      close( LIST );
      chomp( @file_list );
      foreach my $l ( @file_list )
         { print "$l\n"; }
      }
   else
      {
      @file_list = glob( $file_glob );
      }
   
   foreach my $fn ( @file_list )
      {
      next if ( ! -f $fn );

      local *IN,*OUT;
                  
      print ("EDITING $fn\n");

      open (IN, "< $fn") || die "FAILED_EDIT $fn: $!";
      open (OUT, "> $fn.tmp") || die "FAILED_EDIT $fn.tmp: $!";

      while ( <IN> )
         {
         s/$regex_src/$regex_dst/g;
         print OUT;
         }
      
      close(OUT);
      close(IN);
      move("$fn.tmp", "$fn") or die "The move operation failed: $!";   
      }
}

sub signal_exit
{
   exit 1;
}

