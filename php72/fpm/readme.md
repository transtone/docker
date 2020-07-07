
# 配合 docker composer 使用
https://github.com/foxiswho/docker-compose-nginx-php-mysql


# 本地构建
如果你需要本地构建，那么先构建`base`目录下的，
然后修改 `fpm`目录下`Dockerfile`中的 `FROM foxiswho/php-alpine:base-php71`修改为`FROM alphp/php71:base`
再执行如下命令构建
```SHEL
docker build . -f Dockerfile -t alphp/php71:fpm
```