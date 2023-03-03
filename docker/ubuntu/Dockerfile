FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

## DEfinindo tzdata pra poder definir o timezone pra não precisar de interação com o php.
RUN truncate -s0 /tmp/preseed.cfg; \
    echo "tzdata tzdata/Areas select America" >> /tmp/preseed.cfg; \
    echo "tzdata tzdata/Zones/America select Sao_Paulo" >> /tmp/preseed.cfg; \
    debconf-set-selections /tmp/preseed.cfg && \
    rm -f /etc/timezone /etc/localtime && \
    apt-get update && \
    apt-get install -y tzdata

#https://hub.docker.com/_/php

# Executar em produção
# RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Executar em Desevolvimento
# RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN apt update && \
    apt install -y \    
    curl \
    openssl \
    wget \
    #extensao necessária para o php
    zlib1g-dev \
    # #GD
    # libfreetype6-dev \
    # libjpeg62-turbo-dev \
    # libpng-dev \    
    #Intl
    libicu-dev \
    #Zip
    libzip-dev \
    unzip \
    # openssl
    libcurl4-openssl-dev \
    pkg-config \
    libssl-dev \
    php \
    php-curl \
    php-dom \
    php-gd \
    php-zip \
    php-mbstring \
    php-mysqli \
    php-mysql \
    php-bcmath \
    php-intl   
    


# # Instalando NODE.JS
RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash - &&\
    apt-get install -y nodejs

# #limpa apt
# RUN apt-get clean && rm -rf /var/lib/apt/lists/*



# Iniciando Apache
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
# habilitando Vhost
RUN a2enmod rewrite && a2enmod proxy && a2dissite 000-default
# Removendo a pasta html (eu prefiro trabalhar na pasta www)
RUN rm -rf /var/www/html

#RUN docker-php-ext-install mysqli pdo_mysql bcmath exif gd intl zip sockets pcntl
#RUN pecl install xdebug && docker-php-ext-enable xdebug
#RUN pecl install imagick && docker-php-ext-enable imagick
#RUN pecl install redis && docker-php-ext-enable redis
#RUN pecl install mongodb && docker-php-ext-enable mongodb

# Instalando o Composer 
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www

EXPOSE 9000