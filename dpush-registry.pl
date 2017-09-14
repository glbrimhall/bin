#!/usr/bin/perl
use strict;

my $dst_registry = shift @ARGV;
my @dst_images = ();
my %images = ();
my $debug = 0;

sub build_image_list() {

   my $image_raw = `docker image list`;
   my @image_list = split( "\n", $image_raw );

   foreach my $image_line ( @image_list ) {
      print "PARSING: ".$image_line."\n" if $debug;
      my @image_cols = split( /\s+/, $image_line );

      next if ( $image_cols[ 0 ] eq "REPOSITORY" || $image_cols[ 0 ] eq "<none>" );
      $images{ $image_cols[ 0 ] } = $image_cols[ 2 ];
   }

   print "EXTRACTED ".keys( %images )." docker images:\n  ".join( "\n  ", keys( %images ) )."\n";
}

sub tag_image_list() {

   my %image_ids = ();

   foreach my $repo ( keys %images ) {
      next if ( defined( $image_ids{ $images{ $repo } } ) );

      my @regname = split( '/', $repo );

      next if ( $regname[ 0 ] eq $dst_registry );

      my $basename = ( @regname == 2 ) ? $regname[ 1 ] : $regname[ 0 ];
      my $tag_cmd = "docker tag $repo $dst_registry/$basename";
      push @dst_images, "$dst_registry/$basename";

      if ( $debug ) {
         print "EXEC: ".$tag_cmd."\n";
      }
      else {
        my $out = `$tag_cmd 2>&1`;
        print "EXEC: ".$tag_cmd." returned ".$out."\n";
      }

      $image_ids{ $images{ $repo } }++;
   }
}

sub push_image_list() {

  foreach my $dst_img ( @dst_images ) {
     my $cmd = "docker push $dst_img";
     print "EXEC: ".$cmd."\n";
     `$cmd`;
   }
}

sub clean_image_list() {

  foreach my $dst_img ( @dst_images ) {
    my $cmd = "docker rmi $dst_img";
    my $out = `$cmd 2>&1`;
    print "EXEC: ".$cmd." returned ".$out."\n";
  }
}


&build_image_list();

&tag_image_list();

if ( ! $debug ) {

  &push_image_list();

  &clean_image_list();

}
