# 易联打包、安装部署及发布

## Quick Start


### 编译

在windows上编译程序，双击package-docker.bat执行一键编译会在%gopath%\src下生成build目录，手动将相应的包拷贝到composer\build相应目录下 

#####注意：
* 1.请确认package-docker.bat编码方式为ANSI,否则中文乱码，需使用记事本编辑-另存为-编码选择ANSI
* 2.package-docker.bat仅支持放在%gopath%\src下或其一级子目录下

### 1、 搭建打包环境
* 系统需求：
Centos7及以上，注意：所有的脚本是基于Centos7编写和测试，不代表组件不能在各种版本上运行
* 软件需求：
安装Docker version 19.03，低版本某些特性不支持，请升级
如果docker pull速度过慢，可以加载国内镜像，提高下载速度
* linux执行setup-docker.sh一键安装最新版docker


### 2.打包
* 将composer包考进linux中,composer根目录执行chmod +x *.sh && sed -i 's/\r$//'  *.sh
* 运行build.sh
* 运行deploy.sh
* 下载deploy目录，作为发布包

### 3.发布
* 若部署安全运维平台，将服务地址改到global.sh的NSP_ADDRESS变量
* 拷贝发布包deploy到服务器，deploy根目录执行chmod +x *.sh && sed -i 's/\r$//'  *.sh  
* 设置环境参数文件global.sh
* 运行setup-base.sh
* 运行setup-app.sh
* 系统成功运行
 