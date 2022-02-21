#!/bin/bash
# Escola del Treball
# Christian Manalo - isx9565961
# Tasca 4:
# Crea un programa anomenat ​ crea-classe-file.sh que crea alumnes del curs que rep com a
# primer argument. Rep un segon argument corresponent a un fitxer amb noms:password
# d’alumnes a donar d’alta.
# Es tracta de crear la classe amb el nom indicat per el primer argument i afegir-hi els
# alumnes que conté el fitxer rebut com a segon argument. Aquest fitxer conté per a cada línia
# el nom de l’usuari i el seu password amb el format ​ nom:passwd ​ .
# ---------------------------------------------------------------------------------------

OK=0
ERR_NARGS=1
if [ $# -ne 2 ];then
  echo "Error: Num args incorrectes"
  echo "Usage: $0 curs file"
  exit $ERR_NARGS
fi

curs=$1
groupadd $curs

file=$2
while read -r line; do

  user=$(echo $line | cut -d: -f1)
  password=$(echo $line | cut -d: -f2)

  useradd $user -g $curs -G users -m -b /home/$curs 
  echo $user:$password | chpasswd 

done < $file

exit $OK
