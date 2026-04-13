FROM php:8.3-apache

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip git curl \
    && docker-php-ext-install pdo pdo_mysql mysqli bcmath \
    && a2enmod rewrite \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf \
    && echo '<Directory /var/www/html/public>\n    AllowOverride All\n</Directory>' >> /etc/apache2/apache2.conf

WORKDIR /var/www/html
COPY . .
RUN chown -R www-data:www-data /var/www/html

CMD sh -c "composer install --no-interaction && php artisan migrate --force 2>/dev/null; apache2-foreground"