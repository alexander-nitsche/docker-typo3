FROM php:7.3-fpm-alpine

# Available contexts: dev, test, prod
ENV PHP_CONTEXT="prod"

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
        # Downgrade to XDebug v2 to handle PHP 7.3 + XDebug v3 + Symfony package exceptions
        xdebug-2.9.8

RUN curl -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/bin --filename=composer

WORKDIR /usr/local/etc/php
COPY /files /

RUN chmod uga+x /usr/local/bin/docker-typo3-entrypoint
ENTRYPOINT [ "docker-typo3-entrypoint" ]

RUN chown -R www-data:www-data /home/www-data \
    && chown www-data:www-data /var/www/html \
    # Enable overwriting configuration by user "www-data"
    && chown -R :www-data /usr/local/etc/php-fpm.d \
    && chmod -R g+w /usr/local/etc/php-fpm.d \
    && chown -R :www-data /usr/local/etc/php \
    && chmod -R g+w /usr/local/etc/php \
    && sed -i /usr/local/etc/php-fpm.d/www.conf \
           -e 's/^user =.*$/;&/' \
           -e 's/^group =.*$/;&/'
WORKDIR /var/www/html
VOLUME [ "/var/www/html" ]
USER www-data

CMD ["php-fpm"]
