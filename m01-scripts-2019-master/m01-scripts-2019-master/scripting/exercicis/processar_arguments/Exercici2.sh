#/bin/bash
# Christian Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 2) Processar els arguments i comptar quantes n̉hi ha de 3 o mées caràcters.
# ----------------------------------------------------------
OK=0
contador=0
for arg in $*
do	
	caracter=$(echo $arg | wc -c )
	if [ $caracter -ge 3 ]; then
		contador=$((contador+1))	
	fi
done
echo "3 caracters o mes: $contador arguments"
exit $OK
