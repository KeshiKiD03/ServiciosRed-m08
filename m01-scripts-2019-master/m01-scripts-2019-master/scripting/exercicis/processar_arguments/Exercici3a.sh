#/bin/bash
# Christian Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 3) Processar arguments que són matricules:
#       a) llistar les vàlides, del tipus: 9999-AAA.
# ----------------------------------------------------------
OK=0
for matricules in $*
do	
	echo $matricules | egrep "^[0-9]{4}-[A-Z]{3}$" &> /dev/null
	if [ $? -ne 0 ]; then
		echo "$matricules"	
	fi
done
exit $OK
