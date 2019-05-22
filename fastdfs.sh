#!/bin/bash

NEW=$TRACKER_IP
OLD="com.ikingtech.ch116221"

if [ ! -z ${NEW} ];then
    sed -i "s/${OLD}/${NEW}/g" /etc/fdfs/client.conf
    sed -i "s/${OLD}/${NEW}/g" /etc/fdfs/storage.conf
    sed -i "s/${OLD}/${NEW}/g" /etc/fdfs/mod_fastdfs.conf
fi
echo "start trackerd"
/etc/init.d/fdfs_trackerd start
sleep 1
echo "start storage"
/etc/init.d/fdfs_storaged start
sleep 1
echo "start nginx"
/usr/local/nginx/sbin/nginx
#保持前台启动
tail -f /dev/null
