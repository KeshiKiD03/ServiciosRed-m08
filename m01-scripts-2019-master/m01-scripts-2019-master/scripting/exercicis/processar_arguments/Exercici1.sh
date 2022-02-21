#/bin/bash
# Christian Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 1) Processar els arguments i mostrar per stdout només els de 4 o més caràcters.
# ----------------------------------------------------------
OK=0
for arg in $*
do	
	caracter=$(echo $arg | wc -c )
	if [ $caracter -ge 4 ]; then
		echo "$arg"
	fi
done
exit $OK
