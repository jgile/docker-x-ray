FROM php:8.0-cli

RUN apt-get update && apt-get install -y libzip-dev \
    && docker-php-ext-install zip \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && composer global require spatie/x-ray

RUN mkdir app

WORKDIR '/app'

ENTRYPOINT ["/root/.composer/vendor/bin/x-ray", "/app"]

# FROM ubuntu:21.04
#
# ARG WWWGROUP
#
# WORKDIR /var/www/html
#
# ENV DEBIAN_FRONTEND noninteractive
# ENV TZ=UTC
#
# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#
# RUN apt-get update \
#     && apt-get install -y php8.0-cli php8.0-dev \
#        php8.0-pgsql php8.0-sqlite3 php8.0-gd \
#        php8.0-curl php8.0-memcached \
#        php8.0-imap php8.0-mysql php8.0-mbstring \
#        php8.0-xml php8.0-zip php8.0-bcmath php8.0-soap \
#        php8.0-intl php8.0-readline php8.0-pcov \
#        php8.0-msgpack php8.0-igbinary php8.0-ldap \
#        php8.0-redis php8.0-swoole php8.0-xdebug \
#     && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
#     && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
#     && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
#     && apt-get update \
#     && apt-get install -y yarn \
#     && apt-get clean \
#     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#
# RUN setcap "cap_net_bind_service=+ep" /usr/bin/php8.0
#
# RUN groupadd --force -g $WWWGROUP sail
# RUN useradd -ms /bin/bash --no-user-group -g $WWWGROUP -u 1337 sail
#
# COPY start-container /usr/local/bin/start-container
# COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# COPY php.ini /etc/php/8.0/cli/conf.d/99-sail.ini
# RUN chmod +x /usr/local/bin/start-container
#
# EXPOSE 8000
#
# ENTRYPOINT ["start-container"]