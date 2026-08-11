#!/bin/sh

if [ -z "$FTP_USER" ] || [ -z "$FTP_PASSWORD" ]; then
    FTP_USER="ftpuser"
    FTP_PASSWORD="ftppassword123"
fi

# Crear el directorio base si no existe
mkdir -p /var/www/html

# Configurar el usuario de FTP si no existe
if ! id "$FTP_USER" >/dev/null 2>&1; then
    useradd -m -s /bin/bash "$FTP_USER"
    echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
    mkdir -p /etc/vsftpd
    echo "$FTP_USER" > /etc/vsftpd.userlist
fi

# Configuración de vsftpd
cat << EOC > /etc/vsftpd.conf
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
allow_writeable_chroot=YES
secure_chroot_dir=/var/run/vsftpd/empty
pasv_enable=YES
pasv_min_port=21100
pasv_max_port=21110
userlist_enable=YES
userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
local_root=/var/www/html
EOC

# Crear carpeta de runtime de vsftpd si no existe
mkdir -p /var/run/vsftpd/empty

# Dar permisos sobre la carpeta de WordPress
chown -R $FTP_USER:$FTP_USER /var/www/html

exec vsftpd /etc/vsftpd.conf
