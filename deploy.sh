#!/bin/bash

echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】清空发布文件"
rm -rf ./deploy/*
mkdir ./deploy/app
mkdir ./deploy/base
mkdir ./deploy/init
mkdir ./deploy/conf

echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】清空发布文件完成"

cp -r ./build/mysql/build/db-init/*.*  ./deploy/init/
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】拷贝初始化文件完成"

cp -r ./build/redis/build/redis.conf  ./deploy/conf/
cp -r ./build/filebeat/build/filebeat.yml  ./deploy/conf/
cp -r ./build/logstash/build/logstash.conf  ./deploy/conf/
cp -r ./build/nginx/build/nginx.conf  ./deploy/conf/
cp -r ./build/nginx/build/nginx.conf  ./deploy/conf/

cp ./build/flowchart/build/server.yaml  ./deploy/conf/flowchart-server.yaml
cp ./build/serviceapi/build/server.yaml  ./deploy/conf/serviceapi-server.yaml
cp ./build/serviceapi/build/ProductDefaultThingModel  ./deploy/conf/serviceapi-ProductDefaultThingModel
cp ./build/api/build/server.yaml  ./deploy/conf/api-server.yaml
cp ./build/firmware/build/server.yaml  ./deploy/conf/firmware-server.yaml
cp ./build/sdk/build/server.yaml  ./deploy/conf/sdk-server.yaml
cp ./build/monitor/build/server.yaml  ./deploy/conf/monitor-server.yaml
cp ./build/authorization/build/application.yml  ./deploy/conf/authorization-application.yml
cp ./build/easytong/build/application.yml  ./deploy/conf/easytong-application.yml
cp ./build/basedefinition/build/application.yml  ./deploy/conf/basedefinition-application.yml

echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】拷贝配置文件完成"

cp ./build/vernemq/build/vernemq-1.9.1.centos7.x86_64.rpm ./deploy/base/
cp ./build/vernemq/build/vernemq.conf ./deploy/conf/
cp ./build/vernemq/build/redis.lua ./deploy/base/
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】拷贝vernemq完成"

cp -r ./build/webui/build/webui/ ./deploy/app/webui/
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】拷贝webui完成"


cp ./setup.sh ./deploy/setup.sh
cp ./global.sh ./deploy/global.sh
cp ./setup-app.sh ./deploy/setup-app.sh
cp ./setup-base.sh ./deploy/setup-base.sh
cp ./mariadb_create_user.sh ./deploy/mariadb_create_user.sh
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】打包shell进deploy"

docker save mariadb:10.5 > ./deploy/base/mariadb.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存mariadb镜像完成"

docker save redis:5.0.8  > ./deploy/base/redis.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存redis镜像完成"

docker save marian/rebrow  > ./deploy/base/rebrow.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存redis rebrow web gui镜像完成"

docker save mongo:4.2.5  > ./deploy/base/mongo.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存mongodb镜像完成"

docker save nginx:1.17   > ./deploy/base/nginx.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存nginx镜像完成"

docker save influxdb:1.7.10  > ./deploy/base/influxdb.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存influxdb镜像完成"

docker save elastic/filebeat:6.6.1  > ./deploy/base/filebeat.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存filebeat镜像完成"

docker save logstash:6.8.8   > ./deploy/base/logstash.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存logstash镜像完成"

docker save elasticsearch:6.8.8  > ./deploy/base/elasticsearch.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存es6镜像完成"

docker save sjqzhang/go-fastdfs  > ./deploy/base/go-fastdfs.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存go-fastdfs镜像完成"

docker save wurstmeister/zookeeper  > ./deploy/base/zookeeper.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存zookeeper镜像完成"

docker save wurstmeister/kafka:2.12-2.3.0  > ./deploy/base/kafka.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存kafka镜像完成"



docker save zhengyuan/authorization  > ./deploy/app/authorization.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存authorization镜像完成"

docker save zhengyuan/monitor   > ./deploy/app/monitor.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存monitor镜像完成"

docker save zhengyuan/basedefinition  > ./deploy/app/basedefinition.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存basedefinition镜像完成"

docker save zhengyuan/api  > ./deploy/app/api.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存api镜像完成"

docker save zhengyuan/serviceapi  > ./deploy/app/serviceapi.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存serviceapi镜像完成"

docker save zhengyuan/flowchart   > ./deploy/app/flowchart.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存flowchart镜像完成"

docker save zhengyuan/sdk   > ./deploy/app/sdk.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存sdk镜像完成"

docker save zhengyuan/easytong   > ./deploy/app/easytong.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存easytong镜像完成"

docker save zhengyuan/firmware   > ./deploy/app/firmware.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】保存firmware镜像完成"

