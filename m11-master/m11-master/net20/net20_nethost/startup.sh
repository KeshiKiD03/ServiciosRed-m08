#! /bin/bash
/opt/docker/install.sh && echo "Ok install"
/usr/sbin/httpd
/usr/sbin/vsftpd
/usr/sbin/sshd
/usr/sbin/in.tftpd -s /var/lib/tftpboot
/usr/sbin/xinetd -dontfork && echo "xinetd OK"

