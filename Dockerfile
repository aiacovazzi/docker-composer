FROM php:8.3-apache

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip \
    && docker-php-ext-install pdo pdo_mysql mysqli \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i 's|/var/www/html/public|/var/www/html|g' /etc/apache2/sites-available/000-default.conf


WORKDIR /var/www/html

COPY . .

RUN chown -R www-data:www-data /var/www/html

CMD sh -c "composer install --no-interaction && apache2-foreground"
