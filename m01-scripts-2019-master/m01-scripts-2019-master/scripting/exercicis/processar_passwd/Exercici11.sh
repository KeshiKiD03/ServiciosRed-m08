#/bin/bash
# Christiani Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 11) Idem però rep els GIDs com a arguments de la línia d̉ordres.
# ----------------------------------------------------------
if ! [ $# -gt 0 ]; then
	echo "Error: Num d'arguments incorrectes"
	echo "Usage: $0 [...]"
	exit 1
fi

for line in $* ; do
	gids=$(egrep "^[^:]*:[^:]*:$line:" /etc/group) 
	if [ $? -eq 0 ]; then
		gname=$(echo $gids | cut -d: -f1 | tr '[:lower:]'  '[:upper:]')
		users=$(echo $gids | cut -d: -f4 | tr '[:lower:]' '[:upper:]')	
		echo "gname: $gname gid: $line user: $users"
	else
		echo "Error: $line no existeix " >> /dev/stderr
	fi
done

