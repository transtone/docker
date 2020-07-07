# @description php 7.1 image base on the alpine 3.7 镜像更小，构建完成只有46M
#                       some information
# ------------------------------------------------------------------------------------
# @link https://hub.docker.com/_/alpine/      alpine image
# @link https://hub.docker.com/_/php/         php image
# @link https://github.com/docker-library/php php dockerfiles
# ------------------------------------------------------------------------------------
# @build-example docker build . -f alphp-fpm.Dockerfile -t alphp/alphp:fpm
#

#FROM alphp/php71:base
FROM foxiswho/php-alpine:php72
LABEL maintainer="inhere <cloud798@126.com>" version="1.0"

##
# ---------- building ----------
##

RUN set -ex \
        # change apk source repo
        && sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/' /etc/apk/repositories \
        && apk update \
        && apk add --no-cache \
			php7-fpm \
        && apk del --purge *-dev \
        && rm -rf /var/cache/apk/* /tmp/* /usr/share/man /usr/share/php7 \
        # - config PHP-FPM
        && cd /etc/php7 \
        && { \
            echo "[global]"; \
            echo "pid = /var/run/php-fpm.pid"; \
            echo "[www]"; \
            echo "user = www"; \
            echo "group = www"; \
        } | tee php-fpm.d/custom.conf \
        # - config site
        && chown -R www:www /var/www \
        && sed -i 's/127.0.0.1:9000/0.0.0.0:9000/g' /etc/php7/php-fpm.d/www.conf \
        && { \
            echo "#!/bin/sh"; \
            # echo "php /var/www/uem.phar taskServer:start -d"; \
            echo "php-fpm7 -F"; \
        } | tee /run.sh \
        && chmod 755 /run.sh \
        && echo "alias ls='ls -lhG --color=auto'" >> /root/.bashrc \
        && echo "alias ll='ls -lhG --color=auto'" >> /root/.bashrc \
        && chmod 755 /root/.bashrc \
        && . /root/.bashrc \
        && echo -e "\033[42;37m Build Completed :).\033[0m\n"

EXPOSE 9000
VOLUME ["/var/www", "/data"]
WORKDIR "/var/www"

CMD /run.sh
