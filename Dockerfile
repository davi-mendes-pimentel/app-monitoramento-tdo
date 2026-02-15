FROM php:8.4-fpm-alpine

# USER root

RUN apk add --no-cache \
    postgresql-dev \
    && docker-php-ext-install pdo_pgsql pgsql

RUN apk add nginx

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY . /app

VOLUME ./:/app

RUN chown -R 1001:1001 /app

# RUN chown -R 1001:1001 /opt/bitnami/php \
#     && chmod -R g+rwX /opt/bitnami/php

USER 1001

EXPOSE 80

CMD composer install && php artisan migrate --force && php-fpm -D && nginx -g "daemon off;"

