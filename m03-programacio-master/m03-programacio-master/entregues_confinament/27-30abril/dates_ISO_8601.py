#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 30/4/2020

# Versió: 1


#import datetime #En realitat si fem això, tot aquest mòdul de dates no té gaire sentit perquè seria millor utilitzar totes les funcions i objectes de dates que vénen amb aquest mòdul. L'importem només per poder crear la funció data_avui.

#def data_avui():
#	'''
#	Retorna la data d'avui
#	input: --
#	output: string (data en format dd/mm/aaaa)
#	'''
#	avui=datetime.datetime.now()
#	return construeix_data(avui.day, avui.month, avui.year)



def es_any_traspas(year):
	'''
	input: int
	output: boolean
	'''
	#són de traspàs els anys en què les dues darreres xifres de l'any són múltiples de 4, excepte si aquestes xifres són 00. Aleshores, cal tenir en compte les dues primeres xifres de l'any. Si són múltiples de 4, l'any també serà de traspàs.
	# En resum: és de traspàs cada any múltiple de quatre, excepte els múltiples de cent, que no ho són, i excepte els múltiples de 400, que sí que ho són.

	es = False
	if year % 4 == 0:
		es = True
	if year % 100 == 0 and not year % 400 == 0:
		es = False
	return es

def ultim_dia_mes(mes, year):
	'''
	Retorna l'últim dia del mes per a un any
	input: int (1..12), int
	output: int
	'''
	if es_any_traspas(year):
		febrer=29
	else:
		febrer=28
	dies_mes=[31,febrer,31,30,31,30,31,31,30,31,30,31]
	return dies_mes[mes-1]

def get_dia(datestr):
	'''
	Obté el dia d'un string de data yyyy/mm/dd
	input: string amb data correcta
	output: int
	'''
	return (int(datestr[8:10]))

def get_mes(datestr):
	'''
	Obté el mes d'un string de data yyyy/mm/dd
	input: string amb data correcta
	output: int
	'''
	return (int(datestr[5:7]))

def get_year(datestr):
	'''
	Obté l'any d'un string de data yyyy/mm/dd
	input: string amb data correcta
	output: int
	'''
	return (int(datestr[0:4]))


def es_data_valida_str(datestr):
	'''
	Comprova si la data té format yyyy/mm/dd i és vàlida (any>=0)
	input: string
	output: boolean
	'''
	SEPARADOR='/'

	#Comprovem que la longitud sigui correcta
	if not len(datestr) == 10:
		return False

	dias=datestr[8:10]
	mess=datestr[5:7]
	years=datestr[0:4]

	#Comprovem que siguin nombres enters positius:
	if not (dias.isdigit() and mess.isdigit() and years.isdigit()):
		return False

	#Ara ja podem considerar que dia, mes i any són digits vàlids

	#Comprovem que els dos separadors són /
	if not (datestr[4] == SEPARADOR and datestr[7] == SEPARADOR):
		return False

	#No comprovem any perquè només acceptem >=0

	#Comprovem el mes. Ja sabem que mes és un int
	mes=get_mes(datestr)
	if not (mes>=1 and mes <=12):
		return False

	#Comprovem el dia
	dia=get_dia(datestr)
	year=get_year(datestr)
	if not (dia>=1 and dia <= ultim_dia_mes(mes, year)):
		return False

	#Si hem arribat aquí, la data és OK:
	return True

def dia_seguent(datastr):
	'''
	Retorna el dia següent de la data
	input: string en format yyyy/mm/dd
	output: string en format yyyy/mm/dd
	'''
	dia=get_dia(datastr)
	mes=get_mes(datastr)
	year=get_year(datastr)

	if dia==ultim_dia_mes(mes,year):
		dia=1
		mes+=1
		if mes>12:
			mes=1
			year += 1
	else:
		dia += 1
	
	return construeix_data(year, mes, dia)

def dia_anterior(datastr):
	'''
	Retorna el dia anterior a la data d'entrada
	input: string en format yyyy/mm/dd amb data > 01/01/0001
	output: string en format yyyy/mm/dd
	'''
	dia=get_dia(datastr)
	mes=get_mes(datastr)
	year=get_year(datastr)

	dia -= 1

	if dia < 1:
		mes -=1
		if mes < 1:
			mes = 12
			year -= 1 #Què passa si l'any passa a ser negatiu??? E.E. ja ens indica que no ha de poder ser
		#Ara que ja sabem bé el mes que toca, fem que el dia sigui el que toca
		dia = ultim_dia_mes(mes, year)
	return construeix_data(year, mes, dia)

def construeix_data(year, mes, dia):
	''' Retorna una data an format yyyy/mm/dd
	input: int, int, int
	output: string com yyyy/mm/dd(pot no ser una data vàlida!)
	'''
	return (f'{year:04}/{mes:02}/{dia:02}')

def es_data_valida_nums(year, mes, dia):
		''' indica si els paràmetres construeixen una data vàlida (any >=0)
		input: int, int, int
		output: boolean
		'''
		#comprovem any
		if year<0:
			return False

		#comprovem mes
		if not (mes>=1 and mes <=12):
			return False

		#Comprovem el dia

		if not (dia>=1 and dia <= ultim_dia_mes(mes, year)):
			return False

		#Si hem arribat aquí, la data és OK:
		return True

def compara_data(d1, d2):
	'''
	Compara dues dates per saber quina és més gran.
	input: string, string (en format de data vàlida)
	output: int (1 si d1>d2 (> vol dir posterior), 0 si d1=d2, -1 si d1<d2)
	'''
	#Construïm un número a partir de les dates per poder comparar
	dint1=get_year(d1)*10000+get_mes(d1)*100+get_dia(d1)
	dint2=get_year(d2)*10000+get_mes(d2)*100+get_dia(d2)

	diferencia=dint1-dint2
	#"capem" la diferència perquè sigui -1, 0 o 1 (per 0 no cal)
	if diferencia > 1:
		diferencia = 1
	elif diferencia < -1:
		diferencia = -1

	return diferencia

def dies_diferencia(d1, d2):
	'''
	Retorna els dies entre dues dates. Positiu si d2 > d1
	input: string, string (en format de data vàlida yyyy/mm/dd)
	output: int
	'''
	signe = compara_data(d2, d1)

	#ens assegurem que la data es mira des de la petita a la gran
	if signe > 0:
		data_ini=d1
		data_fi=d2
	else:
		data_ini=d2
		data_fi=d1

	data_act=data_ini
	dies_dif=0


	#anar augmentant un dia la data_act fins que sigui igual a la data_fi
	while data_act != data_fi:
		data_act = dia_seguent(data_act)
		dies_dif += 1

	#retornem la diferència que hem trobat tenint en compte el signe!
	return dies_dif * signe

def calcular_dies(dia,mes): 
	'''
	Retorna el dia de l'any corresponent
	input: int,int
	output: int
	'''
	dies_mes = [31 ,29 ,31 ,30 ,31 ,30 ,31 ,31 ,30 ,31 ,30 ,31]
	suma_mes = 0
	for i in range(1,mes):
		suma_mes = dies_mes[i-1] + suma_mes
	dia_any = suma_mes + dia
	return dia_any

def bombolla_dates(llista):    
	'''
	Funció que ordena una llista de dates forma ascendent
	input: llista de cadenes
	output: llista de cadenes ordenat
	'''
	
	for i in range(len(llista)-1,0,-1):
		for j in range(i):
			if compara_data(llista[j],llista[j+1]) == 1:
				# Intercanvi de variables
				t = llista[j]
				llista[j] = llista[j+1]
				llista[j+1] = t
	return llista
#--------------------   comprovem que va bé (test drive):-----------------------
if __name__ == '__main__':
	if False:
		print ('És traspàs 1900? ', es_any_traspas(1900))
		print ('És traspàs 1996? ', es_any_traspas(1996))
		print ('És traspàs 2000? ', es_any_traspas(2000))
		print ('És traspàs 2020? ', es_any_traspas(2020))
		print ('És traspàs 2022? ', es_any_traspas(2022))
	
	if False:
		print ('Últim dia feb-2020: ', ultim_dia_mes(2,2020))
		print ('Últim dia ago-2020: ', ultim_dia_mes(8,2020))
		print ('Últim dia abr-2020: ', ultim_dia_mes(4,2020))
		print ('Últim dia feb-1900: ', ultim_dia_mes(2,1900))
		print ('Últim dia feb-2019: ', ultim_dia_mes(2,2019))
		print ('Últim dia dec-2019: ', ultim_dia_mes(12,2019))

	if False:
		print ('get dia 2020/03/02: ', get_dia('2020/03/02'))
		print ('get mes 2020/03/02: ', get_mes('2020/03/02'))
		print ('get year 2020/03/02: ', get_year('2020/03/02'))

	if False:
		print ('Dia següent del 2002/03/20', dia_seguent('2002/03/20'))
		print ('Dia següent del 2008/02/28', dia_seguent('2008/02/28'))
		print ('Dia següent del 1931/12/19', dia_seguent('1931/12/19'))

	if True:
		print ('Compara dates 2001/03/20 i 2001/12/19: ', compara_data('2001/03/20', '2001/12/19'))
		print ('Compara dates 2019/12/31 i 2020/01/01: ', compara_data('2019/12/31', '2020/01/01'))

	if False:
		print ('Dies entre 2001/1/20 i 2001/5/20 ', dies_diferencia("2001/1/20", "2001/5/20"))
		print ('Dies entre "2019/12/31 i 2020/15/01. ', dies_diferencia("2019/12/31", "2020/15/01"))

	
	if False:
		print ('És data vàlida amb números? 2020/02/28: ', es_data_valida_nums(2020,2,28))
		print ('És data vàlida amb números? 2020/02/29: ', es_data_valida_nums(2020,2,29))
		print ('És data vàlida amb números? 2020/02/30: ', es_data_valida_nums(2020,2,30))
		print ('És data vàlida amb números? 2020/13/30: ', es_data_valida_nums(2020,30,13))
		print ('És data vàlida amb números? 2020/13/32: ', es_data_valida_nums(2020,32,13))
		print ('És data vàlida amb números? -2020/1/1: ', es_data_valida_nums(-2020,1,1))
		#print (f'Avui és {data_avui()} ( representat amb construeix_data() )')

	if False:
		print ('El dia anterior a 2020/2/28 és: ', dia_anterior("2020/02/28"))
		print ('El dia anterior a 2019/3/1 és: ', dia_anterior("2019/03/01"))
		print ('El dia anterior a 2020/01/01 és: ', dia_anterior("2020/01/01"))

	if False:
		print ('es_data_valida_str("2020/02/29"):', es_data_valida_str('2020/02/29'))
		print ('es_data_valida_str("2020/02/30"):', es_data_valida_str("2020/02/30"))
		print ('es_data_valida_str("2020/14/16"):', es_data_valida_str("2020/14/16"))
		print ('es_data_valida_str("20200/03/02"):', es_data_valida_str("20200/03/02"))
		print ('es_data_valida_str("2020-11-10"):', es_data_valida_str("2020-14-10"))

	if False: # Calcular dies
		print('01/02',calcular_dies(1,2))
		print('05/03',calcular_dies(5,3))
		print('22/04',calcular_dies(22,4))

	if False: # Bombolla dates
		llista = ["12/03/2012" , "23/04/2012"  ,"31/01/2012" , "01/12/2012",  "14/11/2012"  ,"22/03/2012"]
		print(llista)
		print("Ordenat")
		print(bombolla_dates(llista))