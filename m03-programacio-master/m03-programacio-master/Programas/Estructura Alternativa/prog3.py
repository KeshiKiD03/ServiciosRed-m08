#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 22/10/19

# Versió: 1
# Descripció: Dir un numero i mostrar el seu valor absolut.
# Especificacions d'Entrada: 1 número int 

# Jocs de prova: 
#     ENTRADA               SALIDA
#       3                     3
#      -3                     3


# Preguntar el número
num = int(input("Introdueix el número: "))

# Condicions per saber el seu valor absolut
if num >= 0:
	print(num)
	
else: 
	print(-num * -1)
