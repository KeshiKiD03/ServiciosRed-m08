#!/bin/bash
# @edt ASIX M01 - ISO
# Christian Manalo Mañibo - isx9565961
# Març 2020
# funcions.03.sh
# ---------------------------------------

# -- Exercici D --
# D. Exercicis 21, 22, 23, 24 i 25. Són exercicis de funcions que criden funcions.
# L’objectiu és entendre l’aniuament de funcions i el pas de paràmetres.

# 25.getAllUsersSize
# Processa una a una les línies del fitxer /etc/passwd i per a cada usuari mostra per
# stdout el size del seu home.

function getAllUsersSize(){
  userlist=$(cut -d: -f1 /etc/passwd) 2> /dev/null

  for user in $userlist; do
    echo $user
    getSize $user 2> /dev/stderr
  done
}

# 24.getSizeIn
# Ídem exercici anterior però processa un a un els login que rep per stdin, cada
# línia un lògin. Valida que el login existeixi, si no és un error. Donat el login mostra
# per stdout el size del seu home. Cal usar les funcions que estem definint.
function getSizeIn(){
  while read -r login; do
    line=$(getHome $login | wc -l ) 2> /dev/null
    if [ $line -eq 1 ]; then
      echo "Error: $login Login inexistent"
      echo "Usage: $0 login"
    fi
    getSize $login
  done
}


# 23.getSize homedir
# Donat un homedir com a argument mostra per stdout l’ocupació en bytes del
# directori. Per calcular l’ocupació utilitza du del que només volem el resultat
# numèric. Cal validar que el directori físic existeix (recordeu que hi ha usuaris que
# poden tenir de home valors que no són rutes vàlides com /bin/false). Retorna 0 si
# el directori existeix i un valor diferent si no existeix. Cal usar les funcions que
# estem creant.
function getSize(){
  status=0
  homedir=$1

  line=$(getHome $homedir | head -n1) 2>  /dev/null
   
  if  [ -d $line ] ; then 
    du -sb $line | cut -f1
  else
    status=1
  fi
  echo $status
}


# 22.getHoleList login[...]
# Fer una funció que rep un o més login d’arguments i per a cada un d’ells mostra
# el seu home utilitzant la funció getHome. Cal validar els arguments rebuts.
function getHomeList(){
  ERR_NARGS=1
  ERR_NOLOGIN=2  

  if [ $# -eq 0 ]; then
    echo "Error: Num d'arguments incorrectes"
    echo "Usage: $0 login[...]"
  fi

  loginlist=$*

  for login in $loginlist; do
    getHome $login11
  done
}


# 21.getHome login
# Fer una funció que rep un login (no cal validar que rep un argument ni que sigui
# un login vàlid) i mostra per stdout el home de l’usuari.
# La funció retorna 0 si ha pogut trobar el home i diferent de zero si no l’ha pogut
# trobar.
function getHome(){
  status=0
  login=$1
  line=$(egrep ^$login: /etc/passwd | cut -d: -f6) 2>/dev/null
  if ! [ -z "$line" ]; then
    echo $line
    echo $status 
  else
    status=1
    echo $status
  fi
}


# -- Exercici C --
# Exercici 20. Aquest és un exercici complet de fer un informe amb validació
# d’arguments, recerca de claus, agrupació de dades i llistat de línies de detall.
# Made the force be with you!.

# 20.showPedidos oficina
# Donat un número d’oficina com a argument (validar es rep un argument i que és
# un número d’oficina vàlid), obtenir els codis dels representants de vendes que
# treballen en aquesta oficina i llistar les comandes d’aquest repventas. És a dir,
# estem fent un llistat de les comandes agrupades per venedors dels venedors que
# treballen en una determinada oficina.

function showPedidos(){
  ERR_NARGS=1
  ERR_NOOFI=2
  if ! [ $# -eq 1 ]; then
    echo "Error: Nº arguments incorrectes" >> /dev/stderr
    echo "Usage: $0 oficina" >> /dev/stderr
    return $ERR_NARGS
  fi

  oficina=$1
  line=$(cut -f1 oficinas.dat | egrep ^$oficina$ ) 2> /dev/null
  if [ -z $line ]; then
    echo "Error: Oficina inexistent"
    echo "Usage: $0 oficina"
    return $ERR_NOOFI
  fi

  llista_treballadors=$(tr '\t' ':' < repventas.dat | egrep ^[^:]*:[^:]*:[^:]*:$line: | cut -d: -f1)
  echo "Oficina: $oficina"
  for treballadors in $llista_treballadors; do
    echo "Venedor: $treballadors"
    echo "  Llistat de comandes:"
    tr '\t' ':' < pedidos.dat | egrep ^[^:]*:[^:]*:[^:]*:$treballadors: | sed -r 's/^(.*)/\t\1/g' | tr ':' '\t'
    echo "---------------"
  done
  

}
# -- Exercici B --
# B. Fer els exercicis 18 i 19 per practicar el processament línia a línia del contingut d’un
# fitxer o de stdin.

# 19.showGidMembers2 [file]
# Processa un fitxer de text que conté un gid per línia o bé stdin (on també espera
# rebre un gid per línia). Mostra el llistat dels usuaris (login, uid, home) d’aquells
# usuaris que tenen aquest grup com a grup principal. Fa un having, mostrant
# només els grups si hi ha almenys 3 usuaris al grup.

function showGidMembers2(){
  ERR_NARGS=1
  ERR_NOFILE=2
  if [ $# -gt 1 ]; then
    echo "Error: Nº arguments incorrectes" >> /dev/stderr
    echo "Usage: $0 [file]" >> /dev/stderr
    return $ERR_NARGS
  fi

  FileIn=/dev/stdin
  if [ $# -eq 1 ]; then
    if ! [ -f "$1" ]; then
      echo "Error: No es un regular file o no existeix"
      echo "Usage: $0 [file]"
      return $ERR_NOFILE
    fi
    FileIn=$1
  fi

  while read -r gid; do
    having=$(egrep "^[^:]*:[^:]*:[^:]*:$gid:" /etc/passwd | cut -d: -f1,3,6 | wc -l)
 
    if [ $having -ge 3 ]; then
      echo "GID: $gid"
      egrep "^[^:]*:[^:]*:[^:]*:$gid:" /etc/passwd | cut -d: -f1,3,6 
      echo "------------"
    fi  
  done < $FileIn
}



# 18. showGidMembers [file]
# Processa un fitxer de text que conté un gid per línia o bé stdin (on també espera
# rebre un gid per línia). Mostra el llistat dels usuaris (login, uid, home) d’aquells
# usuaris que tenen aquest grup com a grup principal.
function showGidMembers(){
  ERR_NARGS=1
  ERR_NOFILE=2
  if [ $# -gt 1 ]; then
    echo "Error: Nº arguments incorrectes" >> /dev/stderr
    echo "Usage: $0 [file]" >> /dev/stderr
    return $ERR_NARGS
  fi

  FileIn=/dev/stdin
  if [ $# -eq 1 ]; then
    if ! [ -f "$1" ]; then
      echo "Error: No es un regular file o no existeix"
      echo "Usage: $0 [file]"
      return $ERR_NOFILE
    fi
    FileIn=$1
  fi

  while read -r gid; do 
    echo "GID: $gid"
    egrep "^[^:]*:[^:]*:[^:]*:$gid:" /etc/passwd | cut -d: -f1,3,6
    echo "------------"
  done < $FileIn
}

# -- Exercici A --
# Fer els exercicis 9 i 11 com a repàs de generar informes. 
# Són en realitat el mateix exercici que el 10 i 12, però en lloc de fer group-by per shell ho fem per gid. 
# Si us plau, feu-los de nou, de zero, i consulteu la solució amb els exercicis ja resolts 10 i 12.

# 11. showAllGroupMembers2
# Fer una nova versió de showAllGroupMembers on per cada grup es llisti una capçalera amb el nom del grup i la 
# quantitat d’usuaris que tenen aquest grup com a grup principal. Per a cada grup llavors es llisten les línies de detall dels usuaris que hi pertanyem,
# per ordre de login, mostrant login, uid, home i shell.

function showAllGroupMembers2(){
  OK=0
  gname_list=$(cut -d: -f1 /etc/group | sort)
  for gname in $gname_list; do
    gid=$(egrep ^$gname: /etc/group | cut -d: -f3)
    user=$(egrep "^[^:]*:[^:]*:[^:]*:$gid:" /etc/passwd | cut -d: -f1,3,6,7 | sort | sed -r 's/^(.*)/\t \1 /g') 
    howmanyusers=$(egrep "^[^:]*:[^:]*:[^:]*:$gid:" /etc/passwd | wc -l)
    
    echo "$group($gid) - $howmanyusers"
    echo "$user" 
    echo "------------------"
  done
  return $OK
}

# 9. showAllGroupMembers 
# Llistar per ordre de gname tots els grups del sistema, per a cada grup hi ha una capçalera amb el nom del grup 
# i a continuació el llistat de tots els usuaris que tenen aquell grup com a grup principal, ordenat per login.
function showAllGroupMembers(){
  OK=0
  gname_list=$(cut -d: -f1 /etc/group | sort)

  for gname in $gname_list; do
  	gid=$(egrep "^$gname:" /etc/group | cut -d: -f3)
  	user=$(egrep "^[^:]*:[^:]*:[^:]*:$gid:" /etc/passwd | cut -d: -f1 | sort | sed -r 's/^(.*)/\t\1/g')

  	echo "$gname($gid)"
  	echo "$user"
  	echo "------------"
  done 
  return $OK
}

