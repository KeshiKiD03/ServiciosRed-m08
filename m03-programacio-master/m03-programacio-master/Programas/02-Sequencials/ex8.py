#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 8/10/09

# Versió: 1
# Descripció: Conversion de metros a pies
# Especificacions d'Entrada: 1 float positivo 

# Jocs de prova: 
#     ENTRADA               SALIDA
#      5.8 m              19.0289 pies                

# Constant
METROS = 3.2808

# Medida pies
pies = float(input("Introduce medida pies: "))

# Coversion pies a metros
resultado = pies * METROS

# Mostrar resultado de la conversion
print(resultado)
