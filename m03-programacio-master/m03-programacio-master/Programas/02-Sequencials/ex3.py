#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 8/10/09

# Versió: 1
# Descripció: Calcula el precio de un articulo + 13% IVA
# Especificacions d'Entrada:  1 float > 0

# Jocs de prova: 
#     ENTRADA               RESULTADO
#       65.5                 74.015

# Constant
IVA = 13 / 100

# Precio del articulo
articulo = float(input("Precio artículo: "))

# Calculamos el precio total + IVA
precio_final = articulo + ( articulo * IVA)

# Resultado del precio final
print(precio_final)
