#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 16/4/2020
# Feu un programa que donada una taula de n enters i una seqüència de n posicions entre 0 i n − 1, 
# reordeni la taula movent els seus elements a les posicions indicades per la seqüència. És a dir, 
# l’i-èsim element de la seqüència indica la posició (començant en zero) a la qual s’ha de moure 
# l’i-èsim element de la taula.
# Utilitzeu un vector auxiliar de mida n per resoldre aquest problema.
# E.E Input consists of a natural number n.

# joc de proves
# 3                              8 7 5
# 5 8 7
# 2 0 1


import sys

# Correció 
'''
#llegim la quantitat d'elements
num = int(sys.stdin.readline())

#llegim els elements
elements = sys.stdin.readline()

#Llegim on els coloquem
seq = sys.stdin.readline()

els = elements.split()
posicions = seq.split()

#creo la llista nova
nou = [0] * num

i = 0 # la posicio inicial de l'element
for pos in posicions:
	nou[int(pos)] = els[i]
	i += 1
	
cadena = ' '.join(nou) #metode que em converteix una llista en cadena
print(cadena)
'''
# Taula i posicions
num = int(input())

taula_entrada = sys.stdin.readline()
taula_entrada = taula_entrada.split(' ')

posicions_entrada = sys.stdin.readline()
posicions_entrada = posicions_entrada.split(' ')

# Fer llistas
taula = []
for n_taula in taula_entrada:
    taula.append(int(n_taula))

posicions = []
for n_pos in posicions_entrada:
    posicions.append(int(n_pos))

# Ordenar
llista_final = []
for pos1 in range(0,num):
    for pos2 in range (0,num):
        if posicions[pos2] == pos1:
            llista_final.append(taula[pos2])

# Mostrar llista
print(*llista_final)   
