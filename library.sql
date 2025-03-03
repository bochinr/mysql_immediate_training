/*
 Source Server         : ATA_MTS
 Source Server Type    : MySQL
 Source Schema         : library
 Target Server Type    : MySQL
*/

DROP DATABASE IF EXISTS `library`;
CREATE DATABASE `library`;
USE library;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book_sort
-- ----------------------------
DROP TABLE IF EXISTS `book_sort`;
CREATE TABLE `book_sort` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '书籍类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of book_sort
-- ----------------------------
BEGIN;
INSERT INTO `book_sort` VALUES (1, '小说');
INSERT INTO `book_sort` VALUES (2, '诗歌');
INSERT INTO `book_sort` VALUES (3, '传记');
INSERT INTO `book_sort` VALUES (4, '儿童读物');
COMMIT;

-- ----------------------------
-- Table structure for books
-- ----------------------------
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '编号',
  `sortid` int unsigned DEFAULT NULL COMMENT '类型编号',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '书名',
  `author` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '作者',
  `allnum` int unsigned NOT NULL DEFAULT '0' COMMENT '总本数',
  `freenum` int unsigned NOT NULL DEFAULT '0' COMMENT '剩余本数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of books
-- ----------------------------
BEGIN;
INSERT INTO `books` VALUES (1, 1, '英雄志', '金庸', 21, 8);
INSERT INTO `books` VALUES (2, 2, '一颗开花的树', '席慕容', 34, 15);
INSERT INTO `books` VALUES (3, 1, '盗墓笔记', '南派三叔', 15, 3);
INSERT INTO `books` VALUES (4, 1, '笑傲江湖', '金庸', 35, 16);
INSERT INTO `books` VALUES (5, 3, '梁启超传', '解玺璋', 20, 10);
INSERT INTO `books` VALUES (6, 2, '再别康桥', '徐志摩', 46, 22);
INSERT INTO `books` VALUES (7, 1, '悟空传', '今何在', 10, 5);
INSERT INTO `books` VALUES (8, 3, '苏东坡传', '林语堂', 16, 13);
INSERT INTO `books` VALUES (9, 2, '雪花的快乐', '徐志摩', 62, 27);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

SET NAMES gbk;