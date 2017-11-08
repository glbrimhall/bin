#!/usr/bin/perl
use strict;
use warnings;

my $file_path  = shift @ARGV;

if ( length( $file_path ) < 1 ) {
  die "ERR: must specify the path of the file within the git repo";
}

my $commits_raw = `git log --all -- $file_path`;
my @commits     = grep( /^commit/, split( /\n/, $commits_raw ) );
my %branches    = ();

foreach my $commit ( @commits ) {
  if ( $commit =~ /^commit (\S+)$/ ) {
    my $commit_num = $1;
    my $branch = `git branch -a --contains $commit_num`;
    if ( length( $branch ) > 0 ) {
      $branches{ $branch }++;
    }
  }
}

print "GIT BRANCHES: $file_path:\n".join( "", keys %branches )."\n";
