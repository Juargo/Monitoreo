#!/usr/bin/perl
use strict;
use Getopt::Long;

our($dir_check_multi);
GetOptions("dir_check_multi|dcm:s" => \$dir_check_multi,
			"h|H|help");

if(!$dir_check_multi){
	$dir_check_multi="/usr/local/nagios/libexec/";
}else{
	print $dir_check_multi;
}
