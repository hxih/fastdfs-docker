#!/bin/bash

NEW=$TRACKER_IP
OLD="com.ikingtech.ch116221"

if [ ! -z ${NEW} ];then
    sed -i "s/${OLD}/${NEW}/g" /etc/fdfs/client.conf
    sed -i "s/${OLD}/${NEW}/g" /etc/fdfs/storage.conf
    sed -i "s/${OLD}/${NEW}/g" /etc/fdfs/mod_fastdfs.conf
fi

if [ $SERVER == "single" ];then
    echo "start trackerd"
    /etc/init.d/fdfs_trackerd start
    sleep 1
    echo "start storage"
    /etc/init.d/fdfs_storaged start
    sleep 1
    echo "start nginx"
    /usr/local/nginx/sbin/nginx
elif [ $SERVER == "tracker" ];then
    echo "start trackerd"
    /etc/init.d/fdfs_trackerd start
elif [ $SERVER == "storage" ];then
    echo "start storage"
    /etc/init.d/fdfs_storaged start
    sleep 1
    echo "start nginx"
    /usr/local/nginx/sbin/nginx
fi
tail -f /dev/null
