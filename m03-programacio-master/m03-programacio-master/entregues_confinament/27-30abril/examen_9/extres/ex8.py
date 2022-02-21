# capçalera complerta

# programa que defineix una key_function per ordenar utilitzant l'algoritme de la bombolla


import funcions_dates   #per a aquest exercici tornem al format tradicional de dates


def key_function_dates(data):
    ''' Funció que transforma un str data en format correcte (en aquest cas dd/mm/aaaa)
    perquè es pugui comparar amb altres dates transformades utilitzant '<'
    
    Entrada: str en format data correcta
    
    Return: Una tupla (o llista) en l'ordre adequat per comparar-la amb una altra amb l'operador < 
    en la línia important de l'algoritme de la bombolla (i que la data cronològicament
    més petita doni més petit)
    
    Important Recorda com funciona l'operador > en les llistes
    '''
    ESCRIU AQUÍ EL TEU CODI
    
    
def bombolla_dates_key(llista):
    '''
    Funció que ordena una llista de forma ascendent
    Entrada: llista d'enters
    Retorn: llista d'enters
    '''
    
    for i in range(1, len(llista)): 
        final = len(llista) - i 
        for j in range(0, final): 
            
            if (key_function_dates(llista[j]) > key_function_dates(llista[j + 1])):  #LÍNIA IMPORTANT
                #comenta que es fa en les ordres de sota 
                t = llista[j] 
                llista[j] = llista[j + 1] 
                llista[j + 1] = t 
    return llista

   
   
#PROGRAMA
dates = sys.argv[1:]

print('dates sense ordenar')
print(dates)

print('dates ordenades')
print(bombolla_dates_key(dates))
