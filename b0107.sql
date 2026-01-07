-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.7.40 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- 导出 workai 的数据库结构
DROP DATABASE IF EXISTS `workai`;
CREATE DATABASE IF NOT EXISTS `workai` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `workai`;

-- 导出  表 workai.ba_admin 结构
DROP TABLE IF EXISTS `ba_admin`;
CREATE TABLE IF NOT EXISTS `ba_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '头像',
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机',
  `login_failure` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '登录失败次数',
  `last_login_time` bigint(16) unsigned DEFAULT NULL COMMENT '上次登录时间',
  `last_login_ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '上次登录IP',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码盐（废弃待删）',
  `motto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '签名',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '状态:enable=启用,disable=禁用',
  `update_time` bigint(16) unsigned DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='管理员表';

-- 正在导出表  workai.ba_admin 的数据：~0 rows (大约)
INSERT INTO `ba_admin` (`id`, `username`, `nickname`, `avatar`, `email`, `mobile`, `login_failure`, `last_login_time`, `last_login_ip`, `password`, `salt`, `motto`, `status`, `update_time`, `create_time`) VALUES
	(1, 'admin', 'Admin', '', 'admin@buildadmin.com', '18888888888', 0, 1767784867, '127.0.0.1', '$2y$10$.xNFAPlNgHgnZ8zeJSBepuGp5jh4EOgbjRYPxqxs95bNBcbiihXAG', '', '', 'enable', 1767784867, 1767770645);

-- 导出  表 workai.ba_admin_group 结构
DROP TABLE IF EXISTS `ba_admin_group`;
CREATE TABLE IF NOT EXISTS `ba_admin_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上级分组',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组名',
  `rules` text COLLATE utf8mb4_unicode_ci COMMENT '权限规则ID',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) unsigned DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='管理分组表';

-- 正在导出表  workai.ba_admin_group 的数据：~4 rows (大约)
INSERT INTO `ba_admin_group` (`id`, `pid`, `name`, `rules`, `status`, `update_time`, `create_time`) VALUES
	(1, 0, '超级管理组', '*', 1, 1767770645, 1767770645),
	(2, 1, '一级管理员', '1,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,77,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,89', 1, 1767770645, 1767770645),
	(3, 2, '二级管理员', '21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43', 1, 1767770645, 1767770645),
	(4, 3, '三级管理员', '55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75', 1, 1767770645, 1767770645);

-- 导出  表 workai.ba_admin_group_access 结构
DROP TABLE IF EXISTS `ba_admin_group_access`;
CREATE TABLE IF NOT EXISTS `ba_admin_group_access` (
  `uid` int(11) unsigned NOT NULL COMMENT '管理员ID',
  `group_id` int(11) unsigned NOT NULL COMMENT '分组ID',
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='管理分组映射表';

-- 正在导出表  workai.ba_admin_group_access 的数据：~1 rows (大约)
INSERT INTO `ba_admin_group_access` (`uid`, `group_id`) VALUES
	(1, 1);

-- 导出  表 workai.ba_admin_log 结构
DROP TABLE IF EXISTS `ba_admin_log`;
CREATE TABLE IF NOT EXISTS `ba_admin_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `username` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '管理员用户名',
  `url` varchar(1500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作Url',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '日志标题',
  `data` longtext COLLATE utf8mb4_unicode_ci COMMENT '请求数据',
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `create_time` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='管理员日志表';

-- 正在导出表  workai.ba_admin_log 的数据：~3 rows (大约)
INSERT INTO `ba_admin_log` (`id`, `admin_id`, `username`, `url`, `title`, `data`, `ip`, `useragent`, `create_time`) VALUES
	(1, 1, 'admin', '/admin/Index/login', '登录', '{"username":"admin","password":"***","keep":"","captchaId":"1f15e48c-553b-4e79-9dcc-c1664eff4d9f","captchaInfo":"297,24-223,73;350;200"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 1767770716),
	(2, 1, 'admin', '/admin/Index/login', '登录', '{"username":"admin","password":"***","keep":"1","captchaId":"9cf6ac1f-74e6-4725-96dd-a6d496ceec6f","captchaInfo":"169,72-327,33;350;200"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 1767781697),
	(3, 1, 'admin', '/admin/crud.Crud/parseFieldData', 'CRUD代码生成-解析字段数据', '{"type":"db","table":"admin","sql":"","connection":"mysql"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 1767781878),
	(4, 1, 'admin', '/admin/crud.Crud/parseFieldData', 'CRUD代码生成-解析字段数据', '{"type":"db","table":"requirement_forms","sql":"","connection":"mysql"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 1767782434),
	(5, 1, 'admin', '/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{"table":"requirement_forms","connection":"mysql","webViewsDir":"web\\\\src\\\\views\\\\backend\\\\requirement\\\\forms","controllerFile":"app\\\\admin\\\\controller\\\\requirement\\\\Forms.php"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 1767782451),
	(6, 1, 'admin', '/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{"type":"db","table":{"name":"requirement_forms","comment":"\\u7b80\\u5316\\u9700\\u6c42\\u8868\\u5355\\u8868","quickSearchField":["id"],"defaultSortField":"id","formFields":["contact_info","requirement_type","requirement_content","payment_method","payment_amount","status","is_deleted"],"columnFields":["id","contact_info","requirement_type","payment_method","payment_amount","create_time","status","is_deleted"],"defaultSortType":"desc","generateRelativePath":"requirement_forms","isCommonModel":"0","modelFile":"app\\\\admin\\\\model\\\\requirement\\\\Forms.php","controllerFile":"app\\\\admin\\\\controller\\\\requirement\\\\Forms.php","validateFile":"app\\\\admin\\\\validate\\\\requirement\\\\Forms.php","webViewsDir":"web\\\\src\\\\views\\\\backend\\\\requirement\\\\forms","databaseConnection":"mysql","designChange":[],"rebuild":"No"},"fields":[{"name":"id","type":"bigint","dataType":"bigint(20)","default":"","defaultType":"NONE","null":"","primaryKey":"1","unsigned":"1","autoIncrement":"1","comment":"\\u4e3b\\u952eID","designType":"pk","table":{"width":"70","operator":"RANGE","sortable":"custom"},"form":[]},{"name":"contact_info","type":"varchar","dataType":"varchar(200)","default":"","defaultType":"EMPTY STRING","null":"","primaryKey":"","unsigned":"","autoIncrement":"","comment":"\\u8054\\u7cfb\\u65b9\\u5f0f\\uff08\\u7535\\u8bdd\\/\\u90ae\\u7bb1\\u7b49\\uff09","designType":"string","table":{"render":"none","operator":"LIKE","sortable":"false"},"form":{"validator":[],"validatorMsg":""}},{"name":"requirement_type","type":"enum","dataType":"enum(\'\\u7b56\\u5212\\u6587\\u6863\',\'\\u7f8e\\u672f\\/\\u89c6\\u9891\',\'Demo\\u539f\\u578b\',\'\\u5b9a\\u5236\\u5f00\\u53d1\',\'\\u54a8\\u8be2\',\'\\u5176\\u4ed6\')","default":"","defaultType":"NULL","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"\\u9700\\u6c42\\u7c7b\\u578b\\uff08\\u53ef\\u9009\\uff09","designType":"radio","table":{"render":"tag","operator":"eq","sortable":"false"},"form":{"validator":[],"validatorMsg":""}},{"name":"requirement_content","type":"text","dataType":"text","default":"","defaultType":"NONE","null":"","primaryKey":"","unsigned":"","autoIncrement":"","comment":"\\u9700\\u6c42\\u8be6\\u7ec6\\u5185\\u5bb9\\uff08\\u5fc5\\u586b\\uff09","designType":"editor","table":{"operator":"false"},"form":{"validator":["editorRequired"],"validatorMsg":""}},{"name":"payment_method","type":"varchar","dataType":"varchar(50)","default":"","defaultType":"NULL","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"\\u652f\\u4ed8\\u65b9\\u5f0f","designType":"string","table":{"render":"none","operator":"LIKE","sortable":"false"},"form":{"validator":[],"validatorMsg":""}},{"name":"payment_amount","type":"decimal","dataType":"decimal(10,2)","default":"","defaultType":"NULL","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"\\u652f\\u4ed8\\u91d1\\u989d","designType":"number","table":{"render":"none","operator":"RANGE","sortable":"false"},"form":{"validator":["number"],"validatorMsg":"","step":"1"}},{"name":"create_time","type":"bigint","dataType":"bigint(20)","default":"","defaultType":"NONE","null":"","primaryKey":"","unsigned":"","autoIncrement":"","comment":"\\u521b\\u5efa\\u65f6\\u95f4\\uff08\\u6beb\\u79d2\\u65f6\\u95f4\\u6233\\uff09","designType":"timestamp","table":{"render":"datetime","operator":"RANGE","sortable":"custom","width":"160","timeFormat":"yyyy-mm-dd hh:MM:ss"},"form":{"validator":["date"],"validatorMsg":""}},{"name":"status","type":"enum","dataType":"enum(\'\\u5f85\\u5904\\u7406\',\'\\u5df2\\u786e\\u8ba4\',\'\\u5df2\\u5b8c\\u6210\')","default":"\\u5f85\\u5904\\u7406","defaultType":"INPUT","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"\\u5904\\u7406\\u72b6\\u6001","designType":"radio","table":{"render":"tag","operator":"eq","sortable":"false"},"form":{"validator":[],"validatorMsg":""}},{"name":"is_deleted","type":"tinyint","dataType":"tinyint(4)","default":"0","defaultType":"INPUT","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"\\u8f6f\\u5220\\u9664\\u6807\\u8bb0(0:\\u6b63\\u5e38 1:\\u5220\\u9664)","designType":"number","table":{"render":"none","operator":"RANGE","sortable":"false"},"form":{"validator":["number"],"validatorMsg":"","step":"1"}}]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 1767782451),
	(7, 1, 'admin', '/admin/crud.Crud/logStart', 'CRUD代码生成-从历史记录开始', '{"id":"1","type":""}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 1767783476),
	(8, 1, 'admin', '/admin/crud.Crud/generateCheck', 'CRUD代码生成-生成前预检', '{"table":"requirement_forms","connection":"mysql","webViewsDir":"web\\\\src\\\\views\\\\backend\\\\requirement\\\\forms","controllerFile":"app\\\\admin\\\\controller\\\\requirement\\\\Forms.php"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 1767783549),
	(9, 1, 'admin', '/admin/crud.Crud/generate', 'CRUD代码生成-生成', '{"type":"log","table":{"name":"requirement_forms","comment":"\\u7b80\\u5316\\u9700\\u6c42\\u8868\\u5355\\u8868","quickSearchField":["id"],"defaultSortField":"id","formFields":["contact_info","requirement_type","requirement_content","payment_method","payment_amount","status","is_deleted","pay_status1"],"columnFields":["id","contact_info","requirement_type","payment_method","payment_amount","create_time","status","is_deleted","pay_status1"],"defaultSortType":"desc","generateRelativePath":"requirement_forms","isCommonModel":"0","modelFile":"app\\\\admin\\\\model\\\\requirement\\\\Forms.php","controllerFile":"app\\\\admin\\\\controller\\\\requirement\\\\Forms.php","validateFile":"app\\\\admin\\\\validate\\\\requirement\\\\Forms.php","webViewsDir":"web\\\\src\\\\views\\\\backend\\\\requirement\\\\forms","databaseConnection":"mysql","designChange":[{"type":"add-field","index":"8","newName":"pay_status1","oldName":"","after":"status","sync":"1"}],"rebuild":"No","empty":""},"fields":[{"name":"id","type":"bigint","dataType":"bigint(20)","default":"","defaultType":"NONE","null":"","primaryKey":"1","unsigned":"1","autoIncrement":"1","comment":"\\u4e3b\\u952eID","designType":"pk","table":{"width":"70","operator":"RANGE","sortable":"custom"},"form":[]},{"name":"contact_info","type":"varchar","dataType":"varchar(200)","default":"","defaultType":"EMPTY STRING","null":"","primaryKey":"","unsigned":"","autoIncrement":"","comment":"\\u8054\\u7cfb\\u65b9\\u5f0f\\uff08\\u7535\\u8bdd\\/\\u90ae\\u7bb1\\u7b49\\uff09","designType":"string","table":{"render":"none","operator":"LIKE","sortable":"false"},"form":{"validator":[],"validatorMsg":""}},{"name":"requirement_type","type":"enum","dataType":"enum(\'\\u7b56\\u5212\\u6587\\u6863\',\'\\u7f8e\\u672f\\/\\u89c6\\u9891\',\'Demo\\u539f\\u578b\',\'\\u5b9a\\u5236\\u5f00\\u53d1\',\'\\u54a8\\u8be2\',\'\\u5176\\u4ed6\')","default":"","defaultType":"NULL","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"\\u9700\\u6c42\\u7c7b\\u578b\\uff08\\u53ef\\u9009\\uff09","designType":"radio","table":{"render":"tag","operator":"eq","sortable":"false"},"form":{"validator":[],"validatorMsg":""}},{"name":"requirement_content","type":"text","dataType":"text","default":"","defaultType":"NONE","null":"","primaryKey":"","unsigned":"","autoIncrement":"","comment":"\\u9700\\u6c42\\u8be6\\u7ec6\\u5185\\u5bb9\\uff08\\u5fc5\\u586b\\uff09","designType":"editor","table":{"operator":"false"},"form":{"validator":["editorRequired"],"validatorMsg":""}},{"name":"payment_method","type":"varchar","dataType":"varchar(50)","default":"","defaultType":"NULL","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"\\u652f\\u4ed8\\u65b9\\u5f0f","designType":"string","table":{"render":"none","operator":"LIKE","sortable":"false"},"form":{"validator":[],"validatorMsg":""}},{"name":"payment_amount","type":"decimal","dataType":"decimal(10,2)","default":"","defaultType":"NULL","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"\\u652f\\u4ed8\\u91d1\\u989d","designType":"number","table":{"render":"none","operator":"RANGE","sortable":"false"},"form":{"validator":["number"],"validatorMsg":"","step":"1"}},{"name":"create_time","type":"bigint","dataType":"bigint(20)","default":"","defaultType":"NONE","null":"","primaryKey":"","unsigned":"","autoIncrement":"","comment":"\\u521b\\u5efa\\u65f6\\u95f4\\uff08\\u6beb\\u79d2\\u65f6\\u95f4\\u6233\\uff09","designType":"timestamp","table":{"render":"datetime","operator":"RANGE","sortable":"custom","width":"160","timeFormat":"yyyy-mm-dd hh:MM:ss"},"form":{"validator":["date"],"validatorMsg":""}},{"name":"status","type":"enum","dataType":"enum(\'\\u5f85\\u5904\\u7406\',\'\\u5df2\\u786e\\u8ba4\',\'\\u5df2\\u5b8c\\u6210\')","default":"\\u5f85\\u5904\\u7406","defaultType":"INPUT","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"\\u5904\\u7406\\u72b6\\u6001","designType":"radio","table":{"render":"tag","operator":"eq","sortable":"false"},"form":{"validator":[],"validatorMsg":""}},{"title":"\\u72b6\\u6001","name":"pay_status1","comment":"\\u652f\\u4ed8\\u72b6\\u6001:0=\\u672a\\u652f\\u4ed8,1=\\u5df2\\u652f\\u4ed8","designType":"switch","table":{"render":"switch","operator":"eq","sortable":"false"},"form":{"validator":[],"validatorMsg":""},"type":"tinyint","length":"1","precision":"0","default":"0","defaultType":"INPUT","null":"","primaryKey":"","unsigned":"1","autoIncrement":""},{"name":"is_deleted","type":"tinyint","dataType":"tinyint(4)","default":"0","defaultType":"INPUT","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"\\u8f6f\\u5220\\u9664\\u6807\\u8bb0(0:\\u6b63\\u5e38 1:\\u5220\\u9664)","designType":"number","table":{"render":"none","operator":"RANGE","sortable":"false"},"form":{"validator":["number"],"validatorMsg":"","step":"1"}}]}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 1767783553),
	(10, 1, 'admin', '/admin/requirement.Forms/edit', '简化需求表单管理-编辑', '{"id":"3","pay_status1":"1"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 1767783571),
	(11, 1, 'admin', '/admin/requirement.Forms/edit', '简化需求表单管理-编辑', '{"id":"3","pay_status1":"0"}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0', 1767783571);

-- 导出  表 workai.ba_admin_rule 结构
DROP TABLE IF EXISTS `ba_admin_rule`;
CREATE TABLE IF NOT EXISTS `ba_admin_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上级菜单',
  `type` enum('menu_dir','menu','button') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'menu' COMMENT '类型:menu_dir=菜单目录,menu=菜单项,button=页面按钮',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标题',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `path` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '路由路径',
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '图标',
  `menu_type` enum('tab','link','iframe') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单类型:tab=选项卡,link=链接,iframe=Iframe',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Url',
  `component` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组件路径',
  `keepalive` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '缓存:0=关闭,1=开启',
  `extend` enum('none','add_rules_only','add_menu_only') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none' COMMENT '扩展属性:none=无,add_rules_only=只添加为路由,add_menu_only=只添加为菜单',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `weigh` int(11) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) unsigned DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='菜单和权限规则表';

-- 正在导出表  workai.ba_admin_rule 的数据：~89 rows (大约)
INSERT INTO `ba_admin_rule` (`id`, `pid`, `type`, `title`, `name`, `path`, `icon`, `menu_type`, `url`, `component`, `keepalive`, `extend`, `remark`, `weigh`, `status`, `update_time`, `create_time`) VALUES
	(1, 0, 'menu', '控制台', 'dashboard', 'dashboard', 'fa fa-dashboard', 'tab', '', '/src/views/backend/dashboard.vue', 1, 'none', 'Remark lang', 999, 1, 1767770645, 1767770645),
	(2, 0, 'menu_dir', '权限管理', 'auth', 'auth', 'fa fa-group', NULL, '', '', 0, 'none', '', 100, 1, 1767770645, 1767770645),
	(3, 2, 'menu', '角色组管理', 'auth/group', 'auth/group', 'fa fa-group', 'tab', '', '/src/views/backend/auth/group/index.vue', 1, 'none', 'Remark lang', 99, 1, 1767770645, 1767770645),
	(4, 3, 'button', '查看', 'auth/group/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(5, 3, 'button', '添加', 'auth/group/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(6, 3, 'button', '编辑', 'auth/group/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(7, 3, 'button', '删除', 'auth/group/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(8, 2, 'menu', '管理员管理', 'auth/admin', 'auth/admin', 'el-icon-UserFilled', 'tab', '', '/src/views/backend/auth/admin/index.vue', 1, 'none', '', 98, 1, 1767770645, 1767770645),
	(9, 8, 'button', '查看', 'auth/admin/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(10, 8, 'button', '添加', 'auth/admin/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(11, 8, 'button', '编辑', 'auth/admin/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(12, 8, 'button', '删除', 'auth/admin/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(13, 2, 'menu', '菜单规则管理', 'auth/rule', 'auth/rule', 'el-icon-Grid', 'tab', '', '/src/views/backend/auth/rule/index.vue', 1, 'none', '', 97, 1, 1767770645, 1767770645),
	(14, 13, 'button', '查看', 'auth/rule/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(15, 13, 'button', '添加', 'auth/rule/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(16, 13, 'button', '编辑', 'auth/rule/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(17, 13, 'button', '删除', 'auth/rule/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(18, 13, 'button', '快速排序', 'auth/rule/sortable', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(19, 2, 'menu', '管理员日志管理', 'auth/adminLog', 'auth/adminLog', 'el-icon-List', 'tab', '', '/src/views/backend/auth/adminLog/index.vue', 1, 'none', '', 96, 1, 1767770645, 1767770645),
	(20, 19, 'button', '查看', 'auth/adminLog/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(21, 0, 'menu_dir', '会员管理', 'user', 'user', 'fa fa-drivers-license', NULL, '', '', 0, 'none', '', 95, 1, 1767770645, 1767770645),
	(22, 21, 'menu', '会员管理', 'user/user', 'user/user', 'fa fa-user', 'tab', '', '/src/views/backend/user/user/index.vue', 1, 'none', '', 94, 1, 1767770645, 1767770645),
	(23, 22, 'button', '查看', 'user/user/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(24, 22, 'button', '添加', 'user/user/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(25, 22, 'button', '编辑', 'user/user/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(26, 22, 'button', '删除', 'user/user/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(27, 21, 'menu', '会员分组管理', 'user/group', 'user/group', 'fa fa-group', 'tab', '', '/src/views/backend/user/group/index.vue', 1, 'none', '', 93, 1, 1767770645, 1767770645),
	(28, 27, 'button', '查看', 'user/group/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(29, 27, 'button', '添加', 'user/group/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(30, 27, 'button', '编辑', 'user/group/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(31, 27, 'button', '删除', 'user/group/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(32, 21, 'menu', '会员规则管理', 'user/rule', 'user/rule', 'fa fa-th-list', 'tab', '', '/src/views/backend/user/rule/index.vue', 1, 'none', '', 92, 1, 1767770645, 1767770645),
	(33, 32, 'button', '查看', 'user/rule/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(34, 32, 'button', '添加', 'user/rule/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(35, 32, 'button', '编辑', 'user/rule/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(36, 32, 'button', '删除', 'user/rule/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(37, 32, 'button', '快速排序', 'user/rule/sortable', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(38, 21, 'menu', '会员余额管理', 'user/moneyLog', 'user/moneyLog', 'el-icon-Money', 'tab', '', '/src/views/backend/user/moneyLog/index.vue', 1, 'none', '', 91, 1, 1767770645, 1767770645),
	(39, 38, 'button', '查看', 'user/moneyLog/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(40, 38, 'button', '添加', 'user/moneyLog/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(41, 21, 'menu', '会员积分管理', 'user/scoreLog', 'user/scoreLog', 'el-icon-Discount', 'tab', '', '/src/views/backend/user/scoreLog/index.vue', 1, 'none', '', 90, 1, 1767770645, 1767770645),
	(42, 41, 'button', '查看', 'user/scoreLog/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(43, 41, 'button', '添加', 'user/scoreLog/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(44, 0, 'menu_dir', '常规管理', 'routine', 'routine', 'fa fa-cogs', NULL, '', '', 0, 'none', '', 89, 1, 1767770645, 1767770645),
	(45, 44, 'menu', '系统配置', 'routine/config', 'routine/config', 'el-icon-Tools', 'tab', '', '/src/views/backend/routine/config/index.vue', 1, 'none', '', 88, 1, 1767770645, 1767770645),
	(46, 45, 'button', '查看', 'routine/config/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(47, 45, 'button', '编辑', 'routine/config/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(48, 44, 'menu', '附件管理', 'routine/attachment', 'routine/attachment', 'fa fa-folder', 'tab', '', '/src/views/backend/routine/attachment/index.vue', 1, 'none', 'Remark lang', 87, 1, 1767770645, 1767770645),
	(49, 48, 'button', '查看', 'routine/attachment/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(50, 48, 'button', '编辑', 'routine/attachment/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(51, 48, 'button', '删除', 'routine/attachment/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(52, 44, 'menu', '个人资料', 'routine/adminInfo', 'routine/adminInfo', 'fa fa-user', 'tab', '', '/src/views/backend/routine/adminInfo.vue', 1, 'none', '', 86, 1, 1767770645, 1767770645),
	(53, 52, 'button', '查看', 'routine/adminInfo/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(54, 52, 'button', '编辑', 'routine/adminInfo/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(55, 0, 'menu_dir', '数据安全管理', 'security', 'security', 'fa fa-shield', NULL, '', '', 0, 'none', '', 85, 1, 1767770645, 1767770645),
	(56, 55, 'menu', '数据回收站', 'security/dataRecycleLog', 'security/dataRecycleLog', 'fa fa-database', 'tab', '', '/src/views/backend/security/dataRecycleLog/index.vue', 1, 'none', '', 84, 1, 1767770645, 1767770645),
	(57, 56, 'button', '查看', 'security/dataRecycleLog/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(58, 56, 'button', '删除', 'security/dataRecycleLog/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(59, 56, 'button', '还原', 'security/dataRecycleLog/restore', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(60, 56, 'button', '查看详情', 'security/dataRecycleLog/info', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(61, 55, 'menu', '敏感数据修改记录', 'security/sensitiveDataLog', 'security/sensitiveDataLog', 'fa fa-expeditedssl', 'tab', '', '/src/views/backend/security/sensitiveDataLog/index.vue', 1, 'none', '', 83, 1, 1767770645, 1767770645),
	(62, 61, 'button', '查看', 'security/sensitiveDataLog/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(63, 61, 'button', '删除', 'security/sensitiveDataLog/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(64, 61, 'button', '回滚', 'security/sensitiveDataLog/rollback', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(65, 61, 'button', '查看详情', 'security/sensitiveDataLog/info', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(66, 55, 'menu', '数据回收规则管理', 'security/dataRecycle', 'security/dataRecycle', 'fa fa-database', 'tab', '', '/src/views/backend/security/dataRecycle/index.vue', 1, 'none', 'Remark lang', 82, 1, 1767770645, 1767770645),
	(67, 66, 'button', '查看', 'security/dataRecycle/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(68, 66, 'button', '添加', 'security/dataRecycle/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(69, 66, 'button', '编辑', 'security/dataRecycle/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(70, 66, 'button', '删除', 'security/dataRecycle/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(71, 55, 'menu', '敏感字段规则管理', 'security/sensitiveData', 'security/sensitiveData', 'fa fa-expeditedssl', 'tab', '', '/src/views/backend/security/sensitiveData/index.vue', 1, 'none', 'Remark lang', 81, 1, 1767770645, 1767770645),
	(72, 71, 'button', '查看', 'security/sensitiveData/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(73, 71, 'button', '添加', 'security/sensitiveData/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(74, 71, 'button', '编辑', 'security/sensitiveData/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(75, 71, 'button', '删除', 'security/sensitiveData/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(76, 0, 'menu', 'BuildAdmin', 'buildadmin', 'buildadmin', 'local-logo', 'link', 'https://doc.buildadmin.com', '', 0, 'none', '', 0, 0, 1767770645, 1767770645),
	(77, 45, 'button', '添加', 'routine/config/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(78, 0, 'menu', '模块市场', 'moduleStore/moduleStore', 'moduleStore', 'el-icon-GoodsFilled', 'tab', '', '/src/views/backend/module/index.vue', 1, 'none', '', 86, 1, 1767770645, 1767770645),
	(79, 78, 'button', '查看', 'moduleStore/moduleStore/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(80, 78, 'button', '安装', 'moduleStore/moduleStore/install', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(81, 78, 'button', '调整状态', 'moduleStore/moduleStore/changeState', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(82, 78, 'button', '卸载', 'moduleStore/moduleStore/uninstall', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(83, 78, 'button', '更新', 'moduleStore/moduleStore/update', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(84, 0, 'menu', 'CRUD代码生成', 'crud/crud', 'crud/crud', 'fa fa-code', 'tab', '', '/src/views/backend/crud/index.vue', 1, 'none', '', 80, 1, 1767770645, 1767770645),
	(85, 84, 'button', '查看', 'crud/crud/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(86, 84, 'button', '生成', 'crud/crud/generate', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(87, 84, 'button', '删除', 'crud/crud/delete', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(88, 45, 'button', '删除', 'routine/config/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770645, 1767770645),
	(89, 1, 'button', '查看', 'dashboard/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767770646, 1767770646),
	(90, 0, 'menu_dir', 'requirement', 'requirement', 'requirement', '', NULL, '', '', 0, 'none', '', 0, 1, 1767782451, 1767782451),
	(91, 90, 'menu', '简化需求表单管理', 'requirement/forms', 'requirement/forms', '', 'tab', '', '/src/views/backend/requirement/forms/index.vue', 1, 'none', '', 0, 1, 1767782451, 1767782451),
	(92, 91, 'button', '查看', 'requirement/forms/index', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767782451, 1767782451),
	(93, 91, 'button', '添加', 'requirement/forms/add', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767782451, 1767782451),
	(94, 91, 'button', '编辑', 'requirement/forms/edit', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767782451, 1767782451),
	(95, 91, 'button', '删除', 'requirement/forms/del', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767782451, 1767782451),
	(96, 91, 'button', '快速排序', 'requirement/forms/sortable', '', '', NULL, '', '', 0, 'none', '', 0, 1, 1767782451, 1767782451);

-- 导出  表 workai.ba_area 结构
DROP TABLE IF EXISTS `ba_area`;
CREATE TABLE IF NOT EXISTS `ba_area` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(11) unsigned DEFAULT NULL COMMENT '父id',
  `shortname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '简称',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '名称',
  `mergename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '全称',
  `level` tinyint(4) unsigned DEFAULT NULL COMMENT '层级:1=省,2=市,3=区/县',
  `pinyin` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '拼音',
  `code` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '长途区号',
  `zip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮编',
  `first` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '首字母',
  `lng` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '经度',
  `lat` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='省份地区表';

-- 正在导出表  workai.ba_area 的数据：~0 rows (大约)

-- 导出  表 workai.ba_attachment 结构
DROP TABLE IF EXISTS `ba_attachment`;
CREATE TABLE IF NOT EXISTS `ba_attachment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `topic` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '细目',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上传管理员ID',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上传用户ID',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '物理路径',
  `width` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '宽度',
  `height` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '高度',
  `name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '原始名称',
  `size` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '大小',
  `mimetype` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'mime类型',
  `quote` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上传(引用)次数',
  `storage` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '存储方式',
  `sha1` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'sha1编码',
  `create_time` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  `last_upload_time` bigint(16) unsigned DEFAULT NULL COMMENT '最后上传时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='附件表';

-- 正在导出表  workai.ba_attachment 的数据：~0 rows (大约)

-- 导出  表 workai.ba_captcha 结构
DROP TABLE IF EXISTS `ba_captcha`;
CREATE TABLE IF NOT EXISTS `ba_captcha` (
  `key` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '验证码Key',
  `code` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '验证码(加密后)',
  `captcha` text COLLATE utf8mb4_unicode_ci COMMENT '验证码数据',
  `create_time` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  `expire_time` bigint(16) unsigned DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='验证码表';

-- 正在导出表  workai.ba_captcha 的数据：~0 rows (大约)

-- 导出  表 workai.ba_config 结构
DROP TABLE IF EXISTS `ba_config`;
CREATE TABLE IF NOT EXISTS `ba_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分组',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '变量输入组件类型',
  `value` longtext COLLATE utf8mb4_unicode_ci COMMENT '变量值',
  `content` longtext COLLATE utf8mb4_unicode_ci COMMENT '字典数据',
  `rule` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '扩展属性',
  `allow_del` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '允许删除:0=否,1=是',
  `weigh` int(11) NOT NULL DEFAULT '0' COMMENT '权重',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='系统配置';

-- 正在导出表  workai.ba_config 的数据：~14 rows (大约)
INSERT INTO `ba_config` (`id`, `name`, `group`, `title`, `tip`, `type`, `value`, `content`, `rule`, `extend`, `allow_del`, `weigh`) VALUES
	(1, 'config_group', 'basics', 'Config group', '', 'array', '[{"key":"basics","value":"Basics"},{"key":"mail","value":"Mail"},{"key":"config_quick_entrance","value":"Config Quick entrance"}]', NULL, 'required', '', 0, -1),
	(2, 'site_name', 'basics', 'Site Name', '', 'string', '华梦沃客AI', NULL, 'required', '', 0, 99),
	(3, 'record_number', 'basics', 'Record number', '域名备案号', 'string', '渝ICP备8888888号-1', NULL, '', '', 0, 0),
	(4, 'version', 'basics', 'Version number', '系统版本号', 'string', 'v1.0.0', NULL, 'required', '', 0, 0),
	(5, 'time_zone', 'basics', 'time zone', '', 'string', 'Asia/Shanghai', NULL, 'required', '', 0, 0),
	(6, 'no_access_ip', 'basics', 'No access ip', '禁止访问站点的ip列表,一行一个', 'textarea', NULL, NULL, '', '', 0, 0),
	(7, 'smtp_server', 'mail', 'smtp server', '', 'string', 'smtp.qq.com', NULL, '', '', 0, 9),
	(8, 'smtp_port', 'mail', 'smtp port', '', 'string', '465', NULL, '', '', 0, 8),
	(9, 'smtp_user', 'mail', 'smtp user', '', 'string', NULL, NULL, '', '', 0, 7),
	(10, 'smtp_pass', 'mail', 'smtp pass', '', 'string', NULL, NULL, '', '', 0, 6),
	(11, 'smtp_verification', 'mail', 'smtp verification', '', 'select', 'SSL', '{"SSL":"SSL","TLS":"TLS"}', '', '', 0, 5),
	(12, 'smtp_sender_mail', 'mail', 'smtp sender mail', '', 'string', NULL, NULL, 'email', '', 0, 4),
	(13, 'config_quick_entrance', 'config_quick_entrance', 'Config Quick entrance', '', 'array', '[{"key":"\\u6570\\u636e\\u56de\\u6536\\u89c4\\u5219\\u914d\\u7f6e","value":"security\\/dataRecycle"},{"key":"\\u654f\\u611f\\u6570\\u636e\\u89c4\\u5219\\u914d\\u7f6e","value":"security\\/sensitiveData"}]', NULL, '', '', 0, 0),
	(14, 'backend_entrance', 'basics', 'Backend entrance', '', 'string', '/admin', NULL, 'required', '', 0, 1);

-- 导出  表 workai.ba_crud_log 结构
DROP TABLE IF EXISTS `ba_crud_log`;
CREATE TABLE IF NOT EXISTS `ba_crud_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `table_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表名',
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '注释',
  `table` text COLLATE utf8mb4_unicode_ci COMMENT '数据表数据',
  `fields` text COLLATE utf8mb4_unicode_ci COMMENT '字段数据',
  `sync` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '同步记录',
  `status` enum('delete','success','error','start') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'start' COMMENT '状态:delete=已删除,success=成功,error=失败,start=生成中',
  `connection` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `create_time` bigint(20) unsigned DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='CRUD记录表';

-- 正在导出表  workai.ba_crud_log 的数据：~0 rows (大约)
INSERT INTO `ba_crud_log` (`id`, `table_name`, `comment`, `table`, `fields`, `sync`, `status`, `connection`, `create_time`) VALUES
	(1, 'requirement_forms', '简化需求表单表', '{"name":"requirement_forms","comment":"简化需求表单表","quickSearchField":["id"],"defaultSortField":"id","formFields":["contact_info","requirement_type","requirement_content","payment_method","payment_amount","status","is_deleted"],"columnFields":["id","contact_info","requirement_type","payment_method","payment_amount","create_time","status","is_deleted"],"defaultSortType":"desc","generateRelativePath":"requirement_forms","isCommonModel":"0","modelFile":"app\\\\admin\\\\model\\\\requirement\\\\Forms.php","controllerFile":"app\\\\admin\\\\controller\\\\requirement\\\\Forms.php","validateFile":"app\\\\admin\\\\validate\\\\requirement\\\\Forms.php","webViewsDir":"web\\\\src\\\\views\\\\backend\\\\requirement\\\\forms","databaseConnection":"mysql","designChange":[],"rebuild":"No"}', '[{"name":"id","type":"bigint","dataType":"bigint(20)","default":"","defaultType":"NONE","null":"","primaryKey":"1","unsigned":"1","autoIncrement":"1","comment":"主键ID","designType":"pk","table":{"width":"70","operator":"RANGE","sortable":"custom"},"form":[]},{"name":"contact_info","type":"varchar","dataType":"varchar(200)","default":"","defaultType":"EMPTY STRING","null":"","primaryKey":"","unsigned":"","autoIncrement":"","comment":"联系方式（电话\\/邮箱等）","designType":"string","table":{"render":"none","operator":"LIKE","sortable":"false"},"form":{"validator":[],"validatorMsg":""}},{"name":"requirement_type","type":"enum","dataType":"enum(\'策划文档\',\'美术\\/视频\',\'Demo原型\',\'定制开发\',\'咨询\',\'其他\')","default":"","defaultType":"NULL","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"需求类型（可选）","designType":"radio","table":{"render":"tag","operator":"eq","sortable":"false"},"form":{"validator":[],"validatorMsg":""}},{"name":"requirement_content","type":"text","dataType":"text","default":"","defaultType":"NONE","null":"","primaryKey":"","unsigned":"","autoIncrement":"","comment":"需求详细内容（必填）","designType":"editor","table":{"operator":"false"},"form":{"validator":["editorRequired"],"validatorMsg":""}},{"name":"payment_method","type":"varchar","dataType":"varchar(50)","default":"","defaultType":"NULL","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"支付方式","designType":"string","table":{"render":"none","operator":"LIKE","sortable":"false"},"form":{"validator":[],"validatorMsg":""}},{"name":"payment_amount","type":"decimal","dataType":"decimal(10,2)","default":"","defaultType":"NULL","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"支付金额","designType":"number","table":{"render":"none","operator":"RANGE","sortable":"false"},"form":{"validator":["number"],"validatorMsg":"","step":"1"}},{"name":"create_time","type":"bigint","dataType":"bigint(20)","default":"","defaultType":"NONE","null":"","primaryKey":"","unsigned":"","autoIncrement":"","comment":"创建时间（毫秒时间戳）","designType":"timestamp","table":{"render":"datetime","operator":"RANGE","sortable":"custom","width":"160","timeFormat":"yyyy-mm-dd hh:MM:ss"},"form":{"validator":["date"],"validatorMsg":""}},{"name":"status","type":"enum","dataType":"enum(\'待处理\',\'已确认\',\'已完成\')","default":"待处理","defaultType":"INPUT","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"处理状态","designType":"radio","table":{"render":"tag","operator":"eq","sortable":"false"},"form":{"validator":[],"validatorMsg":""}},{"name":"is_deleted","type":"tinyint","dataType":"tinyint(4)","default":"0","defaultType":"INPUT","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"软删除标记(0:正常 1:删除)","designType":"number","table":{"render":"none","operator":"RANGE","sortable":"false"},"form":{"validator":["number"],"validatorMsg":"","step":"1"}}]', 0, 'success', 'mysql', 1767782451),
	(2, 'requirement_forms', '简化需求表单表', '{"name":"requirement_forms","comment":"简化需求表单表","quickSearchField":["id"],"defaultSortField":"id","formFields":["contact_info","requirement_type","requirement_content","payment_method","payment_amount","status","is_deleted","pay_status1"],"columnFields":["id","contact_info","requirement_type","payment_method","payment_amount","create_time","status","is_deleted","pay_status1"],"defaultSortType":"desc","generateRelativePath":"requirement_forms","isCommonModel":"0","modelFile":"app\\\\admin\\\\model\\\\requirement\\\\Forms.php","controllerFile":"app\\\\admin\\\\controller\\\\requirement\\\\Forms.php","validateFile":"app\\\\admin\\\\validate\\\\requirement\\\\Forms.php","webViewsDir":"web\\\\src\\\\views\\\\backend\\\\requirement\\\\forms","databaseConnection":"mysql","designChange":[{"type":"add-field","index":"8","newName":"pay_status1","oldName":"","after":"status","sync":"1"}],"rebuild":"No","empty":""}', '[{"name":"id","type":"bigint","dataType":"bigint(20)","default":"","defaultType":"NONE","null":"","primaryKey":"1","unsigned":"1","autoIncrement":"1","comment":"主键ID","designType":"pk","table":{"width":"70","operator":"RANGE","sortable":"custom"},"form":[]},{"name":"contact_info","type":"varchar","dataType":"varchar(200)","default":"","defaultType":"EMPTY STRING","null":"","primaryKey":"","unsigned":"","autoIncrement":"","comment":"联系方式（电话\\/邮箱等）","designType":"string","table":{"render":"none","operator":"LIKE","sortable":"false"},"form":{"validator":[],"validatorMsg":""}},{"name":"requirement_type","type":"enum","dataType":"enum(\'策划文档\',\'美术\\/视频\',\'Demo原型\',\'定制开发\',\'咨询\',\'其他\')","default":"","defaultType":"NULL","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"需求类型（可选）","designType":"radio","table":{"render":"tag","operator":"eq","sortable":"false"},"form":{"validator":[],"validatorMsg":""}},{"name":"requirement_content","type":"text","dataType":"text","default":"","defaultType":"NONE","null":"","primaryKey":"","unsigned":"","autoIncrement":"","comment":"需求详细内容（必填）","designType":"editor","table":{"operator":"false"},"form":{"validator":["editorRequired"],"validatorMsg":""}},{"name":"payment_method","type":"varchar","dataType":"varchar(50)","default":"","defaultType":"NULL","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"支付方式","designType":"string","table":{"render":"none","operator":"LIKE","sortable":"false"},"form":{"validator":[],"validatorMsg":""}},{"name":"payment_amount","type":"decimal","dataType":"decimal(10,2)","default":"","defaultType":"NULL","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"支付金额","designType":"number","table":{"render":"none","operator":"RANGE","sortable":"false"},"form":{"validator":["number"],"validatorMsg":"","step":"1"}},{"name":"create_time","type":"bigint","dataType":"bigint(20)","default":"","defaultType":"NONE","null":"","primaryKey":"","unsigned":"","autoIncrement":"","comment":"创建时间（毫秒时间戳）","designType":"timestamp","table":{"render":"datetime","operator":"RANGE","sortable":"custom","width":"160","timeFormat":"yyyy-mm-dd hh:MM:ss"},"form":{"validator":["date"],"validatorMsg":""}},{"name":"status","type":"enum","dataType":"enum(\'待处理\',\'已确认\',\'已完成\')","default":"待处理","defaultType":"INPUT","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"处理状态","designType":"radio","table":{"render":"tag","operator":"eq","sortable":"false"},"form":{"validator":[],"validatorMsg":""}},{"title":"状态","name":"pay_status1","comment":"支付状态:0=未支付,1=已支付","designType":"switch","table":{"render":"switch","operator":"eq","sortable":"false"},"form":{"validator":[],"validatorMsg":""},"type":"tinyint","length":"1","precision":"0","default":"0","defaultType":"INPUT","null":"","primaryKey":"","unsigned":"1","autoIncrement":""},{"name":"is_deleted","type":"tinyint","dataType":"tinyint(4)","default":"0","defaultType":"INPUT","null":"1","primaryKey":"","unsigned":"","autoIncrement":"","comment":"软删除标记(0:正常 1:删除)","designType":"number","table":{"render":"none","operator":"RANGE","sortable":"false"},"form":{"validator":["number"],"validatorMsg":"","step":"1"}}]', 0, 'success', 'mysql', 1767783553);

-- 导出  表 workai.ba_migrations 结构
DROP TABLE IF EXISTS `ba_migrations`;
CREATE TABLE IF NOT EXISTS `ba_migrations` (
  `version` bigint(20) NOT NULL,
  `migration_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `breakpoint` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 正在导出表  workai.ba_migrations 的数据：~8 rows (大约)
INSERT INTO `ba_migrations` (`version`, `migration_name`, `start_time`, `end_time`, `breakpoint`) VALUES
	(20230620180908, 'Install', '2026-01-07 07:24:05', '2026-01-07 07:24:05', 0),
	(20230620180916, 'InstallData', '2026-01-07 07:24:05', '2026-01-07 07:24:05', 0),
	(20230622221507, 'Version200', '2026-01-07 07:24:05', '2026-01-07 07:24:06', 0),
	(20230719211338, 'Version201', '2026-01-07 07:24:06', '2026-01-07 07:24:06', 0),
	(20230905060702, 'Version202', '2026-01-07 07:24:06', '2026-01-07 07:24:06', 0),
	(20231112093414, 'Version205', '2026-01-07 07:24:06', '2026-01-07 07:24:06', 0),
	(20231229043002, 'Version206', '2026-01-07 07:24:06', '2026-01-07 07:24:06', 0),
	(20250412134127, 'Version222', '2026-01-07 07:24:06', '2026-01-07 07:24:06', 0);

-- 导出  表 workai.ba_requirement_forms 结构
DROP TABLE IF EXISTS `ba_requirement_forms`;
CREATE TABLE IF NOT EXISTS `ba_requirement_forms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `contact_info` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系方式（电话/邮箱等）',
  `requirement_type` enum('策划文档','美术/视频','Demo原型','定制开发','咨询','其他') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '需求类型（可选）',
  `requirement_content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '需求详细内容（必填）',
  `payment_method` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付方式',
  `payment_amount` decimal(10,2) DEFAULT NULL COMMENT '支付金额',
  `create_time` bigint(20) NOT NULL COMMENT '创建时间（毫秒时间戳）',
  `status` enum('待处理','已确认','已完成') COLLATE utf8mb4_unicode_ci DEFAULT '待处理' COMMENT '处理状态',
  `pay_status1` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '支付状态:0=未支付,1=已支付',
  `is_deleted` tinyint(4) DEFAULT '0' COMMENT '软删除标记(0:正常 1:删除)',
  PRIMARY KEY (`id`),
  KEY `idx_create_time` (`create_time`),
  KEY `idx_status` (`status`),
  KEY `idx_contact_info` (`contact_info`(20))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='简化需求表单表';

-- 正在导出表  workai.ba_requirement_forms 的数据：~2 rows (大约)
INSERT INTO `ba_requirement_forms` (`id`, `contact_info`, `requirement_type`, `requirement_content`, `payment_method`, `payment_amount`, `create_time`, `status`, `pay_status1`, `is_deleted`) VALUES
	(1, '13800138000', '咨询', '需要开发一个用户管理系统，包含用户注册、登录、权限管理等功能。', '在线支付', 5000.00, 1767782343000, '待处理', 0, 0),
	(2, 'example@email.com', '咨询', '想咨询关于系统架构设计的最佳实践，以及微服务与传统单体架构的对比。', NULL, NULL, 1767782343000, '待处理', 0, 0),
	(3, 'bumaya1024@163.com', 'Demo原型', '开发一个多米诺小游戏原型', 'wxpay', 1.00, 1767783234, '待处理', 0, 0),
	(4, 'bumaya1024@163.com', '策划文档', '写一个ppt', 'wxpay', 1.00, 1767783936, '待处理', 0, 0),
	(5, 'bumaya1024@163.com', NULL, 'test1', 'wxpay', 1.00, 1767784631, '待处理', 0, 0);

-- 导出  表 workai.ba_security_data_recycle 结构
DROP TABLE IF EXISTS `ba_security_data_recycle`;
CREATE TABLE IF NOT EXISTS `ba_security_data_recycle` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `controller` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器',
  `controller_as` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器别名',
  `data_table` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '对应数据表',
  `connection` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `primary_key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表主键',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) unsigned DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='回收规则表';

-- 正在导出表  workai.ba_security_data_recycle 的数据：~6 rows (大约)
INSERT INTO `ba_security_data_recycle` (`id`, `name`, `controller`, `controller_as`, `data_table`, `connection`, `primary_key`, `status`, `update_time`, `create_time`) VALUES
	(1, '管理员', 'auth/Admin.php', 'auth/admin', 'admin', '', 'id', 1, 1767770645, 1767770645),
	(2, '管理员日志', 'auth/AdminLog.php', 'auth/adminlog', 'admin_log', '', 'id', 1, 1767770645, 1767770645),
	(3, '菜单规则', 'auth/Menu.php', 'auth/menu', 'menu_rule', '', 'id', 1, 1767770645, 1767770645),
	(4, '系统配置项', 'routine/Config.php', 'routine/config', 'config', '', 'id', 1, 1767770645, 1767770645),
	(5, '会员', 'user/User.php', 'user/user', 'user', '', 'id', 1, 1767770645, 1767770645),
	(6, '数据回收规则', 'security/DataRecycle.php', 'security/datarecycle', 'security_data_recycle', '', 'id', 1, 1767770645, 1767770645);

-- 导出  表 workai.ba_security_data_recycle_log 结构
DROP TABLE IF EXISTS `ba_security_data_recycle_log`;
CREATE TABLE IF NOT EXISTS `ba_security_data_recycle_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '操作管理员',
  `recycle_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '回收规则ID',
  `data` text COLLATE utf8mb4_unicode_ci COMMENT '回收的数据',
  `data_table` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表',
  `connection` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `primary_key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表主键',
  `is_restore` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否已还原:0=否,1=是',
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作者IP',
  `useragent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `create_time` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='数据回收记录表';

-- 正在导出表  workai.ba_security_data_recycle_log 的数据：~0 rows (大约)

-- 导出  表 workai.ba_security_sensitive_data 结构
DROP TABLE IF EXISTS `ba_security_sensitive_data`;
CREATE TABLE IF NOT EXISTS `ba_security_sensitive_data` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `controller` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器',
  `controller_as` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器别名',
  `data_table` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '对应数据表',
  `connection` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `primary_key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表主键',
  `data_fields` text COLLATE utf8mb4_unicode_ci COMMENT '敏感数据字段',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) unsigned DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='敏感数据规则表';

-- 正在导出表  workai.ba_security_sensitive_data 的数据：~3 rows (大约)
INSERT INTO `ba_security_sensitive_data` (`id`, `name`, `controller`, `controller_as`, `data_table`, `connection`, `primary_key`, `data_fields`, `status`, `update_time`, `create_time`) VALUES
	(1, '管理员数据', 'auth/Admin.php', 'auth/admin', 'admin', '', 'id', '{"username":"用户名","mobile":"手机","password":"密码","status":"状态"}', 1, 1767770645, 1767770645),
	(2, '会员数据', 'user/User.php', 'user/user', 'user', '', 'id', '{"username":"用户名","mobile":"手机号","password":"密码","status":"状态","email":"邮箱地址"}', 1, 1767770645, 1767770645),
	(3, '管理员权限', 'auth/Group.php', 'auth/group', 'admin_group', '', 'id', '{"rules":"权限规则ID"}', 1, 1767770645, 1767770645);

-- 导出  表 workai.ba_security_sensitive_data_log 结构
DROP TABLE IF EXISTS `ba_security_sensitive_data_log`;
CREATE TABLE IF NOT EXISTS `ba_security_sensitive_data_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '操作管理员',
  `sensitive_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '敏感数据规则ID',
  `data_table` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表',
  `connection` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据库连接配置标识',
  `primary_key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '数据表主键',
  `data_field` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '被修改字段',
  `data_comment` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '被修改项',
  `id_value` int(11) NOT NULL DEFAULT '0' COMMENT '被修改项主键值',
  `before` text COLLATE utf8mb4_unicode_ci COMMENT '修改前',
  `after` text COLLATE utf8mb4_unicode_ci COMMENT '修改后',
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '操作者IP',
  `useragent` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `is_rollback` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否已回滚:0=否,1=是',
  `create_time` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='敏感数据修改记录';

-- 正在导出表  workai.ba_security_sensitive_data_log 的数据：~0 rows (大约)

-- 导出  表 workai.ba_test_build 结构
DROP TABLE IF EXISTS `ba_test_build`;
CREATE TABLE IF NOT EXISTS `ba_test_build` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标题',
  `keyword_rows` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '关键词',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `views` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `likes` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '有帮助数',
  `dislikes` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '无帮助数',
  `note_textarea` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `weigh` int(11) NOT NULL DEFAULT '0' COMMENT '权重',
  `update_time` bigint(20) unsigned DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(20) unsigned DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='知识库表';

-- 正在导出表  workai.ba_test_build 的数据：~0 rows (大约)

-- 导出  表 workai.ba_token 结构
DROP TABLE IF EXISTS `ba_token`;
CREATE TABLE IF NOT EXISTS `ba_token` (
  `token` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Token',
  `type` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '类型',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `create_time` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  `expire_time` bigint(16) unsigned DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='用户Token表';

-- 正在导出表  workai.ba_token 的数据：~3 rows (大约)
INSERT INTO `ba_token` (`token`, `type`, `user_id`, `create_time`, `expire_time`) VALUES
	('5f455f8f2a94faabeb65f50a91aca054e42a7484', 'admin-refresh', 1, 1767781697, 1770373697),
	('99dda673cc397f4070eff64a186d351729a5362e', 'admin', 1, 1767770716, 1768029916),
	('c6265235c217c0faf6deb78730e89b9b097b8c79', 'admin', 1, 1767781697, 1768040897);

-- 导出  表 workai.ba_user 结构
DROP TABLE IF EXISTS `ba_user`;
CREATE TABLE IF NOT EXISTS `ba_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分组ID',
  `username` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '头像',
  `gender` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '性别:0=未知,1=男,2=女',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `money` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '余额',
  `score` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '积分',
  `last_login_time` bigint(16) unsigned DEFAULT NULL COMMENT '上次登录时间',
  `last_login_ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '上次登录IP',
  `login_failure` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '登录失败次数',
  `join_ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '加入IP',
  `join_time` bigint(16) unsigned DEFAULT NULL COMMENT '加入时间',
  `motto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '签名',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '密码盐（废弃待删）',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '状态:enable=启用,disable=禁用',
  `update_time` bigint(16) unsigned DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='会员表';

-- 正在导出表  workai.ba_user 的数据：~0 rows (大约)
INSERT INTO `ba_user` (`id`, `group_id`, `username`, `nickname`, `email`, `mobile`, `avatar`, `gender`, `birthday`, `money`, `score`, `last_login_time`, `last_login_ip`, `login_failure`, `join_ip`, `join_time`, `motto`, `password`, `salt`, `status`, `update_time`, `create_time`) VALUES
	(1, 1, 'user', 'User', '18888888888@qq.com', '18888888888', '', 2, '2026-01-07', 0, 0, NULL, '', 0, '', NULL, '', '$2y$10$bLaNvLRixV6jyhjm9yjwtOwGrwUdYBq7B8mQhXKQIo914KlCegZCO', '', 'enable', 1767770645, 1767770645);

-- 导出  表 workai.ba_user_group 结构
DROP TABLE IF EXISTS `ba_user_group`;
CREATE TABLE IF NOT EXISTS `ba_user_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组名',
  `rules` text COLLATE utf8mb4_unicode_ci COMMENT '权限节点',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) unsigned DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='会员组表';

-- 正在导出表  workai.ba_user_group 的数据：~0 rows (大约)
INSERT INTO `ba_user_group` (`id`, `name`, `rules`, `status`, `update_time`, `create_time`) VALUES
	(1, '默认分组', '*', 1, 1767770645, 1767770645);

-- 导出  表 workai.ba_user_money_log 结构
DROP TABLE IF EXISTS `ba_user_money_log`;
CREATE TABLE IF NOT EXISTS `ba_user_money_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `money` int(11) NOT NULL DEFAULT '0' COMMENT '变更余额',
  `before` int(11) NOT NULL DEFAULT '0' COMMENT '变更前余额',
  `after` int(11) NOT NULL DEFAULT '0' COMMENT '变更后余额',
  `memo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='会员余额变动表';

-- 正在导出表  workai.ba_user_money_log 的数据：~0 rows (大约)

-- 导出  表 workai.ba_user_rule 结构
DROP TABLE IF EXISTS `ba_user_rule`;
CREATE TABLE IF NOT EXISTS `ba_user_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上级菜单',
  `type` enum('route','menu_dir','menu','nav_user_menu','nav','button') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'menu' COMMENT '类型:route=路由,menu_dir=菜单目录,menu=菜单项,nav_user_menu=顶栏会员菜单下拉项,nav=顶栏菜单项,button=页面按钮',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '标题',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `path` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '路由路径',
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '图标',
  `menu_type` enum('tab','link','iframe') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'tab' COMMENT '菜单类型:tab=选项卡,link=链接,iframe=Iframe',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Url',
  `component` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '组件路径',
  `no_login_valid` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '未登录有效:0=否,1=是',
  `extend` enum('none','add_rules_only','add_menu_only') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none' COMMENT '扩展属性:none=无,add_rules_only=只添加为路由,add_menu_only=只添加为菜单',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `weigh` int(11) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态:0=禁用,1=启用',
  `update_time` bigint(16) unsigned DEFAULT NULL COMMENT '更新时间',
  `create_time` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='会员菜单权限规则表';

-- 正在导出表  workai.ba_user_rule 的数据：~6 rows (大约)
INSERT INTO `ba_user_rule` (`id`, `pid`, `type`, `title`, `name`, `path`, `icon`, `menu_type`, `url`, `component`, `no_login_valid`, `extend`, `remark`, `weigh`, `status`, `update_time`, `create_time`) VALUES
	(1, 0, 'menu_dir', '我的账户', 'account', 'account', 'fa fa-user-circle', 'tab', '', '', 0, 'none', '', 98, 1, 1767770645, 1767770645),
	(2, 1, 'menu', '账户概览', 'account/overview', 'account/overview', 'fa fa-home', 'tab', '', '/src/views/frontend/user/account/overview.vue', 0, 'none', '', 99, 1, 1767770645, 1767770645),
	(3, 1, 'menu', '个人资料', 'account/profile', 'account/profile', 'fa fa-user-circle-o', 'tab', '', '/src/views/frontend/user/account/profile.vue', 0, 'none', '', 98, 1, 1767770645, 1767770645),
	(4, 1, 'menu', '修改密码', 'account/changePassword', 'account/changePassword', 'fa fa-shield', 'tab', '', '/src/views/frontend/user/account/changePassword.vue', 0, 'none', '', 97, 1, 1767770645, 1767770645),
	(5, 1, 'menu', '积分记录', 'account/integral', 'account/integral', 'fa fa-tag', 'tab', '', '/src/views/frontend/user/account/integral.vue', 0, 'none', '', 96, 1, 1767770645, 1767770645),
	(6, 1, 'menu', '余额记录', 'account/balance', 'account/balance', 'fa fa-money', 'tab', '', '/src/views/frontend/user/account/balance.vue', 0, 'none', '', 95, 1, 1767770645, 1767770645);

-- 导出  表 workai.ba_user_score_log 结构
DROP TABLE IF EXISTS `ba_user_score_log`;
CREATE TABLE IF NOT EXISTS `ba_user_score_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '变更积分',
  `before` int(11) NOT NULL DEFAULT '0' COMMENT '变更前积分',
  `after` int(11) NOT NULL DEFAULT '0' COMMENT '变更后积分',
  `memo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` bigint(16) unsigned DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='会员积分变动表';

-- 正在导出表  workai.ba_user_score_log 的数据：~0 rows (大约)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
