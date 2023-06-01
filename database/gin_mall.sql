/*
 Navicat Premium Data Transfer

 Source Server         : Ubuntu
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : gin_mall

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 01/06/2023 21:39:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `user_id` bigint(0) UNSIGNED NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_address_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `username` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password_digest` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `avatar` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_admin_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for carousel
-- ----------------------------
DROP TABLE IF EXISTS `carousel`;
CREATE TABLE `carousel`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `img_path` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `product_id` bigint(0) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_carousel_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `user_id` bigint(0) UNSIGNED NOT NULL,
  `product_id` bigint(0) UNSIGNED NOT NULL,
  `boss_id` bigint(0) UNSIGNED NOT NULL,
  `num` bigint(0) UNSIGNED NOT NULL,
  `max` bigint(0) UNSIGNED NOT NULL,
  `check` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_cart_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `category_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_category_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '2023-06-01 19:55:22', '2023-06-01 19:55:22', NULL, '分类1@');
INSERT INTO `category` VALUES (2, '2023-06-01 20:23:32', '2023-06-01 20:23:32', NULL, '分类1@');

-- ----------------------------
-- Table structure for favorite
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `user_id` bigint(0) UNSIGNED NOT NULL,
  `product_id` bigint(0) UNSIGNED NOT NULL,
  `boss_id` bigint(0) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_favorite_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of favorite
-- ----------------------------
INSERT INTO `favorite` VALUES (1, NULL, NULL, '2023-06-01 20:41:41', 5, 26, 4);
INSERT INTO `favorite` VALUES (2, '2023-06-01 20:40:53', '2023-06-01 20:40:53', '2023-06-01 20:42:08', 0, 26, 5);
INSERT INTO `favorite` VALUES (3, '2023-06-01 20:40:59', '2023-06-01 20:40:59', NULL, 0, 26, 5);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_notice_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `user_id` bigint(0) UNSIGNED NOT NULL,
  `product` bigint(0) UNSIGNED NOT NULL,
  `boss_id` bigint(0) UNSIGNED NOT NULL,
  `address_id` bigint(0) UNSIGNED NOT NULL,
  `num` bigint(0) NULL DEFAULT NULL,
  `order_num` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `type` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `money` double NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `category_id` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `info` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `img_path` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` double NULL DEFAULT NULL,
  `discount_price` double NULL DEFAULT NULL,
  `on_sale` tinyint(1) NULL DEFAULT 0,
  `num` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `boss_id` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `boss_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `boss_avatar` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_product_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (1, '2023-06-01 14:02:45', '2023-06-01 14:02:45', NULL, '测试商品', 1, '测试标题', '测试信息', './static/imgs/product/9572c88b-8191-41c7-9554-25cc5d0ddd6f.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (2, '2023-06-01 14:02:49', '2023-06-01 14:02:49', NULL, '测试商品', 1, '测试标题', '测试信息', './static/imgs/product/934af4b3-fa1d-4274-9594-a7d393b82c90.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (3, '2023-06-01 14:02:54', '2023-06-01 14:02:54', NULL, '测试商品', 2, '测试标题', '测试信息', './static/imgs/product/8e8e0051-3d88-49a1-b6b6-4d2248b2382c.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (4, '2023-06-01 14:02:56', '2023-06-01 14:02:56', NULL, '测试商品', 2, '测试标题', '测试信息', './static/imgs/product/7768d1d5-817a-4fdf-a7f4-78f41a1b78dc.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (5, '2023-06-01 14:02:57', '2023-06-01 14:02:57', NULL, '测试商品', 2, '测试标题', '测试信息', './static/imgs/product/1749f6fe-8240-4984-b381-8c155e22ddca.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (6, '2023-06-01 14:02:59', '2023-06-01 14:02:59', NULL, '测试商品', 2, '测试标题', '测试信息', './static/imgs/product/e6d2c8fa-4605-4078-8315-b3345ec6f7f8.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (7, '2023-06-01 14:03:02', '2023-06-01 14:03:02', NULL, '测试商品', 3, '测试标题', '测试信息', './static/imgs/product/15bab5d9-742b-4699-8db7-e39b1204892d.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (8, '2023-06-01 14:03:03', '2023-06-01 14:03:03', NULL, '测试商品', 3, '测试标题', '测试信息', './static/imgs/product/ce59a36e-1b75-4f15-8a2a-5d0278bcc2e5.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (9, '2023-06-01 14:03:04', '2023-06-01 14:03:04', NULL, '测试商品', 3, '测试标题', '测试信息', './static/imgs/product/2146ae60-93b3-480a-939e-727b9a60d305.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (10, '2023-06-01 14:03:05', '2023-06-01 14:03:05', NULL, '测试商品', 3, '测试标题', '测试信息', './static/imgs/product/00a55208-6d02-409e-b22c-f77b6c6324f4.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (11, '2023-06-01 14:03:06', '2023-06-01 14:03:06', NULL, '测试商品', 3, '测试标题', '测试信息', './static/imgs/product/25983cf0-859a-4a5a-b075-b40894044c04.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (12, '2023-06-01 14:03:07', '2023-06-01 14:03:07', NULL, '测试商品', 3, '测试标题', '测试信息', './static/imgs/product/9263fc98-06e6-49ce-ac0b-cae1314d3d81.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (13, '2023-06-01 14:03:08', '2023-06-01 14:03:08', NULL, '测试商品', 3, '测试标题', '测试信息', './static/imgs/product/851a9716-e432-445b-a236-783d4a1d25b9.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (14, '2023-06-01 14:03:09', '2023-06-01 14:03:09', NULL, '测试商品', 3, '测试标题', '测试信息', './static/imgs/product/ec31e793-3170-435e-9460-47c642b7a625.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (15, '2023-06-01 14:03:10', '2023-06-01 14:03:10', NULL, '测试商品', 3, '测试标题', '测试信息', './static/imgs/product/89f7b888-b565-4fe0-8b34-6406aef6c1a5.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (16, '2023-06-01 14:03:11', '2023-06-01 14:03:11', NULL, '测试商品', 3, '测试标题', '测试信息', './static/imgs/product/11d4f0e1-6b8c-4db4-aa43-61860668051d.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (17, '2023-06-01 14:03:12', '2023-06-01 14:03:12', NULL, '测试商品', 3, '测试标题', '测试信息', './static/imgs/product/44c6f9d8-68d0-4214-a924-27682ba33ce1.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (18, '2023-06-01 14:03:13', '2023-06-01 14:03:13', NULL, '测试商品', 3, '测试标题', '测试信息', './static/imgs/product/795b1c7d-d17f-4683-9cc3-28805ee13202.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (19, '2023-06-01 14:03:14', '2023-06-01 14:03:14', NULL, '测试商品', 3, '测试标题', '测试信息', './static/imgs/product/44fde948-1ea7-42fa-ad61-0aa081f6d44d.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (20, '2023-06-01 14:03:15', '2023-06-01 14:03:15', NULL, '测试商品', 3, '测试标题', '测试信息', './static/imgs/product/c371d891-0cd9-4d64-a514-004bbf48f99a.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (21, '2023-06-01 14:03:16', '2023-06-01 14:03:16', NULL, '测试商品', 3, '测试标题', '测试信息', './static/imgs/product/2bb73481-4bb2-4d9f-a382-eb64815c624c.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (22, '2023-06-01 14:10:41', '2023-06-01 14:10:41', NULL, '测试商品', 3, '测试标题', '测试信息', './static/imgs/product/b83a20b0-6e53-4bb5-9e8c-36bb9c4c96d0.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (23, '2023-06-01 14:13:03', '2023-06-01 14:13:03', NULL, '测试商品', 3, '测试标题', '测试信息', './static/imgs/product/a1fd8a68-3628-4136-88ad-cd457e64bb9e.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (24, '2023-06-01 18:18:23', '2023-06-01 18:18:23', NULL, '测试商品', 1, '测试标题', '测试信息', './static/imgs/product/335a6b70-c6b4-4d5b-8130-fb33fc7cb630.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (25, '2023-06-01 19:39:18', '2023-06-01 19:39:18', NULL, '测试商品11', 1, '测试标题11', '测试信息', './static/imgs/product/8e56d097-ae4e-45d2-9140-bf650cd8d964.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');
INSERT INTO `product` VALUES (26, '2023-06-01 20:52:06', '2023-06-01 20:52:06', NULL, '测试商品', 1, '测试标题', '测试信息', './static/imgs/product/975705a7-6d60-430a-a728-ec728b416671.jpg', 71.24, 47.83, 1, 765, 5, '@@@', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg');

-- ----------------------------
-- Table structure for product_img
-- ----------------------------
DROP TABLE IF EXISTS `product_img`;
CREATE TABLE `product_img`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `product_id` bigint(0) UNSIGNED NOT NULL,
  `img_path` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_product_img_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_img
-- ----------------------------
INSERT INTO `product_img` VALUES (1, '2023-06-01 19:39:18', '2023-06-01 19:39:18', NULL, 25, './static/imgs/product/8e56d097-ae4e-45d2-9140-bf650cd8d964.jpg');
INSERT INTO `product_img` VALUES (2, '2023-06-01 20:52:06', '2023-06-01 20:52:06', NULL, 26, './static/imgs/product/975705a7-6d60-430a-a728-ec728b416671.jpg');

-- ----------------------------
-- Table structure for record
-- ----------------------------
DROP TABLE IF EXISTS `record`;
CREATE TABLE `record`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `date` datetime(0) NULL DEFAULT NULL,
  `duration` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `protocol` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `service` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `dst_port` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `flag` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `src_host` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `dst_host` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `src_bytes` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `dst_bytes` bigint(0) UNSIGNED NULL DEFAULT NULL,
  `label` bigint(0) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_record_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` datetime(0) NULL DEFAULT NULL,
  `updated_at` datetime(0) NULL DEFAULT NULL,
  `deleted_at` datetime(0) NULL DEFAULT NULL,
  `username` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password_digest` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nick_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `avatar` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `money` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  INDEX `idx_user_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '2023-05-16 07:08:35', '2023-05-16 07:08:35', NULL, '2994056734', '', '$2a$12$Dn7R101bYXtrYMgngqKIou/ujou3v/wl.2IgoTg0F0FuwfN.TLRLu', 'yruns', '1', '333', '10000');
INSERT INTO `user` VALUES (2, '2023-05-16 07:28:35', '2023-05-16 07:28:35', NULL, '320349579', '', '$2a$12$L0OGJoy0n/gG0F3o98is5OxMmbA2SvTuVA139TxUn52NanWsh6nBO', 'yruns', '1', 'imgs/avatar.jpg', '10000');
INSERT INTO `user` VALUES (3, '2023-05-16 11:50:38', '2023-05-16 11:50:38', NULL, '9203495790', '', '$2a$12$UWd3qqGplqrPjJhOdAcrCOFUYAdG8ZegKUHIEpbRrweI0FZgG8O96', 'yruns', '1', 'imgs/avatar.jpg', '10000');
INSERT INTO `user` VALUES (5, '2023-05-16 12:48:30', '2023-05-31 22:48:03', NULL, '1134', 'yruns.sh@qq.com', '$2a$12$J3aIC5GPD5Cxbctv1pAI3Om7WmDEEDitykcTv6lng1TBubvCM0Sli', '@@@', '1', './static/imgs/76c7fbb7-01b9-41c1-a6ab-ecf64943df23.jpg', '10000');
INSERT INTO `user` VALUES (6, '2023-05-31 00:49:01', '2023-05-31 00:49:01', NULL, 'testok', '', '$2a$12$q.QBfIGxdPKxRYvVXcJHD..O1E0kDUNC5vXf5Fl2Yb9JhdYNqO/gq', 'yruns', '1', 'imgs/avatar.jpg', '10000');

SET FOREIGN_KEY_CHECKS = 1;
