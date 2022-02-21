#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 8/10/09

# Versió: 1
# Descripció: Conversion de pies a metros
# Especificacions d'Entrada: 1 float positivo 

# Jocs de prova: 
#     ENTRADA               SALIDA
#      20.89m              6.37145 pies         

# Constant
METROS = 0.305

# Medida pies
pies = float(input("Introduce metros: "))

# Coversion pies a metros
resultado = pies * METROS

# Mostrar resultado de la conversion
print(resultado)
