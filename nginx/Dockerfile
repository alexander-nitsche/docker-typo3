FROM nginx:1.16-alpine

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

WORKDIR /var/www/html
RUN chown nginx:nginx /var/www/html
VOLUME [ "/var/www/html" ]
