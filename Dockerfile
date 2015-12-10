FROM phusion:baseimage
MAINTAINER Ardjan Zwartjes

# sshd needs this directory to run
RUN chmod 555 /sftp

RUN cat /etc/passwd | grep ^root | tee /etc/passwd
RUN cat /etc/shadow | grep ^root | tee /etc/shadow
RUN cat /config/sftp_users | sed -En 's/([^:]*):.*/\1:x:2:2::\/sftp:\/usr\/bin\/false/p' | newusers
RUN cat /config/sftp_users | chpasswd

COPY sshd_config /etc/ssh/sshd_config

EXPOSE 2200

VOLUME ["/config"]

ENTRYPOINT ["/usr/sbin/sshd", "-e", "-D"]
