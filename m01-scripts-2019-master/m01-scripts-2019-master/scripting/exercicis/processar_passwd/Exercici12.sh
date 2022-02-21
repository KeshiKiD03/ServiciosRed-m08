#/bin/bash
# Christiani Manalo Mañibo
# Febrer 2020
# ASIX-M01
# ----------------------------------------------------------
if ! [ $# -gt 0 ]; then
	echo "Error: Num d'arguments incorrectes"
	echo "Usage: $0 [...]"
	exit 1
fi

for uid in $* 
do
	buscar=$(egrep "^[^:]*:[^:]*:$uid:" /etc/passwd) 
	if [ $? -eq 0 ]; then
		login=$(echo $buscar | cut -d: -f1)
		gname=$(egrep "^[^:]*:^[^:]*:$uid:" /etc/group | cut -d: -f1)
		home=$(echo $buscar | cut -d: -f6)
		shell=$(echo $buscar | cut -d: -f7)
		echo "$login($uid) $home $shell"
	else
		echo "Error: $uid no existeix " >> /dev/stderr
	fi
done

