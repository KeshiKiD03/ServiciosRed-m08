#!/bin/bash
# @edt ASIX M01 - ISO
# Christian Manalo Mañibo - isx9565961
# Març 2020
# Funcions
# ---------------------------------------
ERR_NARGS=1
ERR_NOLOGIN=2
OK=0

# 12. showAllShells2
# Fer una nova versió de showAllShells que per a cada shell mostra una capçalera amb el nom del shell i la quantitat d’usuaris que l’utilitzen, 
# i tot seguit el llistat d’aquests usuaris.
# Atenció, cal filtrar els shells. No es mostren tots sinó només aquells que tinguin dos o més usuaris assignats.

function showAllShells2(){
  llistashells=$(cut -d: -f7 /etc/passwd | sort -u)
  for shell in  $llistashells; do
    users=$(egrep ":$shell$" /etc/passwd | wc -l)
    echo "$shell ($users)"
    if [ $users -gt 2 ]; then
      egrep ":$shell$" /etc/passwd | cut -d: -f1,3,4,6,7 | sort | sed -r 's/^(.*)/\t \1 /g'
    fi
  done
  return $OK
}


# 11. showAllGroupMembers2
# Fer una nova versió de showAllGroupMembers on per cada grup es llisti una capçalera amb el nom del grup i la 
# quantitat d’usuaris que tenen aquest grup com a grup principal. Per a cada grup llavors es llisten les línies de detall dels usuaris que hi pertanyem,
# per ordre de login, mostrant login, uid, home i shell.

function showAllGroupMembers2(){
  llistagroups=$(cut -d: -f1 /etc/group | sort)
  for group in $llistagroups; do
    echo "Group: $group"
    gid=$(egrep ^$group: /etc/group | cut -d: -f3) 
    echo "Quantitat d'usuaris: $(egrep "^[^:]*:[^:]*:[^:]*:$gid:" /etc/passwd | wc -l)" 
    egrep "^[^:]*:[^:]*:[^:]*:$gid:" /etc/passwd | cut -d: -f1,3,6,7 | sort | sed -r 's/^(.*)/\t \1 /g'
    echo "-----------------------------"
  done
  return $OK
}

# 10 - showAllShells
# Llistar totes els shells del sistema per ordre alfabètic i per a cada shell llistar els usuaris que l̉utilitzen. De cada usuari mostrar el login, uid, gid i home. Els usuaris es llisten per ordre de uid.i

function showAllShells(){
  llistashells=$(cut -d: -f7 /etc/passwd | sort -u)
  for shell in  $llistashells; do
    echo "$shell"
    egrep ":$shell$" /etc/passwd | cut -d: -f1,3,4,6 | sort | sed -r 's/^(.*)/\t \1 /g'
  done
  return $OK
}

# 7/8- showGroupMainMembers(gname)
# Donat un gname mostrar el llistat dels usuaris que tenen aquest grup com a grup principal. 
# Com a llistat mostrar el login, uid, dir i shell dels usuaris (en un format de llistat del grep). 
# Validar que es rep un argument i que el gname és vàlid.

function showGroupMainMembers(){
  if [ $# -ne 1 ]; then
    echo "Error: Num arguments incorrectes"
    echo "Usage: $0 gname"
    return $ERR_NARGS
  fi
  gname=$1
  line=$(egrep ^$gname: /etc/group 2> /dev/null) 
  if [ -z "$line" ]; then 
    echo "Error: $gname gname inexistent"
    echo "Usage: $0 gname"
    return $ERR_NOLOGIN
  fi
  
  gid=$(echo $line | cut -d: -f3)
  echo "Llistat grup: $gname($gid)"
  egrep "^[^:]*:[^:]*:[^:]*:$gid:" /etc/passwd | cut -d: -f1,3,4,6,7 | sort -t: -k2,2n | sed -r 's/^([^:]*)/ \t \1/' | sed 's/:/  /g' | tr '[:lower:]' '[:upper:]'

  return $OK
}





# 6- showUserList(login[...])
# Mostrar un a un els camps amb label

function showUserIn(){
  while read -r user ; do
    line=$(egrep "^$user:" /etc/passwd 2> /dev/null)
    if [ -z "$line" ]; then
      echo "Error: $user No existeix" >> /dev/stderr
      echo "Usage: $0 login" >> /dev/stderr
      echo "---------"
    else

      uid=$(echo $line | cut -d: -f3)
      gid=$(echo $line | cut -d: -f4)
      gname=$(egrep "^[^:]*:[^:]*:$gid:" /etc/group | cut -d: -f1 )
      gecos=$(echo $line | cut -d: -f5)
      home=$(echo $line | cut -d: -f6)
      shell=$(echo $line | cut -d: -f7)

      echo "Login: $user"
      echo "UID: $uid"
      echo "GID: $gid"
      echo "Gname: $gname"
      echo "Gecos: $gecos"
      echo "Home: $home"
      echo "Shell: $shell"
      echo "--------"
    fi
  done
  return $OK
}


# 5- showUserList(login[...])
# Mostrar un a un els camps amb label

function showUserList(){
  if [ $# -lt 1 ]; then
    echo "Error: Nº arguments incorrectes"
    echo "Usage: $0 login[...]"
    return $ERR_NARGS
  fi
  for user in $*; do
    line=$(egrep "^$user:" /etc/passwd 2> /dev/null)
    if [ -z "$line" ]; then
      echo "Error: $user No existeix" >> /dev/stderr
      echo "Usage: $0 login" >> /dev/stderr
      echo "---------"
    else

      uid=$(echo $line | cut -d: -f3)
      gid=$(echo $line | cut -d: -f4)
      gname=$(egrep "^[^:]*:[^:]*:$gid:" /etc/group | cut -d: -f1 )
      gecos=$(echo $line | cut -d: -f5)
      home=$(echo $line | cut -d: -f6)
      shell=$(echo $line | cut -d: -f7)

      echo "Login: $user"
      echo "UID: $uid"
      echo "GID: $gid"
      echo "Gname: $gname"
      echo "Gecos: $gecos"
      echo "Home: $home"
      echo "Shell: $shell"
      echo "--------"
    fi
  done
  return $OK
}

# 4- showUser(login)
# Mostrar un a un els camps amb label
function showUserGname(){
if [ $# -ne 1 ]; then
  echo "Error: Nº arguments incorrectes"
  echo "Usage: $0 login"
  return $ERR_NARGS
fi
user=$1
line=$(egrep "^$user:" /etc/passwd 2> /dev/null)
if [ -z "$line" ]; then
  echo "Error: $user No existeix" >> /dev/stderr
  echo "Usage: $0 login" >> /dev/stderr
  return $ERR_NOLOGIN
fi

uid=$(echo $line | cut -d: -f3)
gid=$(echo $line | cut -d: -f4)
gname=$(egrep "^[^:]*:[^:]*:$gid:" /etc/group | cut -d: -f1 )
gecos=$(echo $line | cut -d: -f5)
home=$(echo $line | cut -d: -f6)
shell=$(echo $line | cut -d: -f7)

echo "Login: $user"
echo "UID: $uid"
echo "GID: $gid"
echo "Gname: $gname"
echo "Gecos: $gecos"
echo "Home: $home"
echo "Shell: $shell"

return $OK
}

# showUserGname(gname)
# Mostrar els camps amb label
function showGroup(){
if [ $# -ne 1 ]; then
  echo "Error: Nº arguments incorrectes"
  echo "Usage: $0 login"
  return $ERR_NARGS
fi

gname=$1
line=$(egrep "^$gname:" /etc/group 2> /dev/null)
if [ -z "$line" ]; then
  echo "Error: $gname No valid" >> /dev/stderr
  echo "Usage: $0 gname" >> /dev/stderr
  return $ERR_NOLOGIN
fi

# Mostrar
gid=$(echo $line | cut -d: -f3) 
usuaris=$(echo $line | cut -d: -f4)

echo "Gname: $gname"
echo "GID: $gid"
echo "usuaris: $usuaris"
return $OK
}

# showUserGecos(login)
# Mostrar els camps amb label
function showUserGecos(){
if [ $# -ne 1 ]; then
  echo "Error: Nº arguments incorrectes"
  echo "Usage: $0 login"
  return $ERR_NARGS
fi

user=$1
line=$(egrep "^$user:" /etc/passwd 2> /dev/null)
if [ -z "$line" ]; then
  echo "Error: $user No existeix" >> /dev/stderr
  echo "Usage: $0 login" >> /dev/stderr
  return $ERR_NOLOGIN
fi

# Mostrar
gecos=$(echo $line | cut -d: -f5)
name=$(echo $gecos | cut -d, -f1)
office=$(echo $gecos | cut -d, -f2)
phone_office=$(echo $gecos | cut -d, -f3)
home_phone=$(echo $gecos | cut -d, -f4)

echo "name: $name"
echo "office: $office"
echo "phone office: $phone_office"
echo "home phone: $home_phone"
return $OK
}


# showUser(login)
# Mostrar un a un els camps amb label
function showUser(){
  if [ $# -ne 1 ]; then
    echo "Error: Nº arguments incorrectes"
    echo "Usage: $0 login"
    return $ERR_NARGS
  fi

  user=$1
  egrep "^$user:" /etc/passwd &> /dev/null
  if ! [ $? -eq 0 ]; then
    echo "Error: $user No existeix" >> /dev/stderr
    echo "Usage: $0 login" >> /dev/stderr
    return $ERR_NOLOGIN
  fi

  echo "LOGIN: $user"
  echo "UID: $(egrep "^$user:" /etc/passwd | cut -d: -f3)"
  echo "GID: $(egrep "^$user:" /etc/passwd | cut -d: -f4)"
  echo "GECOS: $(egrep "^$user:" /etc/passwd | cut -d: -f5 )"
  echo "HOME: $(egrep "^$user:" /etc/passwd | cut -d: -f6)"
  echo "SHELL: $(egrep "^$user:" /etc/passwd | cut -d: -f7)"
  return $OK
}

function hola(){
  echo "Hola"
  return 0
}

function dia(){
  date
  return 0
}

function suma(){
  echo $(($1+$2))
  return 0
}


