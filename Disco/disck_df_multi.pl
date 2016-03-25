#!/usr/bin/perl
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
}

if($warning){
}

open(MIFICH,">$DIR/discosdf.cmd");

open(IN, "df -h |");

while(<IN>){
	chomp();
	if (/\s(\d+[\.\,]\w+|\d+\w+|\d+)\s+(\d+[\.\,]\w+|\d+\w+|\d+)\s+(\d+[\.\,]\w+|\d+\w+|\d+)\s+(\d+)%\s+([\/A-Za-z0-9]+)/){
		my $size=$1;
		my $used=$2;
		my $use=$4;
		my $avail=$3;
		my $disk=$5;
		print MIFICH "command[$disk]=$DIR/check_df_multi.pl $size $used $avail $use $warning $critical\n";
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

	--dir_check_multi|dcm : Directorio donde se encuentra check_multi default \"/usr/local/nagios/libexec\"
	--help|h|H : ayuda
EOF

}
