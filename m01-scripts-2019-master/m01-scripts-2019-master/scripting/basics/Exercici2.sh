#!/bin/bash
# Christian Manalo Mañibo 
# Febrer 2020
# ASIX-M01
# 2. Mostar els arguments rebuts línia a línia, tot numerànt-los.
# ----------------------------------------------------------
OK=0
num=1
for arg in $*
do
  echo "$num: $arg"
  num=$((num+1))
done
exit $OK
