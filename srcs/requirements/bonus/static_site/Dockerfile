FROM debian:bullseye
RUN apt-get update -y && apt-get install -y nginx
COPY conf/index.html /var/www/static/index.html
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8081
CMD ["nginx", "-g", "daemon off;"]