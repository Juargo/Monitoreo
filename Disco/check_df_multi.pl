#!/usr/bin/perl
$size=$ARGV[0];
$used=$ARGV[1];
$avail=$ARGV[2];
$use=$ARGV[3];
$por_warning=$ARGV[4];
$por_critical=$ARGV[5];

if ($use < $por_warning){ print " OK - Uso = $used($use%)\tTTL: $size\t<strong>Quedan: $avail</strong> | uso=$use;$por_warning;$por_critical;0;100;"; exit(0);}

elsif ($use >= $por_warning && $use < $por_critical){ print " WARNING - Uso = $used($use%)\tTTL: $size\t<strong>Quedan: $avail</strong>| uso=$use;$por_warning;$por_critical;0;100;"; exit(1);}

elsif ($use >= $por_critical){print "CRITICAL - Uso = $used($use%)\tTTL: $size\t<strong>Quedan: $avail</strong>| uso=$use;$por_warning;$por_critical;0;100;"; exit(2);}

else{print "UNKNOW -";exit(3);}

