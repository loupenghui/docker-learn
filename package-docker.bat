@echo off
echo "#######################��ʼһ�����#############################"

if "src" NEQ "%cd:~-3%" cd ../
if "src" NEQ "%cd:~-3%" echo "Ŀ¼����������������gopathĿ¼��src��ִ��" && goto errorstop

if not exist build md build




SET CGO_ENABLED=0
SET GOOS=linux
SET GOARCH=amd64

echo "===========================��ʼ����flowchart============================="
if exist build\flowchart\build (
	rd /s /q build\flowchart\build
)
md build\flowchart\build
cd flowchart
go build main.go
move main ..\build\flowchart\build\flowchart
copy server-production.yaml ..\build\flowchart\build\server.yaml
echo "==========================flowchart�������=============================="
cd ..\
echo "***********************�Զ�����Dockerfile**************************"
echo FROM centos:7>build\flowchart\Dockerfile
echo WORKDIR /root>>build\flowchart\Dockerfile
echo COPY build/flowchart .>>build\flowchart\Dockerfile
echo RUN ["chmod","+x","flowchart"]>>build\flowchart\Dockerfile
echo ENTRYPOINT ["./flowchart"]>>build\flowchart\Dockerfile



echo "===========================��ʼ����easyconnect-serviceapi============================="
if exist build\serviceapi\build (
	rd /s /q build\serviceapi\build
)
md build\serviceapi\build
cd easyconnect-serviceapi
go build main.go
move main ..\build\serviceapi\build\serviceapi
copy server-production.yaml ..\build\serviceapi\build\server.yaml
copy ProductDefaultThingModel ..\build\serviceapi\build\ProductDefaultThingModel
echo "==========================easyconnect-serviceapi�������=============================="
cd ..\
echo "***********************easyconnect-serviceapi�Զ�����Dockerfile**************************"
echo FROM centos:7>build\serviceapi\Dockerfile
echo WORKDIR /root>>build\serviceapi\Dockerfile
echo COPY build/serviceapi .>>build\serviceapi\Dockerfile
echo RUN ["chmod","+x","serviceapi"]>>build\serviceapi\Dockerfile
echo ENTRYPOINT ["./serviceapi"]>>build\serviceapi\Dockerfile


echo "===========================��ʼ����easyconnect-api============================="
if exist build\api\build (
	rd /s /q build\api\build
)
md build\api\build
cd easyconnect-api
go build main.go
move main ..\build\api\build\api
copy server-production.yaml ..\build\api\build\server.yaml
echo "==========================easyconnect-api�������=============================="
cd ..\
echo "***********************easyconnect-api�Զ�����Dockerfile**************************"
echo FROM centos:7>build\api\Dockerfile
echo WORKDIR /root>>build\api\Dockerfile
echo COPY build/api .>>build\api\Dockerfile
echo RUN ["chmod","+x","api"]>>build\api\Dockerfile
echo ENTRYPOINT ["./api"]>>build\api\Dockerfile


echo "===========================��ʼ����easyconnect-firmware============================="
if exist build\firmware\build (
	rd /s /q build\firmware\build
)
md build\firmware\build
cd easyconnect-firmware
go build main.go
move main ..\build\firmware\build\firmware
copy server-production.yaml ..\build\firmware\build\server.yaml
echo "==========================easyconnect-firmware�������=============================="
cd ..\
echo "***********************easyconnect-firmware�Զ�����Dockerfile**************************"
echo FROM centos:7>build\firmware\Dockerfile
echo WORKDIR /root>>build\firmware\Dockerfile
echo COPY build/firmware .>>build\firmware\Dockerfile
echo RUN ["chmod","+x","firmware"]>>build\firmware\Dockerfile
echo ENTRYPOINT ["./firmware"]>>build\firmware\Dockerfile


echo "===========================��ʼ����easyconnect-sdk============================="
if exist build\sdk\build (
	rd /s /q build\sdk\build
)
md build\sdk\build
cd easyconnect-sdk
go build main.go
move main ..\build\sdk\build\sdk
copy server-production.yaml ..\build\sdk\build\server.yaml
echo "==========================easyconnect-sdk�������=============================="
cd ..\
echo "***********************easyconnect-sdk�Զ�����Dockerfile**************************"
echo FROM centos:7>build\sdk\Dockerfile
echo WORKDIR /root>>build\sdk\Dockerfile
echo COPY build/sdk .>>build\sdk\Dockerfile
echo RUN ["chmod","+x","sdk"]>>build\sdk\Dockerfile
echo ENTRYPOINT ["./sdk"]>>build\sdk\Dockerfile



echo "===========================��ʼ����easyconnect-monitor============================="
if exist build\monitor\build (
	rd /s /q build\monitor\build
)
md build\monitor\build
cd easyconnect-monitor
go build main.go
move main ..\build\monitor\build\monitor
copy server-production.yaml ..\build\monitor\build\server.yaml
echo "==========================easyconnect-monitor�������=============================="
cd ..\
echo "***********************easyconnect-monitor�Զ�����Dockerfile**************************"
echo FROM centos:7>build\monitor\Dockerfile
echo WORKDIR /root>>build\monitor\Dockerfile
echo COPY build/monitor .>>build\monitor\Dockerfile
echo RUN ["chmod","+x","monitor"]>>build\monitor\Dockerfile
echo ENTRYPOINT ["./monitor"]>>build\monitor\Dockerfile


echo "=====================��ʼ����easytong======================"
if exist build\easytong\build (
	rd /s /q build\easytong\build
)
md build\easytong\build
cd easytong
call mvn clean package -Dmaven.test.skip=true
copy target\easytong-0.0.1-SNAPSHOT.jar ..\build\easytong\build\easytong.jar
copy src\main\resources\application-production.yml ..\build\easytong\build\application.yml
echo "====================easytong�������======================="
cd ..\
echo "***************easytong�Զ�����Dockerfile*******************"
echo FROM adoptopenjdk/openjdk8:latest>build\easytong\Dockerfile
echo WORKDIR /root>>build\easytong\Dockerfile
echo COPY build/easytong.jar .>>build\easytong\Dockerfile
echo RUN ["chmod","+x","easytong.jar"]>>build\easytong\Dockerfile
echo ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","easytong.jar"]>>build\easytong\Dockerfile

echo "=====================��ʼ����BaseDefinition======================"
if exist build\basedefinition\build (
	rd /s /q build\basedefinition\build
)
md build\basedefinition\build
cd BaseDefinition
call mvn clean package -Dmaven.test.skip=true
copy target\BaseDefinition-1.0.0.jar ..\build\basedefinition\build\basedefinition.jar
copy src\main\resources\application-production.yml ..\build\basedefinition\build\application.yml
echo "====================basedefinition�������======================="
cd ..\
echo "***************basedefinition�Զ�����Dockerfile*******************"
echo FROM adoptopenjdk/openjdk8:latest >build\basedefinition\Dockerfile
echo WORKDIR /root>>build\basedefinition\Dockerfile
echo COPY build/basedefinition.jar .>>build\basedefinition\Dockerfile
echo RUN ["chmod","+x","basedefinition.jar"]>>build\basedefinition\Dockerfile
echo ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","basedefinition.jar"]>>build\basedefinition\Dockerfile


echo "=====================��ʼ����authorization======================"
if exist build\authorization\build (
	rd /s /q build\authorization\build
)
md build\authorization\build
cd authorization
call mvn clean package -Dmaven.test.skip=true
copy target\authorization-1.0.0.jar ..\build\authorization\build\authorization.jar
copy src\main\resources\application-production.yml ..\build\authorization\build\application.yml
echo "====================authorization�������======================="
cd ..\
echo "***************authorization�Զ�����Dockerfile*******************"
echo FROM adoptopenjdk/openjdk8:latest >build\authorization\Dockerfile
echo WORKDIR /root>>build\authorization\Dockerfile
echo COPY build/authorization.jar .>>build\authorization\Dockerfile
echo RUN ["chmod","+x","authorization.jar"]>>build\authorization\Dockerfile
echo ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","authorization.jar"]>>build\authorization\Dockerfile



echo "===========================��ʼ����WebUI============================="
if exist build\webui\build\webui (
	rd /s /q build\webui\build\webui
)
md build\webui\build\webui
cd WebUI\version1.0
call npm install cnpm -g --registry=https://registry.npm.taobao.org
call cnpm run build
xcopy dist\* ..\..\build\webui\build\webui\ /s /e /c /y /h /r
echo "==========================WebUI�������=============================="
cd ..\..\


echo "#############����ȫ����ɣ�����%gopath%\src\buildĿ¼����%gopath%\src\composer\build##################"

:errorstop
cmd