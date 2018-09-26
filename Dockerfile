FROM php:7.1.17-apache
RUN apt-get -y update && apt-get -y install git libpng-dev g++ libicu-dev icu-devtools libmcrypt-dev mcrypt libzip-dev
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php && mv composer.phar /usr/bin/composer 
RUN docker-php-ext-install gd intl zip
RUN pecl install mcrypt-1.0.0
RUN docker-php-ext-enable mcrypt
RUN chown -R www-data:www-data /var/www
WORKDIR /var/www/html/
USER www-data
RUN git clone -b 3.0 https://github.com/oroinc/crm-application.git oroapp && cd oroapp && composer install --prefer-dist
WORKDIR /var/www/html/oroapp
 
