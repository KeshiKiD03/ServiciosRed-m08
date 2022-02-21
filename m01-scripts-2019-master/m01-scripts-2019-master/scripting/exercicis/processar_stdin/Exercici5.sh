#/bin/bash
# Christiani Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 5) Processar stdin mostrant per stdout les línies de menys de 50 caràcters.
# ----------------------------------------------------------
OK=0
while read -r line
do	
	caracters=$(echo $line | wc -L )
	if [ $caracters -lt 50 ]; then  
		echo "$line"
	fi
done 
exit $OK
