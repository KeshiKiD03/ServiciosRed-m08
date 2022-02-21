#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 8/10/09

# Versió: 1
# Descripció: Calcula el area del triangulo
# Especificacions D'Entrada:  2 float > 0
# Jocs de prova: 
#     ENTRADA               SALIDA
#  base=5.5  altura=7        19.25

# Constant

# Medidas del triangulo
base = float(input("Base del triangulo: "))
altura = float(input("Altura del triangulo: "))

# Calcular el area del triangulo
area = (base * altura) / 2

# Resultado
print(area)
