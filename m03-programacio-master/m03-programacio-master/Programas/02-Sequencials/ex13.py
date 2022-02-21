#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 9/10/09

# Versió: 1
# Descripció: Conversion binario a decimal
# Especificacions d'Entrada: 8 int entre 0 y 1

# Jocs de prova: 
#     ENTRADA               SALIDA
#    11111111                255
#    00101000                40

# Constant
POS7 = 2**7
POS6 = 2**6
POS5 = 2**5
POS4 = 2**4
POS3 = 2**3
POS2 = 2**2
POS1 = 2**1
POS0 = 2**0

# Introducir los binarios
b1 = int(input("Binario 1: "))
b2 = int(input("Binario 2: "))
b3 = int(input("Binario 3: "))
b4 = int(input("Binario 4: "))
b5 = int(input("Binario 5: "))
b6 = int(input("Binario 6: "))
b7 = int(input("Binario 7: "))
b8 = int(input("Binario 8: "))

# Calcular 
resultado_final = ((b1 * POS7) + (b2 * POS6) + (b3 * POS5) + (b4 * POS4)
	+ (b5 * POS3) + (b6 * POS2)+ (b7 * POS1) + (b8 * POS0))

# Mostrar resultado
print(resultado_final)
