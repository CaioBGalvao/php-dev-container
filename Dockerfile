FROM php:8.4-apache-bookworm

# Instala pacotes e extensões do PHP
RUN apt-get update && apt-get install -y \
    zip unzip git gnupg2 \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    # Instala o Xdebug via PECL
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && rm -rf /var/lib/apt/lists/*

# Instala o Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

WORKDIR /var/www/html

RUN a2enmod rewrite

