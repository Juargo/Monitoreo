#!/usr/bin/perl
##############Trafico_Interfaces##############
## Version : 0.1
## Date :  2016 04 
## Author  : Juargo (Jorge Retamal)
## GIT: https://github.com/Juargo/Monitoreo
##################################################################
##
use strict;
use Getopt::Long;
use Cwd 'abs_path';

our($i,$dir_check_multi,$DIR,$interface,$prbyts,$prerr,$ptbyts,$pterr,$rbyts,$rerr,$tbyts,$terr,$check);

GetOptions("dir_check_multi|dcm:s" => \$dir_check_multi,
		"Interface|i:s"=>\$i,
			"h|H|help" => \&_usage);

if(!$dir_check_multi){
	$dir_check_multi="/usr/local/nagios/libexec";
	if (!-e "$dir_check_multi/check_multi") {
   		print "No se encontró el binario check_multi\n";
	}		 
}


$DIR=substr(abs_path($0),0,-21);

open (IN, "cat /proc/net/dev |awk '{print \$1,\$2,\$4,\$10,\$12}'|grep :|sed 's/://g'|grep $i|");

open (DIFF,"cat $DIR/pass.txt|");

while (<DIFF>){
	 chomp();
        ($interface,$prbyts,$prerr,$ptbyts,$pterr)=split(" ",$_);
}

close DIFF;
 `rm -f $DIR/pass.txt`;
open (PFILE,">$DIR/trafico_interfaces.cmd");
while (<IN>){
	chomp();
	($interface,$rbyts,$rerr,$tbyts,$terr)=split(" ",$_);
	
	my $bytesrecibidos = $rbyts-$prbyts;
	my $bytesrecibidoserr = $rerr-$prerr;
 	my $bytestrasmitidos = $tbyts-$ptbyts;
 	my $bytestransmitidos = $terr-$pterr;
	
	
	print PFILE "command[Recibidos]=$DIR/check_trafico_interfaz.pl $bytesrecibidos $bytesrecibidoserr\n";
	print PFILE "command[Transmitidos]=$DIR/check_trafico_interfaz.pl $bytestrasmitidos $bytestransmitidos\n";
	
	open(DIFFN,">>$DIR/pass.txt");
	
	print DIFFN "$interface $rbyts $rerr $tbyts $terr\n";
	close DIFFN;
}
close IN;
close PFILE;
$check=`/usr/local/nagios/libexec/check_multi  -f $DIR/trafico_interfaces.cmd`;
print$check;


sub _usage(){
	print <<"EOF";
##############Trafico_Interfaces##############
### Version : 0.1
### Date :  2016 04 
### Author  : Juargo (Jorge Retamal)
### GIT: https://github.com/Juargo/Monitoreo
###################################################################
###
#
	--dir_check_multi|dcm : 
		Directorio donde se encuentra check_multi default \"/usr/local/nagios/libexec\"
	--Interface: Interface a monitorear tráfico
	--help|h|H : 
		ayuda
EOF

}
