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
	$vh_name = shift;

	open (VH, ">", "$apa_dir" . "/$vh_name" . ".conf");
	print VH <<EOF;

#
# Created by zen do-vh.pl
#

<VirtualHost *:80>
    ServerAdmin postmaster\@$vh_name
    DocumentRoot /var/www/$user_name/$vh_name
    DirectoryIndex index.php index.html index.htm
    ErrorLog /var/www/$user_name/apache-log/$vh_name.error.log
    CustomLog /var/www/$user_name/apache-log/$vh_name.access.log common
    AddType application/x-httpd-php .php .php3 .php4 .php5 .phtml
    AddType application/x-httpd-php-source .phps
</VirtualHost>
EOF

	close(VH);
	
	if ( -d "/var/www/$user_name/$vh_name" ) {
		print "Virtual host directory for $vh_name exists.\n";
		print "Skip create directory.\n";
	} else {
		print "Create dir for $vh_name\n";
		`mkdir /var/www/$user_name/$vh_name`;
	}

	if ( -d "/var/www/$user_name/apache-log" ) {
		print "Apache log dir in user folder exists. Skip.\n";
	} else {
		print "Create apache log directory.\n";
		`mkdir /var/www/$user_name/apache-log`;
	}
	
	`touch /var/www/$user_name/apache-log/$vh_name.error.log`;
	`touch /var/www/$user_name/apache-log/$vh_name.access.log`;
}

return1;


END { }
