#/bin/bash
# Christiani Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 3) Processar arguments que són matricules:
# 	b) stdout les que són vàlides, per stderr les no vàlides. Retorna de status el número d̉errors (de no vàlides)
# ----------------------------------------------------------

OK=0
error=0
for matricules in $*
do	
	echo $matricules | egrep "^[0-9]{4}-[A-Z]{3}$" &> /dev/null 
	if [ $? -eq 0 ]; then
		echo "$matricules"	
	
	else	
		echo "Error: $matricules no valid" >> /dev/stderr
		error=$((error+1))
	fi
done
echo "Errors: $error"
exit $OK
