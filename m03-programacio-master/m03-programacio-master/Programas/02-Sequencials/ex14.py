#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 10/10/09

# Versió: 1
# Descripció: Conversions de base b a base 10.
# Especificacions d'Entrada: 
# 3 int positivos de 2 a 10
# Base no tiene que ser igual a su numero

# Jocs de prova: 
#     ENTRADA               SALIDA
#    B=3 0,1,2                 5
#    

# Introducir la base 

# Constant
BASE = int(input("Introduce la base: "))
POS2 = BASE**2
POS1 = BASE**1
POS0 = BASE**0

# Introducir los digitos
d1 = int(input("Digito 1: "))
d2 = int(input("Digito 2: "))
d3 = int(input("Digito 3: "))

# Calcular 
resultado_final = (d1 * POS2) + (d2 * POS1) + (d3 * POS0)

# Mostrar resultado
print(resultado_final)
