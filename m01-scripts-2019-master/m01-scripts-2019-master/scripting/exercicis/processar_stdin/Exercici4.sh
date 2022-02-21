#/bin/bash
# Christiani Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 4) Processar stdin cmostrant per stdout les línies numerades i en majúscules..
# ----------------------------------------------------------
OK=0
num=1
while read -r line
do	
	echo $num: $line | tr [:lower:] [:upper:] )
	num=$((num+1))	
done 
