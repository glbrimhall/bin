#!/usr/bin/perl
use strict;

# Parse access log entries looking like: '74.117.180.23 - - [06/Sep/2017:11:49:27 -0700] "HEAD /objectviewer?o=http%3A%2F%2Fjrm.library.arizona.edu%2FVolume53%2FNumber2%2Fazu_jrm_v53_n2_190_193_m.pdf HTTP/1.1" 200 - "-" "Mozilla/5.0 (Windows NT 5.1; rv:49.0) Gecko/20100101 Firefox/49.0"'

my %mon2num = qw(
  Jan 1  Feb 2  Mar 3  Apr 4  May 5  Jun 6
  Jul 7  Aug 8  Sep 9  Oct 10 Nov 11 Dec 12
);

my $debug = 0;
my $month_after = $mon2num{ shift @ARGV };
my $year_after = ( shift @ARGV );
my $output_filter = ( shift @ARGV );
my $show_month_year = 0;
my %urls = ();

sub parse_input() {
  
  print "PARSING after $month_after $year_after\n" if $debug;
  
  while( <> )
  {
    if ( m|^.+\[(\d{1,2})/(\w+)/(\d{4})| ) {
      my $month = $mon2num{ $2 };
      my $year  = $3;
      print "PARSED $month $year\n" if $debug;
      if ( 0 == $show_month_year && $year_after <= $year && $month_after <= $month ) {
        print "HITSHOW : ($year_after <= $year)=" . ($year_after <= $year). " : ( $month_after <= $month )=".( $month_after <= $month )."\n" if $debug;
        $show_month_year = 1;
       }
     }
     else {
       print STDERR "ERROR PARSING: ".$_;
     }
  
     if ( $debug || $show_month_year > 0 ) {
       print STDOUT $_ if $debug;
  
       if ( /^[^"]+"(GET|HEAD) (\/\S+) HTTP/ ) {
         my $req = $1;
         my $resource = $2;
         $resource =~ s|%25|%|g;
         $resource =~ s|%3A|:|g;
         $resource =~ s|%2F|/|g;

         if ( $resource =~ /^(.+Volume)/ ) {
           $resource = $1;
         }

         $urls { $resource }++;
       }
     }
  }
}

sub print_url_list {
  my ( $urls ) = @_;


  my @sort_appeared = sort { $$urls{$b} <=> $$urls{$a} } keys %$urls;

  foreach my $url ( @sort_appeared ) {
    if ( defined ( $output_filter ) ) {
      if ( $url !~ m|$output_filter| ) {
        print "[URL] " . $url . " APPEARED " . $$urls{ $url } . "\n";
        delete $$urls{ $url };
      }
    }
    else {
      print "[URL] " . $url . " APPEARED " . $$urls{ $url } . "\n";
    }
  }
}

&parse_input();

&print_url_list( \%urls );

if ( defined( $output_filter ) ) {
  print "\nOUTPUT_FILTER: $output_filter:\n";
  undef $output_filter;
  &print_url_list( \%urls );
}
