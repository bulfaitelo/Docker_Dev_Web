FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

## Definindo tzdata pra poder definir o timezone pra não precisar de interação com o php.
RUN truncate -s0 /tmp/preseed.cfg; \
    echo "tzdata tzdata/Areas select America" >> /tmp/preseed.cfg; \
    echo "tzdata tzdata/Zones/America select Sao_Paulo" >> /tmp/preseed.cfg; \
    debconf-set-selections /tmp/preseed.cfg && \
    rm -f /etc/timezone /etc/localtime && \
    apt-get update && \
    apt-get install -y tzdata

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
    bash-completion \
    vim \
    # PHP & PHP Modules
    php php-curl php-dom php-gd php-zip php-mbstring php-mysqli php-mysql php-bcmath php-intl \
    # Instalando driver mssqlserver
    freetds-common freetds-bin unixodbc php-sybase

# Instalando NODE.JS
RUN curl -fsSL https://deb.nodesource.com/setup_19.x | bash - &&\
    apt-get install -y nodejs

# limpa apt
# RUN apt-get clean && rm -rf /var/lib/apt/lists/*


# Iniciando Apache
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
# habilitando Vhost
RUN a2enmod rewrite && a2enmod proxy && a2dissite 000-default
# Removendo a pasta html (eu prefiro trabalhar na pasta www)
RUN rm -rf /var/www/html
# Criando diretório de logs de erro do PHP
RUN mkdir -m 755 /tmp/php 

# Instalando o Composer 
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www

EXPOSE 9000