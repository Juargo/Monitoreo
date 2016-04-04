#!/usr/bin/perl


open (IN, "cat /proc/net/dev |awk '{print \$1,\$2,\$4,\$10,\$12}'|grep :|sed 's/://g'|");

open (DIFF,"cat /home/jorge/Documentos/Monitoreo/RED/pass.txt|");

while (<DIFF>){
	 chomp();
        ($interface,$rbyts,$rerr,$tbyts,$terr)=split(" ",$_);
	$interfaces_pass{$interface}{'recibidos'}=$rbyts;
	$interfaces_pass{$interface}{'recibidoserr'}=$rerr;
	$interfaces_pass{$interface}{'transmitidos'}=$tbyts;
	$interfaces_pass{$interface}{'transmitidoserr'}=$terr;
}

close DIFF;
 `rm -f /home/jorge/Documentos/Monitoreo/RED/pass.txt`;
open (PFILE,">/home/jorge/Documentos/Monitoreo/RED/trafico_interfaz.cmd");
while (<IN>){
	chomp();
	($interface,$rbyts,$rerr,$tbyts,$terr)=split(" ",$_);
	
	$interfaces{$interface}{'recibidos'}=$rbyts-$interfaces_pass{$interface}{'recibidos'};
        $interfaces{$interface}{'recibidoserr'}=$rerr-$interfaces_pass{$interface}{'recibidoserr'};
        $interfaces{$interface}{'transmitidos'}=$tbyts-$interfaces_pass{$interface}{'transmitidos'};
        $interfaces{$interface}{'transmitidoserr'}=$terr-$interfaces_pass{$interface}{'transmitidoserr'};
	
	open(SFILE,">/home/jorge/Documentos/Monitoreo/RED/$interface.cmd");
	
	print PFILE "command[$interface]=/usr/local/nagios/libexec/check_multi -f /home/jorge/Documentos/Monitoreo/RED/$interface.cmd\n";
	print SFILE "command[Recibidos]=/home/jorge/Documentos/Monitoreo/RED/check_trafico_interfaz.pl $interfaces{$interface}{'recibidos'} $interfaces{$interface}{'recibidoserr'}\n";
	print SFILE "command[Transmitidos]=/home/jorge/Documentos/Monitoreo/RED/check_trafico_interfaz.pl $interfaces{$interface}{'transmitidos'} $interfaces{$interface}{'transmitidoserr'}\n";
	
	close SFILE;
	open(DIFFN,">>/home/jorge/Documentos/Monitoreo/RED/pass.txt");
	
	print DIFFN "$interface $rbyts $rerr $tbyts $terr\n";
	close DIFFN;
}
close IN;
close PFILE;
$check=`/usr/local/nagios/libexec/check_multi  -f /home/jorge/Documentos/Monitoreo/RED/trafico_interfaz.cmd`;
print$check;

