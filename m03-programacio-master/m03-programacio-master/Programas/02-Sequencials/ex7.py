#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 8/10/09

# Versió: 1
# Descripció: Conversion de pulgadas a cm
# Especificacions d'Entrada: 1 float positivo 

# Jocs de prova: 
#     ENTRADA               SALIDA
#   60.6 pulgadas         153.924 cm               

# Constant
CENTIMETROS = 2.54

# Medida pulgadas
pulgadas = float(input("Introduce pulgadas: "))

# Coversion pulgadas a cm
resultado = pulgadas * CENTIMETROS

# Mostrar resultado de la conversion
print(resultado)
