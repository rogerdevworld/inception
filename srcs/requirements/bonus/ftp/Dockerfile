FROM debian:bullseye
RUN apt-get update -y && apt-get install -y vsftpd
COPY tools/setup_ftp.sh /usr/local/bin/setup_ftp.sh
RUN chmod +x /usr/local/bin/setup_ftp.sh
EXPOSE 21 21100-21110
ENTRYPOINT ["/usr/local/bin/setup_ftp.sh"]