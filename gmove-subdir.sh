#!/bin/sh
ls | perl -ne 'chomp( $l = $_ ); print "git mv $l initial/$l\n"'
