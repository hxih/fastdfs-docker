FROM alpine:3.9
# 添加配置文件
ADD conf/client.conf /etc/fdfs/
ADD conf/http.conf /etc/fdfs/
ADD conf/mime.types /etc/fdfs/
ADD conf/storage.conf /etc/fdfs/
ADD conf/tracker.conf /etc/fdfs/
ADD fastdfs.sh /home/
ADD conf/nginx.conf /etc/fdfs/
ADD conf/mod_fastdfs.conf /etc/fdfs/

# run
RUN apk update \
    && apk add --no-cache  git gcc libc-dev make automake autoconf libtool pcre pcre-dev zlib zlib-dev openssl-dev wget vim \
    && mkdir -p /usr/local/src \
    && cd /usr/local/src  \
    && git clone https://github.com/happyfish100/libfastcommon.git --depth 1        \
    && git clone https://github.com/happyfish100/fastdfs.git --depth 1    \
    && git clone https://github.com/happyfish100/fastdfs-nginx-module.git --depth 1   \
    && wget http://nginx.org/download/nginx-1.15.4.tar.gz    \
    && tar -zxvf nginx-1.15.4.tar.gz    \
    && mkdir /home/dfs   \
    && cd /usr/local/src/  \
    && cd libfastcommon/   \
    && ./make.sh && ./make.sh install  \
    && cd ../  \
    && cd fastdfs/   \
    && ./make.sh && ./make.sh install  \
    && cd ../  \
    && cd nginx-1.15.4/  \
    && ./configure --add-module=/usr/local/src/fastdfs-nginx-module/src/   \
    && make && make install  \
    && chmod +x /home/fastdfs.sh \
    && rm -rf /usr/local/src
  
# export config
VOLUME /etc/fdfs/

# EXPOSE 22122 23000 8888
ENTRYPOINT ["/home/fastdfs.sh"]
