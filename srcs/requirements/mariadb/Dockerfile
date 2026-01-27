FROM debian:bullseye 

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server

#COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/setup_db.sh /usr/local/bin/setup_db.sh
RUN chmod +x /usr/local/bin/setup_db.sh
EXPOSE 3306
ENTRYPOINT ["/usr/local/bin/setup_db.sh"]