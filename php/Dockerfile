FROM php:7.3-fpm-alpine

RUN set -ex pipefail \
    && apk add --no-cache \
        git \
    && apk add --no-cache --virtual .user-deps \
        shadow \
    && usermod -u 1000 www-data \
    && groupmod -g 1000 www-data \
    && apk del --no-cache .user-deps

ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/
RUN chmod uga+x /usr/local/bin/install-php-extensions && sync && install-php-extensions \
        gd \
        mysqli \
        zip \
        intl \
        imagick

RUN curl -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/bin --filename=composer

WORKDIR /usr/local/etc/php
RUN cp php.ini-development php.ini
COPY conf.d/default.ini conf.d/default.ini

COPY docker-typo3-entrypoint /usr/local/bin/
RUN chmod uga+x /usr/local/bin/docker-typo3-entrypoint
ENTRYPOINT [ "docker-typo3-entrypoint" ]

RUN chown www-data:www-data /var/www/html \
    && sed -i /usr/local/etc/php-fpm.d/www.conf \
           -e 's/^user =.*$/;&/' \
           -e 's/^group =.*$/;&/'
WORKDIR /var/www/html
VOLUME [ "/var/www/html" ]
USER www-data

CMD ["php-fpm"]
