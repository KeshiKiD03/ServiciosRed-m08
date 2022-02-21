#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 8/10/09

# Versió: 1
# Descripció: Transformar la hora en una expresion correcta.
# Especificacions d'Entrada:  3 ints >= 0

# Jocs de prova: 
#     ENTRADA               RESULTADO
#   3h 118m 195s            5h 1m 15s

# Constant
DIVISION = 60

# Introducir horas, minutos y segundos:
horas = int(input("Introduce las horas: "))
minutos = int(input("Introduce los minutos: "))
segundos = int(input("Introduce los segundos: "))

# Calcular los segundos en formato correcto
segundos_final = segundos % DIVISION
minutos_sobrantes = segundos // DIVISION 

# Calcular los minutos en formato correcto
minutos = minutos_sobrantes + minutos
minutos_final = minutos % DIVISION
horas_sobrantes = minutos // DIVISION

# Calcular las horas en formato correcto
horas_final = horas_sobrantes + horas

print(horas_final,"h,",minutos_final,"m,",segundos_final,"s")

