FROM fedora:32
RUN dnf -y install nss-pam-ldapd pam_mount passwd procps nmap vim openldap-clients openssh openssh openssh-server openssh-clients file openssl
RUN mkdir /opt/docker
COPY . /opt/docker/
RUN  chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
EXPOSE 22
CMD [ "/opt/docker/startup.sh" ]

