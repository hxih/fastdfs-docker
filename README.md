# FastDFS Docker 镜像打包
## 基于轻量级的系统--Alpine
根据https://github.com/happyfish100/fastdfs/tree/master/docker/dockerfile_network 改造成为一个基于alpine3:9的镜像
## 打包
docker build -t \${CONTAINER_NAME}:\${VERSION} .
#### example:
docker build -t fastdfs:1.0 .
## 启动 单机模式 TRACKER_LIST参数如果有多个IP用英文的逗号分隔
docker run -d --name fastdfs --net=host -e SERVER=single -e TRACKER_LIST=\${YOUR_IP:PORT,...} \${CONTAINER_NAME}:\${VERSION}
#### example:
docker run -d --name fastdfs --net=host -e SERVER=single -e TRACKER_LIST=192.168.1.2:22122 fastdfs:1.0
## 启动集群模式 TRACKER_LIST参数如果有多个IP用英文的逗号分隔
### 在需要的服务器上启动tracker服务
docker run -d --name tracker --net=host -e SERVER=tracker \${CONTAINER_NAME}:\${VERSION}
#### example:
docker run -d --name tracker --net=host -e SERVER=tracker fastdfs:1.0
### 在存储服务器上启动storage服务包含nginx服务
docker run -d --name storage --net=host -e SERVER=storage -e TRACKER_LIST=\${YOUR_IP:PORT,...} \${CONTAINER_NAME}:\${VERSION}
#### example:
docker run -d --name storage --net=host -e SERVER=storage -e TRACKER_LIST=192.168.1.2:22122,192.168.1.3:22122 fastdfs:1.0
