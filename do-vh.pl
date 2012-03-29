#!/usr/bin/perl -w

push(@INC,"./");

use strict;
use Vh;   # only for apache/http
use Isp; # for isp manager

my ($user_name, $file,$panel);

if ( $ENV{'USER'} ne "root" ) {
	print "Only root can run me.\n";
	exit;
}

if (@ARGV > 3) {
	print "To many args. Exit.\n";
	exit;	
	
		} elsif (@ARGV == 1) {
			print "I need two args.\n";
			exit;
			
			} elsif ((@ARGV == 0) || ($ARGV[0] eq "--help")) {
				&help;
				exit;
}

if ( ! -e "/var/www" ) {
	print "Directory /var/www does not exist. Exit.\n";
	exit;
}

$user_name = $ARGV[0];
$file = $ARGV[1];
$panel = $ARGV[3];

if ($ARGV[3] eq "isp") {
	&check_panel;
	create_isp_vh($user_name,$file);
} elsif ($ARGV[3] eq "noisp") {
	&chk_dir;
	create_vh($user_name,$file);
}

