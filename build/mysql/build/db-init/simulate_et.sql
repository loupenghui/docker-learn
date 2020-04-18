/*
 Navicat Premium Data Transfer

 Source Server         : 172.16.4.6
 Source Server Type    : MariaDB
 Source Server Version : 100313
 Source Host           : 172.16.4.6:3306
 Source Schema         : simulate_et

 Target Server Type    : MariaDB
 Target Server Version : 100313
 File Encoding         : 65001

 Date: 16/04/2020 08:59:40
*/
CREATE DATABASE simulate_et DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for black_1
-- ----------------------------
DROP TABLE IF EXISTS simulate_et.`black`;
CREATE TABLE simulate_et.`black`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `userid` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名称',
  `createtime` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for device_1
-- ----------------------------
DROP TABLE IF EXISTS simulate_et.`device`;
CREATE TABLE simulate_et.`device`  (
  `deviceid` int(11) NOT NULL COMMENT '主键、设备id',
  `ecproductkey` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '易联设备类型',
  `ecproductname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '易联设备名称',
  `ecdeviceid` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '易联设备id',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '设备类型（商汤、324、模拟设备）',
  `tag` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '标签',
  `ecdevicename` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '易联设备名称',
  `isself` int(1) NULL DEFAULT NULL COMMENT '是否自助（1 自助 ；0 非自助）',
  `forbidden` int(1) NULL DEFAULT NULL COMMENT '是否禁用（0不禁用 ；1 禁用）',
  `createtime` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`deviceid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of device_1
-- ----------------------------
INSERT INTO simulate_et.`device` VALUES (7416, 'epmlkgJl3Dq', NULL, '', 'senselink', '', '测试', 1, 0, '2020-04-10 13:28:27');
INSERT INTO simulate_et.`device` VALUES (4742764, 'PjkGSKa67bA', NULL, 'ypLoJxDbBbeyevzzXZz2', 'simulate', '', '测试001', 1, 0, '2020-04-10 08:56:10');
INSERT INTO simulate_et.`device` VALUES (26433455, 'PjkGSKa67bA', NULL, 'ZV07U9RwakPp0HPDwPrA', 'simulate', '001', '0001', 1, 0, '2020-04-07 09:13:02');
INSERT INTO simulate_et.`device` VALUES (51856987, 'PjkGSKa67bA', NULL, 'cbEAs1pAJlsWGQeIGERE', 'simulate', '', 'sdsdfsf', 1, 0, '2020-04-07 09:13:48');
INSERT INTO simulate_et.`device` VALUES (73728891, 'PjkGSKa67bA', NULL, 'p9JLnXBbsSMmXHejwwBQ', 'simulate', '111', '虚拟设备123', 1, 0, '2020-04-10 11:23:51');
INSERT INTO simulate_et.`device` VALUES (90250471, 'PjkGSKa67bA', NULL, 'R4Ad9cdg4YDG1dAkqEdZ', 'simulate', '111', '1222', 1, 0, '2020-04-10 11:22:09');
INSERT INTO simulate_et.`device` VALUES (99532946, 'PjkGSKa67bA', NULL, 'rxV5KAo8bE5puyRHY1WW', 'simulate', '123|wer', '666', 1, 0, '2020-04-07 09:45:05');

-- ----------------------------
-- Table structure for group_1
-- ----------------------------
DROP TABLE IF EXISTS simulate_et.`group`;
CREATE TABLE simulate_et.`group`  (
  `groupid` int(11) NOT NULL COMMENT '黑名单组id',
  `groupname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '黑名单组名称',
  PRIMARY KEY (`groupid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for product_1
-- ----------------------------
DROP TABLE IF EXISTS simulate_et.`product`;
CREATE TABLE simulate_et.`product`  (
  `id` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `productkey` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品id',
  `productname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名称',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_1
-- ----------------------------
INSERT INTO simulate_et.`product` VALUES ('1', '62KybidAutv', '无线门锁', 'doorlock');
INSERT INTO simulate_et.`product` VALUES ('2', 'epmlkgJl3Dq', '商汤人脸设备', 'senselink');
INSERT INTO simulate_et.`product` VALUES ('3', '8lAXgo4ZbXN', 'YT324', 'yt');
INSERT INTO simulate_et.`product` VALUES ('4', 'PjkGSKa67bA', '模拟设备', 'simulate');

-- ----------------------------
-- Table structure for user_1
-- ----------------------------
DROP TABLE IF EXISTS simulate_et.`user`;
CREATE TABLE simulate_et.`user`  (
  `userid` int(11) NOT NULL COMMENT '用户id',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名称',
  `gender` int(1) NULL DEFAULT NULL COMMENT '性别（1：女 , 2：男）',
  `mobile` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `isblack` int(1) NULL DEFAULT NULL COMMENT '是否加入黑名单（1：是，0 ： 否）',
  `updatetime` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `createtime` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `photopath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '照片路径',
  PRIMARY KEY (`userid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_1
-- ----------------------------
INSERT INTO simulate_et.`user` VALUES (8016459, '刘伟', 2, '15270888244', 0, NULL, '2020-04-09 19:18:17', 'http://172.16.4.9:10036/group1/default/20200407/11/22/0/刘伟.jpg');
INSERT INTO simulate_et.`user` VALUES (8016572, '叶超', 2, '13979416274', 0, NULL, '2020-04-09 19:32:52', 'http://172.16.4.9:10036/group1/default/20200409/19/43/0/捕获.PNG');

SET FOREIGN_KEY_CHECKS = 1;
