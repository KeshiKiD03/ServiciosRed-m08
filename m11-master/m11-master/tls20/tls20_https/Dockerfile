FROM fedora:27
LABEL author="@edt ASIX M11-SAD"
LABEL description="server HTTPS 2018-2019"
RUN dnf -y update vi
RUN dnf -y install vim httpd mod_ssl nmap iputils iproute tree procps 
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
WORKDIR /opt/docker
CMD [ "/opt/docker/startup.sh" ]
