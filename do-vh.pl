#!/usr/bin/perl -w

push(@INC,"./");

use strict;
use vh;   # only for apache/http
#use isp; # for isp manager

my ($user_name, $file,$whoami);

if ( $ENV{'USER'} ne "root" ) {
	print "Only root can run me.\n";
	exit;
}

if (@ARGV > 2) {
	print "To many args. Exit.\n";
	exit;	
		} elsif (@ARGV == 0 || @ARGV == 1) {
			print "I need two args.\n";
			exit;
}

if ( ! -e "/var/www" ) {
	print "Directory /var/www does not exist. Exit.\n";
	exit;
}

$user_name = $ARGV[0];
$file = $ARGV[1];

&chk_dir;

create_vh($user_name,$file);

