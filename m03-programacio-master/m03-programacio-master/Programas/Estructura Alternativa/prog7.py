#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 22/10/19

# Versió: 1
# Descripció: Introduir 1 número i dir si es enter o no.
# Especificacions d'Entrada: 1 número float 

# Jocs de prova: 
#     ENTRADA               SALIDA
#      3                   Es enter
#      5.1                No es enter

# Introduir el numero
num = float(input("Introduir el número: "))


# Comprovar el mes petit
if (num % 1) != 0 :
    print("No es enter")

else:
    print("Es enter")
