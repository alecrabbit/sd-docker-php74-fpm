FROM php:7.3-fpm

ENV REDIS_VERSION 5.1.1

RUN apt-get update && apt-get install -y unzip libicu-dev libwebp-dev \
    libjpeg62-turbo-dev libpng-dev libxpm-dev libfreetype6-dev libxslt-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-install xsl \
    && docker-php-ext-configure gd \
    && docker-php-ext-install gd \
    && pecl install -o -f redis-${REDIS_VERSION} \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql \
    && docker-php-ext-install mysqli pdo_mysql \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install opcache

COPY ./config/php/timezone.ini /usr/local/etc/php/conf.d/timezone.ini
COPY ./config/php/opcache.ini /usr/local/etc/php/conf.d/opcache.ini
