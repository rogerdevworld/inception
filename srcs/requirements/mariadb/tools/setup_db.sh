#!/bin/bash
set -e

# 1. Asegurar que los directorios necesarios existan y tengan permisos
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# Añadimos --bind-address=0.0.0.0 para que escuche a otros contenedores
mysqld_safe --datadir='/var/lib/mysql' --bind-address=0.0.0.0

# 3. Esperar a que el socket esté listo
for i in {30..0}; do
    if mysqladmin ping >/dev/null 2>&1; then
        break
    fi
    echo "Esperando a MariaDB... ($i)"
    sleep 2
done

if [ "$i" = 0 ]; then
    echo "Error: MariaDB no arrancó a tiempo."
    exit 1
fi

# 4. Configuración de base de datos y usuarios
echo "Configurando base de datos..."
mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -u root -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -u root -p${SQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# 5. Apagar la instancia temporal de forma segura
echo "Reiniciando MariaDB en modo normal..."
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# 6. Ejecutar MariaDB en primer plano (este es el proceso que Docker vigilará)
exec mysqld_safe --datadir='/var/lib/mysql'