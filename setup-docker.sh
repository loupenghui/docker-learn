#!/bin/sh
# 一键安装docker
echo "*************** 开始执行安装docker ******************"
echo "=============== 移除旧的版本 ========================"
sudo yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine					  
echo "============== 安装一些必要的系统工具 ==============="
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
echo "============== 添加软件源信息 ======================="
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
echo "============== 开始安装docker ======================="	
sudo yum -y install docker-ce
if [ $? == 0 ]; then
	echo "============== 启动docker服务 ======================="
	sudo systemctl start docker
else
	echo "==> docker安装失败!!请重新尝试";
	exit;
fi
echo "============== 检查docker版本信息 ==================="
sudo docker version 
echo "************** docker安装完成 **************************"
echo "============== 开启docker外网配置 ==================="
sed -i '14c ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375 -H unix://var/run/docker.sock -H tcp://0.0.0.0:7654'  /usr/lib/systemd/system/docker.service
echo "========== docker重新读取配置文件并重启 ============="
systemctl daemon-reload
systemctl restart docker




				  

