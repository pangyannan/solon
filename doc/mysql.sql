/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : solon

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 26/06/2023 23:20:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
                              `dept_id` bigint NOT NULL COMMENT '主键',
                              `dept_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '部门名称',
                              `parent_dept_id` bigint NOT NULL DEFAULT '0' COMMENT '父级部门ID',
                              `parent_dept_id_path` varchar(1000) NOT NULL COMMENT '父级部门路径',
                              `dept_source_code` varchar(255) DEFAULT NULL COMMENT '部门编码，一般与其他系统关联使用',
                              `enable_flag` tinyint NOT NULL DEFAULT '1' COMMENT '是否启用',
                              `delete_flag` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
                              `sort_num` int NOT NULL DEFAULT '0',
                              `create_time` datetime NOT NULL COMMENT '创建时间',
                              `create_user_id` bigint DEFAULT NULL COMMENT '创建人',
                              `update_time` datetime NOT NULL COMMENT '更新时间',
                              `update_user_id` bigint DEFAULT NULL COMMENT '修改人',
                              PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of department
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for department_post_ref
-- ----------------------------
DROP TABLE IF EXISTS `department_post_ref`;
CREATE TABLE `department_post_ref` (
                                       `id` bigint NOT NULL COMMENT '主键',
                                       `dept_id` bigint NOT NULL COMMENT '部门ID',
                                       `post_id` bigint NOT NULL COMMENT '岗位ID',
                                       `create_time` datetime NOT NULL COMMENT '创建时间',
                                       `create_user_id` bigint DEFAULT NULL COMMENT '创建人',
                                       PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of department_post_ref
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for job_config
-- ----------------------------
DROP TABLE IF EXISTS `job_config`;
CREATE TABLE `job_config` (
                              `id` bigint NOT NULL COMMENT '任务id',
                              `job_name` varchar(255) NOT NULL COMMENT '任务名称',
                              `job_group` varchar(255) DEFAULT NULL COMMENT '任务组',
                              `class_name` varchar(255) NOT NULL COMMENT '任务执行className',
                              `status` int NOT NULL DEFAULT '0' COMMENT '任务状态 0-暂停  1-启动',
                              `start_time` datetime DEFAULT NULL COMMENT '任务开始时间',
                              `end_time` datetime DEFAULT NULL COMMENT '任务结束时间',
                              `cron` varchar(255) NOT NULL COMMENT '任务运行时间表达式',
                              `param` varchar(1000) DEFAULT NULL COMMENT '任务参数',
                              `max_log_day` int NOT NULL DEFAULT '90' COMMENT '日志保留最大天数',
                              `delete_flag` int NOT NULL COMMENT '删除标记 0-未删除 1-已删除',
                              `create_time` datetime DEFAULT NULL COMMENT '创建时间',
                              `create_user_id` bigint DEFAULT NULL COMMENT '创建人',
                              `update_time` datetime DEFAULT NULL COMMENT '修改时间',
                              `update_user_id` bigint DEFAULT NULL COMMENT '修改人',
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of job_config
-- ----------------------------
BEGIN;
INSERT INTO `job_config` VALUES (1, '清理任务日志', NULL, 'cloud.flystar.solon.quartz.service.job.JobLogClear', 1, NULL, NULL, '0 0/1 * * * ? ', NULL, 1, 0, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for job_log
-- ----------------------------
DROP TABLE IF EXISTS `job_log`;
CREATE TABLE `job_log` (
                           `id` bigint NOT NULL COMMENT '日志ID',
                           `job_config_id` bigint NOT NULL COMMENT '任务ID',
                           `param` varchar(4000) DEFAULT NULL COMMENT '任务执行参数',
                           `start_time` datetime NOT NULL COMMENT '任务开始时间',
                           `end_time` datetime NOT NULL COMMENT '任务结束时间',
                           `job_success` int NOT NULL COMMENT '执行结果  0-失败，1-成功',
                           `message` varchar(200) DEFAULT NULL COMMENT '执行结果信息',
                           `instance_ip` varchar(255) DEFAULT NULL COMMENT '执行任务的实例IP',
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of job_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for mdm_gbt2259
-- ----------------------------
DROP TABLE IF EXISTS `mdm_gbt2259`;
CREATE TABLE `mdm_gbt2259` (
                               `country_code2` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
                               `country_code3` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
                               `country_number` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
                               `country_short_name_cn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
                               `country_short_name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
                               `country_name_en` varchar(255) DEFAULT NULL,
                               `remark` varchar(255) DEFAULT NULL,
                               `create_time` datetime DEFAULT NULL,
                               `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
                               PRIMARY KEY (`country_code2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of mdm_gbt2259
-- ----------------------------
BEGIN;
INSERT INTO `mdm_gbt2259` VALUES ('AD', 'AND', '020', '安道尔', 'Andorra', 'the Principality of Andorra', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('AE', 'ARE', '784', '阿联酋', 'United Arab Emirates (the)', 'the United Arab Emirates', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('AF', 'AFG', '004', '阿富汗', 'Afghanistan', 'the Islamic Republic of Afghanistan', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('AG', 'ATG', '028', '安提瓜和巴布达', 'Antigua and Barbuda', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('AI', 'AIA', '660', '安圭拉', 'Anguilla', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('AL', 'ALB', '008', '阿尔巴尼亚', 'Albania', 'the Republic of Albania', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('AM', 'ARM', '051', '亚美尼亚', 'Armenia', 'the Republic of Armenia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('AN', 'ANT', '530', '荷属安的列斯', 'Netherlands Antilles (the)', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('AO', 'AGO', '024', '安哥拉', 'Angola', 'the Republic of Angola', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('AQ', 'ATA', '010', '南极洲', 'Antarctica', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('AR', 'ARG', '032', '阿根廷', 'Argentina', 'the Argentine Republic', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('AS', 'ASM', '016', '美属萨摩亚', 'American Samoa', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('AT', 'AUT', '040', '奥地利', 'Austria', 'the Republic of Austria', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('AU', 'AUS', '036', '澳大利亚', 'Australia', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('AW', 'ABW', '533', '阿鲁巴', 'Aruba', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('AX', 'ALA', '248', '奥兰群岛', 'Aland Islands', NULL, 'ISO 3166-1:2006新增', NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('AZ', 'AZE', '031', '阿塞拜疆', 'Azerbaijan', 'the Republic of Azerbaijan', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BA', 'BIH', '070', '波黑', 'Bosnia and Herzegovina', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BB', 'BRB', '052', '巴巴多斯', 'Barbados', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BD', 'BGD', '050', '孟加拉国', 'Bangladesh', 'the People’s Republic of Bangladesh', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BE', 'BEL', '056', '比利时', 'Belgium', 'the Kingdom of Belgium', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BF', 'BFA', '854', '布基纳法索', 'Burkina Faso', 'Burkina Faso', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BG', 'BGR', '100', '保加利亚', 'Bulgaria', 'the Republic of Bulgaria', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BH', 'BHR', '048', '巴林', 'Bahrain', 'the Kingdom of Bahrain', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BI', 'BDI', '108', '布隆迪', 'Burundi', 'the Republic of Burundi', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BJ', 'BEN', '204', '贝宁', 'Benin', 'the Republic of Benin', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BM', 'BMU', '060', '百慕大', 'Bermuda', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BN', 'BRN', '096', '文莱', 'Brunei Darussalam', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BO', 'BOL', '068', '玻利维亚', 'Bolivia', 'the Republic of Bolivia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BR', 'BRA', '076', '巴西', 'Brazil', 'the Federative Republic of Brazil', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BS', 'BHS', '044', '巴哈马', 'Bahamas (The)', 'the Commonwealth of The Bahamas', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BT', 'BTN', '064', '不丹', 'Bhutan', 'the Kingdom of Bhutan', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BV', 'BVT', '074', '布维岛', 'Bouvet Island', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BW', 'BWA', '072', '博茨瓦纳', 'Botswana', 'the Republic of Botswana', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BY', 'BLR', '112', '白俄罗斯', 'Belarus', 'the Republic of Belarus', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('BZ', 'BLZ', '084', '伯利兹', 'Belize', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CA', 'CAN', '124', '加拿大', 'Canada', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CC', 'CCK', '166', '科科斯（基林）群岛', 'Cocos (Keeling) Islands (the)', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CD', 'COD', '180', '刚果（金）', 'Congo (the Democratic Republic of the)', 'the Democratic Republic of the Congo', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CF', 'CAF', '140', '中非', 'Central African Republic (the)', 'the Central African Republic', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CG', 'COG', '178', '刚果（布）', 'Congo', 'the Republic of the Congo', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CH', 'CHE', '756', '瑞士', 'Switzerland', 'the Swiss Confederation', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CI', 'CIV', '384', '科特迪瓦', 'Côte d’Ivoire', 'the Republic of Côte d’Ivoire', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CK', 'COK', '184', '库克群岛', 'Cook Islands (the)', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CL', 'CHL', '152', '智利', 'Chile', 'the Republic of Chile', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CM', 'CMR', '120', '喀麦隆', 'Cameroon', 'the Republic of Cameroon', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CN', 'CHN', '156', '中国', 'China', 'the People’s Republic of China', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CO', 'COL', '170', '哥伦比亚', 'Colombia', 'the Republic of Colombia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CR', 'CRI', '188', '哥斯达黎加', 'Costa Rica', 'the Republic of Costa Rica', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CU', 'CUB', '192', '古巴', 'Cuba', 'the Republic of Cuba', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CV', 'CPV', '132', '佛得角', 'Cape Verde', 'the Republic of Cape Verde', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CX', 'CXR', '162', '圣诞岛', 'Christmas Island', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CY', 'CYP', '196', '塞浦路斯', 'Cyprus', 'the Republic of Cyprus', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('CZ', 'CZE', '203', '捷克', 'Czech Republic (the)', 'the Czech Republic', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('DE', 'DEU', '276', '德国', 'Germany', 'he Federal Republic of Germany', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('DJ', 'DJI', '262', '吉布提', 'Djibouti', 'the Republic of Djibouti', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('DK', 'DNK', '208', '丹麦', 'Denmark', 'the Kingdom of Denmark', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('DM', 'DMA', '212', '多米尼克', 'Dominica', 'the Commonwealth of Dominica', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('DO', 'DOM', '214', '多米尼加', 'Dominican Republic (the)', 'the Dominican Republic', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('DZ', 'DZA', '012', '阿尔及利亚', 'Algeria', 'the People’s Democratic Republic of Algeria', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('EC', 'ECU', '218', '厄瓜多尔', 'Ecuador', 'the Republic of Ecuador', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('EE', 'EST', '233', '爱沙尼亚', 'Estonia', 'the Republic of Estonia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('EG', 'EGY', '818', '埃及', 'Egypt', 'the Arab Republic of Egypt', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('EH', 'ESH', '732', '西撒哈拉', 'Western Sahara', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('ER', 'ERI', '232', '厄立特里亚', 'Eritrea', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('ES', 'ESP', '724', '西班牙', 'Spain', 'the Kingdom of Spain', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('ET', 'ETH', '231', '埃塞俄比亚', 'Ethiopia', 'the Federal Democratic Republic of Ethiopia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('FI', 'FIN', '246', '芬兰', 'Finland', 'the Republic of Finland', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('FJ', 'FJI', '242', '斐济', 'Fiji', 'the Republic of the Fiji Islands', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('FK', 'FLK', '238', '福克兰群岛（马尔维纳斯）', 'Falkland Islands (the) [Malvinas]', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('FM', 'FSM', '583', '密克罗尼西亚联邦', 'Micronesia (the Federated States of)', 'the Federated States of Micronesia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('FO', 'FRO', '234', '法罗群岛', 'Faroe Islands (the)', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('FR', 'FRA', '250', '法国', 'France', 'the French Republic', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GA', 'GAB', '266', '加蓬', 'Gabon', 'the Gabonese Republic', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GB', 'GBR', '826', '英国', 'United Kingdom (the)', 'the United Kingdom of Great Britain and Northern Ireland', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GD', 'GRD', '308', '格林纳达', 'Grenada', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GE', 'GEO', '268', '格鲁吉亚', 'Georgia', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GF', 'GUF', '254', '法属圭亚那', 'French Guiana', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GG', 'GGY', '831', '格恩西岛', 'Guernsey', NULL, 'ISO 3166-1:2006新增', NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GH', 'GHA', '288', '加纳', 'Ghana', 'the Republic of Ghana', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GI', 'GIB', '292', '直布罗陀', 'Gibraltar', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GL', 'GRL', '304', '格陵兰', 'Greenland', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GM', 'GMB', '270', '冈比亚', 'Gambia (The)', 'the Republic of The Gambia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GN', 'GIN', '324', '几内亚', 'Guinea', 'the Republic of Guinea', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GP', 'GLP', '312', '瓜德罗普', 'Guadeloupe', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GQ', 'GNQ', '226', '赤道几内亚', 'Equatorial Guinea', 'the Republic of Equatorial Guinea', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GR', 'GRC', '300', '希腊', 'Greece', 'the Hellenic Republic', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GS', 'SGS', '239', '南乔治亚岛和南桑德韦奇岛', 'South Georgia and the South Sandwich Islands', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GT', 'GTM', '320', '危地马拉', 'Guatemala', 'the Republic of Guatemala', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GU', 'GUM', '316', '关岛', 'Guam', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GW', 'GNB', '624', '几内亚比绍', 'Guinea-Bissau', 'the Republic of Guinea-Bissau', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('GY', 'GUY', '328', '圭亚那', 'Guyana', 'the Republic of Guyana', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('HK', 'HKG', '344', '香港', 'Hong Kong', 'the Hong Kong Special Administrative Region of China', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('HM', 'HMD', '334', '赫德岛和麦克唐纳岛', 'Heard Island and McDonald Islands', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('HN', 'HND', '340', '洪都拉斯', 'Honduras', 'the Republic of Honduras', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('HR', 'HRV', '191', '克罗地亚', 'Croatia', 'the Republic of Croatia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('HT', 'HTI', '332', '海地', 'Haiti', 'the Republic of Haiti', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('HU', 'HUN', '348', '匈牙利', 'Hungary', 'the Republic of Hungary', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('ID', 'IDN', '360', '印度尼西亚', 'Indonesia', 'the Republic of Indonesia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('IE', 'IRL', '372', '爱尔兰', 'Ireland', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('IL', 'ISR', '376', '以色列', 'Israel', 'the State of Israel', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('IM', 'IMN', '833', '英国属地曼岛', 'Isle of Man', NULL, 'ISO 3166-1:2006新增', NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('IN', 'IND', '356', '印度', 'India', 'the Republic of India', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('IO', 'IOT', '086', '英属印度洋领地', 'British Indian Ocean Territory (the)', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('IQ', 'IRQ', '368', '伊拉克', 'Iraq', 'the Republic of Iraq', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('IR', 'IRN', '364', '伊朗', 'Iran (the Islamic Republic of)', 'the Islamic Republic of Iran', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('IS', 'ISL', '352', '冰岛', 'Iceland', 'the Republic of Iceland', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('IT', 'ITA', '380', '意大利', 'Italy', 'the Republic of Italy', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('JE', 'JEY', '832', '泽西岛', 'Jersey', NULL, 'ISO 3166-1:2006新增', NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('JM', 'JAM', '388', '牙买加', 'Jamaica', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('JO', 'JOR', '400', '约旦', 'Jordan', 'the Hashemite Kingdom of Jordan', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('JP', 'JPN', '392', '日本', 'Japan', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('KE', 'KEN', '404', '肯尼亚', 'Kenya', 'the Republic of Kenya', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('KG', 'KGZ', '417', '吉尔吉斯斯坦', 'Kyrgyzstan', 'the Kyrgyz Republic', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('KH', 'KHM', '116', '柬埔寨', 'Cambodia', 'the Kingdom of Cambodia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('KI', 'KIR', '296', '基里巴斯', 'Kiribati', 'the Republic of Kiribati', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('KM', 'COM', '174', '科摩罗', 'Comoros', 'the Union of the Comoros', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('KN', 'KNA', '659', '圣基茨和尼维斯', 'Saint Kitts and Nevis', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('KP', 'PRK', '408', '朝鲜', 'Korea (the Democratic People’s Republic of)', 'the Democratic People’s Republic of Korea', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('KR', 'KOR', '410', '韩国', 'Korea (the Republic of)', 'the Republic of Korea', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('KW', 'KWT', '414', '科威特', 'Kuwait', 'he State of Kuwait', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('KY', 'CYM', '136', '开曼群岛', 'Cayman Islands (the)', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('KZ', 'KAZ', '398', '哈萨克斯坦', 'Kazakhstan', 'the Republic of Kazakhstan', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('LA', 'LAO', '418', '老挝', 'Lao People’s Democratic Republic (the)', 'the Lao People’s Democratic Republic', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('LB', 'LBN', '422', '黎巴嫩', 'Lebanon', 'the Lebanese Republic', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('LC', 'LCA', '662', '圣卢西亚', 'Saint Lucia', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('LI', 'LIE', '438', '列支敦士登', 'Liechtenstein', 'the Principality of Liechtenstein', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('LK', 'LKA', '144', '斯里兰卡', 'Sri Lanka', 'the Democratic Socialist Republic of Sri Lanka', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('LR', 'LBR', '430', '利比里亚', 'Liberia', 'the Republic of Liberia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('LS', 'LSO', '426', '莱索托', 'Lesotho', 'the Kingdom of Lesotho', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('LT', 'LTU', '440', '立陶宛', 'Lithuania', 'the Republic of Lithuania', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('LU', 'LUX', '442', '卢森堡', 'Luxembourg', 'the Grand Duchy of Luxembourg', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('LV', 'LVA', '428', '拉脱维亚', 'Latvia', 'the Republic of Latvia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('LY', 'LBY', '434', '利比亚', 'Libyan Arab Jamahiriya (the)', 'the Socialist People’s Libyan Arab Jamahiriya', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MA', 'MAR', '504', '摩洛哥', 'Morocco', 'the Kingdom of Morocco', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MC', 'MCO', '492', '摩纳哥', 'Monaco', 'the Principality of Monaco', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MD', 'MDA', '498', '摩尔多瓦', 'Moldova (the Republic of)', 'the Republic of Moldova', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('ME', 'MNE', '499', '黑山', 'Montenegro', 'he Republic of Montenegro', 'ISO 3166.1:2006新增', NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MG', 'MDG', '450', '马达加斯加', 'Madagascar', 'the Republic of Madagascar', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MH', 'MHL', '584', '马绍尔群岛', 'Marshall Islands (the)', 'the Republic of the Marshall Islands', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MK', 'MKD', '807', '前南马其顿', 'Macedonia (the former Yugoslav Republic of)', 'the former Yugoslav Republic of Macedonia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('ML', 'MLI', '466', '马里', 'Mali', 'the Republic of Mali', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MM', 'MMR', '104', '缅甸', 'Myanmar', 'the Union of Myanmar', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MN', 'MNG', '496', '蒙古', 'Mongolia', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MO', 'MAC', '446', '澳门', 'Macao', 'Macao Special Administrative Region of China', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MP', 'MNP', '580', '北马里亚纳', 'Northern Mariana Islands (the)', 'the Commonwealth of the Northern Mariana Islands', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MQ', 'MTQ', '474', '马提尼克', 'Martinique', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MR', 'MRT', '478', '毛利塔尼亚', 'Mauritania', 'the Islamic Republic of Mauritania', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MS', 'MSR', '500', '蒙特塞拉特', 'Montserrat', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MT', 'MLT', '470', '马耳他', 'Malta', 'the Republic of Malta', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MU', 'MUS', '480', '毛里求斯', 'Mauritius', 'the Republic of Mauritius', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MV', 'MDV', '462', '马尔代夫', 'Maldives', 'the Republic of Maldives', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MW', 'MWI', '454', '马拉维', 'Malawi', 'the Republic of Malawi', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MX', 'MEX', '484', '墨西哥', 'Mexico', 'the United Mexican States', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MY', 'MYS', '458', '马来西亚', 'Malaysia', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('MZ', 'MOZ', '508', '莫桑比克', 'Mozambique', 'the Republic of Mozambique', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('NA', 'NAM', '516', '纳米比亚', 'Namibia', 'the Republic of Namibia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('NC', 'NCL', '540', '新喀里多尼亚', 'New Caledonia', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('NE', 'NER', '562', '尼日尔', 'Niger (the)', 'the Republic of the Niger', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('NF', 'NFK', '574', '诺福克岛', 'Norfolk Island', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('NG', 'NGA', '566', '尼日利亚', 'Nigeria', 'the Federal Republic of Nigeria', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('NI', 'NIC', '558', '尼加拉瓜', 'Nicaragua', 'the Republic of Nicaragua', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('NL', 'NLD', '528', '荷兰', 'Netherlands (the)', 'the Kingdom of the Netherlands', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('NO', 'NOR', '578', '挪威', 'Norway', 'the Kingdom of Norway', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('NP', 'NPL', '524', '尼泊尔', 'Nepal', 'Nepal', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('NR', 'NRU', '520', '瑙鲁', 'Nauru', 'the Republic of Nauru', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('NU', 'NIU', '570', '纽埃', 'Niue', 'the Republic of Niue', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('NZ', 'NZL', '554', '新西兰', 'New Zealand', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('OM', 'OMN', '512', '阿曼', 'Oman', 'the Sultanate of Oman', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('PA', 'PAN', '591', '巴拿马', 'Panama', 'the Republic of Panama', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('PE', 'PER', '604', '秘鲁', 'Peru', 'the Republic of Peru', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('PF', 'PYF', '258', '法属波利尼西亚', 'French Polynesia', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('PG', 'PNG', '598', '巴布亚新几内亚', 'Papua New Guinea', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('PH', 'PHL', '608', '菲律宾', 'Philippines (the)', 'the Republic of the Philippines', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('PK', 'PAK', '586', '巴基斯坦', 'Pakistan', 'the Islamic Republic of Pakistan', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('PL', 'POL', '616', '波兰', 'Poland', 'the Republic of Poland', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('PM', 'SPM', '666', '圣皮埃尔和密克隆', 'Saint Pierre and Miquelon', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('PN', 'PCN', '612', '皮特凯恩', 'Pitcairn', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('PR', 'PRI', '630', '波多黎各', 'Puerto Rico', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('PS', 'PSE', '275', '巴勒斯坦', 'Palestinian Territory (the Occupied)', 'the Occupied Palestinian Territory', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('PT', 'PRT', '620', '葡萄牙', 'Portugal', 'the Portuguese Republic', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('PW', 'PLW', '585', '帕劳', 'Palau', 'the Republic of Palau', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('PY', 'PRY', '600', '巴拉圭', 'Paraguay', 'the Republic of Paraguay', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('QA', 'QAT', '634', '卡塔尔', 'Qatar', 'the State of Qatar', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('RE', 'REU', '638', '留尼汪', 'Réunion', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('RO', 'ROU', '642', '罗马尼亚', 'Romania', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('RS', 'SRB', '688', '塞尔维亚', 'Serbia', 'the Republic of Serbia', 'ISO 3166.1-2006新增', NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('RU', 'RUS', '643', '俄罗斯联邦', 'Russian Federation (the)', 'the Russian Federation', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('RW', 'RWA', '646', '卢旺达', 'Rwanda', 'the Republic of Rwanda', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SA', 'SAU', '682', '沙特阿拉伯', 'Saudi Arabia', 'the Kingdom of Saudi Arabia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SB', 'SLB', '090', '所罗门群岛', 'Solomon Islands (the)', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SC', 'SYC', '690', '塞舌尔', 'Seychelles', 'the Republic of Seychelles', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SD', 'SDN', '736', '苏丹', 'Sudan (the)', 'the Republic of the Sudan', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SE', 'SWE', '752', '瑞典', 'Sweden', 'the Kingdom of Sweden', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SG', 'SGP', '702', '新加坡', 'Singapore', 'the Republic of Singapore', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SH', 'SHN', '654', '圣赫勒拿', 'Saint Helena', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SI', 'SVN', '705', '斯洛文尼亚', 'Slovenia', 'the Republic of Slovenia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SJ', 'SJM', '744', '斯瓦尔巴岛和扬马延岛', 'Svalbard and Jan Mayen', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SK', 'SVK', '703', '斯洛伐克', 'Slovakia', 'the Slovak Republic', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SL', 'SLE', '694', '塞拉利昂', 'Sierra Leone', 'the Republic of Sierra Leone', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SM', 'SMR', '674', '圣马力诺', 'San Marino', 'the Republic of San Marino', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SN', 'SEN', '686', '塞内加尔', 'Senegal', 'the Republic of Senegal', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SO', 'SOM', '706', '索马里', 'Somalia', 'the Somali Republic', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SR', 'SUR', '740', '苏里南', 'Suriname', 'the Republic of Suriname', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('ST', 'STP', '678', '圣多美和普林西比', 'Sao Tome and Principe', 'the Democratic Republic of Sao Tome and Principe', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SV', 'SLV', '222', '萨尔瓦多', 'El Salvador', 'the Republic of El Salvador', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SY', 'SYR', '760', '叙利亚', 'Syrian Arab Republic (the)', 'the Syrian Arab Republic', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('SZ', 'SWZ', '748', '斯威士兰', 'Swaziland', 'the Kingdom of Swaziland', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('TC', 'TCA', '796', '特克斯和凯科斯群岛', 'Turks and Caicos Islands (the)', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('TD', 'TCD', '148', '乍得', 'Chad', 'the Republic of Chad', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('TF', 'ATF', '260', '法属南部领地', 'French Southern Territories (the)', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('TG', 'TGO', '768', '多哥', 'Togo', 'the Togolese Republic', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('TH', 'THA', '764', '泰国', 'Thailand', 'the Kingdom of Thailand', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('TJ', 'TJK', '762', '塔吉克斯坦', 'Tajikistan', 'the Republic of Tajikistan', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('TK', 'TKL', '772', '托克劳', 'Tokelau', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('TL', 'TLS', '626', '东帝汶', 'Timor-Leste', 'the Democratic Republic of Timor-Leste', 'ISO 3166.1-2006调整了英文名称和字母代码（原代码为TP\\TMP）', NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('TM', 'TKM', '795', '土库曼斯坦', 'Turkmenistan', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('TN', 'TUN', '788', '突尼斯', 'Tunisia', 'the Republic of Tunisia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('TO', 'TON', '776', '汤加', 'Tonga', 'the Kingdom of Tonga', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('TR', 'TUR', '792', '土耳其', 'Turkey', 'the Republic of Turkey', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('TT', 'TTO', '780', '特立尼达和多巴哥', 'Trinidad and Tobago', 'the Republic of Trinidad and Tobago', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('TV', 'TUV', '798', '图瓦卢', 'Tuvalu', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('TW', 'TWN', '158', '台湾', 'Taiwan (Province of China)', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('TZ', 'TZA', '834', '坦桑尼亚', 'Tanzania,United Republic of', 'the United Republic of Tanzania', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('UA', 'UKR', '804', '乌克兰', 'Ukraine', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('UG', 'UGA', '800', '乌干达', 'Uganda', 'the Republic of Uganda', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('UM', 'UMI', '581', '美国本土外小岛屿', 'United States Minor Outlying Islands (the)', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('US', 'USA', '840', '美国', 'United States (the)', 'the United States of America', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('UY', 'URY', '858', '乌拉圭', 'Uruguay', 'the Eastern Republic of Uruguay', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('UZ', 'UZB', '860', '乌兹别克斯坦', 'Uzbekistan', 'the Republic of Uzbekistan', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('VA', 'VAT', '336', '梵蒂冈', 'Holy See (the) [Vatican City State]', NULL, 'ISO 3166.1:2006调整英文名称，代码未变', NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('VC', 'VCT', '670', '圣文森特和格林纳丁斯', 'Saint Vincent and the Grenadines', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('VE', 'VEN', '862', '委内瑞拉', 'Venezuela', 'the Bolivarian Republic of Venezuela', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('VG', 'VGB', '092', '英属维尔京群岛', 'Virgin Islands (British)', 'British Virgin Islands (the)', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('VI', 'VIR', '850', '美属维尔京群岛', 'Virgin Islands (U.S.)', 'the Virgin Islands of the United States', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('VN', 'VNM', '704', '越南', 'Viet Nam', 'the Socialist Republic of Viet Nam', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('VU', 'VUT', '548', '瓦努阿图', 'Vanuatu', 'the Republic of Vanuatu', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('WF', 'WLF', '876', '瓦利斯和富图纳', 'Wallis and Futuna', 'Wallis and Futuna Islands', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('WS', 'WSM', '882', '萨摩亚', 'Samoa', 'the Independent State of Samoa', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('YE', 'YEM', '887', '也门', 'Yemen', 'the Republic of Yemen', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('YT', 'MYT', '175', '马约特', 'Mayotte', NULL, NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('YU', 'YUG', '891', '南斯拉夫', 'YUGOSLAVIA', 'Federal Republic of Yugoslavi', 'GBT2659-2000中包含,ISO 3166-1:2006删除', NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('ZA', 'ZAF', '710', '南非', 'South Africa', 'the Republic of South Africa', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('ZM', 'ZMB', '894', '赞比亚', 'Zambia', 'the Republic of Zambia', NULL, NULL, NULL);
INSERT INTO `mdm_gbt2259` VALUES ('ZW', 'ZWE', '716', '津巴布韦', 'Zimbabwe', 'the Republic of Zimbabwe', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for mdm_gbt2260
-- ----------------------------
DROP TABLE IF EXISTS `mdm_gbt2260`;
CREATE TABLE `mdm_gbt2260` (
                               `area_code` int NOT NULL COMMENT '区划代码',
                               `area_name` varchar(128) NOT NULL COMMENT '地区',
                               `parent_code` int DEFAULT NULL COMMENT '父级地区代码',
                               `area_level` tinyint NOT NULL COMMENT '地区级别 1:省 2:市 3:县/区',
                               `create_time` datetime DEFAULT NULL,
                               `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
                               PRIMARY KEY (`area_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='GBT2260-2007中华人民共和国行政区划代码';

-- ----------------------------
-- Records of mdm_gbt2260
-- ----------------------------
BEGIN;
INSERT INTO `mdm_gbt2260` VALUES (110000, '北京市', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (110100, '北京市-直辖', 110000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (110101, '东城区', 110100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (110102, '西城区', 110100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (110105, '朝阳区', 110100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (110106, '丰台区', 110100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (110107, '石景山区', 110100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (110108, '海淀区', 110100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (110109, '门头沟区', 110100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (110111, '房山区', 110100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (110112, '通州区', 110100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (110113, '顺义区', 110100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (110114, '昌平区', 110100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (110115, '大兴区', 110100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (110116, '怀柔区', 110100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (110117, '平谷区', 110100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (110118, '密云区', 110100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (110119, '延庆区', 110100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120000, '天津市', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120100, '天津市-直辖', 120000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120101, '和平区', 120100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120102, '河东区', 120100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120103, '河西区', 120100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120104, '南开区', 120100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120105, '河北区', 120100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120106, '红桥区', 120100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120110, '东丽区', 120100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120111, '西青区', 120100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120112, '津南区', 120100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120113, '北辰区', 120100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120114, '武清区', 120100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120115, '宝坻区', 120100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120116, '滨海新区', 120100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120117, '宁河区', 120100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120118, '静海区', 120100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (120119, '蓟州区', 120100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130000, '河北省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130100, '石家庄市', 130000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130102, '长安区', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130104, '桥西区', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130105, '新华区', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130107, '井陉矿区', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130108, '裕华区', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130109, '藁城区', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130110, '鹿泉区', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130111, '栾城区', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130121, '井陉县', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130123, '正定县', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130125, '行唐县', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130126, '灵寿县', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130127, '高邑县', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130128, '深泽县', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130129, '赞皇县', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130130, '无极县', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130131, '平山县', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130132, '元氏县', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130133, '赵县', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130181, '辛集市', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130183, '晋州市', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130184, '新乐市', 130100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130200, '唐山市', 130000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130202, '路南区', 130200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130203, '路北区', 130200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130204, '古冶区', 130200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130205, '开平区', 130200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130207, '丰南区', 130200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130208, '丰润区', 130200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130209, '曹妃甸区', 130200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130224, '滦南县', 130200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130225, '乐亭县', 130200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130227, '迁西县', 130200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130229, '玉田县', 130200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130281, '遵化市', 130200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130283, '迁安市', 130200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130284, '滦州市', 130200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130300, '秦皇岛市', 130000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130302, '海港区', 130300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130303, '山海关区', 130300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130304, '北戴河区', 130300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130306, '抚宁区', 130300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130321, '青龙满族自治县', 130300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130322, '昌黎县', 130300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130324, '卢龙县', 130300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130400, '邯郸市', 130000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130402, '邯山区', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130403, '丛台区', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130404, '复兴区', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130406, '峰峰矿区', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130407, '肥乡区', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130408, '永年区', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130423, '临漳县', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130424, '成安县', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130425, '大名县', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130426, '涉县', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130427, '磁县', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130430, '邱县', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130431, '鸡泽县', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130432, '广平县', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130433, '馆陶县', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130434, '魏县', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130435, '曲周县', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130481, '武安市', 130400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130500, '邢台市', 130000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130502, '襄都区', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130503, '信都区', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130505, '任泽区', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130506, '南和区', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130522, '临城县', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130523, '内丘县', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130524, '柏乡县', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130525, '隆尧县', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130528, '宁晋县', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130529, '巨鹿县', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130530, '新河县', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130531, '广宗县', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130532, '平乡县', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130533, '威县', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130534, '清河县', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130535, '临西县', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130581, '南宫市', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130582, '沙河市', 130500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130600, '保定市', 130000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130602, '竞秀区', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130606, '莲池区', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130607, '满城区', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130608, '清苑区', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130609, '徐水区', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130623, '涞水县', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130624, '阜平县', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130626, '定兴县', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130627, '唐县', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130628, '高阳县', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130629, '容城县', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130630, '涞源县', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130631, '望都县', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130632, '安新县', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130633, '易县', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130634, '曲阳县', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130635, '蠡县', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130636, '顺平县', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130637, '博野县', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130638, '雄县', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130681, '涿州市', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130682, '定州市', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130683, '安国市', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130684, '高碑店市', 130600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130700, '张家口市', 130000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130702, '桥东区', 130700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130703, '桥西区', 130700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130705, '宣化区', 130700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130706, '下花园区', 130700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130708, '万全区', 130700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130709, '崇礼区', 130700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130722, '张北县', 130700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130723, '康保县', 130700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130724, '沽源县', 130700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130725, '尚义县', 130700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130726, '蔚县', 130700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130727, '阳原县', 130700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130728, '怀安县', 130700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130730, '怀来县', 130700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130731, '涿鹿县', 130700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130732, '赤城县', 130700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130800, '承德市', 130000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130802, '双桥区', 130800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130803, '双滦区', 130800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130804, '鹰手营子矿区', 130800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130821, '承德县', 130800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130822, '兴隆县', 130800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130824, '滦平县', 130800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130825, '隆化县', 130800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130826, '丰宁满族自治县', 130800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130827, '宽城满族自治县', 130800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130828, '围场满族蒙古族自治县', 130800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130881, '平泉市', 130800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130900, '沧州市', 130000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130902, '新华区', 130900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130903, '运河区', 130900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130921, '沧县', 130900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130922, '青县', 130900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130923, '东光县', 130900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130924, '海兴县', 130900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130925, '盐山县', 130900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130926, '肃宁县', 130900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130927, '南皮县', 130900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130928, '吴桥县', 130900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130929, '献县', 130900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130930, '孟村回族自治县', 130900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130981, '泊头市', 130900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130982, '任丘市', 130900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130983, '黄骅市', 130900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (130984, '河间市', 130900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131000, '廊坊市', 130000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131002, '安次区', 131000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131003, '广阳区', 131000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131022, '固安县', 131000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131023, '永清县', 131000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131024, '香河县', 131000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131025, '大城县', 131000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131026, '文安县', 131000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131028, '大厂回族自治县', 131000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131081, '霸州市', 131000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131082, '三河市', 131000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131100, '衡水市', 130000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131102, '桃城区', 131100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131103, '冀州区', 131100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131121, '枣强县', 131100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131122, '武邑县', 131100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131123, '武强县', 131100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131124, '饶阳县', 131100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131125, '安平县', 131100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131126, '故城县', 131100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131127, '景县', 131100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131128, '阜城县', 131100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (131182, '深州市', 131100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140000, '山西省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140100, '太原市', 140000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140105, '小店区', 140100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140106, '迎泽区', 140100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140107, '杏花岭区', 140100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140108, '尖草坪区', 140100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140109, '万柏林区', 140100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140110, '晋源区', 140100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140121, '清徐县', 140100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140122, '阳曲县', 140100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140123, '娄烦县', 140100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140181, '古交市', 140100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140200, '大同市', 140000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140212, '新荣区', 140200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140213, '平城区', 140200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140214, '云冈区', 140200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140215, '云州区', 140200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140221, '阳高县', 140200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140222, '天镇县', 140200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140223, '广灵县', 140200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140224, '灵丘县', 140200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140225, '浑源县', 140200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140226, '左云县', 140200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140300, '阳泉市', 140000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140302, '城区', 140300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140303, '矿区', 140300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140311, '郊区', 140300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140321, '平定县', 140300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140322, '盂县', 140300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140400, '长治市', 140000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140403, '潞州区', 140400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140404, '上党区', 140400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140405, '屯留区', 140400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140406, '潞城区', 140400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140423, '襄垣县', 140400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140425, '平顺县', 140400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140426, '黎城县', 140400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140427, '壶关县', 140400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140428, '长子县', 140400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140429, '武乡县', 140400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140430, '沁县', 140400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140431, '沁源县', 140400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140500, '晋城市', 140000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140502, '城区', 140500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140521, '沁水县', 140500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140522, '阳城县', 140500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140524, '陵川县', 140500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140525, '泽州县', 140500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140581, '高平市', 140500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140600, '朔州市', 140000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140602, '朔城区', 140600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140603, '平鲁区', 140600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140621, '山阴县', 140600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140622, '应县', 140600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140623, '右玉县', 140600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140681, '怀仁市', 140600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140700, '晋中市', 140000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140702, '榆次区', 140700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140703, '太谷区', 140700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140721, '榆社县', 140700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140722, '左权县', 140700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140723, '和顺县', 140700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140724, '昔阳县', 140700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140725, '寿阳县', 140700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140727, '祁县', 140700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140728, '平遥县', 140700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140729, '灵石县', 140700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140781, '介休市', 140700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140800, '运城市', 140000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140802, '盐湖区', 140800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140821, '临猗县', 140800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140822, '万荣县', 140800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140823, '闻喜县', 140800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140824, '稷山县', 140800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140825, '新绛县', 140800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140826, '绛县', 140800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140827, '垣曲县', 140800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140828, '夏县', 140800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140829, '平陆县', 140800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140830, '芮城县', 140800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140881, '永济市', 140800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140882, '河津市', 140800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140900, '忻州市', 140000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140902, '忻府区', 140900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140921, '定襄县', 140900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140922, '五台县', 140900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140923, '代县', 140900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140924, '繁峙县', 140900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140925, '宁武县', 140900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140926, '静乐县', 140900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140927, '神池县', 140900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140928, '五寨县', 140900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140929, '岢岚县', 140900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140930, '河曲县', 140900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140931, '保德县', 140900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140932, '偏关县', 140900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (140981, '原平市', 140900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141000, '临汾市', 140000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141002, '尧都区', 141000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141021, '曲沃县', 141000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141022, '翼城县', 141000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141023, '襄汾县', 141000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141024, '洪洞县', 141000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141025, '古县', 141000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141026, '安泽县', 141000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141027, '浮山县', 141000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141028, '吉县', 141000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141029, '乡宁县', 141000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141030, '大宁县', 141000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141031, '隰县', 141000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141032, '永和县', 141000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141033, '蒲县', 141000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141034, '汾西县', 141000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141081, '侯马市', 141000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141082, '霍州市', 141000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141100, '吕梁市', 140000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141102, '离石区', 141100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141121, '文水县', 141100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141122, '交城县', 141100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141123, '兴县', 141100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141124, '临县', 141100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141125, '柳林县', 141100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141126, '石楼县', 141100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141127, '岚县', 141100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141128, '方山县', 141100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141129, '中阳县', 141100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141130, '交口县', 141100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141181, '孝义市', 141100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (141182, '汾阳市', 141100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150000, '内蒙古自治区', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150100, '呼和浩特市', 150000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150102, '新城区', 150100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150103, '回民区', 150100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150104, '玉泉区', 150100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150105, '赛罕区', 150100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150121, '土默特左旗', 150100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150122, '托克托县', 150100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150123, '和林格尔县', 150100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150124, '清水河县', 150100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150125, '武川县', 150100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150200, '包头市', 150000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150202, '东河区', 150200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150203, '昆都仑区', 150200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150204, '青山区', 150200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150205, '石拐区', 150200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150206, '白云鄂博矿区', 150200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150207, '九原区', 150200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150221, '土默特右旗', 150200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150222, '固阳县', 150200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150223, '达尔罕茂明安联合旗', 150200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150300, '乌海市', 150000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150302, '海勃湾区', 150300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150303, '海南区', 150300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150304, '乌达区', 150300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150400, '赤峰市', 150000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150402, '红山区', 150400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150403, '元宝山区', 150400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150404, '松山区', 150400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150421, '阿鲁科尔沁旗', 150400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150422, '巴林左旗', 150400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150423, '巴林右旗', 150400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150424, '林西县', 150400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150425, '克什克腾旗', 150400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150426, '翁牛特旗', 150400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150428, '喀喇沁旗', 150400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150429, '宁城县', 150400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150430, '敖汉旗', 150400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150500, '通辽市', 150000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150502, '科尔沁区', 150500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150521, '科尔沁左翼中旗', 150500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150522, '科尔沁左翼后旗', 150500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150523, '开鲁县', 150500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150524, '库伦旗', 150500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150525, '奈曼旗', 150500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150526, '扎鲁特旗', 150500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150581, '霍林郭勒市', 150500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150600, '鄂尔多斯市', 150000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150602, '东胜区', 150600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150603, '康巴什区', 150600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150621, '达拉特旗', 150600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150622, '准格尔旗', 150600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150623, '鄂托克前旗', 150600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150624, '鄂托克旗', 150600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150625, '杭锦旗', 150600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150626, '乌审旗', 150600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150627, '伊金霍洛旗', 150600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150700, '呼伦贝尔市', 150000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150702, '海拉尔区', 150700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150703, '扎赉诺尔区', 150700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150721, '阿荣旗', 150700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150722, '莫力达瓦达斡尔族自治旗', 150700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150723, '鄂伦春自治旗', 150700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150724, '鄂温克族自治旗', 150700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150725, '陈巴尔虎旗', 150700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150726, '新巴尔虎左旗', 150700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150727, '新巴尔虎右旗', 150700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150781, '满洲里市', 150700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150782, '牙克石市', 150700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150783, '扎兰屯市', 150700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150784, '额尔古纳市', 150700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150785, '根河市', 150700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150800, '巴彦淖尔市', 150000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150802, '临河区', 150800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150821, '五原县', 150800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150822, '磴口县', 150800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150823, '乌拉特前旗', 150800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150824, '乌拉特中旗', 150800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150825, '乌拉特后旗', 150800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150826, '杭锦后旗', 150800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150900, '乌兰察布市', 150000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150902, '集宁区', 150900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150921, '卓资县', 150900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150922, '化德县', 150900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150923, '商都县', 150900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150924, '兴和县', 150900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150925, '凉城县', 150900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150926, '察哈尔右翼前旗', 150900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150927, '察哈尔右翼中旗', 150900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150928, '察哈尔右翼后旗', 150900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150929, '四子王旗', 150900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (150981, '丰镇市', 150900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152200, '兴安盟', 150000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152201, '乌兰浩特市', 152200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152202, '阿尔山市', 152200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152221, '科尔沁右翼前旗', 152200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152222, '科尔沁右翼中旗', 152200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152223, '扎赉特旗', 152200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152224, '突泉县', 152200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152500, '锡林郭勒盟', 150000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152501, '二连浩特市', 152500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152502, '锡林浩特市', 152500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152522, '阿巴嘎旗', 152500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152523, '苏尼特左旗', 152500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152524, '苏尼特右旗', 152500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152525, '东乌珠穆沁旗', 152500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152526, '西乌珠穆沁旗', 152500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152527, '太仆寺旗', 152500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152528, '镶黄旗', 152500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152529, '正镶白旗', 152500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152530, '正蓝旗', 152500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152531, '多伦县', 152500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152900, '阿拉善盟', 150000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152921, '阿拉善左旗', 152900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152922, '阿拉善右旗', 152900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (152923, '额济纳旗', 152900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210000, '辽宁省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210100, '沈阳市', 210000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210102, '和平区', 210100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210103, '沈河区', 210100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210104, '大东区', 210100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210105, '皇姑区', 210100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210106, '铁西区', 210100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210111, '苏家屯区', 210100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210112, '浑南区', 210100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210113, '沈北新区', 210100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210114, '于洪区', 210100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210115, '辽中区', 210100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210123, '康平县', 210100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210124, '法库县', 210100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210181, '新民市', 210100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210200, '大连市', 210000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210202, '中山区', 210200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210203, '西岗区', 210200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210204, '沙河口区', 210200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210211, '甘井子区', 210200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210212, '旅顺口区', 210200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210213, '金州区', 210200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210214, '普兰店区', 210200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210224, '长海县', 210200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210281, '瓦房店市', 210200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210283, '庄河市', 210200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210300, '鞍山市', 210000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210302, '铁东区', 210300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210303, '铁西区', 210300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210304, '立山区', 210300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210311, '千山区', 210300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210321, '台安县', 210300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210323, '岫岩满族自治县', 210300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210381, '海城市', 210300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210400, '抚顺市', 210000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210402, '新抚区', 210400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210403, '东洲区', 210400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210404, '望花区', 210400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210411, '顺城区', 210400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210421, '抚顺县', 210400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210422, '新宾满族自治县', 210400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210423, '清原满族自治县', 210400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210500, '本溪市', 210000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210502, '平山区', 210500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210503, '溪湖区', 210500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210504, '明山区', 210500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210505, '南芬区', 210500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210521, '本溪满族自治县', 210500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210522, '桓仁满族自治县', 210500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210600, '丹东市', 210000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210602, '元宝区', 210600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210603, '振兴区', 210600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210604, '振安区', 210600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210624, '宽甸满族自治县', 210600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210681, '东港市', 210600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210682, '凤城市', 210600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210700, '锦州市', 210000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210702, '古塔区', 210700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210703, '凌河区', 210700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210711, '太和区', 210700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210726, '黑山县', 210700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210727, '义县', 210700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210781, '凌海市', 210700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210782, '北镇市', 210700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210800, '营口市', 210000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210802, '站前区', 210800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210803, '西市区', 210800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210804, '鲅鱼圈区', 210800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210811, '老边区', 210800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210881, '盖州市', 210800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210882, '大石桥市', 210800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210900, '阜新市', 210000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210902, '海州区', 210900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210903, '新邱区', 210900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210904, '太平区', 210900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210905, '清河门区', 210900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210911, '细河区', 210900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210921, '阜新蒙古族自治县', 210900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (210922, '彰武县', 210900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211000, '辽阳市', 210000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211002, '白塔区', 211000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211003, '文圣区', 211000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211004, '宏伟区', 211000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211005, '弓长岭区', 211000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211011, '太子河区', 211000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211021, '辽阳县', 211000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211081, '灯塔市', 211000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211100, '盘锦市', 210000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211102, '双台子区', 211100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211103, '兴隆台区', 211100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211104, '大洼区', 211100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211122, '盘山县', 211100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211200, '铁岭市', 210000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211202, '银州区', 211200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211204, '清河区', 211200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211221, '铁岭县', 211200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211223, '西丰县', 211200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211224, '昌图县', 211200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211281, '调兵山市', 211200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211282, '开原市', 211200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211300, '朝阳市', 210000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211302, '双塔区', 211300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211303, '龙城区', 211300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211321, '朝阳县', 211300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211322, '建平县', 211300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211324, '喀喇沁左翼蒙古族自治县', 211300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211381, '北票市', 211300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211382, '凌源市', 211300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211400, '葫芦岛市', 210000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211402, '连山区', 211400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211403, '龙港区', 211400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211404, '南票区', 211400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211421, '绥中县', 211400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211422, '建昌县', 211400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (211481, '兴城市', 211400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220000, '吉林省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220100, '长春市', 220000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220102, '南关区', 220100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220103, '宽城区', 220100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220104, '朝阳区', 220100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220105, '二道区', 220100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220106, '绿园区', 220100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220112, '双阳区', 220100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220113, '九台区', 220100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220122, '农安县', 220100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220182, '榆树市', 220100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220183, '德惠市', 220100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220184, '公主岭市', 220100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220200, '吉林市', 220000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220202, '昌邑区', 220200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220203, '龙潭区', 220200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220204, '船营区', 220200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220211, '丰满区', 220200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220221, '永吉县', 220200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220281, '蛟河市', 220200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220282, '桦甸市', 220200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220283, '舒兰市', 220200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220284, '磐石市', 220200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220300, '四平市', 220000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220302, '铁西区', 220300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220303, '铁东区', 220300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220322, '梨树县', 220300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220323, '伊通满族自治县', 220300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220382, '双辽市', 220300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220400, '辽源市', 220000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220402, '龙山区', 220400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220403, '西安区', 220400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220421, '东丰县', 220400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220422, '东辽县', 220400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220500, '通化市', 220000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220502, '东昌区', 220500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220503, '二道江区', 220500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220521, '通化县', 220500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220523, '辉南县', 220500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220524, '柳河县', 220500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220581, '梅河口市', 220500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220582, '集安市', 220500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220600, '白山市', 220000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220602, '浑江区', 220600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220605, '江源区', 220600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220621, '抚松县', 220600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220622, '靖宇县', 220600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220623, '长白朝鲜族自治县', 220600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220681, '临江市', 220600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220700, '松原市', 220000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220702, '宁江区', 220700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220721, '前郭尔罗斯蒙古族自治县', 220700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220722, '长岭县', 220700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220723, '乾安县', 220700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220781, '扶余市', 220700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220800, '白城市', 220000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220802, '洮北区', 220800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220821, '镇赉县', 220800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220822, '通榆县', 220800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220881, '洮南市', 220800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (220882, '大安市', 220800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (222400, '延边朝鲜族自治州', 220000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (222401, '延吉市', 222400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (222402, '图们市', 222400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (222403, '敦化市', 222400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (222404, '珲春市', 222400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (222405, '龙井市', 222400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (222406, '和龙市', 222400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (222424, '汪清县', 222400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (222426, '安图县', 222400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230000, '黑龙江省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230100, '哈尔滨市', 230000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230102, '道里区', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230103, '南岗区', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230104, '道外区', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230108, '平房区', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230109, '松北区', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230110, '香坊区', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230111, '呼兰区', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230112, '阿城区', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230113, '双城区', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230123, '依兰县', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230124, '方正县', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230125, '宾县', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230126, '巴彦县', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230127, '木兰县', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230128, '通河县', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230129, '延寿县', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230183, '尚志市', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230184, '五常市', 230100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230200, '齐齐哈尔市', 230000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230202, '龙沙区', 230200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230203, '建华区', 230200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230204, '铁锋区', 230200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230205, '昂昂溪区', 230200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230206, '富拉尔基区', 230200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230207, '碾子山区', 230200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230208, '梅里斯达斡尔族区', 230200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230221, '龙江县', 230200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230223, '依安县', 230200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230224, '泰来县', 230200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230225, '甘南县', 230200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230227, '富裕县', 230200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230229, '克山县', 230200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230230, '克东县', 230200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230231, '拜泉县', 230200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230281, '讷河市', 230200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230300, '鸡西市', 230000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230302, '鸡冠区', 230300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230303, '恒山区', 230300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230304, '滴道区', 230300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230305, '梨树区', 230300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230306, '城子河区', 230300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230307, '麻山区', 230300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230321, '鸡东县', 230300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230381, '虎林市', 230300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230382, '密山市', 230300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230400, '鹤岗市', 230000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230402, '向阳区', 230400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230403, '工农区', 230400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230404, '南山区', 230400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230405, '兴安区', 230400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230406, '东山区', 230400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230407, '兴山区', 230400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230421, '萝北县', 230400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230422, '绥滨县', 230400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230500, '双鸭山市', 230000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230502, '尖山区', 230500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230503, '岭东区', 230500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230505, '四方台区', 230500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230506, '宝山区', 230500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230521, '集贤县', 230500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230522, '友谊县', 230500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230523, '宝清县', 230500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230524, '饶河县', 230500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230600, '大庆市', 230000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230602, '萨尔图区', 230600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230603, '龙凤区', 230600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230604, '让胡路区', 230600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230605, '红岗区', 230600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230606, '大同区', 230600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230621, '肇州县', 230600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230622, '肇源县', 230600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230623, '林甸县', 230600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230624, '杜尔伯特蒙古族自治县', 230600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230700, '伊春市', 230000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230717, '伊美区', 230700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230718, '乌翠区', 230700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230719, '友好区', 230700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230722, '嘉荫县', 230700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230723, '汤旺县', 230700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230724, '丰林县', 230700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230725, '大箐山县', 230700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230726, '南岔县', 230700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230751, '金林区', 230700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230781, '铁力市', 230700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230800, '佳木斯市', 230000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230803, '向阳区', 230800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230804, '前进区', 230800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230805, '东风区', 230800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230811, '郊区', 230800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230822, '桦南县', 230800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230826, '桦川县', 230800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230828, '汤原县', 230800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230881, '同江市', 230800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230882, '富锦市', 230800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230883, '抚远市', 230800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230900, '七台河市', 230000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230902, '新兴区', 230900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230903, '桃山区', 230900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230904, '茄子河区', 230900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (230921, '勃利县', 230900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231000, '牡丹江市', 230000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231002, '东安区', 231000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231003, '阳明区', 231000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231004, '爱民区', 231000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231005, '西安区', 231000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231025, '林口县', 231000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231081, '绥芬河市', 231000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231083, '海林市', 231000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231084, '宁安市', 231000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231085, '穆棱市', 231000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231086, '东宁市', 231000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231100, '黑河市', 230000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231102, '爱辉区', 231100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231123, '逊克县', 231100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231124, '孙吴县', 231100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231181, '北安市', 231100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231182, '五大连池市', 231100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231183, '嫩江市', 231100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231200, '绥化市', 230000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231202, '北林区', 231200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231221, '望奎县', 231200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231222, '兰西县', 231200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231223, '青冈县', 231200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231224, '庆安县', 231200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231225, '明水县', 231200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231226, '绥棱县', 231200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231281, '安达市', 231200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231282, '肇东市', 231200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (231283, '海伦市', 231200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (232700, '大兴安岭地区', 230000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (232701, '漠河市', 232700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (232721, '呼玛县', 232700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (232722, '塔河县', 232700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310000, '上海市', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310100, '上海市-直辖', 310000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310101, '黄浦区', 310100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310104, '徐汇区', 310100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310105, '长宁区', 310100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310106, '静安区', 310100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310107, '普陀区', 310100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310109, '虹口区', 310100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310110, '杨浦区', 310100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310112, '闵行区', 310100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310113, '宝山区', 310100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310114, '嘉定区', 310100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310115, '浦东新区', 310100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310116, '金山区', 310100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310117, '松江区', 310100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310118, '青浦区', 310100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310120, '奉贤区', 310100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (310151, '崇明区', 310100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320000, '江苏省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320100, '南京市', 320000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320102, '玄武区', 320100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320104, '秦淮区', 320100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320105, '建邺区', 320100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320106, '鼓楼区', 320100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320111, '浦口区', 320100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320113, '栖霞区', 320100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320114, '雨花台区', 320100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320115, '江宁区', 320100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320116, '六合区', 320100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320117, '溧水区', 320100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320118, '高淳区', 320100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320200, '无锡市', 320000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320205, '锡山区', 320200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320206, '惠山区', 320200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320211, '滨湖区', 320200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320213, '梁溪区', 320200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320214, '新吴区', 320200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320281, '江阴市', 320200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320282, '宜兴市', 320200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320300, '徐州市', 320000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320302, '鼓楼区', 320300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320303, '云龙区', 320300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320305, '贾汪区', 320300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320311, '泉山区', 320300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320312, '铜山区', 320300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320321, '丰县', 320300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320322, '沛县', 320300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320324, '睢宁县', 320300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320381, '新沂市', 320300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320382, '邳州市', 320300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320400, '常州市', 320000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320402, '天宁区', 320400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320404, '钟楼区', 320400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320411, '新北区', 320400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320412, '武进区', 320400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320413, '金坛区', 320400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320481, '溧阳市', 320400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320500, '苏州市', 320000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320505, '虎丘区', 320500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320506, '吴中区', 320500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320507, '相城区', 320500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320508, '姑苏区', 320500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320509, '吴江区', 320500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320581, '常熟市', 320500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320582, '张家港市', 320500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320583, '昆山市', 320500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320585, '太仓市', 320500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320600, '南通市', 320000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320612, '通州区', 320600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320613, '崇川区', 320600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320614, '海门区', 320600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320623, '如东县', 320600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320681, '启东市', 320600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320682, '如皋市', 320600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320685, '海安市', 320600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320700, '连云港市', 320000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320703, '连云区', 320700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320706, '海州区', 320700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320707, '赣榆区', 320700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320722, '东海县', 320700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320723, '灌云县', 320700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320724, '灌南县', 320700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320800, '淮安市', 320000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320803, '淮安区', 320800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320804, '淮阴区', 320800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320812, '清江浦区', 320800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320813, '洪泽区', 320800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320826, '涟水县', 320800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320830, '盱眙县', 320800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320831, '金湖县', 320800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320900, '盐城市', 320000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320902, '亭湖区', 320900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320903, '盐都区', 320900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320904, '大丰区', 320900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320921, '响水县', 320900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320922, '滨海县', 320900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320923, '阜宁县', 320900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320924, '射阳县', 320900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320925, '建湖县', 320900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (320981, '东台市', 320900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321000, '扬州市', 320000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321002, '广陵区', 321000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321003, '邗江区', 321000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321012, '江都区', 321000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321023, '宝应县', 321000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321081, '仪征市', 321000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321084, '高邮市', 321000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321100, '镇江市', 320000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321102, '京口区', 321100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321111, '润州区', 321100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321112, '丹徒区', 321100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321181, '丹阳市', 321100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321182, '扬中市', 321100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321183, '句容市', 321100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321200, '泰州市', 320000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321202, '海陵区', 321200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321203, '高港区', 321200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321204, '姜堰区', 321200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321281, '兴化市', 321200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321282, '靖江市', 321200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321283, '泰兴市', 321200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321300, '宿迁市', 320000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321302, '宿城区', 321300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321311, '宿豫区', 321300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321322, '沭阳县', 321300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321323, '泗阳县', 321300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (321324, '泗洪县', 321300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330000, '浙江省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330100, '杭州市', 330000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330102, '上城区', 330100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330103, '下城区', 330100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330104, '江干区', 330100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330105, '拱墅区', 330100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330106, '西湖区', 330100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330108, '滨江区', 330100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330109, '萧山区', 330100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330110, '余杭区', 330100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330111, '富阳区', 330100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330112, '临安区', 330100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330122, '桐庐县', 330100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330127, '淳安县', 330100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330182, '建德市', 330100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330200, '宁波市', 330000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330203, '海曙区', 330200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330205, '江北区', 330200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330206, '北仑区', 330200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330211, '镇海区', 330200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330212, '鄞州区', 330200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330213, '奉化区', 330200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330225, '象山县', 330200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330226, '宁海县', 330200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330281, '余姚市', 330200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330282, '慈溪市', 330200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330300, '温州市', 330000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330302, '鹿城区', 330300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330303, '龙湾区', 330300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330304, '瓯海区', 330300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330305, '洞头区', 330300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330324, '永嘉县', 330300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330326, '平阳县', 330300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330327, '苍南县', 330300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330328, '文成县', 330300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330329, '泰顺县', 330300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330381, '瑞安市', 330300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330382, '乐清市', 330300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330383, '龙港市', 330300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330400, '嘉兴市', 330000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330402, '南湖区', 330400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330411, '秀洲区', 330400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330421, '嘉善县', 330400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330424, '海盐县', 330400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330481, '海宁市', 330400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330482, '平湖市', 330400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330483, '桐乡市', 330400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330500, '湖州市', 330000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330502, '吴兴区', 330500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330503, '南浔区', 330500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330521, '德清县', 330500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330522, '长兴县', 330500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330523, '安吉县', 330500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330600, '绍兴市', 330000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330602, '越城区', 330600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330603, '柯桥区', 330600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330604, '上虞区', 330600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330624, '新昌县', 330600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330681, '诸暨市', 330600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330683, '嵊州市', 330600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330700, '金华市', 330000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330702, '婺城区', 330700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330703, '金东区', 330700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330723, '武义县', 330700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330726, '浦江县', 330700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330727, '磐安县', 330700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330781, '兰溪市', 330700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330782, '义乌市', 330700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330783, '东阳市', 330700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330784, '永康市', 330700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330800, '衢州市', 330000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330802, '柯城区', 330800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330803, '衢江区', 330800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330822, '常山县', 330800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330824, '开化县', 330800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330825, '龙游县', 330800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330881, '江山市', 330800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330900, '舟山市', 330000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330902, '定海区', 330900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330903, '普陀区', 330900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330921, '岱山县', 330900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (330922, '嵊泗县', 330900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331000, '台州市', 330000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331002, '椒江区', 331000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331003, '黄岩区', 331000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331004, '路桥区', 331000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331022, '三门县', 331000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331023, '天台县', 331000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331024, '仙居县', 331000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331081, '温岭市', 331000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331082, '临海市', 331000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331083, '玉环市', 331000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331100, '丽水市', 330000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331102, '莲都区', 331100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331121, '青田县', 331100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331122, '缙云县', 331100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331123, '遂昌县', 331100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331124, '松阳县', 331100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331125, '云和县', 331100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331126, '庆元县', 331100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331127, '景宁畲族自治县', 331100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (331181, '龙泉市', 331100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340000, '安徽省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340100, '合肥市', 340000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340102, '瑶海区', 340100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340103, '庐阳区', 340100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340104, '蜀山区', 340100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340111, '包河区', 340100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340121, '长丰县', 340100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340122, '肥东县', 340100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340123, '肥西县', 340100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340124, '庐江县', 340100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340181, '巢湖市', 340100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340200, '芜湖市', 340000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340202, '镜湖区', 340200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340207, '鸠江区', 340200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340209, '弋江区', 340200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340210, '湾沚区', 340200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340212, '繁昌区', 340200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340223, '南陵县', 340200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340281, '无为市', 340200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340300, '蚌埠市', 340000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340302, '龙子湖区', 340300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340303, '蚌山区', 340300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340304, '禹会区', 340300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340311, '淮上区', 340300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340321, '怀远县', 340300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340322, '五河县', 340300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340323, '固镇县', 340300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340400, '淮南市', 340000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340402, '大通区', 340400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340403, '田家庵区', 340400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340404, '谢家集区', 340400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340405, '八公山区', 340400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340406, '潘集区', 340400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340421, '凤台县', 340400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340422, '寿县', 340400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340500, '马鞍山市', 340000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340503, '花山区', 340500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340504, '雨山区', 340500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340506, '博望区', 340500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340521, '当涂县', 340500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340522, '含山县', 340500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340523, '和县', 340500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340600, '淮北市', 340000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340602, '杜集区', 340600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340603, '相山区', 340600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340604, '烈山区', 340600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340621, '濉溪县', 340600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340700, '铜陵市', 340000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340705, '铜官区', 340700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340706, '义安区', 340700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340711, '郊区', 340700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340722, '枞阳县', 340700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340800, '安庆市', 340000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340802, '迎江区', 340800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340803, '大观区', 340800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340811, '宜秀区', 340800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340822, '怀宁县', 340800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340825, '太湖县', 340800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340826, '宿松县', 340800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340827, '望江县', 340800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340828, '岳西县', 340800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340881, '桐城市', 340800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (340882, '潜山市', 340800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341000, '黄山市', 340000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341002, '屯溪区', 341000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341003, '黄山区', 341000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341004, '徽州区', 341000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341021, '歙县', 341000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341022, '休宁县', 341000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341023, '黟县', 341000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341024, '祁门县', 341000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341100, '滁州市', 340000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341102, '琅琊区', 341100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341103, '南谯区', 341100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341122, '来安县', 341100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341124, '全椒县', 341100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341125, '定远县', 341100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341126, '凤阳县', 341100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341181, '天长市', 341100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341182, '明光市', 341100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341200, '阜阳市', 340000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341202, '颍州区', 341200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341203, '颍东区', 341200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341204, '颍泉区', 341200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341221, '临泉县', 341200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341222, '太和县', 341200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341225, '阜南县', 341200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341226, '颍上县', 341200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341282, '界首市', 341200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341300, '宿州市', 340000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341302, '埇桥区', 341300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341321, '砀山县', 341300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341322, '萧县', 341300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341323, '灵璧县', 341300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341324, '泗县', 341300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341500, '六安市', 340000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341502, '金安区', 341500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341503, '裕安区', 341500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341504, '叶集区', 341500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341522, '霍邱县', 341500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341523, '舒城县', 341500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341524, '金寨县', 341500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341525, '霍山县', 341500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341600, '亳州市', 340000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341602, '谯城区', 341600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341621, '涡阳县', 341600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341622, '蒙城县', 341600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341623, '利辛县', 341600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341700, '池州市', 340000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341702, '贵池区', 341700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341721, '东至县', 341700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341722, '石台县', 341700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341723, '青阳县', 341700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341800, '宣城市', 340000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341802, '宣州区', 341800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341821, '郎溪县', 341800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341823, '泾县', 341800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341824, '绩溪县', 341800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341825, '旌德县', 341800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341881, '宁国市', 341800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (341882, '广德市', 341800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350000, '福建省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350100, '福州市', 350000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350102, '鼓楼区', 350100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350103, '台江区', 350100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350104, '仓山区', 350100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350105, '马尾区', 350100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350111, '晋安区', 350100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350112, '长乐区', 350100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350121, '闽侯县', 350100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350122, '连江县', 350100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350123, '罗源县', 350100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350124, '闽清县', 350100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350125, '永泰县', 350100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350128, '平潭县', 350100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350181, '福清市', 350100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350200, '厦门市', 350000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350203, '思明区', 350200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350205, '海沧区', 350200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350206, '湖里区', 350200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350211, '集美区', 350200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350212, '同安区', 350200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350213, '翔安区', 350200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350300, '莆田市', 350000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350302, '城厢区', 350300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350303, '涵江区', 350300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350304, '荔城区', 350300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350305, '秀屿区', 350300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350322, '仙游县', 350300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350400, '三明市', 350000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350402, '梅列区', 350400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350403, '三元区', 350400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350421, '明溪县', 350400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350423, '清流县', 350400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350424, '宁化县', 350400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350425, '大田县', 350400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350426, '尤溪县', 350400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350427, '沙县', 350400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350428, '将乐县', 350400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350429, '泰宁县', 350400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350430, '建宁县', 350400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350481, '永安市', 350400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350500, '泉州市', 350000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350502, '鲤城区', 350500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350503, '丰泽区', 350500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350504, '洛江区', 350500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350505, '泉港区', 350500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350521, '惠安县', 350500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350524, '安溪县', 350500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350525, '永春县', 350500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350526, '德化县', 350500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350527, '金门县', 350500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350581, '石狮市', 350500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350582, '晋江市', 350500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350583, '南安市', 350500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350600, '漳州市', 350000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350602, '芗城区', 350600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350603, '龙文区', 350600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350622, '云霄县', 350600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350623, '漳浦县', 350600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350624, '诏安县', 350600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350625, '长泰县', 350600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350626, '东山县', 350600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350627, '南靖县', 350600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350628, '平和县', 350600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350629, '华安县', 350600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350681, '龙海市', 350600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350700, '南平市', 350000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350702, '延平区', 350700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350703, '建阳区', 350700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350721, '顺昌县', 350700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350722, '浦城县', 350700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350723, '光泽县', 350700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350724, '松溪县', 350700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350725, '政和县', 350700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350781, '邵武市', 350700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350782, '武夷山市', 350700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350783, '建瓯市', 350700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350800, '龙岩市', 350000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350802, '新罗区', 350800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350803, '永定区', 350800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350821, '长汀县', 350800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350823, '上杭县', 350800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350824, '武平县', 350800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350825, '连城县', 350800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350881, '漳平市', 350800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350900, '宁德市', 350000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350902, '蕉城区', 350900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350921, '霞浦县', 350900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350922, '古田县', 350900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350923, '屏南县', 350900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350924, '寿宁县', 350900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350925, '周宁县', 350900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350926, '柘荣县', 350900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350981, '福安市', 350900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (350982, '福鼎市', 350900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360000, '江西省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360100, '南昌市', 360000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360102, '东湖区', 360100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360103, '西湖区', 360100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360104, '青云谱区', 360100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360111, '青山湖区', 360100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360112, '新建区', 360100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360113, '红谷滩区', 360100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360121, '南昌县', 360100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360123, '安义县', 360100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360124, '进贤县', 360100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360200, '景德镇市', 360000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360202, '昌江区', 360200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360203, '珠山区', 360200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360222, '浮梁县', 360200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360281, '乐平市', 360200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360300, '萍乡市', 360000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360302, '安源区', 360300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360313, '湘东区', 360300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360321, '莲花县', 360300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360322, '上栗县', 360300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360323, '芦溪县', 360300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360400, '九江市', 360000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360402, '濂溪区', 360400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360403, '浔阳区', 360400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360404, '柴桑区', 360400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360423, '武宁县', 360400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360424, '修水县', 360400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360425, '永修县', 360400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360426, '德安县', 360400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360428, '都昌县', 360400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360429, '湖口县', 360400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360430, '彭泽县', 360400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360481, '瑞昌市', 360400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360482, '共青城市', 360400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360483, '庐山市', 360400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360500, '新余市', 360000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360502, '渝水区', 360500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360521, '分宜县', 360500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360600, '鹰潭市', 360000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360602, '月湖区', 360600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360603, '余江区', 360600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360681, '贵溪市', 360600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360700, '赣州市', 360000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360702, '章贡区', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360703, '南康区', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360704, '赣县区', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360722, '信丰县', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360723, '大余县', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360724, '上犹县', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360725, '崇义县', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360726, '安远县', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360728, '定南县', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360729, '全南县', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360730, '宁都县', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360731, '于都县', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360732, '兴国县', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360733, '会昌县', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360734, '寻乌县', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360735, '石城县', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360781, '瑞金市', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360783, '龙南市', 360700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360800, '吉安市', 360000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360802, '吉州区', 360800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360803, '青原区', 360800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360821, '吉安县', 360800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360822, '吉水县', 360800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360823, '峡江县', 360800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360824, '新干县', 360800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360825, '永丰县', 360800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360826, '泰和县', 360800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360827, '遂川县', 360800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360828, '万安县', 360800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360829, '安福县', 360800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360830, '永新县', 360800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360881, '井冈山市', 360800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360900, '宜春市', 360000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360902, '袁州区', 360900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360921, '奉新县', 360900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360922, '万载县', 360900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360923, '上高县', 360900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360924, '宜丰县', 360900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360925, '靖安县', 360900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360926, '铜鼓县', 360900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360981, '丰城市', 360900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360982, '樟树市', 360900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (360983, '高安市', 360900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361000, '抚州市', 360000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361002, '临川区', 361000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361003, '东乡区', 361000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361021, '南城县', 361000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361022, '黎川县', 361000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361023, '南丰县', 361000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361024, '崇仁县', 361000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361025, '乐安县', 361000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361026, '宜黄县', 361000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361027, '金溪县', 361000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361028, '资溪县', 361000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361030, '广昌县', 361000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361100, '上饶市', 360000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361102, '信州区', 361100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361103, '广丰区', 361100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361104, '广信区', 361100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361123, '玉山县', 361100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361124, '铅山县', 361100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361125, '横峰县', 361100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361126, '弋阳县', 361100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361127, '余干县', 361100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361128, '鄱阳县', 361100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361129, '万年县', 361100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361130, '婺源县', 361100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (361181, '德兴市', 361100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370000, '山东省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370100, '济南市', 370000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370102, '历下区', 370100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370103, '市中区', 370100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370104, '槐荫区', 370100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370105, '天桥区', 370100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370112, '历城区', 370100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370113, '长清区', 370100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370114, '章丘区', 370100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370115, '济阳区', 370100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370116, '莱芜区', 370100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370117, '钢城区', 370100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370124, '平阴县', 370100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370126, '商河县', 370100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370200, '青岛市', 370000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370202, '市南区', 370200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370203, '市北区', 370200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370211, '黄岛区', 370200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370212, '崂山区', 370200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370213, '李沧区', 370200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370214, '城阳区', 370200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370215, '即墨区', 370200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370281, '胶州市', 370200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370283, '平度市', 370200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370285, '莱西市', 370200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370300, '淄博市', 370000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370302, '淄川区', 370300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370303, '张店区', 370300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370304, '博山区', 370300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370305, '临淄区', 370300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370306, '周村区', 370300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370321, '桓台县', 370300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370322, '高青县', 370300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370323, '沂源县', 370300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370400, '枣庄市', 370000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370402, '市中区', 370400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370403, '薛城区', 370400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370404, '峄城区', 370400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370405, '台儿庄区', 370400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370406, '山亭区', 370400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370481, '滕州市', 370400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370500, '东营市', 370000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370502, '东营区', 370500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370503, '河口区', 370500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370505, '垦利区', 370500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370522, '利津县', 370500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370523, '广饶县', 370500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370600, '烟台市', 370000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370602, '芝罘区', 370600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370611, '福山区', 370600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370612, '牟平区', 370600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370613, '莱山区', 370600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370614, '蓬莱区', 370600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370681, '龙口市', 370600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370682, '莱阳市', 370600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370683, '莱州市', 370600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370685, '招远市', 370600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370686, '栖霞市', 370600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370687, '海阳市', 370600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370700, '潍坊市', 370000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370702, '潍城区', 370700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370703, '寒亭区', 370700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370704, '坊子区', 370700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370705, '奎文区', 370700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370724, '临朐县', 370700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370725, '昌乐县', 370700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370781, '青州市', 370700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370782, '诸城市', 370700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370783, '寿光市', 370700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370784, '安丘市', 370700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370785, '高密市', 370700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370786, '昌邑市', 370700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370800, '济宁市', 370000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370811, '任城区', 370800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370812, '兖州区', 370800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370826, '微山县', 370800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370827, '鱼台县', 370800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370828, '金乡县', 370800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370829, '嘉祥县', 370800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370830, '汶上县', 370800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370831, '泗水县', 370800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370832, '梁山县', 370800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370881, '曲阜市', 370800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370883, '邹城市', 370800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370900, '泰安市', 370000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370902, '泰山区', 370900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370911, '岱岳区', 370900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370921, '宁阳县', 370900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370923, '东平县', 370900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370982, '新泰市', 370900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (370983, '肥城市', 370900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371000, '威海市', 370000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371002, '环翠区', 371000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371003, '文登区', 371000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371082, '荣成市', 371000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371083, '乳山市', 371000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371100, '日照市', 370000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371102, '东港区', 371100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371103, '岚山区', 371100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371121, '五莲县', 371100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371122, '莒县', 371100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371300, '临沂市', 370000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371302, '兰山区', 371300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371311, '罗庄区', 371300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371312, '河东区', 371300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371321, '沂南县', 371300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371322, '郯城县', 371300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371323, '沂水县', 371300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371324, '兰陵县', 371300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371325, '费县', 371300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371326, '平邑县', 371300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371327, '莒南县', 371300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371328, '蒙阴县', 371300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371329, '临沭县', 371300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371400, '德州市', 370000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371402, '德城区', 371400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371403, '陵城区', 371400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371422, '宁津县', 371400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371423, '庆云县', 371400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371424, '临邑县', 371400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371425, '齐河县', 371400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371426, '平原县', 371400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371427, '夏津县', 371400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371428, '武城县', 371400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371481, '乐陵市', 371400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371482, '禹城市', 371400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371500, '聊城市', 370000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371502, '东昌府区', 371500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371503, '茌平区', 371500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371521, '阳谷县', 371500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371522, '莘县', 371500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371524, '东阿县', 371500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371525, '冠县', 371500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371526, '高唐县', 371500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371581, '临清市', 371500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371600, '滨州市', 370000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371602, '滨城区', 371600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371603, '沾化区', 371600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371621, '惠民县', 371600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371622, '阳信县', 371600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371623, '无棣县', 371600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371625, '博兴县', 371600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371681, '邹平市', 371600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371700, '菏泽市', 370000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371702, '牡丹区', 371700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371703, '定陶区', 371700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371721, '曹县', 371700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371722, '单县', 371700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371723, '成武县', 371700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371724, '巨野县', 371700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371725, '郓城县', 371700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371726, '鄄城县', 371700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (371728, '东明县', 371700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410000, '河南省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410100, '郑州市', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410102, '中原区', 410100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410103, '二七区', 410100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410104, '管城回族区', 410100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410105, '金水区', 410100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410106, '上街区', 410100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410108, '惠济区', 410100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410122, '中牟县', 410100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410181, '巩义市', 410100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410182, '荥阳市', 410100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410183, '新密市', 410100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410184, '新郑市', 410100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410185, '登封市', 410100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410200, '开封市', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410202, '龙亭区', 410200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410203, '顺河回族区', 410200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410204, '鼓楼区', 410200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410205, '禹王台区', 410200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410212, '祥符区', 410200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410221, '杞县', 410200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410222, '通许县', 410200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410223, '尉氏县', 410200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410225, '兰考县', 410200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410300, '洛阳市', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410302, '老城区', 410300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410303, '西工区', 410300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410304, '瀍河回族区', 410300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410305, '涧西区', 410300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410306, '吉利区', 410300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410311, '洛龙区', 410300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410322, '孟津县', 410300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410323, '新安县', 410300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410324, '栾川县', 410300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410325, '嵩县', 410300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410326, '汝阳县', 410300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410327, '宜阳县', 410300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410328, '洛宁县', 410300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410329, '伊川县', 410300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410381, '偃师市', 410300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410400, '平顶山市', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410402, '新华区', 410400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410403, '卫东区', 410400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410404, '石龙区', 410400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410411, '湛河区', 410400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410421, '宝丰县', 410400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410422, '叶县', 410400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410423, '鲁山县', 410400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410425, '郏县', 410400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410481, '舞钢市', 410400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410482, '汝州市', 410400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410500, '安阳市', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410502, '文峰区', 410500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410503, '北关区', 410500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410505, '殷都区', 410500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410506, '龙安区', 410500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410522, '安阳县', 410500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410523, '汤阴县', 410500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410526, '滑县', 410500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410527, '内黄县', 410500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410581, '林州市', 410500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410600, '鹤壁市', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410602, '鹤山区', 410600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410603, '山城区', 410600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410611, '淇滨区', 410600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410621, '浚县', 410600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410622, '淇县', 410600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410700, '新乡市', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410702, '红旗区', 410700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410703, '卫滨区', 410700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410704, '凤泉区', 410700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410711, '牧野区', 410700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410721, '新乡县', 410700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410724, '获嘉县', 410700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410725, '原阳县', 410700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410726, '延津县', 410700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410727, '封丘县', 410700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410781, '卫辉市', 410700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410782, '辉县市', 410700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410783, '长垣市', 410700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410800, '焦作市', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410802, '解放区', 410800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410803, '中站区', 410800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410804, '马村区', 410800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410811, '山阳区', 410800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410821, '修武县', 410800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410822, '博爱县', 410800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410823, '武陟县', 410800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410825, '温县', 410800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410882, '沁阳市', 410800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410883, '孟州市', 410800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410900, '濮阳市', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410902, '华龙区', 410900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410922, '清丰县', 410900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410923, '南乐县', 410900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410926, '范县', 410900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410927, '台前县', 410900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (410928, '濮阳县', 410900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411000, '许昌市', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411002, '魏都区', 411000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411003, '建安区', 411000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411024, '鄢陵县', 411000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411025, '襄城县', 411000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411081, '禹州市', 411000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411082, '长葛市', 411000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411100, '漯河市', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411102, '源汇区', 411100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411103, '郾城区', 411100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411104, '召陵区', 411100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411121, '舞阳县', 411100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411122, '临颍县', 411100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411200, '三门峡市', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411202, '湖滨区', 411200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411203, '陕州区', 411200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411221, '渑池县', 411200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411224, '卢氏县', 411200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411281, '义马市', 411200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411282, '灵宝市', 411200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411300, '南阳市', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411302, '宛城区', 411300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411303, '卧龙区', 411300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411321, '南召县', 411300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411322, '方城县', 411300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411323, '西峡县', 411300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411324, '镇平县', 411300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411325, '内乡县', 411300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411326, '淅川县', 411300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411327, '社旗县', 411300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411328, '唐河县', 411300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411329, '新野县', 411300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411330, '桐柏县', 411300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411381, '邓州市', 411300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411400, '商丘市', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411402, '梁园区', 411400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411403, '睢阳区', 411400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411421, '民权县', 411400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411422, '睢县', 411400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411423, '宁陵县', 411400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411424, '柘城县', 411400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411425, '虞城县', 411400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411426, '夏邑县', 411400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411481, '永城市', 411400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411500, '信阳市', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411502, '浉河区', 411500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411503, '平桥区', 411500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411521, '罗山县', 411500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411522, '光山县', 411500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411523, '新县', 411500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411524, '商城县', 411500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411525, '固始县', 411500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411526, '潢川县', 411500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411527, '淮滨县', 411500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411528, '息县', 411500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411600, '周口市', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411602, '川汇区', 411600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411603, '淮阳区', 411600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411621, '扶沟县', 411600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411622, '西华县', 411600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411623, '商水县', 411600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411624, '沈丘县', 411600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411625, '郸城县', 411600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411627, '太康县', 411600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411628, '鹿邑县', 411600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411681, '项城市', 411600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411700, '驻马店市', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411702, '驿城区', 411700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411721, '西平县', 411700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411722, '上蔡县', 411700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411723, '平舆县', 411700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411724, '正阳县', 411700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411725, '确山县', 411700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411726, '泌阳县', 411700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411727, '汝南县', 411700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411728, '遂平县', 411700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (411729, '新蔡县', 411700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (419000, '河南省-直辖', 410000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (419001, '济源市', 419000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420000, '湖北省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420100, '武汉市', 420000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420102, '江岸区', 420100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420103, '江汉区', 420100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420104, '硚口区', 420100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420105, '汉阳区', 420100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420106, '武昌区', 420100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420107, '青山区', 420100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420111, '洪山区', 420100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420112, '东西湖区', 420100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420113, '汉南区', 420100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420114, '蔡甸区', 420100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420115, '江夏区', 420100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420116, '黄陂区', 420100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420117, '新洲区', 420100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420200, '黄石市', 420000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420202, '黄石港区', 420200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420203, '西塞山区', 420200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420204, '下陆区', 420200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420205, '铁山区', 420200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420222, '阳新县', 420200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420281, '大冶市', 420200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420300, '十堰市', 420000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420302, '茅箭区', 420300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420303, '张湾区', 420300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420304, '郧阳区', 420300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420322, '郧西县', 420300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420323, '竹山县', 420300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420324, '竹溪县', 420300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420325, '房县', 420300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420381, '丹江口市', 420300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420500, '宜昌市', 420000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420502, '西陵区', 420500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420503, '伍家岗区', 420500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420504, '点军区', 420500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420505, '猇亭区', 420500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420506, '夷陵区', 420500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420525, '远安县', 420500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420526, '兴山县', 420500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420527, '秭归县', 420500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420528, '长阳土家族自治县', 420500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420529, '五峰土家族自治县', 420500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420581, '宜都市', 420500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420582, '当阳市', 420500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420583, '枝江市', 420500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420600, '襄阳市', 420000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420602, '襄城区', 420600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420606, '樊城区', 420600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420607, '襄州区', 420600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420624, '南漳县', 420600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420625, '谷城县', 420600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420626, '保康县', 420600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420682, '老河口市', 420600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420683, '枣阳市', 420600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420684, '宜城市', 420600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420700, '鄂州市', 420000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420702, '梁子湖区', 420700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420703, '华容区', 420700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420704, '鄂城区', 420700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420800, '荆门市', 420000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420802, '东宝区', 420800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420804, '掇刀区', 420800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420822, '沙洋县', 420800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420881, '钟祥市', 420800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420882, '京山市', 420800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420900, '孝感市', 420000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420902, '孝南区', 420900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420921, '孝昌县', 420900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420922, '大悟县', 420900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420923, '云梦县', 420900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420981, '应城市', 420900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420982, '安陆市', 420900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (420984, '汉川市', 420900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421000, '荆州市', 420000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421002, '沙市区', 421000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421003, '荆州区', 421000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421022, '公安县', 421000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421024, '江陵县', 421000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421081, '石首市', 421000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421083, '洪湖市', 421000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421087, '松滋市', 421000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421088, '监利市', 421000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421100, '黄冈市', 420000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421102, '黄州区', 421100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421121, '团风县', 421100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421122, '红安县', 421100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421123, '罗田县', 421100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421124, '英山县', 421100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421125, '浠水县', 421100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421126, '蕲春县', 421100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421127, '黄梅县', 421100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421181, '麻城市', 421100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421182, '武穴市', 421100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421200, '咸宁市', 420000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421202, '咸安区', 421200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421221, '嘉鱼县', 421200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421222, '通城县', 421200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421223, '崇阳县', 421200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421224, '通山县', 421200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421281, '赤壁市', 421200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421300, '随州市', 420000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421303, '曾都区', 421300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421321, '随县', 421300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (421381, '广水市', 421300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (422800, '恩施土家族苗族自治州', 420000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (422801, '恩施市', 422800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (422802, '利川市', 422800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (422822, '建始县', 422800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (422823, '巴东县', 422800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (422825, '宣恩县', 422800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (422826, '咸丰县', 422800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (422827, '来凤县', 422800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (422828, '鹤峰县', 422800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (429000, '湖北省-直辖', 420000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (429004, '仙桃市', 429000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (429005, '潜江市', 429000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (429006, '天门市', 429000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (429021, '神农架林区', 429000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430000, '湖南省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430100, '长沙市', 430000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430102, '芙蓉区', 430100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430103, '天心区', 430100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430104, '岳麓区', 430100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430105, '开福区', 430100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430111, '雨花区', 430100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430112, '望城区', 430100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430121, '长沙县', 430100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430181, '浏阳市', 430100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430182, '宁乡市', 430100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430200, '株洲市', 430000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430202, '荷塘区', 430200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430203, '芦淞区', 430200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430204, '石峰区', 430200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430211, '天元区', 430200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430212, '渌口区', 430200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430223, '攸县', 430200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430224, '茶陵县', 430200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430225, '炎陵县', 430200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430281, '醴陵市', 430200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430300, '湘潭市', 430000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430302, '雨湖区', 430300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430304, '岳塘区', 430300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430321, '湘潭县', 430300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430381, '湘乡市', 430300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430382, '韶山市', 430300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430400, '衡阳市', 430000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430405, '珠晖区', 430400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430406, '雁峰区', 430400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430407, '石鼓区', 430400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430408, '蒸湘区', 430400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430412, '南岳区', 430400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430421, '衡阳县', 430400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430422, '衡南县', 430400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430423, '衡山县', 430400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430424, '衡东县', 430400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430426, '祁东县', 430400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430481, '耒阳市', 430400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430482, '常宁市', 430400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430500, '邵阳市', 430000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430502, '双清区', 430500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430503, '大祥区', 430500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430511, '北塔区', 430500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430522, '新邵县', 430500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430523, '邵阳县', 430500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430524, '隆回县', 430500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430525, '洞口县', 430500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430527, '绥宁县', 430500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430528, '新宁县', 430500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430529, '城步苗族自治县', 430500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430581, '武冈市', 430500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430582, '邵东市', 430500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430600, '岳阳市', 430000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430602, '岳阳楼区', 430600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430603, '云溪区', 430600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430611, '君山区', 430600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430621, '岳阳县', 430600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430623, '华容县', 430600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430624, '湘阴县', 430600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430626, '平江县', 430600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430681, '汨罗市', 430600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430682, '临湘市', 430600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430700, '常德市', 430000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430702, '武陵区', 430700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430703, '鼎城区', 430700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430721, '安乡县', 430700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430722, '汉寿县', 430700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430723, '澧县', 430700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430724, '临澧县', 430700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430725, '桃源县', 430700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430726, '石门县', 430700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430781, '津市市', 430700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430800, '张家界市', 430000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430802, '永定区', 430800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430811, '武陵源区', 430800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430821, '慈利县', 430800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430822, '桑植县', 430800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430900, '益阳市', 430000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430902, '资阳区', 430900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430903, '赫山区', 430900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430921, '南县', 430900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430922, '桃江县', 430900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430923, '安化县', 430900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (430981, '沅江市', 430900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431000, '郴州市', 430000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431002, '北湖区', 431000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431003, '苏仙区', 431000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431021, '桂阳县', 431000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431022, '宜章县', 431000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431023, '永兴县', 431000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431024, '嘉禾县', 431000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431025, '临武县', 431000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431026, '汝城县', 431000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431027, '桂东县', 431000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431028, '安仁县', 431000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431081, '资兴市', 431000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431100, '永州市', 430000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431102, '零陵区', 431100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431103, '冷水滩区', 431100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431121, '祁阳县', 431100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431122, '东安县', 431100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431123, '双牌县', 431100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431124, '道县', 431100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431125, '江永县', 431100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431126, '宁远县', 431100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431127, '蓝山县', 431100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431128, '新田县', 431100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431129, '江华瑶族自治县', 431100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431200, '怀化市', 430000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431202, '鹤城区', 431200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431221, '中方县', 431200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431222, '沅陵县', 431200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431223, '辰溪县', 431200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431224, '溆浦县', 431200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431225, '会同县', 431200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431226, '麻阳苗族自治县', 431200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431227, '新晃侗族自治县', 431200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431228, '芷江侗族自治县', 431200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431229, '靖州苗族侗族自治县', 431200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431230, '通道侗族自治县', 431200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431281, '洪江市', 431200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431300, '娄底市', 430000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431302, '娄星区', 431300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431321, '双峰县', 431300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431322, '新化县', 431300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431381, '冷水江市', 431300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (431382, '涟源市', 431300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (433100, '湘西土家族苗族自治州', 430000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (433101, '吉首市', 433100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (433122, '泸溪县', 433100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (433123, '凤凰县', 433100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (433124, '花垣县', 433100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (433125, '保靖县', 433100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (433126, '古丈县', 433100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (433127, '永顺县', 433100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (433130, '龙山县', 433100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440000, '广东省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440100, '广州市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440103, '荔湾区', 440100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440104, '越秀区', 440100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440105, '海珠区', 440100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440106, '天河区', 440100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440111, '白云区', 440100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440112, '黄埔区', 440100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440113, '番禺区', 440100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440114, '花都区', 440100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440115, '南沙区', 440100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440117, '从化区', 440100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440118, '增城区', 440100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440200, '韶关市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440203, '武江区', 440200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440204, '浈江区', 440200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440205, '曲江区', 440200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440222, '始兴县', 440200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440224, '仁化县', 440200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440229, '翁源县', 440200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440232, '乳源瑶族自治县', 440200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440233, '新丰县', 440200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440281, '乐昌市', 440200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440282, '南雄市', 440200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440300, '深圳市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440303, '罗湖区', 440300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440304, '福田区', 440300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440305, '南山区', 440300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440306, '宝安区', 440300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440307, '龙岗区', 440300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440308, '盐田区', 440300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440309, '龙华区', 440300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440310, '坪山区', 440300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440311, '光明区', 440300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440400, '珠海市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440402, '香洲区', 440400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440403, '斗门区', 440400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440404, '金湾区', 440400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440500, '汕头市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440507, '龙湖区', 440500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440511, '金平区', 440500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440512, '濠江区', 440500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440513, '潮阳区', 440500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440514, '潮南区', 440500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440515, '澄海区', 440500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440523, '南澳县', 440500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440600, '佛山市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440604, '禅城区', 440600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440605, '南海区', 440600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440606, '顺德区', 440600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440607, '三水区', 440600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440608, '高明区', 440600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440700, '江门市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440703, '蓬江区', 440700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440704, '江海区', 440700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440705, '新会区', 440700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440781, '台山市', 440700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440783, '开平市', 440700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440784, '鹤山市', 440700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440785, '恩平市', 440700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440800, '湛江市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440802, '赤坎区', 440800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440803, '霞山区', 440800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440804, '坡头区', 440800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440811, '麻章区', 440800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440823, '遂溪县', 440800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440825, '徐闻县', 440800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440881, '廉江市', 440800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440882, '雷州市', 440800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440883, '吴川市', 440800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440900, '茂名市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440902, '茂南区', 440900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440904, '电白区', 440900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440981, '高州市', 440900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440982, '化州市', 440900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (440983, '信宜市', 440900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441200, '肇庆市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441202, '端州区', 441200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441203, '鼎湖区', 441200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441204, '高要区', 441200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441223, '广宁县', 441200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441224, '怀集县', 441200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441225, '封开县', 441200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441226, '德庆县', 441200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441284, '四会市', 441200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441300, '惠州市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441302, '惠城区', 441300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441303, '惠阳区', 441300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441322, '博罗县', 441300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441323, '惠东县', 441300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441324, '龙门县', 441300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441400, '梅州市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441402, '梅江区', 441400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441403, '梅县区', 441400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441422, '大埔县', 441400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441423, '丰顺县', 441400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441424, '五华县', 441400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441426, '平远县', 441400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441427, '蕉岭县', 441400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441481, '兴宁市', 441400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441500, '汕尾市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441502, '城区', 441500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441521, '海丰县', 441500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441523, '陆河县', 441500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441581, '陆丰市', 441500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441600, '河源市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441602, '源城区', 441600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441621, '紫金县', 441600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441622, '龙川县', 441600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441623, '连平县', 441600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441624, '和平县', 441600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441625, '东源县', 441600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441700, '阳江市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441702, '江城区', 441700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441704, '阳东区', 441700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441721, '阳西县', 441700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441781, '阳春市', 441700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441800, '清远市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441802, '清城区', 441800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441803, '清新区', 441800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441821, '佛冈县', 441800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441823, '阳山县', 441800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441825, '连山壮族瑶族自治县', 441800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441826, '连南瑶族自治县', 441800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441881, '英德市', 441800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441882, '连州市', 441800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (441900, '东莞市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (442000, '中山市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (445100, '潮州市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (445102, '湘桥区', 445100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (445103, '潮安区', 445100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (445122, '饶平县', 445100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (445200, '揭阳市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (445202, '榕城区', 445200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (445203, '揭东区', 445200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (445222, '揭西县', 445200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (445224, '惠来县', 445200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (445281, '普宁市', 445200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (445300, '云浮市', 440000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (445302, '云城区', 445300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (445303, '云安区', 445300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (445321, '新兴县', 445300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (445322, '郁南县', 445300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (445381, '罗定市', 445300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450000, '广西壮族自治区', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450100, '南宁市', 450000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450102, '兴宁区', 450100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450103, '青秀区', 450100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450105, '江南区', 450100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450107, '西乡塘区', 450100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450108, '良庆区', 450100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450109, '邕宁区', 450100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450110, '武鸣区', 450100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450123, '隆安县', 450100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450124, '马山县', 450100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450125, '上林县', 450100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450126, '宾阳县', 450100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450127, '横县', 450100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450200, '柳州市', 450000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450202, '城中区', 450200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450203, '鱼峰区', 450200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450204, '柳南区', 450200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450205, '柳北区', 450200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450206, '柳江区', 450200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450222, '柳城县', 450200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450223, '鹿寨县', 450200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450224, '融安县', 450200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450225, '融水苗族自治县', 450200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450226, '三江侗族自治县', 450200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450300, '桂林市', 450000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450302, '秀峰区', 450300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450303, '叠彩区', 450300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450304, '象山区', 450300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450305, '七星区', 450300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450311, '雁山区', 450300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450312, '临桂区', 450300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450321, '阳朔县', 450300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450323, '灵川县', 450300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450324, '全州县', 450300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450325, '兴安县', 450300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450326, '永福县', 450300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450327, '灌阳县', 450300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450328, '龙胜各族自治县', 450300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450329, '资源县', 450300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450330, '平乐县', 450300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450332, '恭城瑶族自治县', 450300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450381, '荔浦市', 450300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450400, '梧州市', 450000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450403, '万秀区', 450400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450405, '长洲区', 450400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450406, '龙圩区', 450400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450421, '苍梧县', 450400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450422, '藤县', 450400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450423, '蒙山县', 450400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450481, '岑溪市', 450400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450500, '北海市', 450000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450502, '海城区', 450500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450503, '银海区', 450500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450512, '铁山港区', 450500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450521, '合浦县', 450500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450600, '防城港市', 450000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450602, '港口区', 450600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450603, '防城区', 450600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450621, '上思县', 450600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450681, '东兴市', 450600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450700, '钦州市', 450000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450702, '钦南区', 450700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450703, '钦北区', 450700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450721, '灵山县', 450700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450722, '浦北县', 450700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450800, '贵港市', 450000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450802, '港北区', 450800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450803, '港南区', 450800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450804, '覃塘区', 450800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450821, '平南县', 450800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450881, '桂平市', 450800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450900, '玉林市', 450000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450902, '玉州区', 450900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450903, '福绵区', 450900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450921, '容县', 450900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450922, '陆川县', 450900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450923, '博白县', 450900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450924, '兴业县', 450900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (450981, '北流市', 450900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451000, '百色市', 450000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451002, '右江区', 451000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451003, '田阳区', 451000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451022, '田东县', 451000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451024, '德保县', 451000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451026, '那坡县', 451000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451027, '凌云县', 451000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451028, '乐业县', 451000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451029, '田林县', 451000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451030, '西林县', 451000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451031, '隆林各族自治县', 451000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451081, '靖西市', 451000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451082, '平果市', 451000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451100, '贺州市', 450000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451102, '八步区', 451100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451103, '平桂区', 451100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451121, '昭平县', 451100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451122, '钟山县', 451100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451123, '富川瑶族自治县', 451100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451200, '河池市', 450000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451202, '金城江区', 451200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451203, '宜州区', 451200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451221, '南丹县', 451200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451222, '天峨县', 451200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451223, '凤山县', 451200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451224, '东兰县', 451200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451225, '罗城仫佬族自治县', 451200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451226, '环江毛南族自治县', 451200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451227, '巴马瑶族自治县', 451200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451228, '都安瑶族自治县', 451200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451229, '大化瑶族自治县', 451200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451300, '来宾市', 450000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451302, '兴宾区', 451300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451321, '忻城县', 451300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451322, '象州县', 451300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451323, '武宣县', 451300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451324, '金秀瑶族自治县', 451300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451381, '合山市', 451300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451400, '崇左市', 450000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451402, '江州区', 451400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451421, '扶绥县', 451400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451422, '宁明县', 451400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451423, '龙州县', 451400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451424, '大新县', 451400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451425, '天等县', 451400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (451481, '凭祥市', 451400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (460000, '海南省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (460100, '海口市', 460000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (460105, '秀英区', 460100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (460106, '龙华区', 460100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (460107, '琼山区', 460100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (460108, '美兰区', 460100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (460200, '三亚市', 460000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (460202, '海棠区', 460200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (460203, '吉阳区', 460200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (460204, '天涯区', 460200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (460205, '崖州区', 460200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (460300, '三沙市', 460000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (460400, '儋州市', 460000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (469000, '海南省-直辖', 460000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (469001, '五指山市', 469000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (469002, '琼海市', 469000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (469005, '文昌市', 469000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (469006, '万宁市', 469000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (469007, '东方市', 469000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (469021, '定安县', 469000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (469022, '屯昌县', 469000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (469023, '澄迈县', 469000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (469024, '临高县', 469000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (469025, '白沙黎族自治县', 469000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (469026, '昌江黎族自治县', 469000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (469027, '乐东黎族自治县', 469000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (469028, '陵水黎族自治县', 469000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (469029, '保亭黎族苗族自治县', 469000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (469030, '琼中黎族苗族自治县', 469000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500000, '重庆市', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500100, '重庆市-直辖区', 500000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500101, '万州区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500102, '涪陵区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500103, '渝中区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500104, '大渡口区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500105, '江北区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500106, '沙坪坝区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500107, '九龙坡区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500108, '南岸区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500109, '北碚区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500110, '綦江区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500111, '大足区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500112, '渝北区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500113, '巴南区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500114, '黔江区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500115, '长寿区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500116, '江津区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500117, '合川区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500118, '永川区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500119, '南川区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500120, '璧山区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500151, '铜梁区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500152, '潼南区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500153, '荣昌区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500154, '开州区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500155, '梁平区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500156, '武隆区', 500100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500200, '重庆市-直辖县', 500000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500229, '城口县', 500200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500230, '丰都县', 500200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500231, '垫江县', 500200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500233, '忠县', 500200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500235, '云阳县', 500200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500236, '奉节县', 500200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500237, '巫山县', 500200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500238, '巫溪县', 500200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500240, '石柱土家族自治县', 500200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500241, '秀山土家族苗族自治县', 500200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500242, '酉阳土家族苗族自治县', 500200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (500243, '彭水苗族土家族自治县', 500200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510000, '四川省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510100, '成都市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510104, '锦江区', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510105, '青羊区', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510106, '金牛区', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510107, '武侯区', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510108, '成华区', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510112, '龙泉驿区', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510113, '青白江区', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510114, '新都区', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510115, '温江区', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510116, '双流区', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510117, '郫都区', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510118, '新津区', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510121, '金堂县', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510129, '大邑县', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510131, '蒲江县', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510181, '都江堰市', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510182, '彭州市', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510183, '邛崃市', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510184, '崇州市', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510185, '简阳市', 510100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510300, '自贡市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510302, '自流井区', 510300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510303, '贡井区', 510300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510304, '大安区', 510300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510311, '沿滩区', 510300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510321, '荣县', 510300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510322, '富顺县', 510300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510400, '攀枝花市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510402, '东区', 510400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510403, '西区', 510400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510411, '仁和区', 510400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510421, '米易县', 510400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510422, '盐边县', 510400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510500, '泸州市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510502, '江阳区', 510500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510503, '纳溪区', 510500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510504, '龙马潭区', 510500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510521, '泸县', 510500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510522, '合江县', 510500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510524, '叙永县', 510500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510525, '古蔺县', 510500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510600, '德阳市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510603, '旌阳区', 510600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510604, '罗江区', 510600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510623, '中江县', 510600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510681, '广汉市', 510600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510682, '什邡市', 510600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510683, '绵竹市', 510600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510700, '绵阳市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510703, '涪城区', 510700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510704, '游仙区', 510700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510705, '安州区', 510700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510722, '三台县', 510700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510723, '盐亭县', 510700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510725, '梓潼县', 510700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510726, '北川羌族自治县', 510700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510727, '平武县', 510700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510781, '江油市', 510700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510800, '广元市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510802, '利州区', 510800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510811, '昭化区', 510800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510812, '朝天区', 510800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510821, '旺苍县', 510800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510822, '青川县', 510800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510823, '剑阁县', 510800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510824, '苍溪县', 510800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510900, '遂宁市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510903, '船山区', 510900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510904, '安居区', 510900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510921, '蓬溪县', 510900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510923, '大英县', 510900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (510981, '射洪市', 510900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511000, '内江市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511002, '市中区', 511000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511011, '东兴区', 511000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511024, '威远县', 511000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511025, '资中县', 511000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511083, '隆昌市', 511000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511100, '乐山市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511102, '市中区', 511100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511111, '沙湾区', 511100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511112, '五通桥区', 511100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511113, '金口河区', 511100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511123, '犍为县', 511100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511124, '井研县', 511100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511126, '夹江县', 511100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511129, '沐川县', 511100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511132, '峨边彝族自治县', 511100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511133, '马边彝族自治县', 511100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511181, '峨眉山市', 511100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511300, '南充市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511302, '顺庆区', 511300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511303, '高坪区', 511300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511304, '嘉陵区', 511300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511321, '南部县', 511300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511322, '营山县', 511300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511323, '蓬安县', 511300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511324, '仪陇县', 511300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511325, '西充县', 511300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511381, '阆中市', 511300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511400, '眉山市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511402, '东坡区', 511400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511403, '彭山区', 511400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511421, '仁寿县', 511400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511423, '洪雅县', 511400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511424, '丹棱县', 511400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511425, '青神县', 511400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511500, '宜宾市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511502, '翠屏区', 511500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511503, '南溪区', 511500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511504, '叙州区', 511500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511523, '江安县', 511500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511524, '长宁县', 511500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511525, '高县', 511500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511526, '珙县', 511500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511527, '筠连县', 511500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511528, '兴文县', 511500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511529, '屏山县', 511500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511600, '广安市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511602, '广安区', 511600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511603, '前锋区', 511600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511621, '岳池县', 511600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511622, '武胜县', 511600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511623, '邻水县', 511600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511681, '华蓥市', 511600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511700, '达州市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511702, '通川区', 511700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511703, '达川区', 511700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511722, '宣汉县', 511700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511723, '开江县', 511700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511724, '大竹县', 511700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511725, '渠县', 511700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511781, '万源市', 511700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511800, '雅安市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511802, '雨城区', 511800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511803, '名山区', 511800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511822, '荥经县', 511800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511823, '汉源县', 511800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511824, '石棉县', 511800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511825, '天全县', 511800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511826, '芦山县', 511800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511827, '宝兴县', 511800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511900, '巴中市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511902, '巴州区', 511900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511903, '恩阳区', 511900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511921, '通江县', 511900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511922, '南江县', 511900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (511923, '平昌县', 511900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (512000, '资阳市', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (512002, '雁江区', 512000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (512021, '安岳县', 512000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (512022, '乐至县', 512000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513200, '阿坝藏族羌族自治州', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513201, '马尔康市', 513200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513221, '汶川县', 513200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513222, '理县', 513200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513223, '茂县', 513200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513224, '松潘县', 513200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513225, '九寨沟县', 513200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513226, '金川县', 513200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513227, '小金县', 513200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513228, '黑水县', 513200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513230, '壤塘县', 513200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513231, '阿坝县', 513200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513232, '若尔盖县', 513200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513233, '红原县', 513200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513300, '甘孜藏族自治州', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513301, '康定市', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513322, '泸定县', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513323, '丹巴县', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513324, '九龙县', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513325, '雅江县', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513326, '道孚县', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513327, '炉霍县', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513328, '甘孜县', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513329, '新龙县', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513330, '德格县', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513331, '白玉县', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513332, '石渠县', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513333, '色达县', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513334, '理塘县', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513335, '巴塘县', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513336, '乡城县', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513337, '稻城县', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513338, '得荣县', 513300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513400, '凉山彝族自治州', 510000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513401, '西昌市', 513400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513422, '木里藏族自治县', 513400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513423, '盐源县', 513400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513424, '德昌县', 513400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513425, '会理县', 513400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513426, '会东县', 513400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513427, '宁南县', 513400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513428, '普格县', 513400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513429, '布拖县', 513400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513430, '金阳县', 513400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513431, '昭觉县', 513400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513432, '喜德县', 513400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513433, '冕宁县', 513400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513434, '越西县', 513400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513435, '甘洛县', 513400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513436, '美姑县', 513400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (513437, '雷波县', 513400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520000, '贵州省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520100, '贵阳市', 520000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520102, '南明区', 520100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520103, '云岩区', 520100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520111, '花溪区', 520100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520112, '乌当区', 520100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520113, '白云区', 520100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520115, '观山湖区', 520100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520121, '开阳县', 520100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520122, '息烽县', 520100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520123, '修文县', 520100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520181, '清镇市', 520100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520200, '六盘水市', 520000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520201, '钟山区', 520200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520203, '六枝特区', 520200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520204, '水城区', 520200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520281, '盘州市', 520200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520300, '遵义市', 520000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520302, '红花岗区', 520300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520303, '汇川区', 520300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520304, '播州区', 520300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520322, '桐梓县', 520300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520323, '绥阳县', 520300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520324, '正安县', 520300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520325, '道真仡佬族苗族自治县', 520300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520326, '务川仡佬族苗族自治县', 520300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520327, '凤冈县', 520300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520328, '湄潭县', 520300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520329, '余庆县', 520300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520330, '习水县', 520300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520381, '赤水市', 520300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520382, '仁怀市', 520300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520400, '安顺市', 520000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520402, '西秀区', 520400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520403, '平坝区', 520400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520422, '普定县', 520400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520423, '镇宁布依族苗族自治县', 520400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520424, '关岭布依族苗族自治县', 520400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520425, '紫云苗族布依族自治县', 520400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520500, '毕节市', 520000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520502, '七星关区', 520500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520521, '大方县', 520500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520522, '黔西县', 520500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520523, '金沙县', 520500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520524, '织金县', 520500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520525, '纳雍县', 520500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520526, '威宁彝族回族苗族自治县', 520500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520527, '赫章县', 520500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520600, '铜仁市', 520000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520602, '碧江区', 520600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520603, '万山区', 520600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520621, '江口县', 520600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520622, '玉屏侗族自治县', 520600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520623, '石阡县', 520600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520624, '思南县', 520600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520625, '印江土家族苗族自治县', 520600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520626, '德江县', 520600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520627, '沿河土家族自治县', 520600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (520628, '松桃苗族自治县', 520600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522300, '黔西南布依族苗族自治州', 520000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522301, '兴义市', 522300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522302, '兴仁市', 522300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522323, '普安县', 522300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522324, '晴隆县', 522300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522325, '贞丰县', 522300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522326, '望谟县', 522300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522327, '册亨县', 522300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522328, '安龙县', 522300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522600, '黔东南苗族侗族自治州', 520000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522601, '凯里市', 522600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522622, '黄平县', 522600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522623, '施秉县', 522600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522624, '三穗县', 522600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522625, '镇远县', 522600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522626, '岑巩县', 522600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522627, '天柱县', 522600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522628, '锦屏县', 522600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522629, '剑河县', 522600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522630, '台江县', 522600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522631, '黎平县', 522600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522632, '榕江县', 522600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522633, '从江县', 522600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522634, '雷山县', 522600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522635, '麻江县', 522600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522636, '丹寨县', 522600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522700, '黔南布依族苗族自治州', 520000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522701, '都匀市', 522700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522702, '福泉市', 522700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522722, '荔波县', 522700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522723, '贵定县', 522700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522725, '瓮安县', 522700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522726, '独山县', 522700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522727, '平塘县', 522700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522728, '罗甸县', 522700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522729, '长顺县', 522700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522730, '龙里县', 522700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522731, '惠水县', 522700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (522732, '三都水族自治县', 522700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530000, '云南省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530100, '昆明市', 530000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530102, '五华区', 530100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530103, '盘龙区', 530100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530111, '官渡区', 530100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530112, '西山区', 530100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530113, '东川区', 530100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530114, '呈贡区', 530100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530115, '晋宁区', 530100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530124, '富民县', 530100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530125, '宜良县', 530100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530126, '石林彝族自治县', 530100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530127, '嵩明县', 530100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530128, '禄劝彝族苗族自治县', 530100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530129, '寻甸回族彝族自治县', 530100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530181, '安宁市', 530100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530300, '曲靖市', 530000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530302, '麒麟区', 530300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530303, '沾益区', 530300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530304, '马龙区', 530300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530322, '陆良县', 530300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530323, '师宗县', 530300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530324, '罗平县', 530300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530325, '富源县', 530300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530326, '会泽县', 530300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530381, '宣威市', 530300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530400, '玉溪市', 530000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530402, '红塔区', 530400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530403, '江川区', 530400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530423, '通海县', 530400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530424, '华宁县', 530400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530425, '易门县', 530400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530426, '峨山彝族自治县', 530400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530427, '新平彝族傣族自治县', 530400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530428, '元江哈尼族彝族傣族自治县', 530400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530481, '澄江市', 530400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530500, '保山市', 530000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530502, '隆阳区', 530500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530521, '施甸县', 530500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530523, '龙陵县', 530500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530524, '昌宁县', 530500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530581, '腾冲市', 530500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530600, '昭通市', 530000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530602, '昭阳区', 530600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530621, '鲁甸县', 530600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530622, '巧家县', 530600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530623, '盐津县', 530600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530624, '大关县', 530600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530625, '永善县', 530600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530626, '绥江县', 530600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530627, '镇雄县', 530600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530628, '彝良县', 530600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530629, '威信县', 530600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530681, '水富市', 530600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530700, '丽江市', 530000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530702, '古城区', 530700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530721, '玉龙纳西族自治县', 530700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530722, '永胜县', 530700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530723, '华坪县', 530700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530724, '宁蒗彝族自治县', 530700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530800, '普洱市', 530000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530802, '思茅区', 530800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530821, '宁洱哈尼族彝族自治县', 530800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530822, '墨江哈尼族自治县', 530800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530823, '景东彝族自治县', 530800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530824, '景谷傣族彝族自治县', 530800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530825, '镇沅彝族哈尼族拉祜族自治县', 530800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530826, '江城哈尼族彝族自治县', 530800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530827, '孟连傣族拉祜族佤族自治县', 530800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530828, '澜沧拉祜族自治县', 530800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530829, '西盟佤族自治县', 530800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530900, '临沧市', 530000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530902, '临翔区', 530900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530921, '凤庆县', 530900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530922, '云县', 530900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530923, '永德县', 530900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530924, '镇康县', 530900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530925, '双江拉祜族佤族布朗族傣族自治县', 530900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530926, '耿马傣族佤族自治县', 530900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (530927, '沧源佤族自治县', 530900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532300, '楚雄彝族自治州', 530000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532301, '楚雄市', 532300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532322, '双柏县', 532300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532323, '牟定县', 532300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532324, '南华县', 532300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532325, '姚安县', 532300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532326, '大姚县', 532300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532327, '永仁县', 532300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532328, '元谋县', 532300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532329, '武定县', 532300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532331, '禄丰县', 532300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532500, '红河哈尼族彝族自治州', 530000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532501, '个旧市', 532500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532502, '开远市', 532500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532503, '蒙自市', 532500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532504, '弥勒市', 532500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532523, '屏边苗族自治县', 532500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532524, '建水县', 532500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532525, '石屏县', 532500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532527, '泸西县', 532500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532528, '元阳县', 532500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532529, '红河县', 532500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532530, '金平苗族瑶族傣族自治县', 532500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532531, '绿春县', 532500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532532, '河口瑶族自治县', 532500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532600, '文山壮族苗族自治州', 530000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532601, '文山市', 532600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532622, '砚山县', 532600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532623, '西畴县', 532600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532624, '麻栗坡县', 532600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532625, '马关县', 532600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532626, '丘北县', 532600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532627, '广南县', 532600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532628, '富宁县', 532600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532800, '西双版纳傣族自治州', 530000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532801, '景洪市', 532800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532822, '勐海县', 532800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532823, '勐腊县', 532800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532900, '大理白族自治州', 530000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532901, '大理市', 532900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532922, '漾濞彝族自治县', 532900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532923, '祥云县', 532900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532924, '宾川县', 532900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532925, '弥渡县', 532900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532926, '南涧彝族自治县', 532900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532927, '巍山彝族回族自治县', 532900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532928, '永平县', 532900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532929, '云龙县', 532900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532930, '洱源县', 532900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532931, '剑川县', 532900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (532932, '鹤庆县', 532900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (533100, '德宏傣族景颇族自治州', 530000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (533102, '瑞丽市', 533100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (533103, '芒市', 533100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (533122, '梁河县', 533100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (533123, '盈江县', 533100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (533124, '陇川县', 533100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (533300, '怒江傈僳族自治州', 530000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (533301, '泸水市', 533300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (533323, '福贡县', 533300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (533324, '贡山独龙族怒族自治县', 533300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (533325, '兰坪白族普米族自治县', 533300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (533400, '迪庆藏族自治州', 530000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (533401, '香格里拉市', 533400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (533422, '德钦县', 533400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (533423, '维西傈僳族自治县', 533400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540000, '西藏自治区', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540100, '拉萨市', 540000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540102, '城关区', 540100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540103, '堆龙德庆区', 540100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540104, '达孜区', 540100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540121, '林周县', 540100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540122, '当雄县', 540100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540123, '尼木县', 540100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540124, '曲水县', 540100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540127, '墨竹工卡县', 540100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540200, '日喀则市', 540000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540202, '桑珠孜区', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540221, '南木林县', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540222, '江孜县', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540223, '定日县', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540224, '萨迦县', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540225, '拉孜县', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540226, '昂仁县', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540227, '谢通门县', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540228, '白朗县', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540229, '仁布县', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540230, '康马县', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540231, '定结县', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540232, '仲巴县', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540233, '亚东县', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540234, '吉隆县', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540235, '聂拉木县', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540236, '萨嘎县', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540237, '岗巴县', 540200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540300, '昌都市', 540000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540302, '卡若区', 540300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540321, '江达县', 540300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540322, '贡觉县', 540300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540323, '类乌齐县', 540300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540324, '丁青县', 540300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540325, '察雅县', 540300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540326, '八宿县', 540300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540327, '左贡县', 540300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540328, '芒康县', 540300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540329, '洛隆县', 540300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540330, '边坝县', 540300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540400, '林芝市', 540000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540402, '巴宜区', 540400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540421, '工布江达县', 540400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540422, '米林县', 540400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540423, '墨脱县', 540400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540424, '波密县', 540400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540425, '察隅县', 540400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540426, '朗县', 540400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540500, '山南市', 540000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540502, '乃东区', 540500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540521, '扎囊县', 540500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540522, '贡嘎县', 540500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540523, '桑日县', 540500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540524, '琼结县', 540500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540525, '曲松县', 540500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540526, '措美县', 540500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540527, '洛扎县', 540500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540528, '加查县', 540500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540529, '隆子县', 540500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540530, '错那县', 540500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540531, '浪卡子县', 540500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540600, '那曲市', 540000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540602, '色尼区', 540600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540621, '嘉黎县', 540600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540622, '比如县', 540600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540623, '聂荣县', 540600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540624, '安多县', 540600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540625, '申扎县', 540600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540626, '索县', 540600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540627, '班戈县', 540600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540628, '巴青县', 540600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540629, '尼玛县', 540600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (540630, '双湖县', 540600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (542500, '阿里地区', 540000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (542521, '普兰县', 542500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (542522, '札达县', 542500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (542523, '噶尔县', 542500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (542524, '日土县', 542500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (542525, '革吉县', 542500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (542526, '改则县', 542500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (542527, '措勤县', 542500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610000, '陕西省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610100, '西安市', 610000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610102, '新城区', 610100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610103, '碑林区', 610100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610104, '莲湖区', 610100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610111, '灞桥区', 610100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610112, '未央区', 610100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610113, '雁塔区', 610100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610114, '阎良区', 610100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610115, '临潼区', 610100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610116, '长安区', 610100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610117, '高陵区', 610100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610118, '鄠邑区', 610100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610122, '蓝田县', 610100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610124, '周至县', 610100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610200, '铜川市', 610000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610202, '王益区', 610200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610203, '印台区', 610200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610204, '耀州区', 610200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610222, '宜君县', 610200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610300, '宝鸡市', 610000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610302, '渭滨区', 610300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610303, '金台区', 610300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610304, '陈仓区', 610300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610322, '凤翔县', 610300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610323, '岐山县', 610300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610324, '扶风县', 610300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610326, '眉县', 610300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610327, '陇县', 610300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610328, '千阳县', 610300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610329, '麟游县', 610300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610330, '凤县', 610300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610331, '太白县', 610300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610400, '咸阳市', 610000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610402, '秦都区', 610400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610403, '杨陵区', 610400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610404, '渭城区', 610400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610422, '三原县', 610400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610423, '泾阳县', 610400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610424, '乾县', 610400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610425, '礼泉县', 610400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610426, '永寿县', 610400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610428, '长武县', 610400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610429, '旬邑县', 610400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610430, '淳化县', 610400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610431, '武功县', 610400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610481, '兴平市', 610400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610482, '彬州市', 610400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610500, '渭南市', 610000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610502, '临渭区', 610500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610503, '华州区', 610500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610522, '潼关县', 610500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610523, '大荔县', 610500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610524, '合阳县', 610500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610525, '澄城县', 610500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610526, '蒲城县', 610500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610527, '白水县', 610500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610528, '富平县', 610500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610581, '韩城市', 610500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610582, '华阴市', 610500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610600, '延安市', 610000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610602, '宝塔区', 610600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610603, '安塞区', 610600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610621, '延长县', 610600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610622, '延川县', 610600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610625, '志丹县', 610600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610626, '吴起县', 610600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610627, '甘泉县', 610600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610628, '富县', 610600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610629, '洛川县', 610600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610630, '宜川县', 610600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610631, '黄龙县', 610600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610632, '黄陵县', 610600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610681, '子长市', 610600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610700, '汉中市', 610000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610702, '汉台区', 610700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610703, '南郑区', 610700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610722, '城固县', 610700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610723, '洋县', 610700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610724, '西乡县', 610700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610725, '勉县', 610700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610726, '宁强县', 610700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610727, '略阳县', 610700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610728, '镇巴县', 610700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610729, '留坝县', 610700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610730, '佛坪县', 610700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610800, '榆林市', 610000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610802, '榆阳区', 610800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610803, '横山区', 610800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610822, '府谷县', 610800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610824, '靖边县', 610800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610825, '定边县', 610800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610826, '绥德县', 610800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610827, '米脂县', 610800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610828, '佳县', 610800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610829, '吴堡县', 610800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610830, '清涧县', 610800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610831, '子洲县', 610800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610881, '神木市', 610800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610900, '安康市', 610000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610902, '汉滨区', 610900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610921, '汉阴县', 610900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610922, '石泉县', 610900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610923, '宁陕县', 610900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610924, '紫阳县', 610900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610925, '岚皋县', 610900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610926, '平利县', 610900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610927, '镇坪县', 610900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610928, '旬阳县', 610900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (610929, '白河县', 610900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (611000, '商洛市', 610000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (611002, '商州区', 611000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (611021, '洛南县', 611000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (611022, '丹凤县', 611000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (611023, '商南县', 611000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (611024, '山阳县', 611000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (611025, '镇安县', 611000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (611026, '柞水县', 611000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620000, '甘肃省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620100, '兰州市', 620000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620102, '城关区', 620100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620103, '七里河区', 620100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620104, '西固区', 620100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620105, '安宁区', 620100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620111, '红古区', 620100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620121, '永登县', 620100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620122, '皋兰县', 620100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620123, '榆中县', 620100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620200, '嘉峪关市', 620000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620300, '金昌市', 620000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620302, '金川区', 620300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620321, '永昌县', 620300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620400, '白银市', 620000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620402, '白银区', 620400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620403, '平川区', 620400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620421, '靖远县', 620400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620422, '会宁县', 620400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620423, '景泰县', 620400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620500, '天水市', 620000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620502, '秦州区', 620500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620503, '麦积区', 620500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620521, '清水县', 620500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620522, '秦安县', 620500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620523, '甘谷县', 620500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620524, '武山县', 620500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620525, '张家川回族自治县', 620500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620600, '武威市', 620000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620602, '凉州区', 620600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620621, '民勤县', 620600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620622, '古浪县', 620600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620623, '天祝藏族自治县', 620600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620700, '张掖市', 620000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620702, '甘州区', 620700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620721, '肃南裕固族自治县', 620700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620722, '民乐县', 620700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620723, '临泽县', 620700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620724, '高台县', 620700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620725, '山丹县', 620700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620800, '平凉市', 620000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620802, '崆峒区', 620800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620821, '泾川县', 620800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620822, '灵台县', 620800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620823, '崇信县', 620800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620825, '庄浪县', 620800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620826, '静宁县', 620800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620881, '华亭市', 620800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620900, '酒泉市', 620000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620902, '肃州区', 620900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620921, '金塔县', 620900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620922, '瓜州县', 620900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620923, '肃北蒙古族自治县', 620900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620924, '阿克塞哈萨克族自治县', 620900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620981, '玉门市', 620900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (620982, '敦煌市', 620900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621000, '庆阳市', 620000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621002, '西峰区', 621000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621021, '庆城县', 621000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621022, '环县', 621000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621023, '华池县', 621000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621024, '合水县', 621000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621025, '正宁县', 621000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621026, '宁县', 621000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621027, '镇原县', 621000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621100, '定西市', 620000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621102, '安定区', 621100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621121, '通渭县', 621100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621122, '陇西县', 621100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621123, '渭源县', 621100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621124, '临洮县', 621100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621125, '漳县', 621100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621126, '岷县', 621100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621200, '陇南市', 620000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621202, '武都区', 621200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621221, '成县', 621200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621222, '文县', 621200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621223, '宕昌县', 621200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621224, '康县', 621200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621225, '西和县', 621200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621226, '礼县', 621200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621227, '徽县', 621200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (621228, '两当县', 621200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (622900, '临夏回族自治州', 620000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (622901, '临夏市', 622900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (622921, '临夏县', 622900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (622922, '康乐县', 622900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (622923, '永靖县', 622900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (622924, '广河县', 622900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (622925, '和政县', 622900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (622926, '东乡族自治县', 622900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (622927, '积石山保安族东乡族撒拉族自治县', 622900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (623000, '甘南藏族自治州', 620000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (623001, '合作市', 623000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (623021, '临潭县', 623000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (623022, '卓尼县', 623000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (623023, '舟曲县', 623000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (623024, '迭部县', 623000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (623025, '玛曲县', 623000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (623026, '碌曲县', 623000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (623027, '夏河县', 623000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (630000, '青海省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (630100, '西宁市', 630000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (630102, '城东区', 630100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (630103, '城中区', 630100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (630104, '城西区', 630100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (630105, '城北区', 630100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (630106, '湟中区', 630100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (630121, '大通回族土族自治县', 630100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (630123, '湟源县', 630100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (630200, '海东市', 630000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (630202, '乐都区', 630200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (630203, '平安区', 630200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (630222, '民和回族土族自治县', 630200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (630223, '互助土族自治县', 630200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (630224, '化隆回族自治县', 630200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (630225, '循化撒拉族自治县', 630200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632200, '海北藏族自治州', 630000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632221, '门源回族自治县', 632200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632222, '祁连县', 632200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632223, '海晏县', 632200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632224, '刚察县', 632200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632300, '黄南藏族自治州', 630000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632301, '同仁市', 632300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632322, '尖扎县', 632300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632323, '泽库县', 632300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632324, '河南蒙古族自治县', 632300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632500, '海南藏族自治州', 630000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632521, '共和县', 632500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632522, '同德县', 632500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632523, '贵德县', 632500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632524, '兴海县', 632500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632525, '贵南县', 632500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632600, '果洛藏族自治州', 630000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632621, '玛沁县', 632600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632622, '班玛县', 632600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632623, '甘德县', 632600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632624, '达日县', 632600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632625, '久治县', 632600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632626, '玛多县', 632600, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632700, '玉树藏族自治州', 630000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632701, '玉树市', 632700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632722, '杂多县', 632700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632723, '称多县', 632700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632724, '治多县', 632700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632725, '囊谦县', 632700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632726, '曲麻莱县', 632700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632800, '海西蒙古族藏族自治州', 630000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632801, '格尔木市', 632800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632802, '德令哈市', 632800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632803, '茫崖市', 632800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632821, '乌兰县', 632800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632822, '都兰县', 632800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (632823, '天峻县', 632800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640000, '宁夏回族自治区', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640100, '银川市', 640000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640104, '兴庆区', 640100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640105, '西夏区', 640100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640106, '金凤区', 640100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640121, '永宁县', 640100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640122, '贺兰县', 640100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640181, '灵武市', 640100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640200, '石嘴山市', 640000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640202, '大武口区', 640200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640205, '惠农区', 640200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640221, '平罗县', 640200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640300, '吴忠市', 640000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640302, '利通区', 640300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640303, '红寺堡区', 640300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640323, '盐池县', 640300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640324, '同心县', 640300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640381, '青铜峡市', 640300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640400, '固原市', 640000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640402, '原州区', 640400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640422, '西吉县', 640400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640423, '隆德县', 640400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640424, '泾源县', 640400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640425, '彭阳县', 640400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640500, '中卫市', 640000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640502, '沙坡头区', 640500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640521, '中宁县', 640500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (640522, '海原县', 640500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650000, '新疆维吾尔自治区', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650100, '乌鲁木齐市', 650000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650102, '天山区', 650100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650103, '沙依巴克区', 650100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650104, '新市区', 650100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650105, '水磨沟区', 650100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650106, '头屯河区', 650100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650107, '达坂城区', 650100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650109, '米东区', 650100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650121, '乌鲁木齐县', 650100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650200, '克拉玛依市', 650000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650202, '独山子区', 650200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650203, '克拉玛依区', 650200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650204, '白碱滩区', 650200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650205, '乌尔禾区', 650200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650400, '吐鲁番市', 650000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650402, '高昌区', 650400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650421, '鄯善县', 650400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650422, '托克逊县', 650400, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650500, '哈密市', 650000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650502, '伊州区', 650500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650521, '巴里坤哈萨克自治县', 650500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (650522, '伊吾县', 650500, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652300, '昌吉回族自治州', 650000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652301, '昌吉市', 652300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652302, '阜康市', 652300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652323, '呼图壁县', 652300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652324, '玛纳斯县', 652300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652325, '奇台县', 652300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652327, '吉木萨尔县', 652300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652328, '木垒哈萨克自治县', 652300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652700, '博尔塔拉蒙古自治州', 650000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652701, '博乐市', 652700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652702, '阿拉山口市', 652700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652722, '精河县', 652700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652723, '温泉县', 652700, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652800, '巴音郭楞蒙古自治州', 650000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652801, '库尔勒市', 652800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652822, '轮台县', 652800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652823, '尉犁县', 652800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652824, '若羌县', 652800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652825, '且末县', 652800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652826, '焉耆回族自治县', 652800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652827, '和静县', 652800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652828, '和硕县', 652800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652829, '博湖县', 652800, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652900, '阿克苏地区', 650000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652901, '阿克苏市', 652900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652902, '库车市', 652900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652922, '温宿县', 652900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652924, '沙雅县', 652900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652925, '新和县', 652900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652926, '拜城县', 652900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652927, '乌什县', 652900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652928, '阿瓦提县', 652900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (652929, '柯坪县', 652900, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653000, '克孜勒苏柯尔克孜自治州', 650000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653001, '阿图什市', 653000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653022, '阿克陶县', 653000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653023, '阿合奇县', 653000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653024, '乌恰县', 653000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653100, '喀什地区', 650000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653101, '喀什市', 653100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653121, '疏附县', 653100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653122, '疏勒县', 653100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653123, '英吉沙县', 653100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653124, '泽普县', 653100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653125, '莎车县', 653100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653126, '叶城县', 653100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653127, '麦盖提县', 653100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653128, '岳普湖县', 653100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653129, '伽师县', 653100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653130, '巴楚县', 653100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653131, '塔什库尔干塔吉克自治县', 653100, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653200, '和田地区', 650000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653201, '和田市', 653200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653221, '和田县', 653200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653222, '墨玉县', 653200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653223, '皮山县', 653200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653224, '洛浦县', 653200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653225, '策勒县', 653200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653226, '于田县', 653200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (653227, '民丰县', 653200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654000, '伊犁哈萨克自治州', 650000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654002, '伊宁市', 654000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654003, '奎屯市', 654000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654004, '霍尔果斯市', 654000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654021, '伊宁县', 654000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654022, '察布查尔锡伯自治县', 654000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654023, '霍城县', 654000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654024, '巩留县', 654000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654025, '新源县', 654000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654026, '昭苏县', 654000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654027, '特克斯县', 654000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654028, '尼勒克县', 654000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654200, '塔城地区', 650000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654201, '塔城市', 654200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654202, '乌苏市', 654200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654221, '额敏县', 654200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654223, '沙湾县', 654200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654224, '托里县', 654200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654225, '裕民县', 654200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654226, '和布克赛尔蒙古自治县', 654200, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654300, '阿勒泰地区', 650000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654301, '阿勒泰市', 654300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654321, '布尔津县', 654300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654322, '富蕴县', 654300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654323, '福海县', 654300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654324, '哈巴河县', 654300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654325, '青河县', 654300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (654326, '吉木乃县', 654300, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (659000, '新疆维吾尔自治区-直辖', 650000, 2, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (659001, '石河子市', 659000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (659002, '阿拉尔市', 659000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (659003, '图木舒克市', 659000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (659004, '五家渠市', 659000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (659005, '北屯市', 659000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (659006, '铁门关市', 659000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (659007, '双河市', 659000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (659008, '可克达拉市', 659000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (659009, '昆玉市', 659000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (659010, '胡杨河市', 659000, 3, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (710000, '台湾省', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (810000, '香港特别行政区', NULL, 1, NULL, NULL);
INSERT INTO `mdm_gbt2260` VALUES (820000, '澳门特别行政区', NULL, 1, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
                              `permission_id` bigint NOT NULL COMMENT '主键',
                              `permission_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限名称',
                              `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                              `enable_flag` tinyint NOT NULL DEFAULT '1' COMMENT '是否启用',
                              `delete_flag` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
                              `create_time` datetime NOT NULL COMMENT '创建时间',
                              `create_user_id` bigint DEFAULT NULL COMMENT '创建人',
                              `update_time` datetime NOT NULL COMMENT '更新时间',
                              `update_user_id` bigint DEFAULT NULL COMMENT '修改人',
                              PRIMARY KEY (`permission_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of permission
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for permission_resource_ref
-- ----------------------------
DROP TABLE IF EXISTS `permission_resource_ref`;
CREATE TABLE `permission_resource_ref` (
                                           `id` bigint NOT NULL COMMENT '主键',
                                           `permission_id` bigint NOT NULL COMMENT '权限ID',
                                           `resource_id` bigint NOT NULL COMMENT '资源ID',
                                           `create_time` datetime NOT NULL COMMENT '创建时间',
                                           `create_user_id` bigint DEFAULT NULL COMMENT '创建人',
                                           PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of permission_resource_ref
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for post_info
-- ----------------------------
DROP TABLE IF EXISTS `post_info`;
CREATE TABLE `post_info` (
                             `post_id` bigint NOT NULL COMMENT '主键',
                             `post_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '系统编码',
                             `post_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
                             `enable_flag` tinyint NOT NULL DEFAULT '1' COMMENT '是否启用',
                             `delete_flag` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
                             `create_time` datetime NOT NULL COMMENT '创建时间',
                             `create_user_id` bigint DEFAULT NULL COMMENT '创建人',
                             `update_time` datetime NOT NULL COMMENT '更新时间',
                             `update_user_id` bigint DEFAULT NULL COMMENT '修改人',
                             PRIMARY KEY (`post_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of post_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_BLOB_TRIGGERS`;
CREATE TABLE `qrtz_BLOB_TRIGGERS` (
                                      `SCHED_NAME` varchar(120) NOT NULL COMMENT '计划名',
                                      `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
                                      `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
                                      `BLOB_DATA` blob,
                                      PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
                                      KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='以Blob 类型存储的触发器';

-- ----------------------------
-- Records of qrtz_BLOB_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_CALENDARS`;
CREATE TABLE `qrtz_CALENDARS` (
                                  `SCHED_NAME` varchar(120) NOT NULL COMMENT '计划名称',
                                  `CALENDAR_NAME` varchar(200) NOT NULL,
                                  `CALENDAR` blob NOT NULL,
                                  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日历信息';

-- ----------------------------
-- Records of qrtz_CALENDARS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_CRON_TRIGGERS`;
CREATE TABLE `qrtz_CRON_TRIGGERS` (
                                      `SCHED_NAME` varchar(120) NOT NULL COMMENT '计划名称',
                                      `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
                                      `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
                                      `CRON_EXPRESSION` varchar(120) NOT NULL COMMENT '时间表达式',
                                      `TIME_ZONE_ID` varchar(80) DEFAULT NULL COMMENT '时区ID   nvarchar   80',
                                      PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='定时触发器';

-- ----------------------------
-- Records of qrtz_CRON_TRIGGERS
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_CRON_TRIGGERS` VALUES ('DefaultTapClusterScheduler', '1', 'DEFAULT', '0 0/1 * * * ? ', 'Asia/Shanghai');
COMMIT;

-- ----------------------------
-- Table structure for qrtz_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_FIRED_TRIGGERS`;
CREATE TABLE `qrtz_FIRED_TRIGGERS` (
                                       `SCHED_NAME` varchar(120) NOT NULL COMMENT '计划名称',
                                       `ENTRY_ID` varchar(95) NOT NULL COMMENT '组标识',
                                       `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
                                       `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
                                       `INSTANCE_NAME` varchar(200) NOT NULL COMMENT '当前实例的名称',
                                       `FIRED_TIME` bigint NOT NULL COMMENT '当前执行时间',
                                       `SCHED_TIME` bigint NOT NULL COMMENT '计划时间',
                                       `PRIORITY` int NOT NULL COMMENT '权重',
                                       `STATE` varchar(16) NOT NULL COMMENT '状态：WAITING:等待 \r\nPAUSED:暂停 \r\nACQUIRED:正常执行 \r\nBLOCKED：阻塞 \r\nERROR：错误',
                                       `JOB_NAME` varchar(200) DEFAULT NULL COMMENT '作业名称',
                                       `JOB_GROUP` varchar(200) DEFAULT NULL COMMENT '作业组',
                                       `IS_NONCONCURRENT` varchar(1) DEFAULT NULL COMMENT '是否并行',
                                       `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL COMMENT '是否要求唤醒',
                                       PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
                                       KEY `IDX_qrtz_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`),
                                       KEY `IDX_qrtz_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
                                       KEY `IDX_qrtz_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
                                       KEY `IDX_qrtz_FT_JG` (`SCHED_NAME`,`JOB_GROUP`),
                                       KEY `IDX_qrtz_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
                                       KEY `IDX_qrtz_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='保存已经触发的触发器状态信息';

-- ----------------------------
-- Records of qrtz_FIRED_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_JOB_DETAILS`;
CREATE TABLE `qrtz_JOB_DETAILS` (
                                    `SCHED_NAME` varchar(120) NOT NULL COMMENT '计划名称',
                                    `JOB_NAME` varchar(200) NOT NULL COMMENT '集群中job的名字',
                                    `JOB_GROUP` varchar(200) NOT NULL COMMENT '集群中job的所属组的名字',
                                    `DESCRIPTION` varchar(250) DEFAULT NULL COMMENT '描述',
                                    `JOB_CLASS_NAME` varchar(250) NOT NULL COMMENT '作业程序类名',
                                    `IS_DURABLE` varchar(1) NOT NULL COMMENT '是否持久',
                                    `IS_NONCONCURRENT` varchar(1) NOT NULL COMMENT '是否并行',
                                    `IS_UPDATE_DATA` varchar(1) NOT NULL COMMENT '是否更新',
                                    `REQUESTS_RECOVERY` varchar(1) NOT NULL COMMENT '是否要求唤醒',
                                    `JOB_DATA` blob,
                                    PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
                                    KEY `IDX_qrtz_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`),
                                    KEY `IDX_qrtz_J_GRP` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='job 详细信息';

-- ----------------------------
-- Records of qrtz_JOB_DETAILS
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_JOB_DETAILS` VALUES ('DefaultTapClusterScheduler', '1', 'DEFAULT', NULL, 'cloud.flystar.solon.quartz.service.job.JobLogClear', '0', '0', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000A4A4F425F434F4E46494773720033636C6F75642E666C79737461722E736F6C6F6E2E71756172747A2E736572766963652E656E746974792E4A6F62436F6E666967250A575B17CE057B02000F4C0009636C6173734E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400194C6A6176612F74696D652F4C6F63616C4461746554696D653B4C000C6372656174655573657249647400104C6A6176612F6C616E672F4C6F6E673B4C000463726F6E71007E00094C000A64656C657465466C61677400134C6A6176612F6C616E672F496E74656765723B4C0007656E6454696D657400104C6A6176612F7574696C2F446174653B4C0002696471007E000B4C00086A6F6247726F757071007E00094C00076A6F624E616D6571007E00094C00096D61784C6F6744617971007E000C4C0005706172616D71007E00094C0009737461727454696D6571007E000D4C000673746174757371007E000C4C000A75706461746554696D6571007E000A4C000C75706461746555736572496471007E000B7870740032636C6F75642E666C79737461722E736F6C6F6E2E71756172747A2E736572766963652E6A6F622E4A6F624C6F67436C656172707074000E3020302F31202A202A202A203F20737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000707372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C75657871007E0012000000000000000170740012E6B885E79086E4BBBBE58AA1E697A5E5BF977371007E00110000005A70707371007E00110000000170707800);
COMMIT;

-- ----------------------------
-- Table structure for qrtz_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_LOCKS`;
CREATE TABLE `qrtz_LOCKS` (
                              `SCHED_NAME` varchar(120) NOT NULL COMMENT '计划名称',
                              `LOCK_NAME` varchar(40) NOT NULL COMMENT '锁名称',
                              PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储程序的悲观锁的信息(假如使用了悲观锁) ';

-- ----------------------------
-- Records of qrtz_LOCKS
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_LOCKS` VALUES ('clusteredScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_LOCKS` VALUES ('clusteredScheduler', 'TRIGGER_ACCESS');
INSERT INTO `qrtz_LOCKS` VALUES ('DefaultTapClusterScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_LOCKS` VALUES ('DefaultTapClusterScheduler', 'TRIGGER_ACCESS');
COMMIT;

-- ----------------------------
-- Table structure for qrtz_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `qrtz_PAUSED_TRIGGER_GRPS` (
                                            `SCHED_NAME` varchar(120) NOT NULL COMMENT '计划名称',
                                            `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
                                            PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存放暂停掉的触发器';

-- ----------------------------
-- Records of qrtz_PAUSED_TRIGGER_GRPS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_SCHEDULER_STATE`;
CREATE TABLE `qrtz_SCHEDULER_STATE` (
                                        `SCHED_NAME` varchar(120) NOT NULL COMMENT '计划名称',
                                        `INSTANCE_NAME` varchar(200) NOT NULL COMMENT '实例名称',
                                        `LAST_CHECKIN_TIME` bigint NOT NULL COMMENT '最后的检查时间',
                                        `CHECKIN_INTERVAL` bigint NOT NULL COMMENT '检查间隔',
                                        PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='调度器状态';

-- ----------------------------
-- Records of qrtz_SCHEDULER_STATE
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_SCHEDULER_STATE` VALUES ('clusteredScheduler', '192.168.3.31662213503788', 1662392030688, 10000);
INSERT INTO `qrtz_SCHEDULER_STATE` VALUES ('DefaultTapClusterScheduler', '192.168.3.141687792293657', 1687792717541, 10000);
COMMIT;

-- ----------------------------
-- Table structure for qrtz_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_SIMPLE_TRIGGERS`;
CREATE TABLE `qrtz_SIMPLE_TRIGGERS` (
                                        `SCHED_NAME` varchar(120) NOT NULL COMMENT '计划名称',
                                        `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
                                        `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
                                        `REPEAT_COUNT` bigint NOT NULL COMMENT '重复次数',
                                        `REPEAT_INTERVAL` bigint NOT NULL COMMENT '重复间隔',
                                        `TIMES_TRIGGERED` bigint NOT NULL COMMENT '触发次数',
                                        PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='简单的触发器';

-- ----------------------------
-- Records of qrtz_SIMPLE_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_SIMPROP_TRIGGERS`;
CREATE TABLE `qrtz_SIMPROP_TRIGGERS` (
                                         `SCHED_NAME` varchar(120) NOT NULL COMMENT '计划名称',
                                         `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
                                         `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
                                         `STR_PROP_1` varchar(512) DEFAULT NULL,
                                         `STR_PROP_2` varchar(512) DEFAULT NULL,
                                         `STR_PROP_3` varchar(512) DEFAULT NULL,
                                         `INT_PROP_1` int DEFAULT NULL,
                                         `INT_PROP_2` int DEFAULT NULL,
                                         `LONG_PROP_1` bigint DEFAULT NULL,
                                         `LONG_PROP_2` bigint DEFAULT NULL,
                                         `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
                                         `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
                                         `BOOL_PROP_1` varchar(1) DEFAULT NULL,
                                         `BOOL_PROP_2` varchar(1) DEFAULT NULL,
                                         PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='存储CalendarIntervalTrigger和DailyTimeIntervalTrigger两种类型的触发器';

-- ----------------------------
-- Records of qrtz_SIMPROP_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_TRIGGERS`;
CREATE TABLE `qrtz_TRIGGERS` (
                                 `SCHED_NAME` varchar(120) NOT NULL COMMENT '计划名称',
                                 `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
                                 `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
                                 `JOB_NAME` varchar(200) NOT NULL COMMENT '作业名称',
                                 `JOB_GROUP` varchar(200) NOT NULL COMMENT '作业组',
                                 `DESCRIPTION` varchar(250) DEFAULT NULL COMMENT '描述',
                                 `NEXT_FIRE_TIME` bigint DEFAULT NULL COMMENT '下次执行时间',
                                 `PREV_FIRE_TIME` bigint DEFAULT NULL COMMENT '前一次',
                                 `PRIORITY` int DEFAULT NULL COMMENT '优先权',
                                 `TRIGGER_STATE` varchar(16) NOT NULL COMMENT '触发器状态',
                                 `TRIGGER_TYPE` varchar(8) NOT NULL COMMENT '触发器类型',
                                 `START_TIME` bigint NOT NULL COMMENT '开始时间',
                                 `END_TIME` bigint DEFAULT NULL COMMENT '结束时间',
                                 `CALENDAR_NAME` varchar(200) DEFAULT NULL COMMENT '日历名称',
                                 `MISFIRE_INSTR` smallint DEFAULT NULL COMMENT '失败次数',
                                 `JOB_DATA` blob,
                                 PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
                                 KEY `IDX_qrtz_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
                                 KEY `IDX_qrtz_T_JG` (`SCHED_NAME`,`JOB_GROUP`),
                                 KEY `IDX_qrtz_T_C` (`SCHED_NAME`,`CALENDAR_NAME`),
                                 KEY `IDX_qrtz_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`),
                                 KEY `IDX_qrtz_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`),
                                 KEY `IDX_qrtz_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
                                 KEY `IDX_qrtz_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
                                 KEY `IDX_qrtz_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
                                 KEY `IDX_qrtz_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
                                 KEY `IDX_qrtz_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
                                 KEY `IDX_qrtz_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
                                 KEY `IDX_qrtz_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='触发器';

-- ----------------------------
-- Records of qrtz_TRIGGERS
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_TRIGGERS` VALUES ('DefaultTapClusterScheduler', '1', 'DEFAULT', '1', 'DEFAULT', NULL, 1687792740000, 1687792680000, 5, 'WAITING', 'CRON', 1662987381000, 0, NULL, 0, '');
COMMIT;

-- ----------------------------
-- Table structure for resource_info
-- ----------------------------
DROP TABLE IF EXISTS `resource_info`;
CREATE TABLE `resource_info` (
                                 `resource_id` bigint NOT NULL COMMENT '主键',
                                 `project_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '系统编码',
                                 `resource_type` varchar(255) NOT NULL,
                                 `resource_code` varchar(255) NOT NULL COMMENT '资源标识,在每个项目下唯一',
                                 `resource_name` varchar(255) NOT NULL COMMENT '资源名称',
                                 `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
                                 `enable_flag` tinyint NOT NULL DEFAULT '1' COMMENT '是否启用',
                                 `delete_flag` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
                                 `create_time` datetime NOT NULL COMMENT '创建时间',
                                 `create_user_id` bigint DEFAULT NULL COMMENT '创建人',
                                 `update_time` datetime NOT NULL COMMENT '更新时间',
                                 `update_user_id` bigint DEFAULT NULL COMMENT '修改人',
                                 PRIMARY KEY (`resource_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of resource_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
                        `role_id` bigint NOT NULL COMMENT '主键',
                        `role_name` varchar(255) NOT NULL COMMENT '角色名称',
                        `enable_flag` tinyint NOT NULL DEFAULT '1' COMMENT '是否启用',
                        `delete_flag` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
                        `role_source_type` varchar(255) DEFAULT NULL COMMENT '角色来源',
                        `role_source_id` varchar(255) DEFAULT NULL COMMENT '角色来源ID',
                        `create_time` datetime NOT NULL COMMENT '创建时间',
                        `create_user_id` bigint DEFAULT NULL COMMENT '创建人',
                        `update_time` datetime NOT NULL COMMENT '更新时间',
                        `update_user_id` bigint DEFAULT NULL COMMENT '修改人',
                        PRIMARY KEY (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for role_permission_ref
-- ----------------------------
DROP TABLE IF EXISTS `role_permission_ref`;
CREATE TABLE `role_permission_ref` (
                                       `id` bigint NOT NULL COMMENT '主键',
                                       `role_id` bigint NOT NULL COMMENT '用户ID',
                                       `permission_id` bigint NOT NULL COMMENT '角色ID',
                                       `create_time` datetime NOT NULL COMMENT '创建时间',
                                       `create_user_id` bigint DEFAULT NULL COMMENT '创建人',
                                       PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of role_permission_ref
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sequence_config
-- ----------------------------
DROP TABLE IF EXISTS `sequence_config`;
CREATE TABLE `sequence_config` (
                                   `id` bigint NOT NULL,
                                   `biz_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
                                   `biz_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
                                   `seq_prefix` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
                                   `loop_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
                                   `loop_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
                                   `loop_number_min` bigint DEFAULT NULL,
                                   `loop_number_max` bigint DEFAULT NULL,
                                   `loop_number_format` varchar(64) DEFAULT NULL,
                                   `loop_segment_step` int DEFAULT NULL,
                                   `loop_segment_duration_second` int DEFAULT NULL,
                                   `next_number_random_min` bigint DEFAULT NULL,
                                   `next_number_random_max` int DEFAULT NULL,
                                   `create_time` datetime DEFAULT NULL,
                                   `create_user_id` bigint DEFAULT NULL,
                                   `update_time` datetime DEFAULT NULL,
                                   `update_user_id` bigint DEFAULT NULL,
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sequence_config
-- ----------------------------
BEGIN;
INSERT INTO `sequence_config` VALUES (1, 'TEST', '测试', 'T', 'DATE', 'yyyyMMdd', 1, -1, '000000', 1000, 60, 1, 1, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sequence_segment
-- ----------------------------
DROP TABLE IF EXISTS `sequence_segment`;
CREATE TABLE `sequence_segment` (
                                    `id` bigint NOT NULL,
                                    `biz_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
                                    `loop_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
                                    `max_id` bigint DEFAULT NULL,
                                    `version` bigint DEFAULT NULL,
                                    `create_time` datetime DEFAULT NULL,
                                    `update_time` datetime DEFAULT NULL,
                                    PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sequence_segment
-- ----------------------------
BEGIN;
INSERT INTO `sequence_segment` VALUES (1668630357530619906, 'TEST', '', 30, 2, '2023-06-13 22:44:14', '2023-06-13 22:44:14');
INSERT INTO `sequence_segment` VALUES (1668631330177134594, 'TEST', '20230613', 16100, 625, '2023-06-13 22:48:05', '2023-06-13 22:48:05');
INSERT INTO `sequence_segment` VALUES (1672582328646029314, 'TEST', '20230624', 2044000, 2043, '2023-06-24 20:27:57', '2023-06-24 20:27:57');
COMMIT;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
                              `sys_config_id` bigint NOT NULL COMMENT '主键',
                              `config_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '参数键名',
                              `config_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '参数名称',
                              `config_value` longtext COMMENT '参数键值',
                              `config_type` tinyint DEFAULT NULL COMMENT '是否系统内置',
                              `enable_flag` tinyint NOT NULL DEFAULT '1' COMMENT '是否启用',
                              `delete_flag` tinyint NOT NULL DEFAULT '0' COMMENT '是否删除',
                              `create_time` datetime NOT NULL COMMENT '创建时间',
                              `create_user_id` bigint DEFAULT NULL COMMENT '创建人',
                              `update_time` datetime NOT NULL COMMENT '更新时间',
                              `update_user_id` bigint DEFAULT NULL COMMENT '修改人',
                              PRIMARY KEY (`sys_config_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
                            `dict_id` bigint NOT NULL COMMENT '主键',
                            `dict_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '字典类型编码',
                            `dict_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '字典名称',
                            `dict_field_suggest` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '属性命名建议',
                            `remark` varchar(1000) DEFAULT NULL COMMENT '是否系统内置',
                            `enable_flag` tinyint NOT NULL DEFAULT '1' COMMENT '是否启用',
                            `create_time` datetime NOT NULL COMMENT '创建时间',
                            `create_user_id` bigint DEFAULT NULL COMMENT '创建人',
                            `update_time` datetime NOT NULL COMMENT '更新时间',
                            `update_user_id` bigint DEFAULT NULL COMMENT '修改人',
                            PRIMARY KEY (`dict_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_detail
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_detail`;
CREATE TABLE `sys_dict_detail` (
                                   `dict_detail_id` bigint NOT NULL COMMENT '主键',
                                   `dict_id` bigint NOT NULL COMMENT '字典ID',
                                   `dict_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '字典键值',
                                   `dict_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '字典标签',
                                   `dict_index` int DEFAULT '0' COMMENT '字典排序',
                                   `default_flag` tinyint NOT NULL DEFAULT '0' COMMENT '是否默认',
                                   `enable_flag` tinyint NOT NULL DEFAULT '1' COMMENT '是否启用',
                                   `create_time` datetime NOT NULL COMMENT '创建时间',
                                   `create_user_id` bigint DEFAULT NULL COMMENT '创建人',
                                   `update_time` datetime NOT NULL COMMENT '更新时间',
                                   `update_user_id` bigint DEFAULT NULL COMMENT '修改人',
                                   PRIMARY KEY (`dict_detail_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_dict_detail
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for user_department_ref
-- ----------------------------
DROP TABLE IF EXISTS `user_department_ref`;
CREATE TABLE `user_department_ref` (
                                       `id` bigint NOT NULL COMMENT '主键',
                                       `user_id` bigint NOT NULL COMMENT '用户ID',
                                       `dept_id` bigint NOT NULL COMMENT '部门D',
                                       `post_id` bigint DEFAULT NULL COMMENT '岗位ID',
                                       `ref_type` varchar(255) NOT NULL COMMENT 'employee-员工,leader-负责人',
                                       `primary_flag` tinyint NOT NULL DEFAULT '1' COMMENT '主部门 一般一个员工只有一个主部门',
                                       `create_time` datetime NOT NULL COMMENT '创建时间',
                                       `create_user_id` bigint DEFAULT NULL COMMENT '创建人',
                                       `update_time` datetime NOT NULL COMMENT '修改时间',
                                       `update_user_id` bigint DEFAULT NULL COMMENT '修改人',
                                       PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_department_ref
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
                             `user_id` bigint NOT NULL,
                             `nick_name` varchar(255) DEFAULT NULL,
                             `user_name` varchar(255) DEFAULT NULL,
                             `password` varchar(255) DEFAULT NULL,
                             `email` varchar(255) DEFAULT NULL,
                             `phone` varchar(255) DEFAULT NULL,
                             `enable_flag` tinyint DEFAULT NULL,
                             `delete_flag` tinyint DEFAULT NULL,
                             `create_time` datetime DEFAULT NULL,
                             `create_user_id` bigint DEFAULT NULL,
                             `update_time` datetime DEFAULT NULL,
                             `update_user_id` bigint DEFAULT NULL,
                             PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_info
-- ----------------------------
BEGIN;
INSERT INTO `user_info` VALUES (1, '管理员', 'admin', '{bcrypt}$2a$10$6UnhbUQQXcSYChYz50P1me9E5gYNC8cqf5nFl4uNQ7D2C9sfrp/eK', NULL, NULL, 1, 0, NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for user_role_ref
-- ----------------------------
DROP TABLE IF EXISTS `user_role_ref`;
CREATE TABLE `user_role_ref` (
                                 `id` bigint NOT NULL COMMENT '主键',
                                 `user_id` bigint NOT NULL COMMENT '用户ID',
                                 `role_id` bigint NOT NULL COMMENT '角色ID',
                                 `create_time` datetime NOT NULL COMMENT '创建时间',
                                 `create_user_id` bigint DEFAULT NULL COMMENT '创建人',
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_role_ref
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
