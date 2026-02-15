FROM 'bitnami/php-fpm'

USER root

RUN install_packages \
    git \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libwebp-dev

RUN docker-php-ext-install \
    pdo \
    pdo_mysql \
    mysqli \
    gd

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY . /app

RUN chown -R 1001:1001 /app

USER 1001

EXPOSE 9000

CMD ["php-fpm", "-F"]
