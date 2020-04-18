#!/bin/bash


#本地没有找到镜像才从远程pull
function checkOrPullImage(){
    IMAGE=("${1}")
    ARRAY=(${IMAGE//:/ })

    if [ ${#ARRAY[*]} == 1 ]
    then
        ARRAY[1]="latest"
    fi

    for i in [ `docker images | grep ${ARRAY[0]}` ]; do
        if [ "$i" == "${ARRAY[1]}" ]; then
            echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】镜像${IMAGE}已存在"
            return
        fi
    done
    echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】本地仓库未找到镜像${IMAGE}，开始从远程pull"
    docker pull $IMAGE
}


checkOrPullImage "wurstmeister/zookeeper"

checkOrPullImage "wurstmeister/kafka:2.12-2.3.0"

checkOrPullImage "mariadb:10.5"

checkOrPullImage "redis:5.0.8"

checkOrPullImage "marian/rebrow"

checkOrPullImage "mongo:4.2.5"

checkOrPullImage "nginx:1.17"

checkOrPullImage "influxdb:1.7.10"

checkOrPullImage "elastic/filebeat:6.6.1"

checkOrPullImage "logstash:6.8.8"

checkOrPullImage "elasticsearch:6.8.8"

checkOrPullImage "sjqzhang/go-fastdfs"

docker build -t zhengyuan/authorization ./build/authorization
docker build -t zhengyuan/monitor ./build/monitor
docker build -t zhengyuan/basedefinition ./build/basedefinition
docker build -t zhengyuan/api ./build/api
docker build -t zhengyuan/serviceapi ./build/serviceapi
docker build -t zhengyuan/flowchart ./build/flowchart
docker build -t zhengyuan/sdk ./build/sdk
docker build -t zhengyuan/easytong ./build/easytong
docker build -t zhengyuan/firmware ./build/firmware


