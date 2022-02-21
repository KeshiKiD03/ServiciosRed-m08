#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 22/10/19

# Versió: 1
# Descripció: Comprovar si el número es positiu o no.
# Especificacions d'Entrada: 1 número int

# Jocs de prova: 
#     ENTRADA               SALIDA
#       3                   Positiu
#      -1                   Negatiu
#       0                   Positiu



# Leer el número
num = int(input("Introduce un número: "))

# Comprueba si es posi o no
if num >= 0:
	print("Positivo")

else:
	print("Negativo")
