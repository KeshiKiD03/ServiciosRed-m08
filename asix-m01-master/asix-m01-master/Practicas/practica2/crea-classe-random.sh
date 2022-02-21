#!/bin/bash
# Escola del Treball
# Christian Manalo - isx9565961
# Tasca 5:
# Crea un programa anomenat ​ crea-classe-random.sh que crea alumnes del curs que rep
# com primer argument. Rep un segon o més arguments corresponents a noms d’usuaris a
# donar d’alta en aquesta classe. Cada argument és un login (excepte el primer).

# A cada usuari se li assigna un password random de 8 dígits/caracters.

# Evidentment si es creen els usuaris i se’ls assigna un passwd random si no es desa aquesta
# informació enlloc els usuaris no podran entrar... El programa genera un fitxer ​ passwd.log
# amb l’associació de usuari i passwd generat amb el format l​ ogin:passwd ​
# ---------------------------------------------------------------------------------------

OK=0
ERR_NARGS=1

if [ $# -lt 2 ];then
  echo "Error: Num args incorrectes"
  echo "Usage: $0 curs file"
  exit $ERR_NARGS
fi

curs=$1
shift
groupadd $curs 

users_list=$*

for new_user in $users_list 
do
   useradd $new_user -g $curs -G users -b /home/$curs
   random_pass=$(pwgen 8 1)
   echo "$new_user:$random_pass" | chpasswd
   echo "$new_user:$random_pass" >> passwd.log

done
exit 0

