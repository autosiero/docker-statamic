# vim: set ft=dockerfile :
# Configuration file for Docker

# Based on base php image
FROM php:apache as laravel

# Install ImageMagick
RUN apt-get update \
    && apt-get install --no-install-recommends -y libmagickwand-dev libzip-dev libssl-dev \
    && apt-get clean \
    && rm -rf /var/cache/apt /var/lib/apt /var/log/*

# Install MySQL driver for PDO, Exif and Zip
RUN docker-php-ext-install \
        pdo_mysql \
        exif \
        zip \
    && docker-php-source delete

# Install XDebug, imagick and native Redis extension
RUN pecl install xdebug imagick redis \
    && docker-php-ext-enable xdebug imagick redis \
    && rm -rf /tmp/pear

# Install MongoDB
RUN pecl install mongodb --with-mongodb-ssl=openssl \
    && docker-php-ext-enable mongodb \
    && rm -rf /tmp/pear

# Use production PHP
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Change sendmail to mail
COPY ./php.ini "$PHP_INI_DIR/conf.d/statamic.ini"

# Enable some mods
COPY ./brotli.conf "/etc/apache2/mods-available/brotli.conf"
RUN a2enmod \
    authz_core \
    brotli \
    expires \
    headers \
    proxy_http \
    rewrite

# Enable some configs
COPY ./statamic.conf ./mailhog.conf ./phpmyadmin.conf ./mongo-express.conf /etc/apache2/conf-available/
RUN a2enconf \
    statamic \
    phpmyadmin \
    mongo-express \
    mailhog

RUN groupadd --gid 1000 statamic && \
    useradd --uid 1000 -g statamic statamic

# Run as user 1000 (me 😁)
ENV \
    APACHE_RUN_USER=statamic \
    APACHE_RUN_GROUP=statamic

# Make symlink to Statamic
RUN rm -r /var/www/html && ln -s /var/www/statamic/public /var/www/html

# Configure Laravel branch
FROM laravel AS horizon

# Install pcntl
RUN docker-php-ext-install pcntl \
    && docker-php-source delete

# Run as Laravel
USER statamic

# Make sure we're working from /var/www
WORKDIR /var/www

# Run horizon when this container starts
CMD [ "php", "/var/www/statamic/artisan", "horizon" ]
