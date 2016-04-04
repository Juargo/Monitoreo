#!/usr/bin/perl


open(IN ,"lsof|awk \'{print \$3}\'|sort|uniq -c|");

open(ON,">/var/lib/centreon-engine/ssh_router/lsof.cmd");

while(<IN>){
	chomp($_);
		($cantidad,$user)=split(" ",$_);
			print ON "command[$user]=/var/lib/centreon-engine/ssh_router/check_trafico.py $cantidad\n";
			}

			close IN;
			close ON;

			$check=`/usr/local/nagios/libexec/check_multi  -f /var/lib/centreon-engine/ssh_router/lsof.cmd`;
			print$check;
			
