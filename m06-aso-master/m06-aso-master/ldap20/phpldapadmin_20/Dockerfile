# PhpLdapAdmin
FROM fedora:27
LABEL version="1.0"
LABEL author="@edt ASIX-M06"
LABEL subject="phpldapadmin"
RUN dnf -y install vim httpd php-xml phpldapadmin
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
CMD /opt/docker/startup.sh
EXPOSE 80
