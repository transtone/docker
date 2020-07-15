# @description php 7.1 image base on the alpine 3.7 镜像更小
#                       some information
# ------------------------------------------------------------------------------------
# @link https://hub.docker.com/_/alpine/      alpine image
# @link https://hub.docker.com/_/php/         php image
# @link https://github.com/docker-library/php php dockerfiles
# ------------------------------------------------------------------------------------
# @build-example docker build . -f alphp-base.Dockerfile -t alphp/alphp:base
#

FROM httpd:2.4.38-alpine
LABEL maintainer="stone <zm3345@126.com>" version="1.0"

##
# ---------- env settings ----------
##

# --build-arg timezone=Asia/Shanghai
ARG timezone
# pdt pre test dev
ARG app_env=pdt

ENV APP_ENV=${app_env:-"pdt"} \
    TIMEZONE=${timezone:-"Asia/Shanghai"} \
    #  install and remove building packages
    PHPIZE_DEPS="autoconf dpkg-dev dpkg file g++ gcc libc-dev make php7-dev php7-pear pkgconf re2c pcre-dev zlib-dev"

##
# ---------- building ----------
##

RUN set -ex \
        # change apk source repo
        && sed -i 's/http:/https:/' /etc/apk/repositories \
        && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories \
        && apk --no-cache update \
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
        # openssh  \
        libressl \
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
        #
        # - create user dir
        && mkdir -p /usr/local/etc/ \
        && ln -s /etc/php7/php-fpm.conf /usr/local/etc/php-fpm.conf \
        && ln -s /etc/php7/php-fpm.d /usr/local/etc/php-fpm.d \
        && cd /etc/php7 \
        && { \
            echo "[global]"; \
            echo "pid = /var/run/php-fpm.pid"; \
            echo "[www-data]"; \
            echo "user = www-data"; \
            echo "group = www-data"; \
        } | tee php-fpm.d/custom.conf \
        # - config site
        && sed -i 's/127.0.0.1:9000/0.0.0.0:9000/g' /etc/php7/php-fpm.d/www.conf \
        && echo "alias ls='ls -lhG --color=auto'" >> /root/.bashrc \
        && echo "alias ll='ls -lhG --color=auto'" >> /root/.bashrc \
        && chmod 755 /root/.bashrc \
        && . /root/.bashrc \
        #
        && echo -e "\033[42;37m Build Completed :).\033[0m\n"

##
# install php extensions
##

RUN set -ex \
        && cd /tmp \
        && ls -alh \
        && apk update \
        && apk add --no-cache --virtual .phpize-deps \
        $PHPIZE_DEPS \
        openssl-dev  \
        libaio linux-headers libaio-dev \
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

RUN cd /tmp \
    && curl -sSLo ioncube_loaders_lin_x86-64.tar.gz https://test.hnrr.com.cn/static/ioncube_loaders_lin_x86-64.tar.gz \
    && tar -xvzf ioncube_loaders_lin_x86-64.tar.gz -C /tmp \
    && cp ioncube/ioncube_loader_lin_7.2.so  /usr/lib/php7/modules/ioncube.so \
    && rm -Rf ioncube.tar.gz ioncube \
    && echo "zend_extension=ioncube.so" > /etc/php7/conf.d/00_ioncube.ini        

EXPOSE 80
EXPOSE 443
EXPOSE 9000

VOLUME ["/usr/local/apache2/htdocs", "/data"]
WORKDIR "/usr/local/apache2/htdocs"
