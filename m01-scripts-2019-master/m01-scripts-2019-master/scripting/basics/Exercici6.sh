#!/bin/bash
# Christian Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 6. Fer un programa que rep com a arguments noms de dies de la setmana i mostra  quants dies eren laborables i quants festius. Si l̉argument no és un dia de la setmana genera un error per stderr.
# Exemple: $ prog dilluns divendres dilluns dimarts kakota dissabte sunday
# ----------------------------------------------------------
OK=0
laborals=0
festius=0
for dia in $*
do
  case $dia in
    "dilluns"|"dimarts"|"dimecres"|"dijous"|"divendres")
	    laborals=$((laborals+1));;
    "dissabte"|"diumenge")
	    festius=$((festius+1));;
    *)
	    echo "Error: $dia Dia invalid" >> /dev/stderr
esac
done

echo "laborals: $laborals"
echo "festius: $festius"


exit $OK
