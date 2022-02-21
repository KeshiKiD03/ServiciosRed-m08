#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 22/10/19

# Versió: 1
# Descripció: Introduir 2 numeros i dir quin es el mes gran.
# Especificacions d'Entrada: 2 números int 

# Jocs de prova: 
#     ENTRADA               SALIDA
#      2 3                    3
#      5 1                    5

# Introduir els dos números
num1 = int(input("Introduir el primer número: "))
num2 = int(input("Introduir el segon número: "))

# Comprovar el mes petit
if num1 < num2: # Si el primer número es mes gran que el segon
	print(num2)

else:
	print(num1) # Sino, sortirà el segon
