#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 22/10/19

# Versió: 1
# Descripció: Dir un numero i mostrar quin dia de la setmana es.
# Especificacions d'Entrada: 1 número int del 0-6

# Jocs de prova: 
#     ENTRADA               SALIDA
#       0                   Dilluns
#       1                   Dimarts
#       2                   Dimecres
#       3                   Dijous
#       4                   Divendres
#       5                   Dissabte
#       6                   Diumenge


# Leer el número
num = int(input("Introduce un número: "))

# Comprueba si es positivo o no
if num == 0:
	print("Dilluns")

if num == 1:
	print("Dimarts")

if num == 2:
	print("Dimecres")

if num == 3:
	print("Dijous")

if num == 4:
	print("Divendres")

if num == 5:
	print("Dissabte")

if num == 6:
	print("Diumenge")

