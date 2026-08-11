#!/bin/bash
set -e

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Verificamos si la base de datos específica ya existe en el volumen
if [ ! -d "/var/lib/mysql/${SQL_DATABASE}" ]; then
    echo "[MariaDB] Primera ejecución: Inicializando almacenamiento..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

    # Arrancar mysqld de forma temporal para configurar usuarios
    mysqld_safe --datadir='/var/lib/mysql' --bind-address=0.0.0.0 &
    
    # Espera activa hasta que mysqld responda
    until mysqladmin ping >/dev/null 2>&1; do
        sleep 1
    done

    echo "[MariaDB] Creando base de datos y usuarios..."
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
    mysql -u root -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
    mysql -u root -p"${SQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

    echo "[MariaDB] Apagando instancia temporal de configuración..."
    mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown
else
    echo "[MariaDB] La base de datos ya existe. Saltando configuración inicial."
fi

echo "[MariaDB] Iniciando servicio principal..."
exec mysqld_safe --datadir='/var/lib/mysql' --bind-address=0.0.0.0