#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 11/5/2020

# Versió: 1
# Description:      
#     8. Fes un programa que compti les repeticions de les paraules que surten en una frase .
#       Per exemple, per la següent cadena: 
#       cadena="hola hola tres cadena tres tres" 
#       Hem de generar el següent diccionari 
#       d={"hola":2,"tres":3,"cadena":1} 

import diccionaris

def num_value(llista):
    '''
    Retorna els valors totals d'un diccionari
    input: 1 list
    output: 1 int
    '''
    valor = diccionaris.frequencies(llista)
    total = 0
    for i in valor.values():
        total = i + total
    

    return total

def take_second(elem):
	'''
	Key function per a ordenar segons el segon camp
	input: element a ordenar, enter que representa el numero del camp
	output: segon camp
	'''
	return elem[1]
        

def histograma(dic_freq):
    '''
    Dibuixa un histograma de la quantitat de vocals
    input: 1 dic
    output: res 
    '''
    list_values=list(dic_freq.values())
    list_keys=list(dic_freq.keys())

    CARACTER = '*'
    
    for i in range(len(list_values)):
        quantitat = CARACTER * list_values[i]
        print(list_keys[i],":", quantitat)


cadena = input()

# Fem una llista de les paraules
nova_cadena = cadena.split()

print("A) Llistar les paraules")
print(list(diccionaris.frequencies(nova_cadena).keys()))

print()

print("B) Llistar el nombre d'ocurrències per cada paraula")
print(diccionaris.frequencies(nova_cadena))

print()

print("C) Comptar el nombre de paraules diferents que té la frase")
print(len(diccionaris.frequencies(nova_cadena)))

print()

print("D) Comptar el nombre de paraules totals de la frase")
# print(len(nova_cadena))
print(num_value(nova_cadena))

print()

print("E) Mostrar les paraules i les seves ocurrències, però ordenades segons les vegades que han sortit (creant la llista)")
llista_dic = list(diccionaris.frequencies(nova_cadena).items())
llista_dic.sort(key=take_second, reverse=True)
print(llista_dic)

print()

print("F) Fer un histograma de la freqüència en què ha sortit cada paraula")
print(histograma(diccionaris.frequencies(nova_cadena)))