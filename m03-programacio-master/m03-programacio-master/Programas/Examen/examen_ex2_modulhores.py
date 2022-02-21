#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 27/2/2020

# Versió: 1
# Descripció: Modul de funcions de hores

def valida_format(horastr):
	'''
	Valida si el format de la hora es correcte (hh:mm:ss)
	input: str
	output: boolean
	'''
	# Controlar la longitud
	if len(horastr) != 8:
		return False

	# Retallar i veure que tot són digits
	hour = horastr[:2].isdigit()
	minute = horastr[3:5].isdigit()
	seconds = horastr[6:].isdigit()
	if hour and minute and seconds == True:
		return horastr[2] == ":" and horastr[5] == ":"

def es_hora_correcte(horastr):
	'''
	Funció que valida el format d'hora i que sigui correcte
	input: str
	output: boolean
	'''
	SEPARADOR = ":"
	# Controlar la longitud
	if len(horastr) != 8:
		return False
	
	# Retallar 
	hour = get_hour(horastr)
	minute = get_minute(horastr)
	seconds = get_seconds(horastr)


	# Comprovem que els separadors son :
	if not (horastr[2] == SEPARADOR and horastr[5] == SEPARADOR):
		return False

	# Comprovar si les hora son correctes
	if not (hour >= 0 and hour <= 23):
		return False

	# Comprovar si els minuts son correctes
	if not (minute >= 0 and minute <= 59):
		return False

	# Comprovar si els segons son correctes
	if not (seconds >= 0 and seconds <= 59):
		return False

	# Si supera tot es que es una hora correcte
	return True

def get_hour(horastr):
	'''
	Agafa les hores del format hh:mm:ss
	input: str (hh:mm:ss)
	output: int
	'''
	return (int(horastr[:2]))

def get_minute(horastr):
	'''
	Agafa els minuts del format hh:mm:ss
	input: str (hh:mm:ss)
	output: int
	'''
	return (int(horastr[3:5]))

def get_seconds(horastr):
	'''
	Agafa els segons del format hh:mm:ss
	input: str (hh:mm:ss)
	output: int
	'''
	return (int(horastr[6:]))

def construeixHora(hh,mm,ss):
	'''
	Agafa 3 variables que son hores, minuts i segons, el converteix
	en el format hora (hh:mm:ss)
	input: int, int, int
	output: str
	'''
	return (f'{hh:02}:{mm:02}:{ss:02}')

# Activitat 5
def segon_despres(horastr):
	'''
	Retorna el format hh:mm:ss d'un segon despres
	input: str en format hh:mm:ss
	output: str en format hh:mm:ss
	'''

	hour = examen_ex2_modulhores.get_hour(horastr)
	minute = examen_ex2_modulhores.get_minute(horastr)
	seconds = examen_ex2_modulhores.get_seconds(horastr)

	seconds += 1

	# Si segons arriba a 60 suma un minut
	if seconds == 60:
		seconds = 0
		minute += 1
		# Si minut arriba a 60 suma una hora
		if minute == 60:
			minute = 0
			hour += 1
			# Si hora arriba a 24 es reinicia 
			if hour == 24:
				hour = 0

	return  examen_ex2_modulhores.construeixHora(hour, minute, seconds)	

# Test Driver
if __name__ == '__main__':
	if False:

		print("valida_format")
		print("12:35:23 ----", valida_format("12:35:23"))
		print("12.35.23 -----", valida_format("12.35.23"))
		print("2:35:3 ----", valida_format("2:35:3"))

	if True:
		print("es_hora_correcte")
		print("12:35:23 ----", es_hora_correcte("12:35:23"))
		print("12:35:61 ----", es_hora_correcte("12:35:61"))
		print("25:35:23 ----", es_hora_correcte("25:35:23"))
		print("12:69:23 ----", es_hora_correcte("12:69:23"))
		print("12.35.23 -----", es_hora_correcte("12.35.23"))
		print("2:35:3 ----", es_hora_correcte("2:35:3"))

	if False:
		print("get_hour")
		print("12:35:23 ----", get_hour("12:35:23"))
		print("++++++++++++++++++++")
		print("get_minute")
		print("12:35:23 ----", get_minute("12:35:23"))
		print("++++++++++++++++++++")
		print("get_seconds")
		print("12:35:23 ----", get_seconds("12:35:23"))
		print("++++++++++++++++++++")

	if False:
		print("construeixHora")
		print("12,35,23 ----", construeixHora(12,35,23))
		
	if False:
		print("segon_despres")
		print("00:00:00", segon_despres("00:00:00"))
		print("00:00:59", segon_despres("00:00:59"))
		print("00:59:59", segon_despres("00:59:59"))
		print("23:59:59", segon_despres("23:59:59"))

