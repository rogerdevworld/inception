#!/bin/bash
set -e

echo "[WordPress] Esperando a MariaDB..."
until mariadb-admin ping -h"mariadb" --silent; do
    sleep 2
done

if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

if [ ! -f index.php ]; then
    echo "[WordPress] Instalando WordPress..."
    wp core download --allow-root
    
    wp config create --allow-root \
        --dbname="${SQL_DATABASE}" \
        --dbuser="${SQL_USER}" \
        --dbpass="${SQL_PASSWORD}" \
        --dbhost="mariadb:3306"

    wp core install --allow-root \
        --url="${DOMAIN_NAME}" \
        --title="Inception rmarrero" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}"

    wp user create --allow-root \
        "${SQL_USER}" "${WP_USER_EMAIL}" \
        --user_pass="${SQL_PASSWORD}" \
        --role=author

    # --- CONFIGURACIÓN REDIS CACHE (BONUS) ---
    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6379 --raw --allow-root
    wp config set WP_CACHE true --raw --allow-root
    wp plugin install redis-cache --activate --allow-root
    wp redis enable --allow-root

    echo "[WordPress] Instalación completada."
else
    echo "[WordPress] Archivos encontrados. Omitiendo instalación."
fi

exec php-fpm7.4 -F