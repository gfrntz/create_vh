package isp;

BEGIN {
	use Exporter ();
	@ISA = "Exporter";
	@EXPORT = qw(&create_isp_vh);
}

sub check_panel {
	
	if ( -d "/usr/local/ispmgr" ) {
		print "I find isp panel!\n";		
	} else {
		print "Panel not found!\n";	
		exit;
	}
	
}

return 1;

END { };
