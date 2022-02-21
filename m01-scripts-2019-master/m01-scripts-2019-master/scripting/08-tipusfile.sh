#!/bin/bash
# ASX-M01
# Christian Manalo - isx9565961
# Febrer 2020
# Ens diu si es regular, dir o link
#-------------------------------
# Validar argument
ERR_NARGS=1
if [ $# -ne 1 ]; then
	echo "Error: #num args incorrects"
	echo "Usage: $0 file"
	exit $ERR_NARGS
fi

# Doesn't exist
if ! [ -e $1 ]
then 
	echo "$1: Doesn't exist"

# Regular
elif [ -h $1 ]
then	
	echo "$1 is a symbolic link"
	
# Regular
elif [ -f $1 ]
then
	echo "$1 is a regular file"
	
# Dir
elif [ -d $1 ]
then
	echo "$1 is a Directory"

# Another Type
else
	echo "$1 is another type"

fi

exit 0




