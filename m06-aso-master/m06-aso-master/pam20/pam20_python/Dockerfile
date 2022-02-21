FROM fedora:32
RUN dnf -y install vim procs util-linux-user finger passwd cracklib-dicts pam_mount sphinx python3-sphinx python2 gcc pam-devel redhat-rpm-config python-devel make python3 pip
RUN mkdir /opt/docker
COPY . /opt/docker/
RUN  chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
CMD [ "/opt/docker/startup.sh" ]

