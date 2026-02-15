FROM 'bitnami/php-fpm'

USER root

RUN install_packages \
    git \
    unzip

RUN install_packages nginx

COPY nginx.conf /etc/nginx/nginx.conf

# RUN install_packages \
#     php-mysql \
#     php-gd \
#     php-zip \
#     php-bcmath \
#     php-intl

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY . /app

RUN chown -R 1001:1001 /app

RUN chown -R 1001:1001 /opt/bitnami/php \
    && chmod -R g+rwX /opt/bitnami/php

USER 1001

EXPOSE 80

CMD composer install && php-fpm -D && nginx -g "daemon off;"

