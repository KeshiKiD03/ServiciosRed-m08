#!/bin/bash
# Escola del Treball
# Christian Manalo - isx9565961
# Tasca 3:
# Crea un programa anomenat ​ crea-classe-hardcoded.sh que crea 30 alumnes (proveu amb
# 3 per començar...) del curs que rep com a argument.
# Podeu generar els noms dels alumnes automatitzadament amb brace expansion utilitzant
# hisx1-{01-30}.
# Als alumnes els assignem el passwd ‘alum’ per defecte
# ---------------------------------------------------------------------------------------

OK=0
ERR_NARGS=1
if [ $# -ne 1 ];then
  echo "Error: Num args incorrectes"
  echo "Usage: $0 curs"
  exit $ERR_NARGS
fi

curs=$1
noms_alumnes=$(echo $curs-{01..03})
groupadd $curs

for new_alumne in $noms_alumnes
do
  useradd $new_alumne -g $curs -G users -m -b /home/$curs
  echo "$new_alumne:alum" | chpasswd
done

exit $OK
