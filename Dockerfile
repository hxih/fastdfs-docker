FROM alpine:3.9
# 添加配置文件
ADD soft.tar.gz /usr/local/src/

RUN apk update \
    && apk add --no-cache  git gcc libc-dev make automake autoconf libtool pcre pcre-dev zlib zlib-dev openssl-dev wget vim \
    && cd /usr/local/src/soft \
    && mkdir /etc/fdfs -p \
    && cp -af conf/client.conf /etc/fdfs/ \
    && cp -af conf/http.conf /etc/fdfs/ \
    && cp -af conf/mime.types /etc/fdfs/ \
    && cp -af conf/storage.conf /etc/fdfs/ \
    && cp -af conf/tracker.conf /etc/fdfs/ \
    && cp -af conf/nginx.conf /etc/fdfs/ \
    && cp -af conf/mod_fastdfs.conf /etc/fdfs/ \
    && cp -af fastdfs.sh /home/ \
    && tar -zxvf nginx-1.15.4.tar.gz \
    && mkdir /home/dfs \
    && cd /usr/local/src/soft \
    && cd libfastcommon/ \
    && ./make.sh && ./make.sh install \
    && cd ../ \
    && cd fastdfs/ \
    && ./make.sh && ./make.sh install \
    && cd ../ \
    && cd nginx-1.15.4/ \
    && ./configure --add-module=/usr/local/src/soft/fastdfs-nginx-module/src/ \
    && make && make install \
    && chmod u+x /home/fastdfs.sh \
    && rm -rf /usr/local/src \
    && mv /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.bak \
    && cp /etc/fdfs/nginx.conf /usr/local/nginx/conf/ 

VOLUME /etc/fdfs/

ENTRYPOINT ["/home/fastdfs.sh"]
