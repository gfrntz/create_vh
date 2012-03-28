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

	open (VH, ">", "$apa_dir" . "$vh_name" . ".conf");
	print VH <<EOF;

#
# Created by zen do-vh.pl
#

<VirtualHost *:80>
    ServerAdmin postmaster\@$vh_name
    DocumentRoot /var/www/$username/$vh_name
    DirectoryIndex index.php index.html index.htm
    ErrorLog /var/www/$user_name/apache-log/$vh_name.error.log
    CustomLog /var/www/$user_name/apache-log/$vh_name.access.log common
    AddType application/x-httpd-php .php .php3 .php4 .php5 .phtml
    AddType application/x-httpd-php-source .phps
</VirtualHost>
EOF

	close(VH);

}

return1;


END { }
