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

```d
zone "edt" {
    type master;
    file "/etc/bind/db.edt";
};
```


/etc/bind/db.edt
```d
@ SOA ns root 1 4 4 4 4
   NS ns
ns A 192.168.100.169

peertube A 192.168.100.141
```

192.168.100.169  <=  IP DE LA MAQUINA VIRTUAL DEL SERVIDOR DNS
192.168.100.141  <=  IP DE LA MAQUINA VIRTUAL DEL SERVIDOR PEERTUBE

3. Instalar las dependencias

* On a fresh Debian/Ubuntu, as root user, install basic utility programs needed for the installation

```
# apt-get install curl sudo unzip vim
```

* On Ubuntu >= focal (20.04 LTS) or Debian >= Bullseye:

```
sudo apt update
sudo apt install python3-dev python-is-python3 # python-is-python2 should also work
python --version # Should be >= 2.x or >= 3.x
```

* Install common dependencies:

```
sudo apt update
sudo apt install certbot nginx ffmpeg postgresql postgresql-contrib openssl g++ make redis-server git cron wget
ffmpeg -version # Should be >= 4.1
g++ -v # Should be >= 5.x
```

* Now that dependencies are installed, before running PeerTube you should start PostgreSQL and Redis:

```
sudo systemctl start redis postgresql
```

> Acceder: https://github.com/nodesource/distributions/blob/master/README.md 

* Instalar Nodejs

```
curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
apt-get install -y nodejs
```

* Verificar nodejs --version

* Instalar Yarn
```
apt-get install npm
```

```
npm install --global yarn
```





4. PeerTUBE

*  Instalar PostgreSQl

```bash
apt-get install postgresql
```

* Activar cluster

```bash
pg_ctlcluster 13 main start
```

```bash
systemctl status postgresql
```
----

```bash
sudo u
```

```bash
sudo passwd peertube
```

```bash
cd /var/www/peertube
```
* Dar password a Postgres

```bash
passwd postgres
```

    `jupiter:jupiter`

* Dar password a peertube

```bash
sudo -u postgres createuser -P peertube
```

    `peertube:peertube`

```bash
sudo -u postgres createdb -O peertube -E UTF8 -T template0 peertube_prod
```


* Then enable extensions PeerTube needs:

```bash
sudo -u postgres psql -c "CREATE EXTENSION pg_trgm;" peertube_prod
```

```bash
sudo -u postgres psql -c "CREATE EXTENSION unaccent;" peertube_prod
```

```bash
VERSION=$(curl -s https://api.github.com/repos/chocobozzz/peertube/releases/latest | grep tag_name | cut -d '"' -f 4) && echo "Latest Peertube version is $VERSION"
```


* Open the peertube directory, create a few required directories:

```bash
cd /var/www/peertube
```
```bash
sudo -u peertube mkdir config storage versions
```
```bash
sudo -u peertube chmod 750 config/
```



* Download the latest version of the Peertube client, unzip it and remove the zip:

```bash
cd /var/www/peertube/versions
```


```bash
sudo -u peertube wget -q "https://github.com/Chocobozzz/PeerTube/releases/download/${VERSION}/peertube-${VERSION}.zip"
```

```bash
apt-get install unzip
```

```bash
sudo -u peertube unzip -q peertube-${VERSION}.zip && sudo -u peertube rm peertube-${VERSION}.zip
```


* Install Peertube:


```bash
cd /var/www/peertube
```
```bash
sudo -u peertube ln -s versions/peertube-${VERSION} ./peertube-latest
```

```bash
apt-get install yarn
```


```bash
cd ./peertube-latest && sudo -H -u peertube yarn install --production --pure-lockfile
```

### PEERTUBE CONFIGURATION

* Copy the default configuration file that contains the default configuration provided by PeerTube. You must not update this file.

```
$ cd /var/www/peertube
$ sudo -u peertube cp peertube-latest/config/default.yaml config/default.yaml
```

* Now copy the production example configuration:

```
$ cd /var/www/peertube
$ sudo -u peertube cp peertube-latest/config/production.yaml.example config/production.yaml
```


* Modificar y poner



```
# Correspond to your reverse proxy server_name/listen configuration (i.e., your public PeerTube instance>
webserver:
  https: false
  hostname: 'peertube.edt'
  port: 80


```

### WEBSERVER

* We only provide official configuration files for Nginx.

* Copy the nginx configuration template:

```
cp /var/www/peertube/peertube-latest/support/nginx/peertube /etc/nginx/sites-available/peertube
```

* Then set the domain for the webserver configuration file. Replace [peertube-domain] with the domain for the peertube server.

```
sed -i 's/${WEBSERVER_HOST}/peertube.edt/g' /etc/nginx/sites-available/peertube

```


```
sed -i 's/${PEERTUBE_HOST}/127.0.0.1:9000/g' /etc/nginx/sites-available/peertube
```




* Then modify the webserver configuration file. Please pay attention to the alias keys of the static locations. It should correspond to the paths of your storage directories (set in the configuration file inside the storage key).

```
sudo vim /etc/nginx/sites-available/peertube
```

```
root@peertube:/etc/nginx/sites-available# cat peertube 
#server {
#  listen 80;
#  listen [::]:80;
#  server_name peertube.edt;#

#  location /.well-known/acme-challenge/ {
#    default_type "text/plain";
#    root /var/www/certbot;
#  }
#  location / { return 301 https://$host$request_uri; }
#}

server {
  listen 80;
  #listen 443 ssl http2;
  #listen [::]:443 ssl http2;
  server_name peertube.edt;

  access_log /var/log/nginx/peertube.access.log; # reduce I/0 with buffer=10m flush=5m
  error_log  /var/log/nginx/peertube.error.log;

  ##
  # Certificates
  # you need a certificate to run in production. see https://letsencrypt.org/
  ##
 # ssl_certificate     /etc/letsencrypt/live/peertube.edt/fullchain.pem;
 # ssl_certificate_key /etc/letsencrypt/live/peertube.edt/privkey.pem;
}
```


```
ln -s /etc/nginx/sites-available/peertube /etc/nginx/sites-enabled/peertube
```






```
systemctl restart nginx
```


```
systemctl reload nginx
```

## TCP TUNNING
```
$ sudo cp /var/www/peertube/peertube-latest/support/sysctl.d/30-peertube-tcp.conf /etc/sysctl.d/
$ sudo sysctl -p /etc/sysctl.d/30-peertube-tcp.conf
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