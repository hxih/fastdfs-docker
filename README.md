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
