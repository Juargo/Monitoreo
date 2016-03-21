command[/]=/home/jorge/Documentos/Monitoreo/Disco/check_df_multi.pl 50G 5,6G 45G 12%  
command[/dev]=/home/jorge/Documentos/Monitoreo/Disco/check_df_multi.pl 3,9G 0 3,9G 0%  
command[/dev/shm]=/home/jorge/Documentos/Monitoreo/Disco/check_df_multi.pl 3,9G 5,6M 3,9G 1%  
command[/run]=/home/jorge/Documentos/Monitoreo/Disco/check_df_multi.pl 3,9G 9,0M 3,9G 1%  
command[/sys/fs/cgroup]=/home/jorge/Documentos/Monitoreo/Disco/check_df_multi.pl 3,9G 0 3,9G 0%  
command[/boot]=/home/jorge/Documentos/Monitoreo/Disco/check_df_multi.pl 494M 135M 360M 28%  
command[/boot/efi]=/home/jorge/Documentos/Monitoreo/Disco/check_df_multi.pl 200M 9,5M 191M 5%  
command[/home]=/home/jorge/Documentos/Monitoreo/Disco/check_df_multi.pl 872G 488M 871G 1%  
command[/run/user/1000]=/home/jorge/Documentos/Monitoreo/Disco/check_df_multi.pl 793M 32K 793M 1%  


state [OK] = (COUNT(CRITICAL) < 0)
state [WARNING] = (COUNT(WARNING) > 0) 
state [CRITICAL] = (COUNT(CRITICAL) > 0) or (COUNT(WARNING) > 1)
 