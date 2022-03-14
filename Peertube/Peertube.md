# Peertube

2 Máquinas uno para DNS y otro para PEERTUBE

Acceso por SSH -i cpriv root@ip

Cambiar el hostname de cada uno

apt-get update a los dos

# IMPORTANTE

#### apt-get install curl sudo unzip vim

##### sudo apt update
##### sudo apt install python3-dev python-is-python3 # python-is-python2 should also work
##### python --version # Should be >= 2.x or >= 3.x

##### sudo systemctl start redis postgresql

1. Cambiar el DNS de PeerDNS.

apt-get install bind9

2. Configuració DNS

/etc/bind/named.conf.default-zones

```
zone "edt" {
    type master;
    file "/etc/bind/db.edt";
};
```


/etc/bind/db.edt
```
@ SOA ns root 1 4 4 4 4
   NS ns
ns A 192.168.100.169

peertube A 192.168.100.141
```

192.168.100.169  <=  IP DE LA MAQUINA VIRTUAL DEL SERVIDOR DNS
192.168.100.141  <=  IP DE LA MAQUINA VIRTUAL DEL SERVIDOR PEERTUBE

2. PeerTUBE

*  Instalar PostgreSQl

```
apt-get install postgresql
```

* Activar cluster

```
pg_ctlcluster 13 main start
```

```
systemctl status postgresql
```
----

```
sudo u
```

```
sudo passwd peertube
```

```
cd /var/www/peertube
```
* Dar password a Postgres

```
passwd postgres
```

    `jupiter:jupiter`

* Dar password a peertube

```
sudo -u postgres createuser -P peertube
```

    `peertube:peertube`

```
sudo -u postgres createdb -O peertube -E UTF8 -T template0 peertube_prod
```


* Then enable extensions PeerTube needs:

```
sudo -u postgres psql -c "CREATE EXTENSION pg_trgm;" peertube_prod
```

```
sudo -u postgres psql -c "CREATE EXTENSION unaccent;" peertube_prod
```

```
VERSION=$(curl -s https://api.github.com/repos/chocobozzz/peertube/releases/latest | grep tag_name | cut -d '"' -f 4) && echo "Latest Peertube version is $VERSION"
```


* Open the peertube directory, create a few required directories:

```
cd /var/www/peertube
```
```
sudo -u peertube mkdir config storage versions
```
```
sudo -u peertube chmod 750 config/
```



* Download the latest version of the Peertube client, unzip it and remove the zip:

```
cd /var/www/peertube/versions
```


```
sudo -u peertube wget -q "https://github.com/Chocobozzz/PeerTube/releases/download/${VERSION}/peertube-${VERSION}.zip"
```

```
apt-get install unzip
```

```
sudo -u peertube unzip -q peertube-${VERSION}.zip && sudo -u peertube rm peertube-${VERSION}.zip
```


* Install Peertube:


```
cd /var/www/peertube
```
```
sudo -u peertube ln -s versions/peertube-${VERSION} ./peertube-latest
```

```
apt-get install yarn
```


```
cd ./peertube-latest && sudo -H -u peertube yarn install --production --pure-lockfile
```



```

```


```

```






```

```


```

```





```

```


```

```






```

```


```

```





```

```


```

```





```

```


```

```


3. 

4. 

5. 

6. 

7. 

8. 

9. 

10. 

11. 

12. 