# ASIX-M01 Escola del Treball
#### Christian Manalo Mañibo - isx9565961

**Tasca 1:**
**Identificar com obtenir la informació de:**
1-	Processos que un usuari té al sistema i com matar-los.
> ps -u *user* (per llistar)

> pkill -u *user* (per matar)

2-	Treballs d’impressió que un usuari té al sistema i com matar-los.
> lpq -u *user*

> lprm -u *user*

3-	Tasques periòdiques que un usuari té al sistema i com matar-les.
> crontab -u *user* -l (llistar les tasques) 

> crontab -u *user* -d (esborrar el crontab)

4-	Fitxers (fora del home) que un usuari té al sistema i com desar-los en un tar.gz.
> find / -user *user* -type f

5-	Moure tot el home d’un usuari a un tar.gz.
> tar -cvzf home.tar.gz $(cut -d: -f6 /etc/passwd)