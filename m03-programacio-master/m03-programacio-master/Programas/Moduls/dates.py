#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 12/2/2020

import datetime # Per fer la funció diaavui

def valida_format(datastr):
	'''
	Retorna si el format es valida
	input: datastr
	output: bool
	'''

	# Controlar la longitud
	if len(datastr) != 10:
		return False

	# Retallar i veure que tot són digits
	dia = datastr[:2].isdigit()
	mes = datastr[3:5].isdigit()
	year = datastr[6:].isdigit()
	if dia and mes and year == True:
		return datastr[2] == "/" and datastr[5] == "/"


def get_dia(data_str):
	'''
	Funció que dona el dia d'una data
	input: str
	output: str
	'''
	#extreure els digits i retornar el digit
	return (int(data_str[:2]))

def get_mes(data_str):
	'''
	Funció que dona un mes d'una data
	input: str
	output: str
	'''
	#extreure els digits i retornar el digit
	return (int(data_str[3:5]))

def get_year(data_str):
	'''
	Funció que dona un year d'una data
	input: str
	output: str
	'''
	#extreure els digits i retornar el digit
	return (int(data_str[6:]))

def es_year_traspas(year):
	'''
	input: int
	ouptut: boolean
	'''
	# Són de traspàs els years en que les dues darreres xifres de l'any son multiples de 4, excepte si aquestes xifres son 00.
	# Aleshores cal tenir en compte les dues primers xifres de l'any. Si son multiples de 4, l'year tamber sera de traspas.


	return year % 400 == 0 or (year % 4 == 0 and year % 100 != 0)


def ultim_dia_mes(mes,year):
	'''
	Retorna l'ultim dia del mes per a un year
	input: int (1..12, int)
	output: int
	'''
	
	if es_year_traspas(year):
		febrer=29
	else:
		febrer=28
	
	ultim_dia=[31,febrer,31,30,31,30,31,31,30,31,30,31]
		
	return ultim_dia[mes-1]


def es_data_correcte(data_str):
	'''
	Funció que valida el format d'una data dd/mm/aaaa
	input: str
	output: boolean
	'''

	# Controlar la longitud
	if len(data_str) != 10:
		return False
	
	# Retallar 
	dia = get_dia(data_str)
	mes = get_mes(data_str)
	year = get_year(data_str)



	# Comprovem que els separadors son /
	if not (data_str[2] == "/" and data_str[5] == "/"):
		return False

	# Comprovar si el mes es correcte
	if not (mes >= 1 and mes <=12):
		return False

	# Comprovar el dia
	if not (dia >=1  and dia <= ultim_dia_mes(mes, year)):
		return False

	# Si supera tot es que es una dara correcte
	return True

def construeixData(dia,mes,year):
	'''
	Retorna  una data en format dd/mm/aaaaa
	input: int,int,int
	output: string com dd/mm/aaaaa (pot no ser una data vàlida!)
	'''

	return (f'{dia:02}/{mes:02}/{year:04}')

def dia_seguent(datastr):
	'''
	Retorna el dia següent de la data
	input: string en format dd/mm/aaaa
	output: string en format dd/mm/aaaa
	'''

	dia=get_dia(datastr)
	mes=get_mes(datastr)
	year=get_year(datastr)

	if dia == ultim_dia_mes(mes,year):
		dia = 1
		mes +=1
		if mes > 12:
			mes = 1
			year += 1
	else:
		dia += 1

	return  construeixData(dia, mes, year)

def dia_anterior(datastr):
	'''
	Retorna el dia anterior a la data d'entrada
	input: string en format dd/mm/aaaa amb data > 01/01/0001
	output: string en format dd/mm/aaaa
	'''
	dia=get_dia(datastr)
	mes=get_mes(datastr)
	year=get_year(datastr)

	dia -= 1
	if dia < 1:
		mes -=1
		if mes < 1:
			mes = 12
			year -= 1 #Què passa si l'year passa a ser negatiu??? E.E. ja ens indica que no ha de poder ser
		#Ara que ja sabem bé el mes que toca, fem que el dia sigui el que toca
		dia = ultim_dia_mes(mes, year)
	return construeixData(dia, mes, year)

def data_avui():
	'''
	Retorna la data d'avui
	input: --
	output: string (data en format dd/mm/aaaa)
	'''
	avui=datetime.datetime.now()
	return construeixData(avui.day, avui.month, avui.year)

def es_data_valida_nums(dia, mes, year):
		'''
		Indica si els paràmetres construeixen una data vàlida (year >=0)
		input: int, int, int
		output: boolean
		'''
		# Comprovem year
		if year < 0:
			return False

		# Comprovem mes
		if not (mes >= 1 and mes <= 12):
			return False

		# Comprovem el dia
		if not (dia >= 1 and dia <= ultim_dia_mes(mes, year)):
			return False

		# Si hem arribat aquí, la data és OK:
		return True

def compara_data(d1, d2):
	'''
	Compara dues dates per saber quina és més gran.
	input: string, string (en format de data vàlida)
	output: int (1 si d1>d2 (> vold ir posterior), 0 si d1=d2, -1 si d1<d2)
	'''
	
	#Construïm un número a partir de les dates per poder comparar
	dint1=get_year(d1) * 10000 + get_mes(d1) * 100 + get_dia(d1)
	dint2=get_year(d2) * 10000 + get_mes(d2) * 100 + get_dia(d2)

	diferencia = dint1 - dint2
	
	#"capem" la diferència perquè sigui -1, 0 o 1 (per 0 no cal)
	if diferencia > 1:
		diferencia = 1
	elif diferencia < -1:
		diferencia = -1

	return diferencia

def dies_diferencia(d1, d2):
	'''
	Retorna els dies entre dues dates. Positiu si d2 > d1
	input: string, string (en format de data vàlida dd/mm/aaaa)
	output: int
	'''
	signe = compara_data(d2, d1)

	#ens assegurem que la data es mira des de la petita a la gran
	if signe > 0:
		data_ini = d1
		data_fi = d2
	else:
		data_ini = d2
		data_fi = d1

	data_act = data_ini
	dies_dif = 0


	#anar augmentant un dia la data_act fins que sigui igual a la data_fi
	while data_act != data_fi:
		data_act = dia_seguent(data_act)
		dies_dif += 1

	#retornem la diferència que hem trobat tenint en compte el signe!
	return dies_dif * signe

def diumenge_de_pasqua(year):
	'''
	Retorna data de diumenge de pasqua
	input: int
	output: datastr 

	'''
	a = year % 19
	b = year %4
	c = a % 7
	a = (19 * a + 24) % 30
	b = (2* b + 4 * c + 6 * a + 5) % 7
	dia = 22 + a + b  

	if dia > 31:
		dia = dia - 31
		mes = 4

	return construeixData(dia,mes,year)

# Comprovem que va be (test driver)
if __name__ == '__main__':
	if False:
		print("valida_format(datastr)")
		print("12/02/2020",valida_format("12/02/2020"))
		print("12/2/2020",valida_format("12/2/2020"))
	if False:
		print("get_dia(datastr)")
		print("01/12/2020",get_dia("01/12/2020"))
	if False:
		print("get_mes(datastr)")
		print("01/12/2020",get_mes("01/12/2020"))
	if False
		print("get_year(datastr)")
		print("01/12/2020",get_year("01/12/2020"))
	if False:
		print("es_year_traspas(year)")
		print("2020", es_year_traspas(2020))
		print("2019", es_year_traspas(2019))
	if False:
		print("ultim_dia_mes(mes,year)")
		print("2,2020", ultim_dia_mes(2,2020))
		print("5,2020", ultim_dia_mes(5,2020))
		print("12,2020", ultim_dia_mes(12,2020))
	if False:
		print("es_data_correcte(datastr)")
		print("12/02/2020", es_data_correcte("12/02/2020"))
		print("30/022020", es_data_correcte("30/022020"))
		print("29/02/2019", es_data_correcte("29/02/2019"))
		print("0402/2019", es_data_correcte("0402/2019"))
		print("1/2/2019", es_data_correcte("1/2/2019"))
	if False:
		print("construeixData(dia,mes,year)")
		print("12,2,2020", construeixData(12,2,2020))
	if False:
		print("dia_seguent(datastr)")
		print("28/02/2020", dia_seguent("28/02/2020"))
		print("28/02/2019", dia_seguent("28/02/2019"))
	if False:
		print("dia_anterior(datastr)")
		print("01/01/2020", dia_anterior("01/01/2020"))
		print("01/03/2020", dia_anterior("01/03/2020"))
	if False:
		print("data_avui()")
		print(data_avui())
		print("Any actual", get_year(data_avui()))
		print("Mes actual", get_mes(data_avui()))
		print("Dia actual", get_dia(data_avui()))
	if False:
		print("es_data_valida_nums(dia,mes,any)")
		print("4/3/2000", es_data_valida_nums(4,3,2000))
		print("36/13/2000", es_data_valida_nums(36,13,2000))
	if False:
		print("compara_data(d1,d2)")
		print("# Si es 0 es igual, si es 1 d1 es posterior que d2, si es -1 d1 es anterior que d2")
		print("14/12/2020,13/12/2020",compara_data("14/12/2020", "13/12/2020"))
		print("12/12/2020,12/12/2020",compara_data("12/12/2020", "12/12/2020"))
		print("12/12/2020,13/12/2020",compara_data("12/12/2020", "13/12/2020"))
	if False:
		print("dies_diferencia(d1,d2)")	
		print("25/12/2020,13/12/2020",dies_diferencia("25/12/2020", "13/12/2020"))
	if False:
		print("diumenge_de_pasqua(year)")
		print("2020", diumenge_de_pasqua(2020))
		print("2019", diumenge_de_pasqua(2019))

