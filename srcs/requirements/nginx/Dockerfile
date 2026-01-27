# Debian Bullseye (Penúltima estable)
FROM debian:bullseye

# 1. Instalar NGINX y OpenSSL
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y nginx openssl

# 2. Crear el certificado SSL (Auto-firmado)
# El Subject exige TLS. Aquí generamos la llave y el certificado de una vez.
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=ES/ST=Barcelona/L=Barcelona/O=42/OU=42/CN=rmarrero.42.fr/UID=rmarrero"

# 3. Copiar nuestro archivo de configuración personalizado
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

# 4. Exponer el único puerto permitido por el subject
EXPOSE 443

# 5. Arrancar NGINX en primer plano
# 'daemon off;' es vital para que el contenedor no se apague al instante
CMD ["nginx", "-g", "daemon off;"]