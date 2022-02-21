#!/bin/bash
# ASX-M01
# Christian Manalo - isx9565961
# Febrer 2020
# Validar un argument que es un directori i llister-ne el contingut i enumerarlo
#--------------------------------
ERR_NARGS=1
ERR_ARGVL=2
OK=0

# Comprova arguments
if ! [ $# -eq 1 ]
then
	echo "Error: #num d'arguments incorrectes"
	echo "Usage: $0 directori"
	exit $ERR_NARGS
fi


# Comprova si es directori
dir=$1
if ! [ -d $dir ]
then 
	echo "Error: Directori invalid"
	echo "Usage: $0 directori"
	exit $ERR_ARGVL
fi


# Fa un ls
fileList=$(ls $dir)
num=1
for file in $fileList
do
	if [ -h $dir/$file ]; then
		echo "$num: $file link"
	
	elif [ -f $dir/$file ]; then
		echo "$num: $file regular file"
	
	elif [ -d $dir/$file ]; then
		echo "$num: $file directori"
	else
		echo "$num: $file altres "
	
	num=$((num+1))

	fi

done
exit $OK
