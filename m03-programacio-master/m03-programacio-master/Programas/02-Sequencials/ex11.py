#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 8/10/09

# Versió: 1
# Descripció: Conversion de libras a kg 
# Especificacions d'Entrada: 1 float positivo 

# Jocs de prova: 
#     ENTRADA               SALIDA
#   34.2 libras           15.5268 kg

# Constant
KILOS = 0.454

# Medida libras
libras = float(input("Introduce libras: "))

# Coversion libras a kg 
resultado = libras * KILOS

# Mostrar resultado de la conversion
print(resultado)
