#! /bin/bash
#cp /opt/docker/httpd.conf /etc/httpd/conf/httpd.conf
cp /opt/docker/ssl.conf  /etc/httpd/conf.d/.
cp /opt/docker/webs.conf /etc/httpd/conf.d/.
mkdir /var/www/certs
mkdir /var/www/www.auto1.cat
mkdir /var/www/www.auto2.cat
mkdir /var/www/www.web1.org
mkdir /var/www/www.web2.org

# www.auto1.cat
cp /opt/docker/index.auto1.html /var/www/www.auto1.cat/index.html
cp /opt/docker/serverkey.auto1.pem /var/www/certs/serverkey.auto1.pem
cp /opt/docker/servercert.auto1.pem /var/www/certs/servercert.auto1.pem
# www.auto2.cat
cp /opt/docker/index.auto2.html /var/www/www.auto2.cat/index.html
cp /opt/docker/serverkey.auto2.pem /var/www/certs/serverkey.auto2.pem
cp /opt/docker/servercert.auto2.pem /var/www/certs/servercert.auto2.pem
# CA
cp /opt/docker/cakey.pem /var/www/certs/cakey.pem
cp /opt/docker/cacert.pem /var/www/certs/cacert.pem
# www.web1.cat 
cp /opt/docker/index.web1.html /var/www/www.web1.org/index.html
cp /opt/docker/serverkey.web1.pem /var/www/certs/serverkey.web1.pem
cp /opt/docker/servercert.web1.pem /var/www/certs/servercert.web1.pem
# www.web2.cat 
cp /opt/docker/index.web2.html /var/www/www.web2.org/index.html
cp /opt/docker/serverkey.web2.pem /var/www/certs/serverkey.web2.pem
cp /opt/docker/servercert.web2.pem /var/www/certs/servercert.web2.pem
# web default
cp /opt/docker/index.plain.html /var/www/html/index.html
#sed -i -e s,'https.edt.org','https.edt.org www.auto1.cat www.auto2.cat www.web1.org www.web2.org', /etc/hosts
sed  's/https.edt.org/https.edt.org www.auto1.cat www.auto2.cat www.web1.org www.web2.org www.web1.org www.web2.org/' /etc/hosts > /tmp/hosts$$
cp /tmp/hosts$$ /etc/hosts

