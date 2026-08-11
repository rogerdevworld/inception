FROM debian:bullseye
RUN apt-get update -y && apt-get install -y wget php php-mysqli
WORKDIR /var/www/html
RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O index.php
EXPOSE 8080
CMD ["php", "-S", "0.0.0.0:8080"]