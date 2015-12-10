FROM phusion/baseimage:latest
MAINTAINER Ardjan Zwartjes

# sshd needs this directory to run
RUN mkdir -p /sftp
RUN chmod 555 /sftp

COPY sshd_config /etc/ssh/sshd_config

COPY entrypoint /usr/sbin/entrypoint

RUN chmod 755 /usr/sbin/entrypoint

EXPOSE 2200

VOLUME ["/config"]

ENTRYPOINT ["/usr/sbin/entrypoint"]
