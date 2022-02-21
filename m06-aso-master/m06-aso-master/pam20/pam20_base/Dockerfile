FROM fedora:32
RUN dnf -y install procs util-linux-user vim finger passwd cracklib-dicts pam_mount nfs-utils
RUN mkdir /opt/docker
COPY . /opt/docker/
RUN  chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
CMD [ "/opt/docker/startup.sh" ]

