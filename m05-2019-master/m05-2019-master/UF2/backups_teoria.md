## BACKUPS

![backup plan](BCP-Risk-Management.gif)

---

> PROBLEMA: les dades es corrompen.


En efecte, la probabilitat de que es perdin dades d'un sistema de fitxers és
molt alta, és per això que necessitem tenir algun pla per respondre a aquesta
contingència.

Tenim dues maneres d'atacar el problema:

+ Problema del passat: recuperació de dades
+ Problema del futur: backups

Escollir la segona opció ens permet en el futur fer servir la primera.

Ens centrem amb la 2a opció: els backups.


Com no podia ser d'una altra manera existeixen diferents estratègies i programari per fer còpies de seguretat.

Abans de fer servir un o altre és important preguntar-se:

*Per què?*

Són importants aquestes dades? (potser són cançons que pots tornar a baixar-te fàcilment d'internet)

Això t'ajudarà a decidir si fas el backup o no.

*Què?*

Fem còpia de tot un sistema de fitxers o només d'una part?

Això t'ajudarà a decidir si fas servir un backup físic o lògic.

*On?*

A on s'emmagatemmaran els backups? Al mateix lloc? A una altre lloc? Al núvol?

Això ens ajudarà a decidir si podem fer un backup complet o diferencial o incremental.

*Quan?*

Quin és el millor moment per fer el backup?

Això ens ajudarà a decidir quan podem fer un backup complet o diferencial o incremental

*Suport?*

Memòria USB? Disc dur USB? Servidor dedicat?


##### Tipus de Backup

En funció de si volem fer un backup de tot el disc (o tota una partició) o només alguns directoris, podem fer:

+ Backup físic (raw)

	+ És una còpia d'una partició per blocs.
	+ Aquesta còpia ho guarda tot, per tant, tots els atributs (permisos, dates
	  ...) de tots els fitxers
	+ A mateixa quantitat d'espai a llegir és més ràpid que el lògic: només cal
	  pensar en un sistema de fitxers amb un mínim de fragmentació. Això
implica una feinada per copiar un fitxer de manera lògica. En canvi el backup
físic llegeix el disc seqüencialment 
	+ Però també es copien tots els blocs de la partició que estan declarats
	  com a lliures, això implica que si la partició de disc està gairebè buida
trigarà molt més que el backup de fitxers.


+ Backup lògic

	Certes preguntes que responen al RTO (Recovery time objective) o RPO
(Recovery point Objective) es poden resumir amb un exemple:

	*Et pots permetre perdre les dades que has generat durant una setmana, però
més temps no?* => Backup setmanal

	*Et pots permetre perdre les dades que has generat durant un dia, però més
temps no?* => Backup diari (o el més habitual: Backup cada nit)
	
	Hi ha diferents tipus de backups però els més bàsics i coneguts serien:

	+ Còpia de seguretat completa (full backup). Còpia de tots els fitxers.
		
		+ Necessita més espai d'emmagatzematge
		+ Necessita menys fitxers per a la recuperació: només 1.

	+ Còpia de seguretat incremental (incremental backup). El primer dia es fa un *full backup* i els següents es fa un backup del que ha canviat respecte a l'anterior.

		+ Necessita menys espai d'emmagatzematge
		+ Necessita més fitxers per a la recuperació: tots els fitxers des del full backup fins al del dia que es vol recuperar.
		+ Si es perd un element de la cadena, ja no es pot recuperar a partir d'aquell punt

	+ Còpia de seguretat diferencial (diferencial backup). El primer dia es fa un *full backup* i els següents es fa un backup del que ha canviat respecte al dia del *full backup*.		

		+ Necessita menys espai d'emmagatzematge que el complet i més que l'incremental.
		+ Necessita més fitxers que el complet per a la recuperació i menys que l'incremental: només 2. El del dia que es vol recuperar i el del full backup.
		+ Si es perd un dels diferencials no afecta als anteriors o posteriors diferencials.

----

![tipus de backup](types_of_backup.png) 

![Comparativa diferencial versus incremental](BACKUP_DIRENCIAL_VS_INCREMENTAL.jpg)





Extret de:

* [Backup Your System](https://help.ubuntu.com/community/BackupYourSystem)


*USB is not a backup plan just in case USA fails*

