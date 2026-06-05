/*
 Navicat Premium Dump SQL

 Source Server         : newlocal
 Source Server Type    : MySQL
 Source Server Version : 90700 (9.7.0)
 Source Host           : localhost:3306
 Source Schema         : logbook

 Target Server Type    : MySQL
 Target Server Version : 90700 (9.7.0)
 File Encoding         : 65001

 Date: 05/06/2026 09:42:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  INDEX `cache_expiration_index`(`expiration` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cache
-- ----------------------------

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  INDEX `cache_locks_expiration_index`(`expiration` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cache_locks
-- ----------------------------

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `control` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES (1, 'Manual Login', 0, '2026-05-19 14:04:40', '2026-05-29 17:12:10');
INSERT INTO `config` VALUES (2, 'RFID Login', 1, '2026-05-19 14:04:40', '2026-05-29 17:12:10');

-- ----------------------------
-- Table structure for egate_data
-- ----------------------------
DROP TABLE IF EXISTS `egate_data`;
CREATE TABLE `egate_data`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `student_number` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lrn` bigint UNSIGNED NULL DEFAULT NULL,
  `rfid` bigint NULL DEFAULT NULL,
  `gatepass_no` bigint NULL DEFAULT NULL,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` int NULL DEFAULT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `contact` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sex` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `department` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `course` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `school_level` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `grade_level` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sched` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `gatepass_no`(`gatepass_no` ASC) USING BTREE,
  UNIQUE INDEX `rfid`(`rfid` ASC) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE,
  INDEX `egate_data_student_number_logged_at_index`(`student_number` ASC) USING BTREE,
  INDEX `egate_data_student_number_index`(`student_number` ASC) USING BTREE,
  INDEX `egate_data_lrn_index`(`lrn` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of egate_data
-- ----------------------------
INSERT INTO `egate_data` VALUES (1, '11', NULL, NULL, NULL, 'Maria Santos, Dela Cruz', 1, NULL, NULL, NULL, 'College of Computing Studies', 'BS Information Technology', NULL, '1st Year', '/storage/registration-images/K3GKnWabtexgjoXTOlO8a2IRefv2uiLWvAlzW6ej.png', '2026-05-19 23:19:45', '2026-05-29 12:12:27', NULL);
INSERT INTO `egate_data` VALUES (2, '22', NULL, NULL, NULL, 'John Paul, Villanueva, Reyes', 1, NULL, NULL, 'Male', 'College of Computing Studies', 'BS Computer Science', NULL, '2nd Year', NULL, '2026-05-19 23:19:45', '2026-05-22 10:54:56', NULL);
INSERT INTO `egate_data` VALUES (3, '33', NULL, NULL, 595930496, 'Angela Lopez, Garcia', 2, NULL, NULL, NULL, 'College of Engineering', 'BS Civil Engineering', NULL, '3rd Year', '/storage/registration-images/ASOaxWb8Y27IbgSWHB4F4jcUbckxPdxEBAYC8fL4.png', '2026-05-19 23:19:45', '2026-05-29 15:31:38', 1);
INSERT INTO `egate_data` VALUES (4, '66', 44, NULL, NULL, 'Carlo, Ramos, Mendoza', 1, NULL, NULL, 'Male', 'College of Business Administration', 'BS Accountancy', NULL, '4th Year', NULL, '2026-05-19 23:19:45', '2026-05-22 10:54:59', NULL);
INSERT INTO `egate_data` VALUES (5, '3762720653', NULL, NULL, NULL, 'Bea Fernandez, Torres', 1, NULL, NULL, NULL, 'College of Education', 'BSEd English', NULL, '2nd Year', NULL, '2026-05-19 23:19:45', '2026-05-26 09:02:04', NULL);
INSERT INTO `egate_data` VALUES (6, '2026-00006', NULL, NULL, NULL, 'Ethan, Diaz, Navarro', 1, NULL, NULL, 'Male', 'College of Computing Studies', 'BS Information Systems', NULL, '1st Year', NULL, '2026-05-19 23:19:45', '2026-05-22 10:55:05', NULL);
INSERT INTO `egate_data` VALUES (7, '2026-00007', NULL, NULL, NULL, 'Sofia, Lim, Aquino', 2, NULL, NULL, 'Female', 'College of Nursing', 'BS Nursing', NULL, '3rd Year', NULL, '2026-05-19 23:19:45', '2026-05-22 10:55:23', NULL);
INSERT INTO `egate_data` VALUES (8, '2026-00008', NULL, NULL, NULL, 'Miguel, Perez, Castro', 2, NULL, NULL, 'Male', 'College of Arts and Sciences', 'BA Communication', NULL, '4th Year', NULL, '2026-05-19 23:19:45', '2026-05-22 10:55:21', NULL);
INSERT INTO `egate_data` VALUES (9, '2026-00009', NULL, NULL, NULL, 'Patricia, Ocampo, Luna', 2, NULL, NULL, 'Female', 'College of Engineering', 'BS Electrical Engineering', NULL, '2nd Year', NULL, '2026-05-19 23:19:45', '2026-05-22 10:55:17', NULL);
INSERT INTO `egate_data` VALUES (10, '2026-00010', NULL, NULL, NULL, 'Noah, Rivera, Bautista', 2, NULL, NULL, 'Male', 'College of Hospitality Management', 'BS Hospitality Management', NULL, '1st Year', NULL, '2026-05-19 23:19:45', '2026-05-22 10:55:15', NULL);
INSERT INTO `egate_data` VALUES (11, '2026-00011', NULL, NULL, NULL, 'Claire Manalo, Santiago', 2, NULL, NULL, NULL, 'College of Education', 'BEEd General Education', NULL, '4th Year', NULL, '2026-05-19 23:19:45', '2026-05-22 23:02:39', NULL);
INSERT INTO `egate_data` VALUES (12, '2026-00012', NULL, NULL, 11223, 'Adrian Tan, Flores', 2, 'test@test.com', NULL, NULL, 'College of Computing Studies', 'BS Computer Science', NULL, '3rd Year', NULL, '2026-05-19 23:19:45', '2026-05-29 15:51:44', 1);
INSERT INTO `egate_data` VALUES (13, '23123', NULL, 123123, 1122, '123123', 1, NULL, '3423434', NULL, 'College of Nursing', 'BS Nursing', 'werwer', 'werewr', NULL, '2026-05-28 10:16:21', '2026-05-29 15:53:53', NULL);
INSERT INTO `egate_data` VALUES (14, '2545653123', NULL, 1231233, 112234, 'asdasd', 1, '213123@gmail.com', '3423434', NULL, 'College of Engineering', NULL, 'sdasdasd', 'asdasd', NULL, '2026-05-29 15:53:34', '2026-05-29 15:53:34', NULL);

-- ----------------------------
-- Table structure for egate_logs
-- ----------------------------
DROP TABLE IF EXISTS `egate_logs`;
CREATE TABLE `egate_logs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `egate_data_id` bigint UNSIGNED NULL DEFAULT NULL,
  `student_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `time_in` time NULL DEFAULT NULL,
  `time_out` time NULL DEFAULT NULL,
  `log_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `egate_logs_egate_data_id_foreign`(`egate_data_id` ASC) USING BTREE,
  CONSTRAINT `egate_logs_egate_data_id_foreign` FOREIGN KEY (`egate_data_id`) REFERENCES `egate_data` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 603 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of egate_logs
-- ----------------------------
INSERT INTO `egate_logs` VALUES (1, 2, '22', '2026-05-19 23:45:18', '2026-05-19 23:45:18', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (2, 1, '11', '2026-05-19 23:45:19', '2026-05-19 23:45:19', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (3, 3, '33', '2026-05-19 23:45:19', '2026-05-19 23:45:19', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (4, 1, '11', '2026-05-19 23:45:21', '2026-05-19 23:45:21', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (5, 2, '22', '2026-05-19 23:45:21', '2026-05-19 23:45:21', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (366, 4, '0595930496', '2026-05-21 10:12:50', '2026-05-21 10:12:50', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (367, 4, '0595930496', '2026-05-21 10:12:51', '2026-05-21 10:12:51', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (368, 4, '0595930496', '2026-05-21 10:12:52', '2026-05-21 10:12:52', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (369, 4, '0595930496', '2026-05-21 10:13:20', '2026-05-21 10:13:20', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (370, 4, '0595930496', '2026-05-21 10:13:22', '2026-05-21 10:13:22', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (371, 4, '0595930496', '2026-05-21 10:13:44', '2026-05-21 10:13:44', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (372, 4, '0595930496', '2026-05-21 10:13:46', '2026-05-21 10:13:46', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (373, 4, '0595930496', '2026-05-21 10:13:49', '2026-05-21 10:13:49', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (374, 4, '0595930496', '2026-05-21 10:13:56', '2026-05-21 10:13:56', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (375, 4, '0595930496', '2026-05-21 12:52:50', '2026-05-21 12:52:50', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (376, 4, '0595930496', '2026-05-21 12:53:06', '2026-05-21 12:53:06', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (377, 1, '11', '2026-05-22 01:54:12', '2026-05-22 01:54:12', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (378, 1, '11', '2026-05-22 01:54:14', '2026-05-22 01:54:14', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (379, 2, '22', '2026-05-22 01:54:16', '2026-05-22 01:54:16', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (380, 3, '33', '2026-05-22 01:54:17', '2026-05-22 01:54:17', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (381, 1, '11', '2026-05-22 01:56:17', '2026-05-22 01:56:17', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (382, 2, '22', '2026-05-22 01:56:17', '2026-05-22 01:56:17', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (383, 3, '33', '2026-05-22 01:56:18', '2026-05-22 01:56:18', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (384, 1, '11', '2026-05-25 10:03:24', '2026-05-25 10:03:24', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (385, 2, '22', '2026-05-25 10:03:25', '2026-05-25 10:03:25', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (386, 1, '11', '2026-05-25 10:03:25', '2026-05-25 10:03:25', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (387, 2, '22', '2026-05-25 10:03:26', '2026-05-25 10:03:26', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (388, 1, '11', '2026-05-25 10:03:29', '2026-05-25 10:03:29', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (389, 2, '22', '2026-05-25 10:03:29', '2026-05-25 10:03:29', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (390, 1, '11', '2026-05-25 10:03:30', '2026-05-25 10:03:30', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (391, 2, '22', '2026-05-25 10:03:30', '2026-05-25 10:03:30', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (392, 1, '11', '2026-05-25 16:58:26', '2026-05-25 16:58:26', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (393, 1, '11', '2026-05-25 16:58:26', '2026-05-25 16:58:26', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (394, 2, '22', '2026-05-25 16:58:27', '2026-05-25 16:58:27', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (395, 1, '11', '2026-05-25 16:58:27', '2026-05-25 16:58:27', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (396, 2, '22', '2026-05-25 16:58:28', '2026-05-25 16:58:28', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (397, 1, '11', '2026-05-25 16:58:29', '2026-05-25 16:58:29', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (398, 2, '22', '2026-05-25 16:58:29', '2026-05-25 16:58:29', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (399, 1, '11', '2026-05-25 16:58:30', '2026-05-25 16:58:30', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (400, 2, '22', '2026-05-25 16:58:30', '2026-05-25 16:58:30', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (401, 1, '11', '2026-05-25 16:58:31', '2026-05-25 16:58:31', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (402, 2, '22', '2026-05-25 16:58:31', '2026-05-25 16:58:31', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (403, 1, '11', '2026-05-25 16:58:32', '2026-05-25 16:58:32', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (404, 2, '22', '2026-05-25 16:58:32', '2026-05-25 16:58:32', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (405, 1, '11', '2026-05-25 16:58:33', '2026-05-25 16:58:33', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (406, 2, '22', '2026-05-25 16:58:33', '2026-05-25 16:58:33', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (407, 1, '11', '2026-05-25 16:58:34', '2026-05-25 16:58:34', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (408, 2, '22', '2026-05-25 16:58:35', '2026-05-25 16:58:35', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (409, 1, '11', '2026-05-26 10:31:27', '2026-05-26 10:31:27', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (410, 1, '11', '2026-05-26 10:31:30', '2026-05-26 10:31:30', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (411, 2, '22', '2026-05-26 10:31:32', '2026-05-26 10:31:32', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (412, 1, '11', '2026-05-26 10:31:32', '2026-05-26 10:31:32', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (413, 2, '22', '2026-05-26 10:31:33', '2026-05-26 10:31:33', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (414, 1, '11', '2026-05-26 10:31:34', '2026-05-26 10:31:34', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (415, 2, '22', '2026-05-26 10:31:34', '2026-05-26 10:31:34', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (416, 1, '11', '2026-05-26 10:31:36', '2026-05-26 10:31:36', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (417, 2, '22', '2026-05-26 10:31:36', '2026-05-26 10:31:36', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (418, 1, '11', '2026-05-26 10:31:37', '2026-05-26 10:31:37', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (419, 2, '22', '2026-05-26 10:31:38', '2026-05-26 10:31:38', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (420, 1, '11', '2026-05-26 10:31:41', '2026-05-26 10:31:41', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (421, 2, '22', '2026-05-26 10:31:41', '2026-05-26 10:31:41', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (422, 1, '11', '2026-05-26 10:35:29', '2026-05-26 10:35:29', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (423, 2, '22', '2026-05-26 10:35:32', '2026-05-26 10:35:32', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (424, 2, '22', '2026-05-26 10:35:33', '2026-05-26 10:35:33', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (425, 1, '11', '2026-05-26 10:35:34', '2026-05-26 10:35:34', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (426, 2, '22', '2026-05-26 10:35:35', '2026-05-26 10:35:35', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (427, 1, '11', '2026-05-26 10:35:36', '2026-05-26 10:35:36', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (428, 2, '22', '2026-05-26 10:35:38', '2026-05-26 10:35:38', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (429, 1, '11', '2026-05-26 10:35:40', '2026-05-26 10:35:40', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (430, 1, '11', '2026-05-26 10:35:45', '2026-05-26 10:35:45', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (431, 2, '22', '2026-05-26 10:35:47', '2026-05-26 10:35:47', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (432, 1, '11', '2026-05-26 10:35:50', '2026-05-26 10:35:50', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (433, 2, '22', '2026-05-26 10:35:51', '2026-05-26 10:35:51', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (434, 1, '11', '2026-05-26 10:35:52', '2026-05-26 10:35:52', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (435, 2, '22', '2026-05-26 10:35:52', '2026-05-26 10:35:52', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (436, 1, '11', '2026-05-26 10:35:55', '2026-05-26 10:35:55', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (437, 2, '22', '2026-05-26 10:35:56', '2026-05-26 10:35:56', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (438, 1, '11', '2026-05-26 10:35:57', '2026-05-26 10:35:57', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (439, 2, '22', '2026-05-26 10:35:58', '2026-05-26 10:35:58', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (440, 1, '11', '2026-05-26 10:35:59', '2026-05-26 10:35:59', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (441, 2, '22', '2026-05-26 10:35:59', '2026-05-26 10:35:59', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (442, 1, '11', '2026-05-26 10:36:01', '2026-05-26 10:36:01', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (443, 2, '22', '2026-05-26 10:36:01', '2026-05-26 10:36:01', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (444, 1, '11', '2026-05-26 10:36:02', '2026-05-26 10:36:02', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (445, 2, '22', '2026-05-26 10:36:03', '2026-05-26 10:36:03', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (446, 1, '11', '2026-05-26 10:36:05', '2026-05-26 10:36:05', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (447, 1, '11', '2026-05-26 10:36:09', '2026-05-26 10:36:09', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (448, 1, '11', '2026-05-26 10:36:13', '2026-05-26 10:36:13', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (449, 2, '22', '2026-05-26 10:36:14', '2026-05-26 10:36:14', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (450, 1, '11', '2026-05-26 10:36:17', '2026-05-26 10:36:17', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (451, 2, '22', '2026-05-26 10:36:21', '2026-05-26 10:36:21', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (452, 1, '11', '2026-05-26 10:36:24', '2026-05-26 10:36:24', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (453, 2, '22', '2026-05-26 10:36:25', '2026-05-26 10:36:25', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (454, 1, '11', '2026-05-26 10:36:25', '2026-05-26 10:36:25', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (455, 2, '22', '2026-05-26 10:36:26', '2026-05-26 10:36:26', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (456, 1, '11', '2026-05-26 10:36:27', '2026-05-26 10:36:27', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (457, 2, '22', '2026-05-26 10:36:28', '2026-05-26 10:36:28', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (458, 1, '11', '2026-05-26 10:36:28', '2026-05-26 10:36:28', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (459, 2, '22', '2026-05-26 10:36:29', '2026-05-26 10:36:29', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (460, 1, '11', '2026-05-26 10:37:26', '2026-05-26 10:37:26', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (461, 2, '22', '2026-05-26 10:37:27', '2026-05-26 10:37:27', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (462, 1, '11', '2026-05-26 10:37:28', '2026-05-26 10:37:28', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (463, 1, '11', '2026-05-26 10:37:30', '2026-05-26 10:37:30', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (464, 2, '22', '2026-05-26 10:37:30', '2026-05-26 10:37:30', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (465, 1, '11', '2026-05-26 10:43:03', '2026-05-26 10:43:03', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (466, 2, '22', '2026-05-26 10:43:03', '2026-05-26 10:43:03', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (467, 1, '11', '2026-05-26 10:43:04', '2026-05-26 10:43:04', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (468, 1, '11', '2026-05-26 10:43:06', '2026-05-26 10:43:06', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (469, 2, '22', '2026-05-26 10:43:07', '2026-05-26 10:43:07', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (470, 1, '11', '2026-05-26 10:43:08', '2026-05-26 10:43:08', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (471, 2, '22', '2026-05-26 10:43:08', '2026-05-26 10:43:08', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (472, 1, '11', '2026-05-26 10:43:12', '2026-05-26 10:43:12', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (473, 2, '22', '2026-05-26 10:43:13', '2026-05-26 10:43:13', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (474, 1, '11', '2026-05-26 10:43:14', '2026-05-26 10:43:14', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (475, 2, '22', '2026-05-26 10:43:14', '2026-05-26 10:43:14', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (476, 1, '11', '2026-05-26 10:43:16', '2026-05-26 10:43:16', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (477, 2, '22', '2026-05-26 10:43:16', '2026-05-26 10:43:16', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (478, 1, '11', '2026-05-26 10:43:17', '2026-05-26 10:43:17', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (479, 2, '22', '2026-05-26 10:43:18', '2026-05-26 10:43:18', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (480, 1, '11', '2026-05-26 10:43:19', '2026-05-26 10:43:19', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (481, 1, '11', '2026-05-26 10:48:37', '2026-05-26 10:48:37', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (482, 1, '11', '2026-05-26 10:48:40', '2026-05-26 10:48:40', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (483, 2, '22', '2026-05-26 10:48:41', '2026-05-26 10:48:41', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (484, 1, '11', '2026-05-26 10:48:45', '2026-05-26 10:48:45', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (485, 2, '22', '2026-05-26 10:48:46', '2026-05-26 10:48:46', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (486, 1, '11', '2026-05-26 10:52:54', '2026-05-26 10:52:54', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (487, 2, '22', '2026-05-26 10:52:55', '2026-05-26 10:52:55', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (488, 3, '33', '2026-05-26 11:31:27', '2026-05-26 11:31:27', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (489, 3, '33', '2026-05-26 11:31:28', '2026-05-26 11:31:28', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (490, 3, '33', '2026-05-26 11:31:28', '2026-05-26 11:31:28', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (491, 3, '33', '2026-05-26 11:31:29', '2026-05-26 11:31:29', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (492, 3, '33', '2026-05-26 11:31:38', '2026-05-26 11:31:38', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (493, 3, '33', '2026-05-26 11:31:40', '2026-05-26 11:31:40', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (494, 3, '33', '2026-05-26 11:31:42', '2026-05-26 11:31:42', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (495, 3, '33', '2026-05-26 11:31:42', '2026-05-26 11:31:42', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (496, 3, '33', '2026-05-26 11:31:42', '2026-05-26 11:31:42', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (497, 3, '33', '2026-05-26 11:31:43', '2026-05-26 11:31:43', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (498, 3, '33', '2026-05-26 11:31:44', '2026-05-26 11:31:44', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (499, 3, '33', '2026-05-26 11:31:45', '2026-05-26 11:31:45', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (500, 3, '33', '2026-05-26 11:31:46', '2026-05-26 11:31:46', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (501, 3, '33', '2026-05-26 11:31:46', '2026-05-26 11:31:46', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (502, 1, '11', '2026-05-26 12:49:11', '2026-05-26 12:49:11', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (503, 2, '22', '2026-05-26 12:49:14', '2026-05-26 12:49:14', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (504, 1, '11', '2026-05-26 12:49:15', '2026-05-26 12:49:15', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (505, 2, '22', '2026-05-26 12:49:16', '2026-05-26 12:49:16', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (506, 1, '11', '2026-05-26 12:49:32', '2026-05-26 12:49:32', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (507, 2, '22', '2026-05-26 12:49:32', '2026-05-26 12:49:32', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (508, 1, '11', '2026-05-26 12:50:56', '2026-05-26 12:50:56', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (509, 1, '11', '2026-05-26 12:50:58', '2026-05-26 12:50:58', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (510, 1, '11', '2026-05-26 12:51:01', '2026-05-26 12:51:01', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (511, 2, '22', '2026-05-26 12:51:02', '2026-05-26 12:51:02', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (512, 1, '11', '2026-05-26 12:51:03', '2026-05-26 12:51:03', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (513, 2, '22', '2026-05-26 12:51:03', '2026-05-26 12:51:03', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (514, 1, '11', '2026-05-26 12:51:07', '2026-05-26 12:51:07', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (515, 2, '22', '2026-05-26 12:51:08', '2026-05-26 12:51:08', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (516, 1, '11', '2026-05-26 12:51:08', '2026-05-26 12:51:08', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (517, 2, '22', '2026-05-26 12:51:09', '2026-05-26 12:51:09', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (518, 1, '11', '2026-05-26 12:51:09', '2026-05-26 12:51:09', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (519, 2, '22', '2026-05-26 12:51:10', '2026-05-26 12:51:10', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (520, 1, '11', '2026-05-26 12:51:12', '2026-05-26 12:51:12', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (521, 2, '22', '2026-05-26 12:51:13', '2026-05-26 12:51:13', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (522, 1, '11', '2026-05-26 13:02:27', '2026-05-26 13:02:27', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (523, 2, '22', '2026-05-26 13:02:31', '2026-05-26 13:02:31', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (524, 1, '11', '2026-05-26 13:02:32', '2026-05-26 13:02:32', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (525, 2, '22', '2026-05-29 10:45:09', '2026-05-29 10:45:09', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (526, 1, '11', '2026-05-29 10:45:10', '2026-05-29 10:45:10', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (527, 2, '22', '2026-05-29 10:45:10', '2026-05-29 10:45:10', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (528, 1, '11', '2026-05-29 10:45:11', '2026-05-29 10:45:11', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (529, 2, '22', '2026-05-29 10:56:07', '2026-05-29 10:56:07', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (530, 1, '11', '2026-05-29 10:56:15', '2026-05-29 10:56:15', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (531, 3, '33', '2026-05-29 10:56:19', '2026-05-29 10:56:19', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (532, 4, '66', '2026-05-29 10:56:20', '2026-05-29 10:56:20', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (533, 1, '11', '2026-05-29 10:56:36', '2026-05-29 10:56:36', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (534, 2, '22', '2026-05-29 10:57:49', '2026-05-29 10:57:49', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (535, 1, '11', '2026-05-29 10:57:51', '2026-05-29 10:57:51', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (536, 3, '33', '2026-05-29 10:57:53', '2026-05-29 10:57:53', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (537, 3, '33', '2026-05-29 11:11:37', '2026-05-29 11:11:37', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (538, 1, '11', '2026-05-29 11:13:53', '2026-05-29 11:13:53', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (539, 2, '22', '2026-05-29 11:13:54', '2026-05-29 11:13:54', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (540, 1, '11', '2026-05-29 11:13:55', '2026-05-29 11:13:55', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (541, 2, '22', '2026-05-29 11:13:56', '2026-05-29 11:13:56', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (542, 1, '11', '2026-05-29 11:13:57', '2026-05-29 11:13:57', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (543, 2, '22', '2026-05-29 11:13:57', '2026-05-29 11:13:57', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (544, 1, '11', '2026-05-29 11:13:58', '2026-05-29 11:13:58', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (545, 1, '11', '2026-05-29 11:22:55', '2026-05-29 11:22:55', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (546, 1, '11', '2026-05-29 11:22:57', '2026-05-29 11:22:57', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (547, 2, '22', '2026-05-29 11:22:58', '2026-05-29 11:22:58', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (548, 1, '11', '2026-05-29 11:22:59', '2026-05-29 11:22:59', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (549, 2, '22', '2026-05-29 11:23:01', '2026-05-29 11:23:01', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (550, 2, '22', '2026-05-29 11:23:02', '2026-05-29 11:23:02', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (551, 2, '22', '2026-05-29 11:23:03', '2026-05-29 11:23:03', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (552, 1, '11', '2026-05-29 11:25:32', '2026-05-29 11:25:32', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (553, 1, '11', '2026-05-29 11:25:34', '2026-05-29 11:25:34', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (554, 1, '11', '2026-05-29 11:25:37', '2026-05-29 11:25:37', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (555, 1, '11', '2026-05-29 11:32:12', '2026-05-29 11:32:12', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (556, 2, '22', '2026-05-29 11:32:14', '2026-05-29 11:32:14', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (557, 2, '22', '2026-05-29 11:32:16', '2026-05-29 11:32:16', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (558, 2, '22', '2026-05-29 11:32:19', '2026-05-29 11:32:19', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (559, 3, '33', '2026-05-29 11:34:09', '2026-05-29 11:34:09', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (560, 3, '33', '2026-05-29 11:34:31', '2026-05-29 11:34:31', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (561, 3, '33', '2026-05-29 11:35:08', '2026-05-29 11:35:08', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (562, 3, '33', '2026-05-29 11:35:10', '2026-05-29 11:35:10', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (563, 3, '33', '2026-05-29 11:35:22', '2026-05-29 11:35:22', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (564, 3, '33', '2026-05-29 11:35:43', '2026-05-29 11:35:43', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (565, 3, '33', '2026-05-29 11:35:46', '2026-05-29 11:35:46', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (566, 3, '33', '2026-05-29 11:35:59', '2026-05-29 11:35:59', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (567, 3, '33', '2026-05-29 11:37:23', '2026-05-29 11:37:23', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (568, 3, '33', '2026-05-29 11:40:30', '2026-05-29 11:40:30', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (569, 2, '22', '2026-05-29 11:45:08', '2026-05-29 11:45:08', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (570, 1, '11', '2026-05-29 11:45:09', '2026-05-29 11:45:09', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (571, 3, '33', '2026-05-29 11:45:10', '2026-05-29 11:45:10', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (572, 3, '33', '2026-05-29 11:45:10', '2026-05-29 11:45:10', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (573, 3, '33', '2026-05-29 11:45:11', '2026-05-29 11:45:11', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (574, 2, '22', '2026-05-29 11:45:12', '2026-05-29 11:45:12', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (575, 2, '22', '2026-05-29 11:45:13', '2026-05-29 11:45:13', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (576, 2, '22', '2026-05-29 11:45:14', '2026-05-29 11:45:14', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (577, 2, '22', '2026-05-29 11:45:15', '2026-05-29 11:45:15', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (578, 3, '33', '2026-05-29 11:47:37', '2026-05-29 11:47:37', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (579, 3, '33', '2026-05-29 11:47:41', '2026-05-29 11:47:41', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (580, 3, '33', '2026-05-29 11:47:45', '2026-05-29 11:47:45', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (581, 3, '33', '2026-05-29 11:47:46', '2026-05-29 11:47:46', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (582, 3, '33', '2026-05-29 11:47:47', '2026-05-29 11:47:47', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (583, 3, '33', '2026-05-29 11:47:48', '2026-05-29 11:47:48', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (584, 3, '33', '2026-05-29 11:47:48', '2026-05-29 11:47:48', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (585, 3, '33', '2026-05-29 11:47:49', '2026-05-29 11:47:49', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (586, 3, '33', '2026-05-29 11:47:50', '2026-05-29 11:47:50', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (587, 3, '33', '2026-05-29 11:48:28', '2026-05-29 11:48:28', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (588, 1, '11', '2026-05-29 12:12:46', '2026-05-29 12:12:46', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (589, 2, '22', '2026-05-29 12:12:48', '2026-05-29 12:12:48', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (590, 1, '11', '2026-05-29 12:12:48', '2026-05-29 12:12:48', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (591, 2, '22', '2026-05-29 12:12:49', '2026-05-29 12:12:49', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (592, 1, '11', '2026-05-29 12:12:49', '2026-05-29 12:12:49', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (593, 13, '23123', '2026-05-29 15:19:12', '2026-05-29 15:19:12', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (594, 13, '23123', '2026-05-29 15:19:20', '2026-05-29 15:19:20', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (595, 13, '23123', '2026-05-29 15:19:22', '2026-05-29 15:19:22', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (596, 13, '23123', '2026-05-29 15:20:25', '2026-05-29 15:20:25', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (597, 13, '23123', '2026-05-29 15:20:27', '2026-05-29 15:20:27', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (598, 3, '33', '2026-05-29 15:25:31', '2026-05-29 15:25:31', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (599, 3, '33', '2026-05-29 15:31:45', '2026-05-29 15:31:45', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (600, 3, '33', '2026-05-29 15:31:49', '2026-05-29 15:31:49', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (601, 3, '33', '2026-05-29 15:31:50', '2026-05-29 15:31:50', NULL, NULL, NULL);
INSERT INTO `egate_logs` VALUES (602, 3, '33', '2026-05-29 15:31:51', '2026-05-29 15:31:51', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for job_batches
-- ----------------------------
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `cancelled_at` int NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of job_batches
-- ----------------------------

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED NULL DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jobs_queue_index`(`queue` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of jobs
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '0001_01_01_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO `migrations` VALUES (3, '0001_01_01_000002_create_jobs_table', 1);
INSERT INTO `migrations` VALUES (4, '2026_05_15_000003_create_egate_logs_table', 1);
INSERT INTO `migrations` VALUES (5, '2026_05_18_155527_create_permission_tables', 1);
INSERT INTO `migrations` VALUES (6, '2026_05_18_162302_egate_logs', 1);
INSERT INTO `migrations` VALUES (7, '2026_05_18_200000_align_users_table_for_rbac', 1);
INSERT INTO `migrations` VALUES (8, '2026_05_19_000001_add_egate_data_id_to_egate_logs_table', 1);
INSERT INTO `migrations` VALUES (9, '2026_05_19_000002_add_lrn_to_egate_data_table', 1);
INSERT INTO `migrations` VALUES (10, '2026_05_19_000003_create_config_table', 1);
INSERT INTO `migrations` VALUES (11, '2026_05_19_000004_convert_egate_times_to_datetime', 1);
INSERT INTO `migrations` VALUES (12, '2026_05_21_000001_add_rfid_to_egate_data_table', 2);
INSERT INTO `migrations` VALUES (13, '2026_05_25_000001_rename_time_login_permission_to_time_out', 3);
INSERT INTO `migrations` VALUES (14, '2026_05_28_000001_rename_data_permissions_to_registration', 3);
INSERT INTO `migrations` VALUES (15, '2026_05_29_000001_add_gatepass_no_to_egate_data_table', 3);
INSERT INTO `migrations` VALUES (16, '2026_06_01_000001_rename_time_permissions_to_login_logout', 3);

-- ----------------------------
-- Table structure for model_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions`  (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`, `model_id`, `model_type`) USING BTREE,
  INDEX `model_has_permissions_model_id_model_type_index`(`model_id` ASC, `model_type` ASC) USING BTREE,
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of model_has_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for model_has_roles
-- ----------------------------
DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles`  (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`role_id`, `model_id`, `model_type`) USING BTREE,
  INDEX `model_has_roles_model_id_model_type_index`(`model_id` ASC, `model_type` ASC) USING BTREE,
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of model_has_roles
-- ----------------------------
INSERT INTO `model_has_roles` VALUES (1, 'App\\Models\\User', 1);
INSERT INTO `model_has_roles` VALUES (6, 'App\\Models\\User', 2);
INSERT INTO `model_has_roles` VALUES (9, 'App\\Models\\User', 3);
INSERT INTO `model_has_roles` VALUES (1, 'App\\Models\\User', 4);

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` bigint UNSIGNED NULL DEFAULT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'web',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `permissions_code_guard_name_unique`(`code` ASC, `guard_name` ASC) USING BTREE,
  INDEX `permissions_parent_id_foreign`(`parent_id` ASC) USING BTREE,
  CONSTRAINT `permissions_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `permissions` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 54 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of permissions
-- ----------------------------
INSERT INTO `permissions` VALUES (1, 'Users', 'users', NULL, 'web', '2026-05-19 14:03:31', '2026-05-19 14:03:31');
INSERT INTO `permissions` VALUES (4, 'Create Users', 'users.create', 1, 'web', '2026-05-19 14:03:31', '2026-05-19 14:03:31');
INSERT INTO `permissions` VALUES (5, 'Update Users', 'users.update', 1, 'web', '2026-05-19 14:03:31', '2026-05-19 14:03:31');
INSERT INTO `permissions` VALUES (6, 'Delete Users', 'users.delete', 1, 'web', '2026-05-19 14:03:31', '2026-05-19 14:03:31');
INSERT INTO `permissions` VALUES (9, 'Update User Passwords', 'users.update.pass', 1, 'web', '2026-05-21 01:30:40', '2026-05-21 02:59:39');
INSERT INTO `permissions` VALUES (10, 'View Users', 'users.view', 1, 'web', '2026-05-21 01:30:33', '2026-05-21 02:59:39');
INSERT INTO `permissions` VALUES (11, 'Roles', 'roles', NULL, 'web', '2026-05-21 01:30:25', '2026-05-21 01:30:29');
INSERT INTO `permissions` VALUES (17, 'View Roles', 'roles.view', 11, 'web', '2026-05-21 01:30:21', '2026-05-21 02:59:39');
INSERT INTO `permissions` VALUES (18, 'Create Roles', 'roles.create', 11, 'web', '2026-05-21 01:30:11', '2026-05-21 02:59:39');
INSERT INTO `permissions` VALUES (19, 'Update Roles', 'roles.update', 11, 'web', '2026-05-21 01:30:07', '2026-05-21 02:59:39');
INSERT INTO `permissions` VALUES (20, 'Delete Roles', 'roles.delete', 11, 'web', '2026-05-21 01:29:51', '2026-05-21 02:59:39');
INSERT INTO `permissions` VALUES (21, 'Student Logs', 'logs', NULL, 'web', '2026-05-21 01:29:55', '2026-05-22 10:44:06');
INSERT INTO `permissions` VALUES (22, 'View Logs', 'logs.view', 21, 'web', '2026-05-21 01:29:40', '2026-05-21 02:59:39');
INSERT INTO `permissions` VALUES (23, 'Registration', 'Data', NULL, 'web', '2026-05-21 01:26:52', '2026-06-05 09:40:37');
INSERT INTO `permissions` VALUES (24, 'View Registration', 'data.view', 23, 'web', '2026-05-21 01:27:05', '2026-06-05 09:40:37');
INSERT INTO `permissions` VALUES (25, 'Create Registration', 'data.create', 23, 'web', '2026-05-21 01:26:45', '2026-06-05 09:40:37');
INSERT INTO `permissions` VALUES (26, 'Update Registration', 'data.update', 23, 'web', '2026-05-21 01:27:37', '2026-06-05 09:40:37');
INSERT INTO `permissions` VALUES (27, 'Delete Registration', 'data.delete', 23, 'web', '2026-05-21 01:28:13', '2026-06-05 09:40:37');
INSERT INTO `permissions` VALUES (28, 'Print Registration', 'data.print', 23, 'web', '2026-05-21 01:29:31', '2026-06-05 09:40:37');
INSERT INTO `permissions` VALUES (29, 'Export Registration', 'data.export', 23, 'web', '2026-05-21 01:29:22', '2026-06-05 09:40:37');
INSERT INTO `permissions` VALUES (31, 'Delete Logs', 'logs.delete', 21, 'web', '2026-05-21 01:32:58', '2026-05-21 03:02:42');
INSERT INTO `permissions` VALUES (32, 'Print Logs', 'logs.print', 21, 'web', '2026-05-21 01:33:04', '2026-05-21 03:02:42');
INSERT INTO `permissions` VALUES (35, 'Export Logs', 'export.logs', 21, 'web', '2026-05-21 03:10:36', '2026-05-21 03:10:36');
INSERT INTO `permissions` VALUES (36, 'Login/Logout', 'login_logout', NULL, 'web', '2026-05-21 09:54:15', '2026-06-05 09:40:37');
INSERT INTO `permissions` VALUES (37, 'Login', 'login', 36, 'web', '2026-05-21 09:54:22', '2026-06-05 09:40:37');
INSERT INTO `permissions` VALUES (40, 'Logout', 'logout', 36, 'web', '2026-05-21 09:55:53', '2026-06-05 09:40:37');
INSERT INTO `permissions` VALUES (41, 'Employee Logs', 'emlog', NULL, 'web', '2026-05-22 10:39:37', '2026-05-22 10:39:40');
INSERT INTO `permissions` VALUES (42, 'View', 'emlog.view', 41, 'web', '2026-05-22 10:43:25', '2026-05-22 10:43:25');
INSERT INTO `permissions` VALUES (44, 'Print', 'emlog.print', 41, 'web', '2026-05-22 10:45:09', '2026-05-22 10:45:09');
INSERT INTO `permissions` VALUES (45, 'Delete', 'emlog.delete', 41, 'web', '2026-05-22 10:45:36', '2026-05-22 10:45:36');
INSERT INTO `permissions` VALUES (46, 'Setup Sched Schedule', 'setschedcehed', NULL, 'web', '2026-05-25 11:59:49', '2026-05-25 11:59:49');
INSERT INTO `permissions` VALUES (47, 'View', 'setschedcehed.view', 46, 'web', '2026-05-25 12:00:10', '2026-05-25 12:00:17');
INSERT INTO `permissions` VALUES (48, 'Create', 'setschedcehed.create', 46, 'web', '2026-05-25 12:00:34', '2026-05-25 12:00:34');
INSERT INTO `permissions` VALUES (49, 'Update', 'setschedcehed.update', 46, 'web', '2026-05-25 12:00:48', '2026-05-25 12:00:48');
INSERT INTO `permissions` VALUES (50, 'Delete', 'setschedcehed.delete', 46, 'web', '2026-05-25 12:02:12', '2026-05-25 12:02:12');
INSERT INTO `permissions` VALUES (51, 'Setup Sched Employee', 'setschedem', NULL, 'web', '2026-05-25 12:07:01', '2026-05-25 12:07:01');
INSERT INTO `permissions` VALUES (52, 'View', 'setschedem.view', 51, 'web', '2026-05-25 12:07:14', '2026-05-25 12:07:14');
INSERT INTO `permissions` VALUES (53, 'Update', 'setschedem.update', 51, 'web', '2026-05-25 12:07:32', '2026-05-25 12:07:32');

-- ----------------------------
-- Table structure for role_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions`  (
  `permission_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`, `role_id`) USING BTREE,
  INDEX `role_has_permissions_role_id_foreign`(`role_id` ASC) USING BTREE,
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role_has_permissions
-- ----------------------------
INSERT INTO `role_has_permissions` VALUES (1, 1);
INSERT INTO `role_has_permissions` VALUES (4, 1);
INSERT INTO `role_has_permissions` VALUES (5, 1);
INSERT INTO `role_has_permissions` VALUES (6, 1);
INSERT INTO `role_has_permissions` VALUES (9, 1);
INSERT INTO `role_has_permissions` VALUES (10, 1);
INSERT INTO `role_has_permissions` VALUES (11, 1);
INSERT INTO `role_has_permissions` VALUES (17, 1);
INSERT INTO `role_has_permissions` VALUES (18, 1);
INSERT INTO `role_has_permissions` VALUES (19, 1);
INSERT INTO `role_has_permissions` VALUES (20, 1);
INSERT INTO `role_has_permissions` VALUES (21, 1);
INSERT INTO `role_has_permissions` VALUES (22, 1);
INSERT INTO `role_has_permissions` VALUES (23, 1);
INSERT INTO `role_has_permissions` VALUES (24, 1);
INSERT INTO `role_has_permissions` VALUES (25, 1);
INSERT INTO `role_has_permissions` VALUES (26, 1);
INSERT INTO `role_has_permissions` VALUES (27, 1);
INSERT INTO `role_has_permissions` VALUES (28, 1);
INSERT INTO `role_has_permissions` VALUES (29, 1);
INSERT INTO `role_has_permissions` VALUES (31, 1);
INSERT INTO `role_has_permissions` VALUES (32, 1);
INSERT INTO `role_has_permissions` VALUES (35, 1);
INSERT INTO `role_has_permissions` VALUES (36, 1);
INSERT INTO `role_has_permissions` VALUES (37, 1);
INSERT INTO `role_has_permissions` VALUES (40, 1);
INSERT INTO `role_has_permissions` VALUES (41, 1);
INSERT INTO `role_has_permissions` VALUES (42, 1);
INSERT INTO `role_has_permissions` VALUES (44, 1);
INSERT INTO `role_has_permissions` VALUES (45, 1);
INSERT INTO `role_has_permissions` VALUES (46, 1);
INSERT INTO `role_has_permissions` VALUES (47, 1);
INSERT INTO `role_has_permissions` VALUES (48, 1);
INSERT INTO `role_has_permissions` VALUES (49, 1);
INSERT INTO `role_has_permissions` VALUES (50, 1);
INSERT INTO `role_has_permissions` VALUES (51, 1);
INSERT INTO `role_has_permissions` VALUES (52, 1);
INSERT INTO `role_has_permissions` VALUES (53, 1);
INSERT INTO `role_has_permissions` VALUES (21, 5);
INSERT INTO `role_has_permissions` VALUES (22, 5);
INSERT INTO `role_has_permissions` VALUES (23, 5);
INSERT INTO `role_has_permissions` VALUES (24, 5);
INSERT INTO `role_has_permissions` VALUES (36, 5);
INSERT INTO `role_has_permissions` VALUES (37, 5);
INSERT INTO `role_has_permissions` VALUES (40, 5);
INSERT INTO `role_has_permissions` VALUES (41, 5);
INSERT INTO `role_has_permissions` VALUES (42, 5);
INSERT INTO `role_has_permissions` VALUES (21, 6);
INSERT INTO `role_has_permissions` VALUES (22, 6);
INSERT INTO `role_has_permissions` VALUES (36, 6);
INSERT INTO `role_has_permissions` VALUES (37, 6);
INSERT INTO `role_has_permissions` VALUES (40, 6);
INSERT INTO `role_has_permissions` VALUES (41, 6);
INSERT INTO `role_has_permissions` VALUES (42, 6);
INSERT INTO `role_has_permissions` VALUES (1, 8);
INSERT INTO `role_has_permissions` VALUES (4, 8);
INSERT INTO `role_has_permissions` VALUES (10, 8);
INSERT INTO `role_has_permissions` VALUES (21, 8);
INSERT INTO `role_has_permissions` VALUES (22, 8);
INSERT INTO `role_has_permissions` VALUES (23, 8);
INSERT INTO `role_has_permissions` VALUES (24, 8);
INSERT INTO `role_has_permissions` VALUES (25, 8);
INSERT INTO `role_has_permissions` VALUES (26, 8);
INSERT INTO `role_has_permissions` VALUES (28, 8);
INSERT INTO `role_has_permissions` VALUES (29, 8);
INSERT INTO `role_has_permissions` VALUES (32, 8);
INSERT INTO `role_has_permissions` VALUES (35, 8);
INSERT INTO `role_has_permissions` VALUES (36, 8);
INSERT INTO `role_has_permissions` VALUES (37, 8);
INSERT INTO `role_has_permissions` VALUES (40, 8);
INSERT INTO `role_has_permissions` VALUES (41, 8);
INSERT INTO `role_has_permissions` VALUES (42, 8);
INSERT INTO `role_has_permissions` VALUES (21, 9);
INSERT INTO `role_has_permissions` VALUES (22, 9);
INSERT INTO `role_has_permissions` VALUES (23, 9);
INSERT INTO `role_has_permissions` VALUES (24, 9);
INSERT INTO `role_has_permissions` VALUES (25, 9);
INSERT INTO `role_has_permissions` VALUES (26, 9);
INSERT INTO `role_has_permissions` VALUES (28, 9);
INSERT INTO `role_has_permissions` VALUES (29, 9);
INSERT INTO `role_has_permissions` VALUES (32, 9);
INSERT INTO `role_has_permissions` VALUES (35, 9);
INSERT INTO `role_has_permissions` VALUES (41, 9);
INSERT INTO `role_has_permissions` VALUES (42, 9);
INSERT INTO `role_has_permissions` VALUES (44, 9);
INSERT INTO `role_has_permissions` VALUES (46, 9);
INSERT INTO `role_has_permissions` VALUES (47, 9);
INSERT INTO `role_has_permissions` VALUES (48, 9);
INSERT INTO `role_has_permissions` VALUES (49, 9);
INSERT INTO `role_has_permissions` VALUES (50, 9);
INSERT INTO `role_has_permissions` VALUES (51, 9);
INSERT INTO `role_has_permissions` VALUES (52, 9);
INSERT INTO `role_has_permissions` VALUES (53, 9);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'web',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `roles_name_guard_name_unique`(`name` ASC, `guard_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'Admin', 'web', '2026-05-19 23:19:45', '2026-05-21 13:23:59');
INSERT INTO `roles` VALUES (5, 'Employee', 'web', '2026-05-20 15:57:32', '2026-05-21 13:24:15');
INSERT INTO `roles` VALUES (6, 'Guard', 'web', '2026-05-21 02:52:48', '2026-05-21 02:52:48');
INSERT INTO `roles` VALUES (7, 'Student', 'web', '2026-05-21 13:24:22', '2026-05-21 13:24:22');
INSERT INTO `roles` VALUES (8, 'Staff', 'web', '2026-05-22 01:36:15', '2026-05-22 01:36:15');
INSERT INTO `roles` VALUES (9, 'HR', 'web', '2026-05-25 11:51:06', '2026-05-25 11:51:13');

-- ----------------------------
-- Table structure for sched_details
-- ----------------------------
DROP TABLE IF EXISTS `sched_details`;
CREATE TABLE `sched_details`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `schedule_id` int NOT NULL,
  `day` int NOT NULL,
  `am_in` time NULL DEFAULT NULL,
  `am_out` time NULL DEFAULT NULL,
  `pm_in` time NULL DEFAULT NULL,
  `pm_out` time NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `schedule_id`(`schedule_id` ASC, `day` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sched_details
-- ----------------------------
INSERT INTO `sched_details` VALUES (22, 1, 1, '08:00:00', '12:00:00', '13:00:00', '17:00:00', '2026-05-25 12:08:20', '2026-05-25 12:08:20');
INSERT INTO `sched_details` VALUES (23, 1, 2, '08:00:00', '12:00:00', '13:00:00', '17:00:00', '2026-05-25 12:08:20', '2026-05-25 12:08:20');
INSERT INTO `sched_details` VALUES (24, 1, 3, '08:00:00', '12:00:00', '13:00:00', '17:00:00', '2026-05-25 12:08:20', '2026-05-25 12:08:20');
INSERT INTO `sched_details` VALUES (25, 1, 4, '08:00:00', '12:00:00', '13:00:00', '17:00:00', '2026-05-25 12:08:20', '2026-05-25 12:08:20');
INSERT INTO `sched_details` VALUES (26, 1, 5, '08:00:00', '12:00:00', '13:00:00', '17:00:00', '2026-05-25 12:08:20', '2026-05-25 12:08:20');
INSERT INTO `sched_details` VALUES (27, 1, 6, '08:00:00', '12:00:00', '13:00:00', '17:00:00', '2026-05-25 12:08:20', '2026-05-25 12:08:20');
INSERT INTO `sched_details` VALUES (28, 1, 7, '08:00:00', '12:00:00', '13:00:00', '17:00:00', '2026-05-25 12:08:20', '2026-05-25 12:08:20');

-- ----------------------------
-- Table structure for schedules
-- ----------------------------
DROP TABLE IF EXISTS `schedules`;
CREATE TABLE `schedules`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of schedules
-- ----------------------------
INSERT INTO `schedules` VALUES (1, 'AJSKAHS', '2026-05-25 09:37:21', '2026-05-25 10:17:46');
INSERT INTO `schedules` VALUES (3, 'JAhkjhakjds', '2026-05-25 11:44:11', '2026-05-25 11:44:11');

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sessions_user_id_index`(`user_id` ASC) USING BTREE,
  INDEX `sessions_last_activity_index`(`last_activity` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('aajABMv3x89ZlhiE8K7TwssXLAyEOmwvhgEIbTWS', 1, '192.168.254.109', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoidjZiNTJDdU16VUR3QnhNbjYyeDU2dzREYWE1a3BTSFQ4dW1heElzYSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozODoiaHR0cDovLzE5Mi4xNjguMjU0LjExMDo4MDAwL2FkbWluL2xvZ3MiO31zOjk6Il9wcmV2aW91cyI7YToyOntzOjM6InVybCI7czo0MzoiaHR0cDovLzE5Mi4xNjguMjU0LjExMDo4MDAwL2FkbWluL2Rhc2hib2FyZCI7czo1OiJyb3V0ZSI7czoxNToiYWRtaW4uZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1780627251);
INSERT INTO `sessions` VALUES ('tU3JtJH0cDjoELJQyAYAIqfIaY9BuHYskKDr7b3p', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiVERkM1h0RVZZRWxBalVCV1V2S0NSdW11N0lFUTZPM0JnZ2V3QnI3TiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMjoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL2FkbWluL2RhdGEiO31zOjk6Il9wcmV2aW91cyI7YToyOntzOjM6InVybCI7czoyMToiaHR0cDovLzEyNy4wLjAuMTo4MDAwIjtzOjU6InJvdXRlIjtzOjQ6ImhvbWUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1780297631);
INSERT INTO `sessions` VALUES ('wHv0ultHxAEs5xIK7FukMIXoHL429PrHPF1YDCDl', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiRTFNNTJISmRJMlFIaFNQU1h5NlpPSlBaT2t2NFRNbEk3ZjlMbUR6eSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NTk6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9kYXRhL2ZldGNoP25hbWVfc29ydD1hc2MmcGFnZT0xIjtzOjU6InJvdXRlIjtzOjE2OiJhZG1pbi5kYXRhLmZldGNoIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1780295502);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_username_unique`(`username` ASC) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', 'test@example.com', '$2y$12$S88gxvq3CmEyr8zyeDGWkuNM29C4kq05FY3gGImpGCqWY.ATF6dIy', '2026-05-22 01:37:28', '2026-05-22 01:37:28');
INSERT INTO `users` VALUES (2, 'guard', 'guard@gmail.com', '$2y$12$S88gxvq3CmEyr8zyeDGWkuNM29C4kq05FY3gGImpGCqWY.ATF6dIy', '2026-05-21 01:21:44', '2026-05-21 01:21:44');
INSERT INTO `users` VALUES (3, 'hraccount', 'hraccount@gmail.com', '$2y$12$S88gxvq3CmEyr8zyeDGWkuNM29C4kq05FY3gGImpGCqWY.ATF6dIy', '2026-05-21 02:54:22', '2026-05-26 12:18:41');

SET FOREIGN_KEY_CHECKS = 1;
