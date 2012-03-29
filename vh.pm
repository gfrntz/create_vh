package vh;

BEGIN {
	use Exporter ();
	@ISA = "Exporter";
	@EXPORT = qw(&chk_dir &create_vh);
}



sub chk_dir {

	if ( -d "/etc/httpd/" ) {
		print "This is httpd!\n";
		$apa_dir = "/etc/httpd/conf.d/";
	} elsif ( -d "/etc/apache2" ) {
		print "This is apache2!\n";
		$apa_dir = "/etc/apache2/sites-enabled";
		print "$apa_dir\n";
	} else {
		print "Can't find apache dir =(\n";
	}
		
}

sub create_vh {
	$user_name = shift;
	$file = shift;

	open (DOMAINS, "<", $file) or die "Can't open $file : $!\n";

	if ( -d "/var/www/$user_name" ) {
		print "Directory for user $user_name exist. Skip.\n";
	} else {
		`mkdir /var/www/$user_name`;
	}

	if ( -d "/var/www/$user_name/apache-log" ) {
		print "Apache log dir in user folder exists. Skip.\n";
	} else {
		print "Create apache log directory.\n";
		`mkdir /var/www/$user_name/apache-log`;
	}

	while ( <DOMAINS> ) {
	chomp($_);
	print "Create vh for - $_\n";

	if ( -d "/var/www/$user_name/$_" ) {
		print "Virtual host directory for $_ exists.\n";
		print "Skip create directory.\n";
	} else {
		print "Create dir for $_\n";
		`mkdir /var/www/$user_name/$_`;
	}

		open (VH, ">", "$apa_dir" . "/$_" . ".conf") or die "Can't open $file : $!\n";;
		print VH <<EOF;

#
# Created by zen do-vh.pl
#

<VirtualHost *:80>
    ServerAdmin postmaster\@$_
    DocumentRoot /var/www/$user_name/$_
    DirectoryIndex index.php index.html index.htm
    ErrorLog /var/www/$user_name/apache-log/$_.error.log
    CustomLog /var/www/$user_name/apache-log/$_.access.log common
    AddType application/x-httpd-php .php .php3 .php4 .php5 .phtml
    AddType application/x-httpd-php-source .phps
</VirtualHost>
EOF

		close(VH);

	
		`touch /var/www/$user_name/apache-log/$_.error.log`;
		`touch /var/www/$user_name/apache-log/$_.access.log`;
	}

	close DOMAINS;
}

return1;

END { }
