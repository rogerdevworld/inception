#!/bin/bash
set -e
sleep 10
if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

if [ ! -f index.php ]; then
    wp core download --allow-root
    wp config create --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306

    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="Inception de rmarrero" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL

    wp user create --allow-root \
        $SQL_USER $WP_USER_EMAIL \
        --user_pass=$SQL_PASSWORD \
        --role=author
    
    echo "WordPress configurado correctamente para rmarrero."
else
    echo "WordPress ya está instalado, saltando configuración."
fi

exec php-fpm7.4 -F