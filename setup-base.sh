#!/bin/bash

chmod +x global.sh
source ./global.sh


echo "关闭易联相关组件"

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

stop_docker ec-mariadb
stop_docker ec-mongo
stop_docker ec-redis
stop_docker ec-rebrow
stop_docker ec-influxdb
stop_docker ec-filebeat-host1
stop_docker ec-logstash
stop_docker ec-elasticsearch
stop_docker ec-fastdfs
stop_docker zookeeper
stop_docker ec-kafka

echo "请等待5s，确保成功关闭后再启动容器"
sleep 5


echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】DOCKER_DATA_PATH变量:${DOCKER_DATA_PATH}"
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】PUB_IP变量:${PUB_IP}"

sed -i 's@${PUB_IP}@'${PUB_IP}'@g' ./conf/filebeat.yml
sed -i 's@${DOCKER_DATA_PATH}@'${DOCKER_DATA_PATH}'@g' ./conf/filebeat.yml

sed -i 's@${PUB_IP}@'${PUB_IP}'@g' ./conf/logstash.conf

sed -i 's@${PUB_IP}@'${PUB_IP}'@g' ./conf/vernemq.conf
sed -i 's@${PUB_IP}@'${PUB_IP}'@g' ./conf/nginx.conf


echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】替换配置文件变量完成"

sudo docker load --input ./base/mariadb.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入mariadb镜像完成"
sudo docker run --restart=always --name ec-mariadb  -p 3306:3306 -d  --privileged=true \
    -v ${DOCKER_DATA_PATH}/mariadb/data:/var/lib/mysql \
    -v $PWD/init:/docker-entrypoint-initdb.d \
    -v $PWD/mariadb_create_user.sh:/docker-entrypoint-initdb.d/mariadb_create_user.sh:ro \
    -e MYSQL_ROOT_PASSWORD=310012 \
    mariadb:10.5
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动mariadb数据库完成"

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s

sudo docker load --input ./base/mongo.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入mongo镜像完成"
sudo docker run --restart=always --name ec-mongo -p 27017:27017 -d --privileged=true \
    -v ${DOCKER_DATA_PATH}/mongo/data:/etc/mongo \
    -e MONGODB_DATABASE=easyconnect \
    -e MONGO_INITDB_ROOT_USERNAME=mongoadmin \
    -e MONGO_INITDB_ROOT_PASSWORD=mongoadmin \
    mongo:4.2.5
# sudo docker run --restart=always --name ec-mongo -p 27017:27017 -d --privileged=true -v /my/custom:/etc/mongo -d mongo --config /etc/mongo/mongod.conf
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动mongo数据库完成"

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s

sudo docker load --input ./base/redis.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入redis镜像完成"
sudo docker run --restart=always -d --name ec-redis -p 6379:6379 --privileged=true \
    -v $PWD/conf/redis.conf:/usr/local/etc/redis/redis.conf redis:5.0.8 redis-server /usr/local/etc/redis/redis.conf
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动redis数据库完成"

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s

sudo docker load --input ./base/rebrow.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入rebrow reidis web gui镜像完成"
sudo docker run --restart=always -d -p 5004:5004 --name ec-rebrow --link ec-redis:ec-redis marian/rebrow
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动rebrow reidis web gui完成"

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s

sudo docker load --input ./base/influxdb.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入influxdb镜像完成"
sudo docker run --name ec-influxdb --restart=always -d -p 8086:8086 --privileged=true \
    -e TZ=Asia/Shanghai \
    -e INFLUXDB_ADMIN_USER=admin \
    -e INFLUXDB_ADMIN_PASSWORD=hzsun@310012 \
    -v $PWD/influxdb_create_user.sh:/etc/influxdb/scripts/influxdb_create_user.sh  \
    -v ${DOCKER_DATA_PATH}/influxdb/data:/var/lib/influxdb \
    influxdb:1.7.10
echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s
sudo docker exec -it ec-influxdb  /bin/bash -c "sh /etc/influxdb/scripts/influxdb_create_user.sh"
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动influxdb数据库完成"

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s

sudo docker load --input ./base/filebeat.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入filebeat镜像完成"
sudo docker run --name ec-filebeat-host1 --restart=always -d --privileged=true \
    -v $PWD/conf/filebeat.yml:/usr/share/filebeat/filebeat.yml \
    elastic/filebeat:6.6.1
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动filebeat完成"

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s

sudo docker load --input ./base/logstash.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入logstash镜像完成"
sudo docker run --name ec-logstash --restart=always -d -p 5044:5044 --privileged=true \
    -v $PWD/conf/logstash.conf:/usr/share/logstash/pipeline/logstash.conf logstash:6.8.8
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动logstash完成"

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s

sudo docker load --input ./base/elasticsearch.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入es镜像完成"
sudo docker run --name ec-elasticsearch --restart=always -p 9200:9200 -p 9300:9300 --privileged=true \
    -e "discovery.type=single-node" \
    -d \
    -v ${DOCKER_DATA_PATH}/elasticsearch/data:/usr/share/elasticsearch/data \
    elasticsearch:6.8.8
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动es完成"

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s

sudo docker load --input ./base/go-fastdfs.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入go-fastdfs镜像完成"
sudo docker run --name ec-fastdfs --restart=always -p 10036:8080 -d --privileged=true \
    -v ${DOCKER_DATA_PATH}/fastdfs/data:/data \
    -e GO_FASTDFS_DIR=/data sjqzhang/go-fastdfs
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动go-fastdfs完成"

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s

sudo docker load --input ./base/zookeeper.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入zookeeper镜像完成"
sudo docker run -d --name zookeeper -p 2181:2181 -t wurstmeister/zookeeper:latest
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动zookeeper完成"

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s

sudo docker load --input ./base/kafka.tar.gz
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】载入kafka镜像完成"
sudo docker run -d --name ec-kafka --publish 9092:9092 --privileged=true \
    --link zookeeper \
    --env KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181 \
    --env KAFKA_ADVERTISED_HOST_NAME=${PUB_IP} \
    --env KAFKA_ADVERTISED_PORT=9092 \
    --volume /etc/localtime:/etc/localtime \
    wurstmeister/kafka:2.12-2.3.0
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】启动kafka完成"

echo "休眠等待1s以便Docker完成容器运行......"
sleep 1s


#以下步骤并不成功，必须手动更改配置文件，尝试中
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】开始安装vernemq......."
yum install -y ./base/vernemq-1.9.1.centos7.x86_64.rpm
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】安装vernemq成功"
systemctl enable vernemq
/bin/cp ./conf/vernemq.conf /etc/vernemq
/bin/cp ./base/redis.lua /usr/share/vernemq/lua/auth/
echo "【$(date "+%Y:%m:%d-%vimH:%M:%S") 】若长时间启动未成功，请按Ctrl+C退出命令后手动更新/etc/vernemq/vernemq.conf"
systemctl restart vernemq
echo "【$(date "+%Y:%m:%d-%H:%M:%S") 】vernemq启动成功"

