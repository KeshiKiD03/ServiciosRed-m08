#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 8/10/09

# Versió: 1
# Descripció: Los segundos introducidos lo pasamos con el formato H:M:S
# Especificacions d'Entrada: 1 int >= 0

# Jocs de prova: 
#     ENTRADA               SALIDA
#       0 s                 0:0:0
#      4800 s               1:20:0

# Constant
DIVISION = 60

# Leer segundos
segundos = int(input("Introduce los segundos: "))

# Calculamos los segundos
segundo_final = segundos % DIVISION
minuto = segundos // DIVISION

# Calculamos los minutos
minuto_final = minuto % DIVISION

# Calculamos las horas
hora_final = minuto // DIVISION

# Resultado
print(hora_final,":",minuto_final,":",segundo_final)
