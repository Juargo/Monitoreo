#!/usr/bin/perl
$PATH="$ENV{'PWD'}";
#$por_warning=$ARGV[0];
#$por_critical=$ARGV[1];
#
open(MIFICH,">$PATH/discosdf.cmd");
#
open(IN, "df -h |");
##Size  Used Avail Use% Mounted on
## 8,1G  4,4G  3,3G  57% /
#
while(<IN>){
	chomp();
	if (/\s(\d+[\.\,]\w+|\d+\w+|\d+)\s+(\d+[\.\,]\w+|\d+\w+|\d+)\s+(\d+[\.\,]\w+|\d+\w+|\d+)\s+(\d+%)\s+([\/A-Za-z0-9]+)/){
	$size=$1;
	$used=$2;
	$use=$4;
	$avail=$3;
	$disk=$5;
	if($disk=~ ".*mysql"){ $disk="mysql"}
	print MIFICH "command[$disk]=$PATH/check_df_multi.pl $size $used $avail $use $por_warning $por_critical\n";
	}
}
close(IN);
print MIFICH "\n\n";
print MIFICH "state [OK] = (COUNT(CRITICAL) < 0)\n";
print MIFICH "state [WARNING] = (COUNT(WARNING) > 0) \n";
print MIFICH "state [CRITICAL] = (COUNT(CRITICAL) > 0) or (COUNT(WARNING) > 1)\n ";
close MIFICH;
$check=`/usr/local/nagios/libexec/check_multi -f $PATH/discosdf.cmd`;
print "$check";
if($check=~/^([A-Z]+) -/){
if( $1 eq "WARNING"){exit(1)}
elsif($1 eq "OK"){exit(0)}
elsif($1 eq "CRITICAL"){exit(2)}
else{exit(3)}
																			}
#
#
