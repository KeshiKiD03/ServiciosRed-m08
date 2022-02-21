# Explicar instal·lació feta el primer dia
## Christian Manalo Mañibo
### Configuració


Instala todos los paquetes de vim, gvim y mc, con la opción -y automaticamente contesta “yes” en las preguntas de la instalación:
> dnf -y install vim gvim mc


Lo mismo que el anterior, nos instala paquetes necesarios para la configuración del kerberos:
> dnf -y install  krb5-devel krb5-workstation
> dnf -y install pam_mount


Este comando es una abreviación del anterior, podemos instalar multiples paquetes en una sola línea de comando:
> dnf -y install krb5-devel krb5-workstation pam_mount




### Personalització
Instalamos el servicio gpm, con la opcion -y automaticamente contestará “yes” a todas las preguntas de la instalación:
> dnf -y install gpm


Instalamos el comando pwgen, es un comando que permite crear una contraseña aleatoria, con la opción -y automaticamente nos contestará  “yes” todas las preguntas de la instalación:
> dnf -y install pwgen


Con el comando rpm instalamos los siguientes paquetes que se encuentran en los links:
> rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-27.noarch.rpm

> rpm -ivh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-27.noarch.rpm


La primera linea es el comando dnf, instala una version del adobe que se encuentra en el siguiente link, con la opción -y automaticamente nos contestará “yes” a las preguntas de la instalación:
> dnf -y install http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm 



La siguiente línea importamos una clave para el repositorio de adobe:
> rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux


Instalamos un plugin de flash, con la opción -y de dnf, automaticamente contestará yes a las siguientes preguntas de instalación:
> dnf -y install flash-plugin


Con el comando dnf verificamos la lista actual de los repositorios:
> dnf repolist


Instalamos programas extra que son el chromium, vlc, gimp, git, tig, gnome-tweak-tool, con el comando dnf:
> dnf install chromium vlc gimp git tig gnome-tweak-tool -y