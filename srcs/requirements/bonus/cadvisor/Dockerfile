FROM debian:bullseye
RUN apt-get update -y && apt-get install -y wget
RUN wget https://github.com/google/cadvisor/releases/download/v0.47.0/cadvisor-v0.47.0-linux-amd64 -O /usr/local/bin/cadvisor
RUN chmod +x /usr/local/bin/cadvisor
EXPOSE 8080
CMD ["/usr/local/bin/cadvisor", "-logtostderr"]