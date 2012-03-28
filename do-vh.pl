#!/usr/bin/perl -w

push(@INC,"./");

use strict;
use vh;   # only for apache/http
#use isp; # for isp manager

my ($user_name, $vh_name);


&chk_dir;


create_vh($user_name,$vh_name);





sub check_panel {
	
	if ( -d "/usr/local/ispmgr" ) {
		print "I find isp panel!\n";		
	} else {
		print "Panel not found!\n";	
	}
	
}
