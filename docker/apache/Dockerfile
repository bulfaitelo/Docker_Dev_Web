FROM php:apache

#https://hub.docker.com/_/php

# Executar em produção
# RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Executar em Desevolvimento
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN apt-get update && \
    apt-get install -y \
    openssl \
    wget \
    #extensao necessária para o php
    zlib1g-dev \
    #GD
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \    
    #Intl
    libicu-dev \
    #Zip
    libzip-dev \
    unzip \
    # openssl
    libcurl4-openssl-dev \
    pkg-config \
    libssl-dev \
    #limpa apt

# Instalando NODE.JS
RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash - &&\
    apt-get install -y nodejs


RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite && a2enmod proxy && a2dissite 000-default
# Removendo a pasta html (eu prefiro trabalhar na pasta www)
RUN rm -rf /var/www/html

RUN docker-php-ext-install mysqli pdo_mysql bcmath exif gd intl zip sockets pcntl
RUN pecl install xdebug && docker-php-ext-enable xdebug
#RUN pecl install imagick && docker-php-ext-enable imagick
#RUN pecl install redis && docker-php-ext-enable redis
#RUN pecl install mongodb && docker-php-ext-enable mongodb

# Instalando o Composer 
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# USER www-data

WORKDIR /var/www

EXPOSE 9000