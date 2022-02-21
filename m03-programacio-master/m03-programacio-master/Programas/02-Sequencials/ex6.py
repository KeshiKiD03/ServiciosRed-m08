#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 8/10/09

# Versió: 1
# Descripció: Conversion de cm a pulgadas
# Especificacions d'Entrada: 1 float positivo 

# Jocs de prova: 
#     ENTRADA               SALIDA
#      5.3 cm               2.10606 pulgadas

# Constant
PULGADAS = 0.39737

# Medida cm
cm = float(input("Introduce cm: "))

# Coversion cm a pulgadas
resultado = cm * PULGADAS

# Mostrar resultado de la conversion
print(resultado)
