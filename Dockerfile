FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y nginx libnginx-mod-http-geoip2 && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/geoip

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]