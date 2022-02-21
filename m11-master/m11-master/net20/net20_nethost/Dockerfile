FROM fedora:32
LABEL author="@edt ASIX M11-SAD"
LABEL description="NET20 Curs 2020-2021"
RUN dnf -y install xinetd iproute iputils nmap uw-imap procps net-tools passwd httpd vsftpd openssh-server tftp-server telnet
RUN mkdir /opt/docker
#RUN mkdir /opt/docker/xinetd.d
#COPY xinetd.d/* /opt/docker/xinetd.d/
ADD * /opt/docker/
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
WORKDIR /opt/docker
CMD [ "/opt/docker/startup.sh" ]

