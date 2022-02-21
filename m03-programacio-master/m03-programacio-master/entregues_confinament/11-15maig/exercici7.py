#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 11/5/2020

# Versió: 1
# Description:      
# Dissenya un programa que rebi per paràmetre una frase qualsevol (per entrada standard) i compti quantes vegades surt cada una de les vocals. Dissenya'n un altre que per cada caràcter donat compti les vegades que surt. 
# Presenta els resultats de les següents maneres:
#       • Amb un histograma
#       • Mostrant el diccionari 'maco':
#       clau: a	  valor: 8
#       clau: u	  valor: 3

import diccionaris

def histograma(dic_freq,find_car):
    '''
    Dibuixa un histograma de la quantitat de vocals
    input: 1 dic
    output: res 
    '''
    list_values=list(dic_freq.values())

    CARACTER = '*'
    
    for i in range(len(list_values)):
        quantitat = CARACTER * list_values[i]
        print(find_car[i],":", quantitat)

frase = input("Introdueix frase: ")
carac_buscar = input("Caracters a buscar: ")

# Esborrar caracters repetits
list_carac=''
for i in carac_buscar:
    if not i in list_carac:
        list_carac = list_carac + i
    
print("Histograma")
print(histograma(diccionaris.crea_dicc_freq_patro(frase,list_carac),list_carac))

print()

print("Mostrant diccionari 'maco'")
print(diccionaris.diccionari_maco(diccionaris.crea_dicc_freq_patro(frase,list_carac)))
