#!/bin/bash
# Christian Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 3. Fer un comptador des de zero fins al valor indicat per l̉argument rebut.
# ----------------------------------------------------------
num=0
while [ $num -le $1 ]
do
  echo "$num"
  num=$((num+1))
done
exit 0
