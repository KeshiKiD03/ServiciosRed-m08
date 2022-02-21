#!/bin/bash
# Escola del Treball
# Christian Manalo - isx9565961
# Tasca 2 
# Feu un programa anomenat ​ del_usuari.sh que rep un login i elimina TOT el que
# pertany a l’usuari, però deixant un tar.gz de tots els fitxers que li pertanyen. Va
# generant una traça per stderr de tot allò que va eliminant.
# -------------------------------------------------------------------------------------
OK=0
ERR_NARGS=1
ERR_NOLOGIN=2
if [ $# -ne 1 ];then
  echo "Error: Num args incorrectes"
  echo "Usage: $0 login"
  exit $ERR_NARGS
fi

login=$1

line=$(egrep "^$login:" /etc/passwd) 
if [ -z  $line ];then
  echo "Error: $login usuari inexistent"
  echo "Usage: $0 login"
  exit $ERR_NOLOGIN
fi


pkill -U $(id -u $login)

tar -czf $login-home.tar.gz $(find / -user $login 2> /dev/stderr) 2> /dev/stderr

rm $(find / -user $login 2> /dev/null) 2>  /dev/stderr

userdel -r $login 

exit $OK