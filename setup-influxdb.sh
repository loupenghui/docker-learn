#! /bin/bash
# 一键安装influxdb
BASE_PATH="/opt/monitor-platform/server-install"
TARGET_URL="/opt/monitor-platform/monitor"
CONTAINER_NAME="influxdb"
TAG="1.5.2"
IS_EXISTS_IMAGE_NAME="false"
IS_EXISTS_CONTAINER="false"
IS_EXISTS_CONTAINER_RUNGING="false"
START_CONTAINER_CHECK_MAX_TIMES=3
START_CONTAINER_CHECK_CURRENT=1
basepath=$(cd `dirname $0`; pwd)
NETWORK_NAME="host"
#端口
FIRE_PORT="8086"
echo "*****************************执行安装${CONTAINER_NAME}:${TAG}*********************************"
# ========================下载镜像======================================
for i in [ `docker images | grep $TAG` ]; do
	if [ "$i" == "$CONTAINER_NAME" ]; then
		IS_EXISTS_IMAGE_NAME="true"
		break
	fi
done
if [[ $IS_EXISTS_IMAGE_NAME == "true"  ]]; then
	echo "本地已存在${CONTAINER_NAME}:${TAG}镜像，不再重新安装......"
else
	echo "本地不存在${CONTAINER_NAME}:${TAG}镜像，正在安装......."
	sudo docker load --input $BASE_PATH/setup-packege/images/$CONTAINER_NAME.tar
fi
IS_FIREWALLD_OPEN=`systemctl status firewalld.service |grep active|awk '{print $2}'`;
if [ $IS_FIREWALLD_OPEN != "inactive" ];then 
	echo "********************正在检查端口$FIRE_PORT是否开启***********************"
	IS_EXIST=`firewall-cmd --zone=public --query-port=$FIRE_PORT/tcp`;
	if [ $IS_EXIST != yes ];then 
		echo "********************正在开启端口$FIRE_PORT***********************"
		firewall-cmd --zone=public --add-port=$FIRE_PORT/tcp --permanent
		firewall-cmd --reload
		echo "********************端口$FIRE_PORT已开启***********************"
	else 
		echo "********************端口$FIRE_PORT已开启***********************"
	fi
fi
 # ====================创建镜像===========================================
if [[ $IS_EXISTS_CONTAINER == "false" ]]; then
	echo "检查influxdb容器是否创建......"
	for i in [ `docker ps -a` ]; do
		if [[ "$i" == "${CONTAINER_NAME}" ]]; then
			IS_EXISTS_CONTAINER="true"
			break
		fi
	done
	if [[ $IS_EXISTS_CONTAINER == "false" ]]; then
	    chmod a+x influxdb_create_user.sh
		if [[ -f "$basepath/influxdb_create_user.sh" ]]; then
			echo "检查到${CONTAINER_NAME}容器尚未创建!"
	        # 执行容器创建
			# 运行容器实例 --privileged=true 获取管理员权限
			echo "创建${CONTAINER_NAME}容器实例..."
			sudo docker run -d  --net $NETWORK_NAME --name influxdb_docker \
			-e TZ=Asia/Shanghai \
			--restart always \
			--privileged=true \
			-v $basepath/influxdb_create_user.sh:/etc/influxdb/scripts/influxdb_create_user.sh  \
			-v $TARGET_URL/influxdb:/var/lib/influxdb:rw \
			influxdb:$TAG
			echo "休眠等待1s以便Docker完成容器运行......"
			sleep 1s
	        echo "进入${CONTAINER_NAME}容器: docker exec -it influxdb_docker  /bin/bash -c 'sh /etc/influxdb/scripts/influxdb_create_user.sh'"
			# 进入容器并执行脚本：
			sudo docker exec -it influxdb_docker  /bin/bash -c "sh /etc/influxdb/scripts/influxdb_create_user.sh"
			echo "${CONTAINER_NAME}容器已创建完毕!"
			IS_EXISTS_CONTAINER_RUNGING=true
			docker cp /opt/monitor-platform/monitor/conf/influxdb-conf/influxdb.conf influxdb_docker:/etc/influxdb/influxdb.conf
			docker restart influxdb_docker
			sleep 2
		else
			echo "$basepath/influxdb_create_user.sh文件不存在，docker需要用此文件创建influxdb容器实例并创建用户"
			exit 1
		fi
	else
		echo "检查到influxdb容器已创建!"
	fi
fi
# ===================启动或重启容器===============================
if [[ $IS_EXISTS_CONTAINER == "true" && $IS_EXISTS_CONTAINER_RUNGING == "false" ]]; then
    echo "下面最多执行三次$CONTAINER_NAME容器检查重启.."
	while [[ $START_CONTAINER_CHECK_CURRENT -le $START_CONTAINER_CHECK_MAX_TIMES ]]; do
		echo "检查$CONTAINER_NAME容器状态.....$START_CONTAINER_CHECK_CURRENT"
		for i in [ `docker ps ` ]; do
			if [[ "$i" == "$CONTAINER_NAME" ]]; then
				IS_EXISTS_CONTAINER_RUNGING="true"
				break
			fi
		done
		if [[ $IS_EXISTS_CONTAINER_RUNGING == "false" ]]; then
			echo "检查到$CONTAINER_NAME容器当前不在运行状态!"
			echo "启动$CONTAINER_NAME容器...."
			docker start influxdb_docker
			for i in [ `docker ps ` ]; do
				if [[ "$i" == "$CONTAINER_NAME" ]]; then
					IS_EXISTS_CONTAINER_RUNGING="true"
					break
				fi
			done
			if [[ $IS_EXISTS_CONTAINER_RUNGING == "true" ]]; then
				echo "$CONTAINER_NAME容器已经在运行!"
				break
			fi
		else
			echo "$CONTAINER_NAME容器已经在运行!"
			break
		fi
		START_CONTAINER_CHECK_CURRENT=$((START_CONTAINER_CHECK_CURRENT+1))
	done
	if [[ $IS_EXISTS_CONTAINER_RUNGING == "false" ]]; then
		echo "检查到$CONTAINER_NAME容器当前仍未运行,请联系相关人员进行处理"
		exit 1
	fi
fi
echo "*****************************${CONTAINER_NAME}:${TAG}安装完毕*********************************"

