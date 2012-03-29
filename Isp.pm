package Isp;

BEGIN {
	use Exporter ();
	@ISA = "Exporter";
	@EXPORT = qw(&check_panel &create_isp_vh);
}

sub check_panel {
	
	if ( -d "/usr/local/ispmgr" ) {
		print "I found isp panel!\n";		
	} else {
		print "Panel not found!\n";	
		exit;
	}
	
	if ( ! -e "/usr/local/ispmgr/sbin/mgrctl" ) {
		print "mgrctl not found. Exit.\n";
		exit;
	}

}

sub create_isp_vh {
	$user_name = shift;
	$file = shift;

	if (`/usr/local/ispmgr/sbin/mgrctl user | grep $user_name` == 1) {
		print "User exists. Skip.\n";
	} else {
		print "Create user.\n";
		`/usr/local/ispmgr/sbin/mgrctl user.edit name=testapi passwd=qwerty ssl=on cgi=on ssi=on phpmod=on \
		phpcgi=on phpfcgi=on domainlimit=10000 webdomainlimit=10000 baseuserlimit=10000\
		maillimit=10000 baselimit=10000 preset=custom ftplimit=10000 disklimit=10000 sok=yes`;
	}
	print "Enter user mailbox.\n";
	chomp($mail = <STDIN>);
	print "Enter srv ip.";
	chomp($srv_ip = <STDIN>) ;
	
	open (DOMAINS, "<", $file) or die "Can't open $file : $!\n";
	
	while ( <DOMAINS> ) {
	chomp($_);

	print "Create vh for - $_\n";
	
	`/usr/local/ispmgr/sbin/mgrctl wwwdomain.edit domain=api.test alias=www.api.test ip=$srv_ip \
	owner=testapi  admin=$mail index="index.php index.html" cgi=on php=phpmod sok=yes`;
	
	}
		
	close DOMAINS;
}

return 1;

END { };
