command[/]=/home/soporte/Monitoreo/Disco/check_df_multi.pl rootfs 3,4G 3,1G 152M 96 97 98
command[/dev]=/home/soporte/Monitoreo/Disco/check_df_multi.pl devtmpfs 10M 0 10M 0 97 98
command[/run]=/home/soporte/Monitoreo/Disco/check_df_multi.pl tmpfs 587M 272K 587M 1 97 98
command[/]=/home/soporte/Monitoreo/Disco/check_df_multi.pl ext4 3,4G 3,1G 152M 96 97 98
command[/run/lock]=/home/soporte/Monitoreo/Disco/check_df_multi.pl tmpfs 5,0M 0 5,0M 0 97 98
command[/run/shm]=/home/soporte/Monitoreo/Disco/check_df_multi.pl tmpfs 1,3G 0 1,3G 0 97 98
command[/home]=/home/soporte/Monitoreo/Disco/check_df_multi.pl ext4 8,1G 6,1G 1,6G 80 97 98
command[/Data]=/home/soporte/Monitoreo/Disco/check_df_multi.pl ext4 9,9G 151M 9,2G 2 97 98


state [OK] = (COUNT(CRITICAL) < 0)
state [WARNING] = (COUNT(WARNING) > 0) 
state [CRITICAL] = (COUNT(CRITICAL) > 0) or (COUNT(WARNING) > 1)
 