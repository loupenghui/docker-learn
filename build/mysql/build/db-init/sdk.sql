/*
 Navicat Premium Data Transfer

 Source Server         : 172.16.4.6_root-mariadb
 Source Server Type    : MariaDB
 Source Server Version : 100313
 Source Host           : 172.16.4.6:3306
 Source Schema         : iot_platform

 Target Server Type    : MariaDB
 Target Server Version : 100313
 File Encoding         : 65001

 Date: 10/04/2020 17:48:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- 在iot_platform数据库添加模拟设备信息表
use iot_platform;

-- ----------------------------
-- Table structure for emulator_device
-- ----------------------------
DROP TABLE IF EXISTS `emulator_device`;
CREATE TABLE `emulator_device`  (
  `product_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `connect` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '设备是否在运行，0离线，1在线',
  `heart_interval` int(255) NOT NULL DEFAULT 60 COMMENT '心跳时间间隔/s',
  `device_secret` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `product_secret` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `firmware_version` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '设备固件版本，默认1.0',
  PRIMARY KEY (`product_key`, `device_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备模拟器设备信息表';


-- ----------------------------
-- Table structure for emulator_device_event
-- ----------------------------
DROP TABLE IF EXISTS `emulator_device_event`;
CREATE TABLE `emulator_device_event`  (
  `product_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `event_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '事件名',
  `need_loop` tinyint(1) NULL DEFAULT 0 COMMENT '是否是定时事件',
  `event_interval` int(11) NOT NULL DEFAULT 0 COMMENT '事件循环发布时间间隔',
  PRIMARY KEY (`product_key`, `device_name`, `event_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '模拟设备事件记录表';


-- ----------------------------
-- Table structure for emulator_device_service
-- ----------------------------
DROP TABLE IF EXISTS `emulator_device_service`;
CREATE TABLE `emulator_device_service`  (
  `product_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `topic_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订阅的命令名称',
  PRIMARY KEY (`product_key`, `device_name`, `topic_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '模拟设备订阅主题表';
