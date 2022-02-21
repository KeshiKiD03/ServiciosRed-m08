#!/bin/bash
# ASX-M01
# Christian Manalo - isx9565961
# Febrer 2020
# Validar un argument o mes arguments i comprava si es un directori i llister-ne el contingut i enumerarlo
#--------------------------------
ERR_NARGS=1
ERR_ARGVL=2
OK=0

# Comprova arguments
if ! [ $# -ge 1 ]
then
	echo "Error: #num d'arguments incorrectes"
	echo "Usage: $0 directori[...]"
	exit $ERR_NARGS
fi


# Comprova si es directori
directoris=$*
for argument in $directoris
do	
	if ! [ -d $argument ]
	then 
		echo "Error: Directori invalid" 
		echo "Usage: $0 directori" 
	else
		# Fa un ls
		echo "Processant directori: $argument"
		fileList=$(ls $argument)
		num=1
		for file in $fileList
		do
			if [ -h $argument/$file ]; then
				echo "$num: $file link"
	
			elif [ -f $argument/$file ]; then
				echo "$num: $file regular file"
	
			elif [ -d $argument/$file ]; then
				echo "$num: $file directori"
			else
				echo "$num: $file altres "
			fi
			num=$((num+1))
		done
	fi
done
exit $OK
