FROM debian:bullseye
RUN apt-get update -y && apt-get install -y redis-server
EXPOSE 6379
CMD ["redis-server", "--protected-mode", "no", "--bind", "0.0.0.0"]