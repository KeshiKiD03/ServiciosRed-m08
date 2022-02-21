#/bin/bash
# Christiani Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 6) Processar per stdin linies d̉entrada tipus “Tom Snyder” i mostrar per stdout la línia en format → T. Snyder.
# ----------------------------------------------------------

while read -r line
do
	echo $line | sed -r 's/(^.)[^ ]*/\1./g'
done
