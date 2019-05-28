#!/bin/bash
OLD="tracker_server=com.ikingtech.ch116221:22122"
index=0
for var in $(echo ${TRACKER_LIST}|sed 's#,# #g')
do
    if [[ ! -z ${var} ]] && [[ $index -eq 0 ]];then
        NEW="tracker_server=${var}"
        echo "NEW-->${NEW}"
        sed -i "s/${OLD}/${NEW}/g" /etc/fdfs/client.conf
        sed -i "s/${OLD}/${NEW}/g" /etc/fdfs/storage.conf
        sed -i "s/${OLD}/${NEW}/g" /etc/fdfs/mod_fastdfs.conf
        let index=$index+1
    elif [[ ! -z ${var} ]] && [[ $index -gt 0 ]];then
        APPEND="${APPEND}\ntracker_server=${var}"
        let index=$index+1
    fi
done

echo "APPEND-->$APPEND"
if [ ! -z ${APPEND} ];then
    sed -i "/tracker_server=/a\\${APPEND}" /etc/fdfs/client.conf
    sed -i "/tracker_server=/a\\${APPEND}" /etc/fdfs/storage.conf
    sed -i "/tracker_server=/a\\${APPEND}" /etc/fdfs/mod_fastdfs.conf
fi

if [ $SERVER == "single" ];then
    echo "start trackerd"
    /etc/init.d/fdfs_trackerd stop 2>/dev/null
    sleep 2
    /etc/init.d/fdfs_trackerd start
    sleep 2
    echo "start storage"
    /etc/init.d/fdfs_storaged stop 2>/dev/null
    sleep 2
    /etc/init.d/fdfs_storaged start
    echo "start nginx"
    /usr/local/nginx/sbin/nginx -s stop 2>/dev/null
    sleep 2
    /usr/local/nginx/sbin/nginx
elif [ $SERVER == "tracker" ];then
    echo "start trackerd"
    /etc/init.d/fdfs_trackerd stop 2>/dev/null
    sleep 2
    /etc/init.d/fdfs_trackerd start
elif [ $SERVER == "storage" ];then
    echo "start storage"
    /etc/init.d/fdfs_storaged stop 2>/dev/null
    sleep 2
    /etc/init.d/fdfs_storaged start
    echo "start nginx"
    /usr/local/nginx/sbin/nginx -s stop 2>/dev/null
    sleep 2
    /usr/local/nginx/sbin/nginx
fi
tail -f /dev/null
