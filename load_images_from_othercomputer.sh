#!/bin/bash
docker load --input ./base/mariadb.tar.gz
docker load --input ./base/mongo.tar.gz
docker load --input ./base/redis.tar.gz
docker load --input ./base/rebrow.tar.gz
docker load --input ./base/influxdb.tar.gz
docker load --input ./base/filebeat.tar.gz
docker load --input ./base/logstash.tar.gz
docker load --input ./base/elasticsearch.tar.gz
docker load --input ./base/go-fastdfs.tar.gz
