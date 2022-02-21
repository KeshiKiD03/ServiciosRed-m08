#!/bin/bash
# Christian Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 5. Mostrar línia a línia l̉entrada estàndard, retallant només els primers 50 caràcters.
# ----------------------------------------------------------
while read -r line
do
	echo "$line" | cut -c1-50  
done
