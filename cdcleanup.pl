#!/usr/bin/perl

my $root_dir   = "/image1/music";
my %dirs       =
         (
         root  => $root_dir,
         flac  => $root_dir."/flac",
         mp3   => $root_dir."/mp3",
         wav   => $root_dir."/wav",
         ogg   => $root_dir."/ogg",
         m3u   => $root_dir."/m3u",
         );
my ( $DISCID, $DAUTHOR, $DALBUM,
     $DYEAR, $DGENRE, @DTITLE )  = ( "", "", "", "", "", () );
my ( $AUTHOR, $ALBUM, $AUTHOR_, $ALBUM_ ) = ( "", "", "", "" );
my ( $AUTHALBM )                 = ( "" );
my   @OLD_SONG   = ();
my   @NEW_SONG   = ();
my   @MSTR_SONG  = ();

my     $cwd    = `pwd`;
chomp( $cwd );
       
sub flatten
{
   my ($v) = @_;
   #print ("$v\n");
#   $$v = lc($$v);
   $v =~ s/[\;\&\[\]]/+/g;
   $v =~ s/(<<|>>)/\*/g;
   $v =~ s/[\/\\]/\*/g;
   $v =~ s/[\<\>\!\'\"\|\(\)\.\-\#\,\?\:\'\"]//g;
   # trim whitespace:
   #print ("$v\n");
   $v =~ s/\s\s+/ /g;
   $v =~ s/^\s+//g;
   $v =~ s/\s+$//g;
   $v =~ s/ \+ /+/g;
   $v =~ s/ \* /*/g;
   #print ("$v\n");
   return $v;
}

sub word_shorten
{
   my ( $maxlen, $v, $maxword, $reverse, $pad ) = @_;

   if ( $maxword <= 0 )
      {
      $maxword = 65335;
      }
   else
      {
      $v =~ s/\bof //ig;
      }
   $v =~ s/\bthe //ig;

   my   @word           = split( / +/, lc( $v ) );
   my   $len            = 0;
   my   $new            = 0;
   my   $padlen         = length( $pad );
   
   if ( 1 == @word )
      {
      $v =~ s/([A-Z])/ $1/g;
      $v =~ s/^ //g;
      if ( $maxword > 0 )         {
         $v =~ s/\bOf //g;
         }
      $v =~ s/\bThe //g;
      my @nospaces = split ( / /, $v );
      if ( 1 < @nospaces )
         { @word = @nospaces; }
      }

   if ( $reverse )
      { @word = reverse @word; }
   
   foreach my $w ( @word )
      {
      if ( length( $w ) > $maxword )
         { $w = substr( $w, 0, $maxword ); }
      $word[ $new ] = ucfirst( $w );
      $new++;
      $len += length( $w ) + $padlen;
      last if $len >= $maxlen;
      }
   $new--;

   @word = @word[ 0 .. $new ];

   if ( $reverse )
      { @word = reverse @word; }

   $v = flatten( join( $pad, @word) );

   if ( length( $v ) > $maxlen )
      { $v = substr( $v, 0, $maxlen ); }
   
   return $v;
}

sub find_composer
{
   my ( $genre, $text, $author, $pos )   = @_;
   my %composers    =
       (
       Classical  => [
                     beethoven,
                     brahms,
                     bach,
                     bruch,
                     chopin,
                     debussy,
                     dvorak,
                     "ennis sisters",
                     "john williams",
                     mozart,
                     mendelssohn,
                     prokofiev,
                     "saint-saens",
                     shostakovich,
                     stravinsky,
                     strauss,
                     rachmaninov,
                     ],
        Soundtrack =>[
                     "john williams",
                     ],
        );

   if ( $genre eq "Opera" ||
        $genre eq "Piano" )
      { $DGENRE = $genre = "Classical"; }
   
   if ( ! defined( $composers{ $genre } ) )
      { return 0; }
   
   my $composer     = $composers{ $genre };
   my $found        = -1;
   $text            = lc( $text );

   foreach my $name ( @$composer )
      {
      $found = index( $text, $name );

      if ( $found != -1 )
         {
         my @firstlast  = split( " ", $name );

         $$author  = ucfirst( $firstlast[ 0 ] );
         $$pos     = $found;

         if ( 2 == @firstlast )
            { $$author .= ' '.ucfirst( $firstlast[ 1 ] ); }
         
         return 1;
         }
      }
   return 0;
}

sub sanitize_author
{
   my ( $AUTH )               = @_;
   my   $author               = "";
   my   $last_name            = "";
   my   $first_name           = "";
   my   $comma                = -1;

   if ( &find_composer( $DGENRE, $AUTH, \$last_name, \$comma ) )
      {
      $author = $last_name;
      }
   # Last name:
   elsif ( -1 != ( $comma = index( $AUTH, ',' ) ) )
      {
      $last_name  = substr( $AUTH, 0, $comma );
      $first_name = substr( $AUTH, $comma + 1 );
      }
   elsif ( -1 != ( $comma = index( $AUTH, '-' ) ) )
      {
      $last_name  = substr( $AUTH, 0, $comma );
      $first_name = substr( $AUTH, $comma + 1 );
      }
   # Last name at end:
   elsif ( -1 != ( $comma = rindex( $AUTH, ' ' ) ) )
      {
      $first_name = substr( $AUTH, 0, $comma );
      $last_name  = substr( $AUTH, $comma + 1 );
      }
   else
   # Assume only last name:
      { $author = $AUTH; }

   if ( ! $author )
      {
      $first_name = ucfirst( &flatten( $first_name ) );
      $last_name  = ucfirst( &flatten( $last_name ) );
      $author     = $first_name.' '.$last_name;
      }
   
   $author =~ s/\ba //ig;
   $author =~ s/  +/ /g;
   
   return &flatten( $author );
}

sub sanitize_album
{
   my ( $album, $author ) = @_;
   
   if ( $DGENRE eq "Classical" )
      {
      $album =~ s/\bN[or]s{0,1}\.{0,1}\s+(\d+)/$1/i;
      $album =~ s/,*[ \(]+Op( |\.)*(\d+)\)*//i;
      $album =~ s/,*[ \(]+bwv( |\.)*(\d+)\)*//i;
      $album =~ s/,*[ \(]+ker( |\.)*(\d+)\)*//i;
      #$album =~ s/symph\w*\b/symph/i;
      #$album =~ s/conc\w*\b/conc/i;
      #$album =~ s/\b[a-g#]{1,2}( |-)+(maj|min|mol)\S+//i;
      #$album =~ s/\bin\s+[a-g#]{1,2}//i;
      #$album =~ s/(\d+)\s*,\s*(\d+)/$1 + $2/g;
      $album =~ s/\bin //i;
      $album =~ s/\band //i;
      $album =~ s/\bfor //i;
      $album =~ s/\bunaccompanied //i;
      }
   else
      {
      $album =~ s/\ba //ig;
      $album =~ s/^a //ig;
      }

   $album = &flatten( $album );
   $album =~ s/\b(\w+)(\s+\1)+\b/$1/gi;
   $album =~ s/^$author //gi;
   $album =~ s/  +/ /g;
   return $album;
}

sub old_song_name
{
   my ( $OLD_SONG, $dir, $end  ) = @_;
   my   $dirlen            = length( $dir ) + 1;
   my   $endlen            = length( $end ) + 1;
   my   @SONG              = ();

   @SONG = glob( "$dir/*.$end" );
   @SONG = map( substr( $_, $dirlen ), @SONG );
   @SONG = map( substr( $_, 0, -$endlen ), @SONG );
   @SONG = sort( @SONG );

   if ( $#DTITLE != $#SONG )
      { print "INFO: ".$#DTITLE." tracks!= ".$#SONG." *.$end\n"; }
   
   @$OLD_SONG = @SONG;
   return;
}

sub filter_duplicate_title
{
   my $cur   = $TITLE[ $track ];
   my $next  = $TITLE[ $track + 1 ];
   my $prev  = $TITLE[ $track - 1 ];

   my $next_beg   = 0;
   my $prev_beg   = 0;
   my @cur_word   = split( /\W+/, $cur );
   my @next_word  = split( /\W+/, $next );
   my @prev_word  = split( /\W+/, $prev );
   
   foreach $word ( @cur_word )
      {
      if ( $word eq $next_word[ $next_beg ] )
         { $next_beg++; }
      else
         { last; }
      }

   foreach $word ( @cur_word )
      {
      if ( $word eq $prev_word[ $prev_beg ] )
         { $prev_beg++; }
      else
         { last; }
      }

   my $start = $next_beg > $prev_beg ? $next_beg : $prev_beg;
   my $title = join( ' ', @cur_word[ $start .. $#cur_word ] );
}

sub new_song_name
{
   my ( $NEW_SONG, $MSTR_SONG ) = @_;
   my   @new_song  = ();
   my   @mstr_song = ();

   # For the song name, we want to have it less than 48 chars:
   $AUTH = &word_shorten( 10, $AUTHOR, 0, 0, '' );
   $ALBM = &word_shorten( 10, $ALBUM, 3, 0, '' );
   $AUTHALBM = $AUTH."-".$ALBM;

   print ("NEW_SONG_NAME DGENRE = $DGENRE\n");
   
   foreach my $track ( 0 .. $#DTITLE )
      {
      my $tracknum = sprintf( "%0.2d", $track );
      my $title    = $DTITLE[ $track ];
      
      if ( $DGENRE eq "Classical" )
         {
         $title =~ s/\b(\w+)s: \1/$1/g;
         $title = &sanitize_album( $title, $AUTHOR );
         }
      
      $title   = &flatten( $title );
      $title   =~ s/^$AUTHOR //gi;
      $title   =~ s/^$ALBUM //gi;

      push @mstr_song, $tracknum."-".
         &word_shorten( 31, $title, 0, $DGENRE eq "Classical", '_' );

      $title   = &word_shorten( 8, $title, 4, $DGENRE eq "Classical", '' );
      $title   = $tracknum.$title;
      
      push @new_song, $AUTHALBM."-".$title;
      }

   @$MSTR_SONG = @mstr_song;
   @$NEW_SONG  = @new_song;
   return;      
}
   
sub load_cddb
{
   my  ( $dir, $old_end )   = @_;
   my $TITLE      = undef;
   $DISCID        = undef;
   $DAUTHOR       = undef;
   $DALBUM        = undef;
   $DYEAR         = "2006";
   $DGENRE        = "Classical";
   @DTITLE        = ();
   
   my    $cddb    = "$dir/audio.cddb";
   local *CDDB;
   if ( ! open(  CDDB, "< $cddb" ) )
      {
      print "SKIPPING $cddb: ".$!."\n";
      return 0;
      }
   else
      { print "PROCESS $cddb\n"; }
      
   my    @cdinfo = <CDDB>;
   close( CDDB );   
   
   foreach my $cdline ( @cdinfo )
      {
      #print $cdline;
      if ( $cdline =~ /^DISCID=(.+)$/ )
         { $DISCID = $1; }
      elsif ( $cdline =~ /^DTITLE=(.+)$/ )
         {
         $TITLE .= $1;
         }
      elsif ( $cdline =~ /^DYEAR=(.+)$/ )
         { $DYEAR = $1; }
      elsif ( $cdline =~ /^DGENRE=(.+)$/ )
         {
         $DGENRE = ucfirst( $1 );
         }
      elsif ( $cdline =~ /^TTITLE(\d+)=(.+)$/ )
         {
         $DTITLE[ $1 ] .= $2;
         }
      }
   
   if ( $TITLE =~ /^([^\/]+)\/\s*(.+)$/ )
      {
      $DAUTHOR = $1;
      $DALBUM  = $2;
      $DAUTHOR =~ s/\s*$//g;
      $DALBUM  =~ s/\s*$//g;
      }
   else
      {
      print "SKIPPING $cddb - BAD author in $DTITLE\n";
      return 0;
      }

   # sanitize ticks
   $DISCID  =~ s/\'//g;
   $DAUTHOR =~ s/\'//g;
   $DALBUM  =~ s/\'//g;
   $DGENRE  =~ s/\'//g;

   foreach my $t ( 0 .. $#DTITLE )
      { $DTITLE[ $t ] =~ s/\'//g; }

   $AUTHOR  = &sanitize_author( $DAUTHOR );
   $ALBUM   = &sanitize_album( $DALBUM, $DAUTHOR );
   
   @OLD_SONG   = ();
   @NEW_SONG   = ();
   @MSTR_SONG  = ();

   if ( ! $DISCID )
      { return 0; }

   if ( $DGENRE eq "Classical" )
      {
      ( $ALBUM, $AUTHOR ) = &cleanup_classical_album_author( $ALBUM, $AUTHOR );
      }
   
   $AUTHOR  = &word_shorten( 31, $AUTHOR, 0, 0, ' ' );
   $ALBUM   = &word_shorten( 50, $ALBUM, 0, 0, ' ' );

   $AUTHOR_ = $AUTHOR;
   $ALBUM_  = $ALBUM;
   $AUTHOR_ =~ s/ +/_/g;
   $ALBUM_  =~ s/ +/_/g;
   &old_song_name( \@OLD_SONG, $dir, $old_end );
   &new_song_name( \@NEW_SONG, \@MSTR_SONG );

   print "READ  AUTHOR=$DAUTHOR DALBUM=$DALBUM $DYEAR $DGENRE $DISCID\n";
   print "CLEAN AUTHOR=$AUTHOR ALBUM=$ALBUM\n";

   foreach my $track ( 0 .. $#DTITLE )
      {
      print "TITLE $track:\n";
      print "O[".length( $OLD_SONG[ $track ] )."]".$OLD_SONG[ $track ]."\n";
      print "T[".length( $DTITLE[ $track ] )."]".$DTITLE[ $track ]."\n";
      print "M[".length( $MSTR_SONG[ $track ] )."]".$MSTR_SONG[ $track ]."\n";
      print "N[".length( $NEW_SONG[ $track ] )."]".$NEW_SONG[ $track ]."\n";
      }
   
   return 1;
}

sub encode_flac
{
   my $end = "flac";
   `mkdir -p $flac_dir/$AUTHOR/$ALBUM`;
   foreach my $track ( 0 .. $#TITLE )
      {
      `cp $old_song.flac $new_song.flac`;
      `cp $old_song.inf $new_song.inf`;
      }
}

sub cleanup_classical_album_author
{
   my ( $album, $author )  = @_;
   my ( $composer, $pos )  = ( "", -1 );

   my %author_clean =
      (
      "George Szell Cleveland Orchestra" => "Brahms",
      "Cleveland Orchestra" => "Brahms",
      "Vladimir Ashkenazy" => "Mozart",
      );
   # custom stuff:
   foreach my $a ( keys %author_clean )
      {
      if ( $author eq $a )
         {
         $author = $author_clean{ $a };
         last;
         }
      }
   
   if ( ! &find_composer( "Classical", $author, \$composer, \$pos ) &&
          &find_composer( "Classical", $album, \$composer, \$pos ) )
      {
      $album  = $author.substr( $album, $pos + length( $composer ) );
      $author = $composer;
      }

   print ("CLEAN=$album\n");

   my %album_clean =
      (
      "Berlin Philharmonic Orchestra Karajan" => '',
      "San Francisco Symphony Michael Tilson Tomas" => '',
      "Felix Mendelssohn Bartholdy" => '',
      "Isaac Stern Eugene Ormandy Rudolf Serkin" => '',
      "Juilliard String Quartet Los Angeles Philharmonic EsaPekka Salonen Yefim Bronfman" => '',
       "Szell*The 4 Symphonies Disc 1" => 'Symphony 1',
       "Szell*The 4 Symphonies Disc 3" => 'Symphony 4',
      );
   foreach my $a ( keys %album_clean )
      {
      if ( ! length( $album_clean{ $a } ) )
         {
         my $p = index( $album, $a );
         if ( -1 != $p )
            {
            $album = substr( $album, length( $a ) + 1 );
            last;
            }
         }
      elsif ( $album eq $a )
         {
         $album = $album_clean{ $a };
         last;
         }
      }

   return ( $album, $author );
}

sub exec_cmd
{
   my ( $cmd ) = @_;
   print "EXEC: $cmd\n";
   my $r = `$cmd`;
   if ( $? != 0 )
      { print "EXEC_ERR result = $?|$!|$r\n"; }
   return $?;
}

sub mp3_id3_tag
{
   my ( $track )  = @_;
   my $title      = $DTITLE[ $track ];
   $track++;

   my %genre =
      (
       "Indie Pop"      => Rock,
       "Popular music"  => Rock,
       Gypsy            => Ethnic,
       Christian        => "Christian Rap",
      );
   
   if ( defined( $genre{ $DGENRE } ) )
      { $DGENRE = $genre{ $DGENRE }; }
   
   return "--tt \'$title\' ".
          "--ta \'$AUTHOR\' ".
          "--tl \'$DALBUM\' ".
          "--ty \'$DYEAR\' ".
          "--tn \'$track\' ".
          "--tg \'$DGENRE\'";
}

sub ogg_id3_tag
{
   my ( $track )  = @_;
   my $title      = $DTITLE[ $track ];
   $track++;

   return "--title=\'$title\' ".
          "--artist=\'$AUTHOR\' ".
          "--album=\'$DALBUM\' ".
          "--date=\'$DYEAR\' ".
          "--tracknum=\'$track\' ".
          "--genre=\'$DGENRE\'";
}

sub flac_id3_tag
{
   my ( $track )  = @_;
   my $title      = $DTITLE[ $track ];
   $track++;

   return "-T \'title=$title\' ".
          "-T \'artist=$AUTHOR\' ".
          "-T \'album=$DALBUM\' ".
          "-T \'date=$DYEAR\' ".
          "-T \'tracknum=$track\' ".
          "-T \'genre=$DGENRE\'";
}

sub iter_songs
{
   my ( $old_dir, $OLD_SONG, $old_end,
        $new_dir, $NEW_SONG, $new_end,
        $command, $tag_func, $auth_dir ) = @_;

   #&exec_cmd( "rm -fr \"$new_dir\"" );
   &exec_cmd( "mkdir -p \"$new_dir\"" );
   
   foreach my $track ( 0 .. $#DTITLE )
      {
      my $old = "$old_dir/$$OLD_SONG[ $track ].$old_end";
      my $new = "$new_dir/$$NEW_SONG[ $track ].$new_end";

      next if ( -f $new );
      
      my $cmd = "$command";
      $cmd    =~ s/\$old/"$old"/;
      $cmd    =~ s/\$new/"$new"/;

      if ( $tag_func )
         {
         my $tag = &$tag_func( $track );
         
         $cmd    =~ s/\$tag/$tag/;
         }
      &exec_cmd( $cmd );
      }
   &exec_cmd( "cd $new_dir; ls \*.$new_end | sort > $AUTHALBM.m3u; cd $cwd" );
}

sub convert_list
{
   my ( $cd_list) = @_;
   
   # to generate list: find /image1/music/ -mindepth 2 -maxdepth 2 -type d 
   local *CDLIST;
   open(  CDLIST, "< $cd_list" ) || die "Failed to open cd list $cd_list: ".$!;
   my    @cdlist = <CDLIST>;
   close( CDLIST );
   chomp(@cdlist );

   `mkdir -p $root_dir/m3u`;
   
   foreach my $dir ( @cdlist )
      {
      next if ( ! length( $dir ) );
      &convert_cd( $dir );
      }
}

sub encode_cd
{
   my ( $dir ) = @_;

   return if ! &load_cddb( $dir, "wav" );

   if ( $#DTITLE != $#OLD_SONG )
      {
      print "Not all titles are cut from cd\n";
      return 0;
      }

   my @INF_LIST = ();
   &old_song_name( \@INF_LIST, $dir, 'inf' );
   
   &iter_songs( $dir, \@OLD_SONG, 'wav',
                $dirs{mp3}."/$AUTHOR_/$ALBUM_", \@NEW_SONG, 'mp3',
                'lame -V2 --vbr-new -q0 --lowpass 19.7 -b96 '.
                '$tag $old $new', 'mp3_id3_tag' );
   
   &iter_songs( $dir, \@OLD_SONG, 'wav',
                $dirs{ogg}."/$AUTHOR_/$ALBUM_", \@NEW_SONG, 'ogg',
                'oggenc -q 6 $tag -o $new $old', 'ogg_id3_tag' );
   
   &iter_songs( $dir, \@INF_LIST, 'inf',
                $dirs{flac}."/$AUTHOR_/$ALBUM_", \@MSTR_SONG, 'inf',
                'cp $old $new', '' );
   
   &iter_songs( $dir, \@OLD_SONG, 'wav',
                $dirs{flac}."/$AUTHOR_/$ALBUM_", \@MSTR_SONG, 'flac',
                'flac $tag -o $new $old', 'flac_id3_tag' );

   &exec_cmd( "cp $dir/audio.* ".$dirs{flac}."/$AUTHOR_/$ALBUM_" );
   &exec_cmd( "cd ".$dirs{m3u}."; ".
              "ls ../flac/$AUTHOR_/$ALBUM_/*.flac | sort > ".
              "$AUTHOR_-$ALBUM_.m3u; cd $cwd" );

   #&exec_cmd( "rm -fr ".$dirs{wav}."/$AUTHOR_/$ALBUM_" );
   
   return 1;
}

sub convert_cd
{
   my ( $dir ) = @_;

   return if ! &load_cddb( $dir, "flac" );

   #return;
   
   # restore wav dir from flac identical to end of cut_cd phase:
   my @NEW_WAV = map( sprintf( "track%0.2d.cdda", $_ ), ( 1..@DTITLE ) );
   my @NEW_INF = map( sprintf( "audio_%0.2d", $_ ), ( 1..@DTITLE ) );
   my @OLD_INF = ();
   my $dir_wav = $dirs{wav}."/$AUTHOR_/$ALBUM_"; 

   &old_song_name( \@OLD_INF, $dir, 'inf' );

   &iter_songs( $dir, \@OLD_INF, 'inf',
                $dir_wav, \@NEW_INF, 'inf',
                'cp $old $new', '' );
   
   &exec_cmd( "cp $dir/audio.* $dir_wav" );
   
   &iter_songs( $dir, \@OLD_SONG, 'flac',
                $dir_wav, \@NEW_WAV, 'wav',
                'flac -d $old -o $new' );

   &encode_cd( $dir_wav );
   #&exec_cmd( "rm -fr ".$dirs{wav}."/$AUTHOR_/$ALBUM_" );
   
   return 1;
}

sub cut_cd
{
   my ( $DEVICE )    = @_;
   my   $CDP_DEV     = "/dev/$DEVICE";
   my   $extract_dir = "$root_dir/wav/$DEVICE";

   &exec_cmd( "mkdir -p $extract_dir" );
   chdir "$extract_dir";

   # download audio.cddb
   if ( ! -f "audio.cddb" )
      {
      &exec_cmd( "cdda2wav -D $CDP_DEV -vall -x -B -J -L 1 ".
                 "cddbp-server=freedb.freedb.org" );
      }

   return if ! &load_cddb( $extract_dir, "inf" );

   my @CUT_WAV = ();
   my @NEW_WAV = map( sprintf( "track%0.2d.cdda", $_ ), ( 1..@DTITLE ) );

   #map( print( $_."\n" ), @NEW_WAV );

   &old_song_name( \@CUT_WAV, $extract_dir, 'wav' );
   
   # cut cdrom as *.wav tracks
   if ( 0 == @CUT_WAV )
      { &exec_cmd( "cdparanoia -d $CDP_DEV -w -B " );}
   else
      {
      foreach my $track ( 0..$#NEW_WAV )
         {
         my $wav = $NEW_WAV[ $track ].".wav";
         if ( ! -f $wav )
            { &exec_cmd( "cdparanoia -d $CDP_DEV -w $track $wav" ); }
         }
      }

   $extract_dir = $dirs{wav}."/$AUTHOR_/$ALBUM_";
   
   &exec_cmd( "mkdir -p ".$dirs{wav}."/$AUTHOR_" );
   &exec_cmd( "mv $root_dir/wav/$DEVICE $extract_dir" );

   &encode_cd( $extract_dir );
}

sub main 
{
   my $mode = $ARGV[ 0 ];

   if ( $mode =~ /^convert$/i )
      { &convert_list( $ARGV[ 1 ] ); }
   elsif ( $mode =~ /^cut$/i )
      { &cut_cd( $ARGV[ 1 ] ); }
   elsif ( $mode =~ /^encode$/i )
      { &encode_cd( $ARGV[ 1 ] ); }
   else
      { &print_options(); }
}

&main();

exit 0;
