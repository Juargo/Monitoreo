#!/usr/bin/perl
use Cwd 'abs_path';

$DIR=substr(abs_path($0),0,-22);

open (IN, "cat /proc/net/dev |awk '{print \$1,\$2,\$4,\$10,\$12}'|grep :|sed 's/://g'|");

open (DIFF,"cat $DIR/pass.txt|");

while (<DIFF>){
	 chomp();
        ($interface,$rbyts,$rerr,$tbyts,$terr)=split(" ",$_);
	$interfaces_pass{$interface}{'recibidos'}=$rbyts;
	$interfaces_pass{$interface}{'recibidoserr'}=$rerr;
	$interfaces_pass{$interface}{'transmitidos'}=$tbyts;
	$interfaces_pass{$interface}{'transmitidoserr'}=$terr;
}

close DIFF;
 `rm -f $DIR/pass.txt`;
open (PFILE,">$DIR/trafico_interfaces.cmd");
while (<IN>){
	chomp();
	($interface,$rbyts,$rerr,$tbyts,$terr)=split(" ",$_);
	
	$interfaces{$interface}{'recibidos'}=$rbyts-$interfaces_pass{$interface}{'recibidos'};
        $interfaces{$interface}{'recibidoserr'}=$rerr-$interfaces_pass{$interface}{'recibidoserr'};
        $interfaces{$interface}{'transmitidos'}=$tbyts-$interfaces_pass{$interface}{'transmitidos'};
        $interfaces{$interface}{'transmitidoserr'}=$terr-$interfaces_pass{$interface}{'transmitidoserr'};
	
	open(SFILE,">$DIR/$interface.cmd");
	
	print PFILE "command[$interface]=/usr/local/nagios/libexec/check_multi -f $DIR/$interface.cmd\n";
	print SFILE "command[Recibidos]=$DIR/check_trafico_interfaz.pl $interfaces{$interface}{'recibidos'} $interfaces{$interface}{'recibidoserr'}\n";
	print SFILE "command[Transmitidos]=$DIR/check_trafico_interfaz.pl $interfaces{$interface}{'transmitidos'} $interfaces{$interface}{'transmitidoserr'}\n";
	
	close SFILE;
	open(DIFFN,">>$DIR/pass.txt");
	
	print DIFFN "$interface $rbyts $rerr $tbyts $terr\n";
	close DIFFN;
}
close IN;
close PFILE;
$check=`/usr/local/nagios/libexec/check_multi  -f $DIR/trafico_interfaces.cmd`;
print$check;

