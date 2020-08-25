FROM nginx:1.18-alpine-perl

RUN set -ex pipefail \
    && apk add --no-cache \
        bash \
        bash-completion \
    && apk add --no-cache --virtual .user-deps \
        shadow \
    && usermod -u 1000 nginx \
    && groupmod -g 1000 nginx \
    && apk del --no-cache .user-deps

COPY /files /

RUN chmod uga+x /usr/local/bin/docker-nginx-entrypoint
ENTRYPOINT [ "docker-nginx-entrypoint" ]

WORKDIR /var/www/html
RUN chown nginx:nginx /var/www/html
VOLUME [ "/var/www/html" ]
