# @description php 7.1 image base on the alpine 3.7 镜像更小
#                       some information
# ------------------------------------------------------------------------------------
# @link https://hub.docker.com/_/alpine/      alpine image
# @link https://hub.docker.com/_/php/         php image
# @link https://github.com/docker-library/php php dockerfiles
# ------------------------------------------------------------------------------------
# @build-example docker build . -f alphp-base.Dockerfile -t alphp/alphp:base
#

FROM httpd:alpine
LABEL maintainer="inhere <cloud798@126.com>" version="1.0"

##
# ---------- env settings ----------
##

# --build-arg timezone=Asia/Shanghai
ARG timezone
# pdt pre test dev
ARG app_env=pdt
ARG add_user=www

ENV APP_ENV=${app_env:-"pdt"} \
    TIMEZONE=${timezone:-"Asia/Shanghai"} \
    #  install and remove building packages
    PHPIZE_DEPS="autoconf dpkg-dev dpkg file g++ gcc libc-dev make php7-dev php7-pear pkgconf re2c pcre-dev zlib-dev"

ENV HIREDIS_VERSION=0.13.3 \
    PHALCON_VERSION=3.3.2 \
    SWOOLE_VERSION=2.1.3 \
    MONGO_VERSION=1.4.2
##
# ---------- building ----------
##

RUN set -ex \
        # change apk source repo
        && sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/' /etc/apk/repositories \
        && apk update \
        && apk add --no-cache \
        # Install base packages
        vim \
        wget \
        net-tools \
        git \
        zip \
        unzip \
        ca-certificates \
        curl \
        tar \
        xz \
        libressl \
        # openssh  \
        openssl  \
        tzdata \
        pcre \
        #
        # install php7 and some extensions
        php7 \
        php7-common \
        php7-fpm \
        php7-amqp \
        php7-bz2 \
        php7-bcmath \
        php7-calendar \
        php7-curl \
        php7-cgi \
        php7-ctype \
        php7-dom \
        #php7-dba \
        #php7-doc \
        #php7-embed \
        #php7-enchant \
        php7-exif \
        php7-ftp \
        php7-fileinfo \
        # php7-filter \
        php7-gd \
        php7-gettext \
        php7-gmp \
        php7-iconv \
        php7-imap \
        php7-intl \
        php7-json \
        php7-ldap \
        #php7-litespeed \
        php7-memcached \
        php7-mcrypt \
        php7-mbstring \
        php7-mongodb \
        php7-mysqlnd \
        php7-mysqli \
        php7-odbc \
        php7-openssl \
        php7-opcache \
        php7-pcntl \
        php7-pdo \
        php7-pdo_dblib \
        php7-pdo_mysql \
        php7-pdo_odbc \
        php7-pdo_pgsql \
        php7-pdo_sqlite \
        php7-pgsql \
        php7-phar \
        php7-phpdbg \
        php7-pspell \
        php7-posix \
        php7-recode \
        php7-redis \
        php7-simplexml \
        # php7-sqlite \
        php7-session \
        php7-shmop \
        php7-snmp \
        php7-sockets \
        php7-soap \
        php7-sqlite3 \
        php7-ssh2 \
        php7-sysvshm \
        php7-sysvmsg \
        php7-sysvsem \
#        php7-timezonedb \
        php7-tidy \
        php7-tokenizer \
        php7-wddx \
        php7-xml \
        php7-xmlreader \
        php7-xmlrpc \
        php7-xmlwriter \
        php7-xsl \
        php7-zip \
        php7-zlib \
        && apk del --purge *-dev
##        && rm -rf /var/cache/apk/* /tmp/* /usr/share/man /usr/share/php7

##
# ---------- some config,clear work ----------
##
RUN set -ex \
        && cd /etc/php7 \
        # - config PHP
        && { \
            echo "upload_max_filesize=100M"; \
            echo "post_max_size=108M"; \
            echo "memory_limit=1024M"; \
            echo "date.timezone=${TIMEZONE}"; \
        } | tee conf.d/99-overrides.ini \
        #
        # - config timezone
        && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
        && echo "${TIMEZONE}" > /etc/timezone \
        #
        # ---------- some config work ----------
        # - ensure 'www' user exists
        && addgroup -S ${add_user} \
        && adduser -D -S -G ${add_user} ${add_user} \
        #
        # - create user dir
        && mkdir -p /data \
        && chown -R ${add_user}:${add_user} /data \
        && mkdir -p /usr/local/etc/ \
        && ln -s /etc/php7/php-fpm.conf /usr/local/etc/php-fpm.conf \
        && ln -s /etc/php7/php-fpm.d /usr/local/etc/php-fpm.d \
        #
        && echo -e "\033[42;37m Build Completed :).\033[0m\n"

##
# install php extensions
##

# 下载太慢，所以可以先下载好
# COPY deps/hiredis-${HIREDIS_VERSION}.tar.gz hiredis.tar.gz
# COPY deps/swoole-${SWOOLE_VERSION}.tar.gz swoole.tar.gz
# COPY deps/cphalcon-${PHALCON_VERSION}.tar.gz cphalcon.tar.gz
# COPY deps/mongodb-${MONGO_VERSION}.tgz mongodb.tgz
RUN set -ex \
        && cd /tmp \
        #&& curl -SL "https://github.com/redis/hiredis/archive/v${HIREDIS_VERSION}.tar.gz" -o hiredis.tar.gz \
        #&& curl -SL "https://github.com/swoole/swoole-src/archive/v${SWOOLE_VERSION}.tar.gz" -o swoole.tar.gz \
        # && curl -SL "https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz" -o cphalcon.tar.gz \
        # && curl -SL "https://github.com/mongodb/mongo-php-driver/archive/v${MONGO_VERSION}.tgz" -o mongodb.tgz \
        # && curl -SL "http://pecl.php.net/get/mongodb-${MONGO_VERSION}.tgz" -o mongodb.tgz \
        && ls -alh \
        && apk update \
        && apk add --no-cache --virtual .phpize-deps \
        $PHPIZE_DEPS \
        # for mongodb ext
        openssl-dev \
        # for swoole ext
        libaio linux-headers libaio-dev \
        #
        # php extension: mongodb
        # && pecl install mongodb.tgz \
        #&& pecl install mongodb \
        #&& echo "extension=mongodb.so" > /etc/php7/conf.d/20_mongodb.ini  \
        && pecl install seaslog \
        && echo "extension=seaslog.so" > /etc/php7/conf.d/20_seaslog.ini  \
        && pecl install swoole \
        && echo "extension=swoole.so" > /etc/php7/conf.d/20_swoole.ini  \
        #
        # php extension: phalcon framework
        # && tar -xf cphalcon.tar.gz \
        # && apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS \
        # && cd cphalcon-${PHALCON_VERSION}/build \
        # # in alpine no bash shell, so change to 'sh install'
        # # && ./install \
        # && sh install \
        # && cp ../tests/_ci/phalcon.ini $(php-config --configure-options | grep -o "with-config-file-scan-dir=\([^ ]*\)" | awk -F'=' '{print $2}') \
        # && cd ../../ \
        # && rm -r cphalcon-${PHALCON_VERSION} \
        #
        # hiredis - redis C client, provide async operate support for Swoole
        # && wget -O hiredis.tar.gz -c https://github.com/redis/hiredis/archive/v${HIREDIS_VERSION}.tar.gz \
        #&& cd /tmp \
        #&& tar -zxvf hiredis.tar.gz \
        #&& cd hiredis-${HIREDIS_VERSION} \
        #&& make -j && make install \
        #
        # php extension: swoole
        #&& cd /tmp \
        #&& mkdir -p swoole \
        #&& tar -xf swoole.tar.gz -C swoole --strip-components=1 \
        #&& rm swoole.tar.gz \
        #&& ( \
        #    cd swoole \
        #    && phpize \
        #    && ./configure --enable-async-redis --enable-mysqlnd --enable-coroutine \
        #    && make -j$(nproc) && make install \
        #) \
        #&& rm -r swoole \
        && echo "extension=swoole.so" > /etc/php7/conf.d/20_swoole.ini \
        && curl -sS https://getcomposer.org/installer | php \
        && mv composer.phar /usr/local/bin/ \
        && chmod 755 /usr/local/bin/composer.phar \
        && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer \
        && curl -sSLo phpunit.phar https://phar.phpunit.de/phpunit.phar \
        && chmod 755 phpunit.phar \
        && mv phpunit.phar /usr/local/bin/ \
        && ln -s /usr/local/bin/phpunit.phar /usr/local/bin/phpunit \
        && apk del .phpize-deps \
        && rm -rf /var/cache/apk/* /tmp/* /usr/share/man /usr/share/php7 \
        #
        && echo -e "\033[42;37m Build Completed :).\033[0m\n"

COPY ./ioncube_loaders_lin_x86-64.tar.gz /tmp

RUN cd /tmp \
    && tar -xvzf ioncube_loaders_lin_x86-64.tar.gz -C /tmp \
    && cp ioncube/ioncube_loader_lin_7.2.so  /usr/lib/php7/modules/ioncube.so \
    && rm -Rf ioncube.tar.gz ioncube \
    && echo "zend_extension=ioncube.so" > /etc/php7/conf.d/00_ioncube.ini        

EXPOSE 9000
#EXPOSE 9501

VOLUME ["/var/www", "/data"]
WORKDIR "/var/www"
