# 拉取node镜像
FROM node:10-alpine

# 设置镜像作者
LABEL MAINTAINER="qiyang.hqy@dtwave-inc.com"

# 设置国内阿里云镜像站、安装chromium 68、文泉驿免费中文字体等依赖库
RUN echo "https://mirrors.aliyun.com/alpine/v3.8/main/" > /etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/v3.8/community/" >> /etc/apk/repositories \
    && echo "https://mirrors.aliyun.com/alpine/edge/testing/" >> /etc/apk/repositories \
    && apk -U --no-cache update && apk -U --no-cache --allow-untrusted add \
      zlib-dev \
      xorg-server \
      dbus \
      ttf-freefont \
      chromium \
      wqy-zenhei@edge \
      bash \
      bash-doc \
      bash-completion -f

# 设置时区
RUN rm -rf /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 设置环境变量
ENV NODE_ENV production

# 创建项目代码的目录
RUN mkdir -p /workspace

# 指定RUN、CMD与ENTRYPOINT命令的工作目录
WORKDIR /workspace

# 复制宿主机当前路径下所有文件到docker的工作目录
COPY . /workspace

# 清除npm缓存文件
RUN npm cache clean --force && npm cache verify
# 如果设置为true，则当运行package scripts时禁止UID/GID互相切换
# RUN npm config set unsafe-perm true

# 安装pm2
RUN npm i pm2 -g

# 安装依赖
RUN npm install

# 暴露端口
EXPOSE 3000

# 运行命令
ENTRYPOINT pm2-runtime start docker_pm2.json
