# FastDFS Docker 镜像打包
## 基于轻量级的系统--Alpine
根据https://github.com/happyfish100/fastdfs/tree/master/docker/dockerfile_network 改造成为一个基于alpine3:9的镜像
## 打包
docker build -t ${CONTAINER_NAME}:${VERSION} .
## 启动 单机模式
docker run -d --name fastdfs --net=host -e SERVER=single -e TRACKER_IP=${YOUR_IP} ${CONTAINER_NAME}:${VERSION}
## 启动 单独服务模式
### 启动tracker服务
docker run -d --name tracker --net=host -e SERVER=tracker ${CONTAINER_NAME}:${VERSION}
### 启动storage服务包含nginx服务
docker run -d --name storage --net=host -e SERVER=storage -e TRACKER_IP=${YOUR_IP} ${CONTAINER_NAME}:${VERSION}
## 集群模式
### 启动tracker服务在需要的服务器上，再在存储服务器上启动storage服务，然后自行修改容器中/etc/fdfs/storage.conf配置文件的tracker_server地址，或者单独映射/etc/fdfs/storage.conf配置文件。
