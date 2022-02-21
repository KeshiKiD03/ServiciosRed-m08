#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 8/10/09

# Versió: 1
# Descripció: El treballador cobra un preu fix per hora i es descompte
# 10% en concepte del impost sobre la renta. Es mostra el sou brut, 
# descompte de la renta i salari que ha de pagar.

# Especificacions d'Entrada:  
# 1 String, nom del treballador
# 1 int > 0
# 1 float > 0

# Jocs de prova: 
#     ENTRADA               RESULTADO
#   Jose 5h 2.5          

# Constant
DESCUENTO = 10 / 100

# Introducir datos
nombre = input("Nombre: ")
horas_trabajadas = int(input("Horas Trabajadas: "))
cobro_horas = float(input("Cobro por hora: "))

# Calcular el descuento del 10% en concepto de impuesto sobre la renta.
resultado_descuento = horas_trabajadas * DESCUENTO

# Calcular cuanto cobra a la hora en bruto
hora_bruto = cobro_horas - resultado_descuento

# Calcular cuanto cobra en TOTAL
sueldo_bruto = cobro_horas * horas_trabajadas

# Calcular cuanto cobraria sin el descuento
salario_pagar = hora_bruto * horas_trabajadas

# Resultado
print(sueldo_bruto) # Sueldo bruto
print(resultado_descuento) # Descuento renta
print(salario_pagar) # Salario a pagar
