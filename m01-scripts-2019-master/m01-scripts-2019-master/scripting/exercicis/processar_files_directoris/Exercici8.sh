#/bin/bash
# Christiani Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 8) Programa: prog file…
# a)Validar existeix almenys un file. Per a cada file comprimir-lo. Generar per stdout el nom del file comprimit si s̉ha comprimit correctament, o un missatge d̉error per stderror si no s̉ha pogut comprimir. En finalitzar es mostra per stdout quants files ha comprimit.
# Retorna status 0 ok, 1 error nº args, 2 si algun error en comprimir.
# ----------------------------------------------------------
status=0							

# Comprova num arguments
if  [ $# -lt 1 ]; then 
	echo "Error: Nº d'arguments incorrectes"
	echo "Usage: $0 prog file[...]"
	echo "status: 1"
	exit 1
fi

contador=0
# Itera cada argument
for arg in $*
do	
	tar -czf $arg.tar $arg &> /dev/null
	if [ $? -eq 0 ]; then 
		echo $arg.tar
		contador=$((contador+1))
	else
		echo "Error: $arg no s'ha pogut comprimir" >> /dev/stderr
		status=2
	fi
done 

echo "Fitxers comprimits: $contador"
echo "status: $status"

