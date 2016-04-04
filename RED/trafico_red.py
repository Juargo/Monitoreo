#!/usr/bin/python

import os
import commands

NagiosDir_registro="/var/lib/centreon-engine/ssh_router/registro_pasado.txt"
if not os.path.exists(NagiosDir_registro):
	archivo=open(NagiosDir_registro,'a')
	archivo.write('0 0')
	archivo.close()

archivo=open(NagiosDir_registro,'r')
Receive, Transmit= archivo.readline().split(" ")
archivo.close()

Receive_now, Transmit_now=commands.getoutput('grep eth0 /proc/net/dev | awk "{print \$2,\$10}"').split()

receive_ttl=int(Receive_now)-int(Receive)
transmit_ttl=int(Transmit_now)-int(Transmit)

archivo=open(NagiosDir_registro,'w')
archivo.write('{0} {1}'.format(Receive_now,Transmit_now))
archivo.close()

archivo_multi=open("/var/lib/centreon-engine/ssh_router/trafico.cmd",'w')
archivo_multi.write("command[Recibidos]=/var/lib/centreon-engine/ssh_router/check_trafico.py {0}\n".format(receive_ttl))
archivo_multi.write("command[Transmitidos]=/var/lib/centreon-engine/ssh_router/check_trafico.py {0}\n".format(transmit_ttl))
archivo_multi.close()

print commands.getoutput("/usr/local/nagios/libexec/check_multi -f /var/lib/centreon-engine/ssh_router/trafico.cmd")


