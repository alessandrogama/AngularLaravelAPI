FROM php:7.4.1-apache

RUN a2enmod rewrite

# Install Composer
RUN apt-get -y update && \
    apt-get -y install curl nano git vim zip unzip libxml2-dev libmemcached-dev libmcrypt-dev zlib1g-dev libsodium-dev && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN docker-php-ext-install mysqli pdo pdo_mysql tokenizer xml pcntl intl fileinfo sockets bcmath sockets sodium exif \
    && docker-php-ext-enable mysqli pdo pdo_mysql tokenizer xml pcntl intl fileinfo sockets bcmath sockets sodium exif

# Configuration for Apache
COPY apache/000-default.conf /etc/apache2/sites-available

# APC
# RUN pear config-set php_ini /usr/local/etc/php/php.ini
# RUN pecl config-set php_ini /usr/local/etc/php/php.ini
# RUN pecl channel-update pecl.php.net && pecl install mcrypt-1.0.1 xdebug redis && docker-php-ext-enable xdebug redis 

# Edit PHP INI
# RUN echo "memory_limit = 1G" > /usr/local/etc/php/php.ini
RUN echo "memory_limit = 1G" > /usr/local/etc/php/php.ini
RUN echo "upload_max_filesize = 50M" >> /usr/local/etc/php/php.ini
RUN echo "post_max_size = 500M" >> /usr/local/etc/php/php.ini
RUN echo "date.timezone = America/Sao_Paulo" >> /usr/local/etc/php/php.ini



# Clean after install
RUN apt-get autoremove -y && apt-get clean all

EXPOSE 80 443

# Change website folder rights and upload your website
RUN chown -R www-data:www-data /var/www/html
ADD ./backend /var/www/html

# Change working directory
WORKDIR /var/www/html

# Create Laravel folders (mandatory)
RUN mkdir -p /var/www/html/bootstrap/cache
RUN mkdir -p /var/www/html/bootstrap/cache

RUN mkdir -p /var/www/html/storage/framework
RUN mkdir -p /var/www/html/storage/framework/sessions
RUN mkdir -p /var/www/html/storage/framework/views
RUN mkdir -p /var/www/html/storage/meta
RUN mkdir -p /var/www/html/storage/cache
RUN mkdir -p /var/www/html/public/storage/uploads/

# Change folder permission
RUN chmod -R 0777 /var/www/html/storage/
RUN chmod -R 0777 /var/www/html/public/storage/uploads/
# Laravel writing rights
RUN chgrp -R www-data /var/www/html/storage /var/www/html/bootstrap/cache
RUN chmod -R ug+rwx /var/www/html/storage /var/www/html/bootstrap/cache


RUN service apache2 restart