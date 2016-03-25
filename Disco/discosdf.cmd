command[/dev]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 797M 0 797M 0 10 
command[/dev/shm]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 803M 184K 803M 1 10 
command[/run]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 803M 2,0M 801M 1 10 
command[/sys/fs/cgroup]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 803M 0 803M 0 10 
command[/]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/var/tmp]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/var/spool]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/var/opt]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/tmp]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/usr/local]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/var/log]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/opt]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/var/crash]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/srv]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/var/lib/pgsql]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/var/lib/mailman]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/var/lib/named]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/var/lib/libvirt/images]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/var/lib/mariadb]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/var/lib/mysql]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/boot/grub2/i386]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/boot/grub2/x86]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 13G 5,3G 6,3G 46 10 
command[/home]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 18G 70M 18G 1 10 
command[/run/media/juargo/openSUSE]=/home/juargo/Monitoreo/Disco/check_df_multi.pl 4,4G 4,4G 0 100 10 


state [OK] = (COUNT(CRITICAL) < 0)
state [WARNING] = (COUNT(WARNING) > 0) 
state [CRITICAL] = (COUNT(CRITICAL) > 0) or (COUNT(WARNING) > 1)
 