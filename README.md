# FastDFS Docker 镜像打包
## 基于轻量级的系统--Alpine
根据https://github.com/happyfish100/fastdfs/tree/master/docker/dockerfile_network 改造成为一个基于alpine3:9的镜像
## 打包
<code>
docker build -t \${CONTAINER_NAME}:\${VERSION} .
</code>

#### example:
<code>
docker build -t fastdfs:1.0 .
</code>

## 启动 单机模式 TRACKER_LIST参数如果有多个IP用英文的逗号分隔
<code>
docker run -d --name fastdfs --net=host -e SERVER=single -e TRACKER_LIST=\${YOUR_IP:PORT,...} \${CONTAINER_NAME}:\${VERSION}
</code>

#### example:
<code>
docker run -d --name fastdfs --net=host -e SERVER=single -e TRACKER_LIST=192.168.1.2:22122 fastdfs:1.0
</code>

## 启动集群模式 TRACKER_LIST参数如果有多个IP用英文的逗号分隔
### 在需要的服务器上启动tracker服务
<code>
docker run -d --name tracker --net=host -e SERVER=tracker \${CONTAINER_NAME}:\${VERSION}
</code>

#### example:
<code>
docker run -d --name tracker --net=host -e SERVER=tracker fastdfs:1.0
</code>

### 在存储服务器上启动storage服务包含nginx服务
<code>
docker run -d --name storage --net=host -e SERVER=storage -e TRACKER_LIST=\${YOUR_IP:PORT,...} \${CONTAINER_NAME}:\${VERSION}
</code>

#### example:
<code>
docker run -d --name storage --net=host -e SERVER=storage -e TRACKER_LIST=192.168.1.2:22122,192.168.1.3:22122 fastdfs:1.0
</code>

## VERSION 1.2
##### 新增环境变量NGINX_ROOT，赋值为'true'时，容器中nginx以root身份运行。


## VERSION 1.1
##### 1、新增环境变量NGINX_PORT自定义nginx监听端口（默认8888）；
##### 2、下载所需文件及软件打包为soft.tar.gz，包含：
https://github.com/happyfish100/fastdfs.git

https://github.com/happyfish100/fastdfs-nginx-module.git

https://github.com/happyfish100/libfastcommon.git

http://nginx.org/download/nginx-1.15.4.tar.gz

https://github.com/happyfish100/fastdfs/tree/master/docker/dockerfile_network/conf
