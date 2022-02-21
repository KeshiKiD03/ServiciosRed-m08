#/bin/bash
# Christiani Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 7) Programa: prog -f|-d arg1 arg2 arg3 arg4
# a) Valida que els quatre arguments rebuts són tots del tipus que indica el flag. És a dir, si es crida amb -f valida que tots quatre són file. Si es crida amb -d valida que tots quatre són directoris.
#     Retorna 0 ok, 1 error nº args, 2 hi ha elements errònis.
# ----------------------------------------------------------
status=0
# Comprova num arguments
if ! [ $# -eq 5 ]; then 
	echo "Error: Nº d'arguments incorrectes"
	echo "Usage: $0 prog -f|-d arg1 arg2 arg3 arg4"
	echo "1"
	exit 1
fi

opcions=$1
shift

# Comprova la opció
if ! [ $opcions == "-f" -o $opcions == "-d" ]; then
	echo "Error: Flag incorrecte"
	echo "Usage: $0 prog -f|-d arg1 arg2 arg3 arg4"
	echo "2"
	exit 2

fi

# Itera cada argument
for arg in $*
do	
	# Si es un element eroni
	if ! [ $opcions $arg ]; then
		status=2
	fi	
done 


echo $status


