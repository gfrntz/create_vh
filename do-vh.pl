#!/usr/bin/perl -w

push(@INC,"./");

use strict;
use vh;   # only for apache/http
#use isp; # for isp manager

my ($user_name, $vh_name, $whoami);

if ( chomp($whoami = `whoami`) ne "root" ) {
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

$user_name = $ARGV[0];
$vh_name = $ARGV[1];

&chk_dir;

print "User name = $user_name ; vh name = $vh_name\n";

create_vh($user_name,$vh_name);

