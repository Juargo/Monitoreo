#!/usr/bin/perl
##################disk_df_multi ##############
# Version : 0.1
# Date :  2016 03 
# Author  : Juargo (Jorge Retamal)
# GIT: https://github.com/Juargo/Monitoreo
#################################################################
#
use strict;
use Getopt::Long;
use Cwd 'abs_path';

our($dir_check_multi,$DIR,$warning,$critical);

$DIR=substr(abs_path($0),0,-18);

GetOptions("dir_check_multi|dcm:s" => \$dir_check_multi,
		"warning|w:n"=>\$warning,
		"critical|c:n"=>\$critical,
			"h|H|help" => \&_usage);

if(!$dir_check_multi){
	$dir_check_multi="/usr/local/nagios/libexec";
	if (!-e "$dir_check_multi/check_multi") {
   		print "No se encontró el binario check_multi\n";
	}		 
}

if(!$warning){
	print "no ha ingresado warning";
	exit();
}
if(!$critical){
        print "no ha ingresado critical";
        exit();
}

open(MIFICH,">$DIR/discosdf.cmd");

open(IN, "df -Th |");

while(<IN>){
	chomp();
	if (/\s(\w+)\s+(\d+[\.\,]\w+|\d+\w+|\d+)\s+(\d+[\.\,]\w+|\d+\w+|\d+)\s+(\d+[\.\,]\w+|\d+\w+|\d+)\s+(\d+)%\s+([\/A-Za-z0-9]+)/){
		my $type = $1;
		my $size = $2;
		my $used = $3;
		my $avail = $4;
		my $use  = $5;
		my $disk = $6;
		print MIFICH "command[$disk]=$DIR/check_df_multi.pl $type $size $used $avail $use $warning $critical\n";
	}
}
close IN;

print MIFICH "\n\n";
print MIFICH "state [OK] = (COUNT(CRITICAL) < 0)\n";
print MIFICH "state [WARNING] = (COUNT(WARNING) > 0) \n";
print MIFICH "state [CRITICAL] = (COUNT(CRITICAL) > 0) or (COUNT(WARNING) > 1)\n ";
close MIFICH;

my $check=`$dir_check_multi/check_multi -f $DIR/discosdf.cmd`;
print "$check";

if($check=~/^([A-Z]+) -/){
	if( $1 eq "WARNING"){exit(1)}
	elsif($1 eq "OK"){exit(0)}
	elsif($1 eq "CRITICAL"){exit(2)}
	else{exit(3)}
}

sub _usage(){
	print <<"EOF";
disck_df_check.pl 
	
	Este script mide el uso de cada disco a través del comando df -Th. 
	Para el monitoreo es utilizado el porcentaje de uso, pero además entrega información de cuanto disco queda disponible.

	--dir_check_multi|dcm : 
		Directorio donde se encuentra check_multi default \"/usr/local/nagios/libexec\"
	--warning|w : 
		porcentaje que se tomará como warning
	--critical|c :
		porcentaje que se tomará como critical
	--help|h|H : 
		ayuda
EOF

}
