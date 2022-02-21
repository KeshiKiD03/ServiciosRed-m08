#/bin/bash
# Christian Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 1. Mostrar l̉entrada estàndard numerant línia a línia
# ----------------------------------------------------------
OK=0
num=1
while read -r line
do
  echo "$num.$line"
  num=$((num+1))
done
exit $OK
