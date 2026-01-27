FROM debian:bullseye

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
    wget \
    curl \
    php7.4 \
    php-fpm \
    php-mysql \
    mariadb-client

RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf
RUN mkdir -p /run/php
COPY ./tools/wp_config.sh /usr/local/bin/wp_config.sh
RUN chmod +x /usr/local/bin/wp_config.sh
WORKDIR /var/www/html
EXPOSE 9000
ENTRYPOINT ["/usr/local/bin/wp_config.sh"]