#!/usr/bin/perl
#####################check_disk_multi ##############
# Version : 0.1
# Date :  2016 03 
# Author  : Juargo (Jorge Retamal)
# GIT: https://github.com/Juargo/Monitoreo
#################################################################

($type,$size,$used,$avail,$use,$warning,$critical)=@ARGV;

if ($use<$warning){
	print ":: OK :::: Total=$size :::: Uso=$used($use%) :::::: Disponible=$avail :::::: ---Type=$type|uso=$use%;$warning;$critical;0;100";exit(0);
}
elsif ($use >= $warning && $use < $critical){
	print ":: WARNING :::: total=$size :::: Uso=$used($use%) :::::: Disponible=$avail :::::---Type=$type|uso=$use%;$warning;$critical;0;100";exit(1);
}
elsif ($use >= $critical){
	print ":: CRITICAL :::: total=$size :::: Uso=$used($use%) :::::: Disponible=$avail ::::: ---Type=$type|uso=$use%;$warning;$critical;0;100";exit(2);
}
else{
	print "UNKNOW -";exit(3);
}

