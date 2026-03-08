#!/bin/bash
set -e

# 1. Asegurar que los directorios necesarios existan y tengan permisos
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# 2. Inicializar la base de datos si no existe (primera ejecución)
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Inicializando almacenamiento de MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# 3. Arrancar MariaDB en segundo plano (el '&' es vital)
# Esto permite que el script siga ejecutando los siguientes comandos
mysqld_safe --datadir='/var/lib/mysql' --bind-address=0.0.0.0 &

# 4. Esperar a que MariaDB esté listo para recibir comandos
echo "Esperando a que MariaDB arranque..."
for i in {30..0}; do
    if mysqladmin ping >/dev/null 2>&1; then
        break
    fi
    echo "MariaDB aún no responde... ($i)"
    sleep 2
done

if [ "$i" = 0 ]; then
    echo "Error: MariaDB no arrancó a tiempo."
    exit 1
fi

# 5. Configuración de base de datos y usuarios
# Usamos '@'%' para que el usuario sea accesible desde el contenedor de WordPress
echo "Configurando base de datos y privilegios..."
mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -u root -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -u root -p${SQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# 6. Apagar la instancia temporal para reiniciar en modo limpio
echo "Reiniciando MariaDB..."
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# 7. Ejecutar MariaDB en primer plano (proceso que Docker vigilará)
# IMPORTANTE: Aquí NO ponemos el '&' para que el contenedor se mantenga activo
echo "MariaDB está listo y en funcionamiento."
exec mysqld_safe --datadir='/var/lib/mysql' --bind-address=0.0.0.0