#!/bin/bash
# ASX-M01
# Christian Manalo - isx9565961
# Febrer 2020
# Exemples bucles while
#--------------------------------
ERR_NARGS=1
ERR_ARGVL=2
OK=0

# Processar stain fins a token "FI"
contador=1
while read -r line 
do
	echo $contador: $line | tr '[a-z]' '[A-Z]'
	contador=$((contador+1))	
done
exit $OK

# Mostrar l'entrada estandar numerant las linias
contador=1
while read -r line
do
	echo "$contador: $line"
       	contador=$((contador+1))
done
exit $OK


# Mostrar l'entrada estandard linia a linia
while read -r line
do
	echo $line
done
exit $OK


# Enumerar els arguments
contador=1
while [ -n "$1" ]
do
	echo "$contador: $1, $#, $*"
	contador=$((contador+1))
	shift
done
exit $OK


# Mostrar els arguments
while [ -n "$1" ]
do
	echo "$1 $#: $*"
	shift
done
exit $OK

# Mostrar els arguments
while [ $# -gt 0 ]
do
	echo "$#: $*"
	shift
done
exit $OK


# Comptador recreixent del arg rebut
contador=$1
MIN=0
while [ $contador -ge $MIN ]
do
	echo -n "$contador,"
	contador=$((contador-1))
done
exit $OK



# Compta de 1 - 10
contador=1
MAX=10
while [ $contador -le $MAX ]
do
	echo "$contador"
	contador=$((contador+1))
done
exit $OK

