#!/usr/bin/perl
use Switch;

my %servers = ();
my @serverList = ();
my @chiVcenter = ();
my @coloVcenter = ();
my @hqVcenter = ();

sub process_inputfiles {
   foreach my $INPUT_FILE (@ARGV) {
      print "PROCESSING $INPUT_FILE\n";
   
      my $INPUT_FH;
      open ( $INPUT_FH, "<:encoding(UTF-16)", $INPUT_FILE ) || die "ERROR: opening $INPUT_FILE: $!";
      
      switch ( $INPUT_FILE ) {
         case /serverlist/i       { @serverList = <$INPUT_FH>; }
         case /chiVcenter/i       { @chiVcenter = <$INPUT_FH>; }
         case /coloVcenter/i      { @coloVcenter = <$INPUT_FH>; }
         case /hqVcenter/i        { @hqVcenter = <$INPUT_FH>; }
      }
      close $INPUT_FH;
   }
}

sub parse_serverList {
   foreach my $server ( @serverList ) {
       chomp( $server );
       my @cols = split( /\t/, $server );
       if ( $cols[ 1 ] =~ /\d+\.\d+.\d+.\d+/ ) {
          map { s/^\s+|\s+$//g; } @cols;
          map { s/^"+|"$//g; } @cols;
          my $server_name = lc( shift @cols );
          $servers{ $server_name } = [ @cols ];
       }
       else {
          print "DROPPING line: $server";
       }
    }
}

sub output_serverList {
   foreach my $server_name ( keys %servers ) {
       print $server_name."|".join( "|", @{ $servers{ $server_name } } )."\n"; 
   }
}

&process_inputfiles();

&parse_serverList();

&output_serverList();



