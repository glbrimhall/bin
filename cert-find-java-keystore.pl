#! /usr/bin/env perl

# Original version of this code came from https://stackoverflow.com/questions/8980364/how-do-i-find-out-what-keystore-my-jvm-is-using

use strict;
use warnings;
use Cwd qw(realpath);
$_ = realpath((grep {-x && -f} map {"$_/keytool"} split(':', $ENV{PATH}))[0]);

die "ERROR: Can not find keytool" unless defined $_;

my $keytool = $_;

print "CERT: using '$keytool'.\n";

s/keytool$//;

print "CERT: looking for keystore starting at ".$_ . '../lib/security/cacerts'."\n";

my $cacerts = realpath($_ . '../lib/security/cacerts');

die "ERROR: Can not find cacerts" unless -f $cacerts;

print "CERT: located keystore at '$cacerts'.\n";

my $cert_list = `$keytool -list -keystore "$cacerts" -storepass changeit`;

die "Can not read key container" unless $? == 0;

if ( @ARGV < 1 ) {
  print "CERT: keystore list of certificates:\n$cert_list";
}

foreach (@ARGV) {

  my $cert = $_;
  s/\.[^.]+$//;
  my $alias = $_;
  print "Importing '$cert' as '$alias'.\n";
  `keytool -importcert -file "$cert" -alias "$alias" -keystore "$cacerts" -storepass changeit`;
  warn "Can not import certificate: $?" unless $? == 0;
}
