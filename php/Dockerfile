FROM php:7.3-fpm-alpine

# Available levels: alert, error, warning, notice, debug
# @see https://www.php.net/manual/en/install.fpm.configuration.php
ENV PHP_LOGLEVEL="warning"

# Make locales available to non-login shell
ENV MUSL_LOCPATH="/usr/share/i18n/locales/musl"

RUN set -ex pipefail \
    && apk add --no-cache \
        git \
        ghostscript \
        bash \
        bash-completion \
        musl-locales \
        musl-locales-lang \
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
        gmagick \
        xdebug

RUN curl -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/bin --filename=composer

WORKDIR /usr/local/etc/php
RUN cp php.ini-development php.ini
COPY /files /

RUN chmod uga+x /usr/local/bin/docker-typo3-entrypoint
ENTRYPOINT [ "docker-typo3-entrypoint" ]

RUN chown -R www-data:www-data /home/www-data \
    && chown www-data:www-data /var/www/html \
    && sed -i /usr/local/etc/php-fpm.d/www.conf \
           -e 's/^user =.*$/;&/' \
           -e 's/^group =.*$/;&/'
WORKDIR /var/www/html
VOLUME [ "/var/www/html" ]
USER www-data

CMD ["php-fpm"]
