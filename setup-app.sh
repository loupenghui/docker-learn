#!/bin/bash

echo "关闭易联相关服务"

function stop_docker () {
	msg=`docker ps -a| grep $1`
    if [[ ! -n "$msg" ]];then
	  echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】$1 已关闭"
	else
	  echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】正在关闭$1 ....."
	  sudo docker stop $1
	  sudo docker rm $1
	  echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】$1 已关闭"
	fi
}

stop_docker ec-nginx
stop_docker ec-firmware
stop_docker ec-easytong
stop_docker ec-sdk
stop_docker ec-flowchart
stop_docker ec-serviceapi
stop_docker ec-api
stop_docker ec-basedefinition
stop_docker ec-monitor
stop_docker ec-authorization



echo "请等待5s，确保成功关闭后再启动容器"
sleep 5


chmod +x global.sh
source ./global.sh

echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】DOCKER_DATA_PATH变量:${DOCKER_DATA_PATH}"
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】PUB_IP变量:${PUB_IP}"

sed -i 's@${PUB_IP}@'${PUB_IP}'@g' ./conf/flowchart-server.yaml
sed -i 's@${PUB_IP}@'${PUB_IP}'@g' ./conf/serviceapi-server.yaml
sed -i 's@${PUB_IP}@'${PUB_IP}'@g' ./conf/api-server.yaml
sed -i 's@${PUB_IP}@'${PUB_IP}'@g' ./conf/firmware-server.yaml
sed -i 's@${PUB_IP}@'${PUB_IP}'@g' ./conf/sdk-server.yaml
sed -i 's@${PUB_IP}@'${PUB_IP}'@g' ./conf/monitor-server.yaml
sed -i 's@${PUB_IP}@'${PUB_IP}'@g' ./conf/authorization-application.yml
sed -i 's@${PUB_IP}@'${PUB_IP}'@g' ./conf/easytong-application.yml
sed -i 's@${PUB_IP}@'${PUB_IP}'@g' ./conf/basedefinition-application.yml

sed -i 's@${DOCKER_DATA_PATH}@'${DOCKER_DATA_PATH}'@g' ./conf/flowchart-server.yaml
sed -i 's@${DOCKER_DATA_PATH}@'${DOCKER_DATA_PATH}'@g' ./conf/serviceapi-server.yaml
sed -i 's@${DOCKER_DATA_PATH}@'${DOCKER_DATA_PATH}'@g' ./conf/api-server.yaml
sed -i 's@${DOCKER_DATA_PATH}@'${DOCKER_DATA_PATH}'@g' ./conf/firmware-server.yaml
sed -i 's@${DOCKER_DATA_PATH}@'${DOCKER_DATA_PATH}'@g' ./conf/sdk-server.yaml
sed -i 's@${DOCKER_DATA_PATH}@'${DOCKER_DATA_PATH}'@g' ./conf/monitor-server.yaml
sed -i 's@${DOCKER_DATA_PATH}@'${DOCKER_DATA_PATH}'@g' ./conf/authorization-application.yml
sed -i 's@${DOCKER_DATA_PATH}@'${DOCKER_DATA_PATH}'@g' ./conf/easytong-application.yml
sed -i 's@${DOCKER_DATA_PATH}@'${DOCKER_DATA_PATH}'@g' ./conf/basedefinition-application.yml

sed -i 's@${NSP_ADDRESS}@'${NSP_ADDRESS}'@g' ./conf/monitor-server.yaml

echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】替换配置文件变量完成"



docker load --input ./app/authorization.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入authorization镜像完成"
docker run --name ec-authorization --restart=always --net host -d --privileged=true \
    -v $PWD/conf/authorization-application.yml:/root/application.yml \
    -v ${DOCKER_DATA_PATH}/authorization:${DOCKER_DATA_PATH} \
    zhengyuan/authorization

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动authorization完成"


docker load --input ./app/monitor.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入monitor镜像完成"
docker run --name ec-monitor --restart=always --net host -d --privileged=true \
    -v $PWD/conf/monitor-server.yaml:/root/server.yaml \
    -v ${DOCKER_DATA_PATH}/monitor:${DOCKER_DATA_PATH} \
    zhengyuan/monitor

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动monitor完成"


docker load --input ./app/basedefinition.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入basedefinition镜像完成"
docker run --name ec-basedefinition --restart=always --net host -d --privileged=true \
    -v $PWD/conf/basedefinition-application.yml:/root/application.yml \
    -v ${DOCKER_DATA_PATH}/basedefinition:${DOCKER_DATA_PATH} \
    zhengyuan/basedefinition

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动authorization完成"


docker load --input ./app/api.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入api镜像完成"
docker run --name ec-api --restart=always --net host -d --privileged=true \
    -v $PWD/conf/api-server.yaml:/root/server.yaml \
    -v ${DOCKER_DATA_PATH}/api:${DOCKER_DATA_PATH} \
    zhengyuan/api

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动api完成"


docker load --input ./app/serviceapi.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入serviceapi镜像完成"
docker run --name ec-serviceapi --restart=always --net host -d --privileged=true \
    -v $PWD/conf/serviceapi-server.yaml:/root/server.yaml \
    -v ${DOCKER_DATA_PATH}/serviceapi:${DOCKER_DATA_PATH} \
    -v $PWD/conf/serviceapi-ProductDefaultThingModel:/root/ProductDefaultThingModel \
    zhengyuan/serviceapi

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动serviceapi完成"


docker load --input ./app/flowchart.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入flowchart镜像完成"
docker run --name ec-flowchart --restart=always --net host -d --privileged=true \
    -v $PWD/conf/flowchart-server.yaml:/root/server.yaml \
    -v ${DOCKER_DATA_PATH}/flowchart:${DOCKER_DATA_PATH} \
    zhengyuan/flowchart

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动flowchart完成"


docker load --input ./app/sdk.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入sdk镜像完成"
docker run --name ec-sdk --restart=always --net host -d --privileged=true \
    -v $PWD/conf/sdk-server.yaml:/root/server.yaml \
    -v ${DOCKER_DATA_PATH}/sdk:${DOCKER_DATA_PATH} \
    zhengyuan/sdk

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动sdk完成"


docker load --input ./app/easytong.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入easytong镜像完成"
docker run --name ec-easytong --restart=always -p 8011:8888 -d --privileged=true \
    -v $PWD/conf/easytong-application.yml:/root/application.yml \
    -v ${DOCKER_DATA_PATH}/easytong:${DOCKER_DATA_PATH} \
    zhengyuan/easytong

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动easytong完成"


docker load --input ./app/firmware.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入firmware镜像完成"
docker run --name ec-firmware --restart=always --net host -d --privileged=true \
    -v $PWD/conf/firmware-server.yaml:/root/server.yaml \
    -v ${DOCKER_DATA_PATH}/firmware:${DOCKER_DATA_PATH} \
    zhengyuan/firmware

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动firmware完成"


docker load --input ./base/nginx.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入nginx镜像完成"
docker run --name ec-nginx -p 8089:80 --privileged=true \
    -v ${DOCKER_DATA_PATH}/nginx/logs:/var/log/nginx \
    -v $PWD/conf/nginx.conf:/etc/nginx/nginx.conf \
    -v $PWD/app/webui:/usr/share/nginx/html:ro \
    -d nginx:1.17
echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s

echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动nginx 前端完成"

echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】应用全部启动完成"
