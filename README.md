# FastDFS Docker 镜像打包
## 基于轻量级的系统--Alpine
根据https://github.com/happyfish100/fastdfs/tree/master/docker/dockerfile_network 改造成为一个基于alpine3:9的镜像
## 启动
docker run -d --name fastdfs --net=host -e TRACKER_IP=${YOUR_IP} ${CONTAINER_NAME}:${VERSION}
