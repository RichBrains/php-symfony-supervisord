FROM php:7-fpm-alpine

RUN docker-php-ext-configure pdo_mysql && \
    docker-php-ext-configure opcache && \
    docker-php-ext-configure mcrypt

RUN docker-php-ext-install pdo_mysql opcache mcrypt && \
    docker-php-source delete

RUN apk --update add supervisor
RUN mkdir -p /var/log/supervisor

RUN ln -s /usr/bin/php7 /usr/bin/php
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ADD supervisor.conf /etc/supervisor.d/supervisor.conf

WORKDIR /var/www/html

EXPOSE 9000

CMD ["/usr/bin/supervisord"]
