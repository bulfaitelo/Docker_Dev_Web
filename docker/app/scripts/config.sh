#!/bin/sh
# Use o timestamp atual para invalidar o cache
CACHE_BUST=$(date +%s)
# Instalando NODE.JS
if [ "$APP_NODE_JS" = "true" ]
then    
    apt-get update &&  apt-get install -y ca-certificates curl gnupg
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
    apt-get update && apt-get install nodejs -y

    # Instalando libs para o chromium, necessário para executar o puppeteer
    if [ "$APP_LARAVEL_PDF" = "true" ]
    then
        # Pc
        if [ "$APP_PLATFORM" = "x86" ]
        then
            apt-get install -y gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils libgbm-dev libxshmfence-dev
            npm install --location=global --unsafe-perm puppeteer@^17
            chmod -R o+rx /usr/lib/node_modules/puppeteer/.local-chromium
            runuser -l app -c 'npx --yes puppeteer browsers install chrome'
        # Apple Silicon
        elif [ "$APP_PLATFORM" = "arm64" ]
        then
         
            apt-get install -y gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils libgbm-dev libxshmfence-dev
            npm install --location=global --unsafe-perm puppeteer@^17
            chmod -R o+rx /usr/lib/node_modules/puppeteer/.local-chromium
            runuser -l app -c 'npx --yes puppeteer browsers install chromium@1083080'     
        else
            echo "Unknown environment: $APP_PLATFORM"
            exit 1    
        fi
    fi
fi

# Instalando Drive e configurando Conexão com SQL SERVER.
if [ "$APP_SQL_SERVER" = "true" ]
then
    pecl install sqlsrv
    pecl install pdo_sqlsrv
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
    curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list
    apt-get update
    apt-get remove -y libodbc2 libodbcinst2 odbcinst unixodbc-common
    ACCEPT_EULA=Y apt-get install -y msodbcsql18
    ACCEPT_EULA=Y apt-get install -y mssql-tools18   
fi