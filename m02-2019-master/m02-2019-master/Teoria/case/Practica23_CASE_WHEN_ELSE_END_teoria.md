# CASE - WHEN - ELSE - END

Especifica una estructura condicional dins d'una sentència SQL.

**Exemples**

_Llistar els noms dels venedors i una columna que dessigni si són majors de 40 anys o no amb el text "Adulto" o "Joven" respectivament_

```SQL
SELECT nombre, 
	CASE 
		WHEN edad>40 THEN 'Adulto' 
		ELSE 'Joven'
    END
FROM repventas;
```

_Llistar els codis dels productes denotant si el preu és menor a 100 ('muy barato'), entre 100 i 1000 ('barato'), entre 1000 i 3000 ('caro') o més gran a 3000 ('muy caro')._

```SQL
SELECT id_fab, id_producto, precio,
	CASE 
		WHEN precio < 100 THEN 'muy barato' 
		WHEN precio < 1000 THEN 'barato' 
        WHEN precio < 3000 THEN 'caro' 
        ELSE 'Muy caro' 
    END 
FROM productos;
```

_Llistar els productes i especificar si són molt venuts (més de 2 comandes) o no. Ho especificarem posant el text 'muy vendido' o 'poco vendido'._

```SQL
SELECT id_fab, id_producto, 
	CASE 
		WHEN count(*) > 2 THEN 'muy vendido' 
		ELSE 'poco vendido' 
    END 
FROM productos 
JOIN pedidos ON id_fab = fab AND id_producto = producto 
GROUP BY id_fab, id_producto;
```

_Llisteu nom, edat i vendes dels venedors que compleixin el següent si tenen menys de 40 anys. Només llistarem els venedors que tinguin vendes superiors a 200000, si tenen 40 anys o més només llistarem els venedors que tinguin unes vendes superiors a 300000._

```SQL
SELECT nombre, edad, ventas 
FROM repventas 
WHERE 
CASE 
    WHEN edad < 40 THEN ventas > 200000 
    ELSE ventas > 300000 
END;
```

_Establiu la quota a 0 als menors de 35 anys i pugeu un 5% a la resta_

**Nota:** Executeu aquesta funció només en una còpia de la BD de training, per tenir una sempre igual a l'original.

Per fer la còpia, i utilitzar-la, utilitzeu aquestes comandes:

```SQL
    --crear la còpia:
    CREATE DATABASE trainingmod template training;
    --connectar-nos a la còpia:
    \C trainingmod
```

I la sentència per actualitzar les quotes segons l'enunciat:

```SQL
UPDATE repventas 
SET cuota = CASE 
                WHEN edad < 35 THEN 0 
                ELSE cuota * 1.05
            END;
```



