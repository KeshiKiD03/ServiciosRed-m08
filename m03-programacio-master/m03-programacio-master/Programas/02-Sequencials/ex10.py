#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 8/10/09

# Versió: 1
# Descripció: Conversion de kg a libras
# Especificacions d'Entrada: 1 float positivo 

# Jocs de prova: 
#     ENTRADA               SALIDA
#      10.3kg              22.70738 libras

# Constant
LIBRAS = 2.2046

# Medida kilos
kilos = float(input("Introduce kilos: "))

# Coversion kilos a libras
resultado = kilos * LIBRAS

# Mostrar resultado de la conversion
print(resultado)
