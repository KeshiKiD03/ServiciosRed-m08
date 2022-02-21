#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 22/10/19

# Versió: 1
# Descripció: Introduir 2 numeros i dir si son divisors.
# Especificacions d'Entrada: 2 números int 

# Jocs de prova: 
#     ENTRADA               SALIDA
#      2 3                    3
#      5 1                    5

# Introduir els dos números
num1 = int(input("Introduir el primer número: "))
num2 = int(input("Introduir el segon número: "))

# Comprovar si son divisors
if (num1 % num2) == 0:
    print(num2,"és divisor de",num1)

elif (num1 % num2) == 0:
    print(num1,"és divisor de",num2)
    
else:
    print("No són divisors entre ells")
