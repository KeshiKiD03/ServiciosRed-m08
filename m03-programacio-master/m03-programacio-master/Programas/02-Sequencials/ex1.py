#!/usr/bin/python3
#-*- coding: utf-8-*- 

# Escola del treball de Barcelona 
# ASIX 2019-2020 

# Christian Manalo 
# isx9565961 
# 8/10/09

# Versió: 1
# Descripció: Augment de sou de tres empleats amb 10, 12 i 15%
# Especificacions d'Entrada:  3 ints > 0

# Jocs de prova: 
#     ENTRADA               RESULTADO
#   1200  700  1500       1320  784 1725


# Constant
AUGMENT_SOU1 = 10 / 100
AUGMENT_SOU2 = 12 / 100
AUGMENT_SOU3 = 15 / 100

# Sou dels empleats
sou1 = 1200
sou2 = 700
sou3 = 1500

# Cálcul del sou
resultat_sou1 = sou1 + (sou1 * AUGMENT_SOU1)
resultat_sou2 = sou2 + (sou2 * AUGMENT_SOU2)
resultat_sou3 = sou3 + (sou3 * AUGMENT_SOU3)

# Mostrar resultat
print(resultat_sou1) 
print(resultat_sou2)
print(resultat_sou3)
