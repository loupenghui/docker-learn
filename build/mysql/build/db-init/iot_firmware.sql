/*
 Navicat Premium Data Transfer

 Source Server         : 172.16.4.6_root-mariadb
 Source Server Type    : MariaDB
 Source Server Version : 100313
 Source Host           : 172.16.4.6:3306
 Source Schema         : iot_firmware

 Target Server Type    : MariaDB
 Target Server Version : 100313
 File Encoding         : 65001

 Date: 15/04/2020 10:02:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

create database iot_firmware;
use iot_firmware;

-- ----------------------------
-- Table structure for iot_firmware
-- ----------------------------
DROP TABLE IF EXISTS `iot_firmware`;
CREATE TABLE `iot_firmware`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '固件名称',
  `version` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '版本号',
  `product_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '产品key',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '下载路径',
  `create_time` timestamp(0) NULL DEFAULT current_timestamp COMMENT '上传时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '描述',
  `usable` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否可用，1-可用 0-被删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '固件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for iot_firmware_detail
-- ----------------------------
DROP TABLE IF EXISTS `iot_firmware_detail`;
CREATE TABLE `iot_firmware_detail`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `upgrade_id` int(11) NOT NULL DEFAULT 0 COMMENT '升级id，来自iot_upgrade表的id',
  `device_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '设备关键字',
  `finish_time` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '升级完成时间',
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '状态：1-待升级 2-升级中 3-成功 4-失败 5-未下发',
  `err_msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '失败信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备升级进度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for iot_firmware_device
-- ----------------------------
DROP TABLE IF EXISTS `iot_firmware_device`;
CREATE TABLE `iot_firmware_device`  (
  `device_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '设备key',
  `firmware_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '固件名称',
  `firmware_version` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '固件版本',
  PRIMARY KEY (`device_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '设备当前固件版本表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for iot_firmware_upgrade
-- ----------------------------
DROP TABLE IF EXISTS `iot_firmware_upgrade`;
CREATE TABLE `iot_firmware_upgrade`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增',
  `firmware_id` int(11) NOT NULL DEFAULT 0 COMMENT '固件id：来自iot_firmware的id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '固件下发名',
  `strategy` int(11) NOT NULL DEFAULT 0 COMMENT '升级策略：0-立刻 1-定时',
  `all_device` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否全部升级：1-全部 0-部分',
  `device_count` int(11) NOT NULL DEFAULT 0 COMMENT '下发设备数量',
  `device_total` int(11) NOT NULL DEFAULT 0 COMMENT '所有设备数量',
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '升级状态：1-待升级 2-升级中 3-成功',
  `start_time` timestamp(0) NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP COMMENT '升级时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '固件升级记录表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
