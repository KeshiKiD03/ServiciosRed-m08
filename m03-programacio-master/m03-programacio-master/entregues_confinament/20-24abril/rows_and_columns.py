#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 22/4/2020

# Write a program that reads a matrix, and afterwards prints the rows, the columns and the elements that are asked for.

# E.E 
# Input consists of a matrix followed by a sequence of questions about the matrix. 
# The matrix is described with two natural numbers n > 0 and m > 0, followed by n lines with m integer numbers each one. 
# Every question begins with the word “row”, “column” or “element”. If the word is “row”, it is followed by the number of a row. 
# If the word is “column”, it is followed by the number of a column. If the word is “element”, it is followed by the number of a row and the number of a column. 
# All the given numbers of row and of column are correct, and start with 1.
import sys

def get_row(llista, num_fila):
    '''
    Retorna la fila indicada
    input: list,  int
    output: str
    '''
    return ' '.join(map(str,llista[num_fila-1]))

def get_column(llista, num_columna):
    '''
    Retorna la columna indicada
    input: list, int
    output: str
    '''
    column = []
    for fila in llista:
        column.append(fila[num_columna-1])

    return ' '.join(map(str,column))


def get_element(llista, num_fila, num_columna):
    '''
    retorna l'element indicat donat dos numeros
    input: list,int, int
    output: str
    '''
    return str(llista[num_fila-1][num_columna-1])


# Introduim la matriu n i m
matrix = sys.stdin.readline().split()
fila = int(matrix[0]) # Filas
columna = int(matrix[1]) # Columnas

# Fem la llista
llista_llistes=[]
for i in range(0, fila):
    seq = sys.stdin.readline().split(' ')
    llista_fila=[]
    for elem in seq:
    	llista_fila.append(int(elem))

    llista_llistes.append(llista_fila)

# Linea en blanc per separar les consultes
intro = sys.stdin.readline()

consultes = sys.stdin.readline()
list_cons = consultes.split()

while consultes != '':
	# Busca fila 
    if list_cons[0] == 'row':
    	row = get_row(llista_llistes, int(list_cons[1]))
    	print(list_cons[0]," ",list_cons[1],": ", row ,sep="")


    # busca columna
    elif list_cons[0] == 'column':
    	column = get_column(llista_llistes, int(list_cons[1]))
    	print(list_cons[0]," ",list_cons[1],": ", column ,sep="")

    # Busca un element en concret
    elif list_cons[0] == 'element':
    	element = get_element(llista_llistes, int(list_cons[1]), int(list_cons[2]))
    	print(list_cons[0]," ",list_cons[1]," ",list_cons[2],": ", element ,sep="")

    # Reiniciem
    consultes = sys.stdin.readline()
    list_cons = consultes.split()

