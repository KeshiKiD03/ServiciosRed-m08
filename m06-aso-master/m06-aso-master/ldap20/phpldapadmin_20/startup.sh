#! /bin/bash
cp /opt/docker/phpldapadmin.conf /etc/httpd/conf.d/phpldapadmin.conf
cp /opt/docker/config.php /etc/phpldapadmin/config.php
ulimit -n 1024
/sbin/php-fpm
/sbin/httpd -DFOREGROUND
