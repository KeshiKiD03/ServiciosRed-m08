#/bin/bash
# Christiani Manalo Mañibo
# Febrer 2020
# ASIX-M01
#10) Programa: prog.sh
#    Rep per stdin GIDs i llista per stdout la informació de cada un d̉aquests grups, en format: gname: GNAME, gid: GID, users: USERS
# ----------------------------------------------------------

while read -r line; do
	gids=$(egrep "^[^:]*:[^:]*:$line:" /etc/group) 
	if [ $? -eq 0 ]; then
		gname=$(echo $gids | cut -d: -f1 | tr '[:lower:]'  '[:upper:]')
		users=$(echo $gids | cut -d: -f4 | tr '[:lower:]' '[:upper:]')	
		echo "gname: $gname"
		echo "gid: $line"
		echo "user: $users"
	else
		echo "Error: $line no existeix " >> /dev/stderr
	fi
done

