-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2014 年 11 月 16 日 14:15
-- 服务器版本: 5.6.12-log
-- PHP 版本: 5.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `distribution`
--
CREATE DATABASE IF NOT EXISTS `distribution` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `distribution`;

-- --------------------------------------------------------

--
-- 表的结构 `custom_info`
--

CREATE TABLE IF NOT EXISTS `custom_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` char(20) NOT NULL,
  `password` char(20) NOT NULL,
  `truename` char(10) NOT NULL,
  `birth` int(11) NOT NULL,
  `QQ` int(11) NOT NULL,
  `phone` char(20) NOT NULL,
  `cTime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `custom_info`
--

INSERT INTO `custom_info` (`id`, `username`, `password`, `truename`, `birth`, `QQ`, `phone`, `cTime`) VALUES
(1, 'custom1', 'custom1', '客户1', 10000000, 12345, '123456', 10000000),
(2, 'custom2', 'custom2', '客户2', 10000000, 12345, '123456', 10000000);

-- --------------------------------------------------------

--
-- 表的结构 `distributor_info`
--

CREATE TABLE IF NOT EXISTS `distributor_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` char(20) NOT NULL,
  `password` char(20) NOT NULL,
  `truename` char(10) NOT NULL,
  `identify` char(20) NOT NULL,
  `bank_card` int(20) NOT NULL,
  `company` char(20) NOT NULL,
  `sex` varchar(2) NOT NULL,
  `birth` int(11) NOT NULL,
  `QQ` int(11) NOT NULL,
  `phone` char(20) NOT NULL,
  `address` char(255) NOT NULL,
  `cTime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `distributor_info`
--

INSERT INTO `distributor_info` (`id`, `username`, `password`, `truename`, `identify`, `bank_card`, `company`, `sex`, `birth`, `QQ`, `phone`, `address`, `cTime`) VALUES
(1, 'distributior1', 'distributior1', '分销商1', '123456789', 1234567890, '分销商公司', '男', 100000000, 12345, '123456', '分销商1地址', 100000000),
(2, 'distributior2', 'distributior2', '分销商2', '123456789', 1234567890, '分销商公司', '女', 100000000, 12345, '123456', '分销商2地址', 100000000);

-- --------------------------------------------------------

--
-- 表的结构 `distributor_sale`
--

CREATE TABLE IF NOT EXISTS `distributor_sale` (
  `distributor_id` int(11) NOT NULL COMMENT '分销商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `amount` int(11) NOT NULL COMMENT '销售数量',
  `status` int(11) NOT NULL COMMENT '是否上架',
  `cTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `distributor_id` (`distributor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `factory_info`
--

CREATE TABLE IF NOT EXISTS `factory_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '厂家id',
  `username` char(20) NOT NULL,
  `password` char(20) NOT NULL,
  `truename` char(10) NOT NULL COMMENT '厂家负责人姓名',
  `sex` varchar(2) NOT NULL COMMENT '厂家性别',
  `phone` char(20) NOT NULL COMMENT '厂家联系方式',
  `description` char(255) NOT NULL COMMENT '厂家描述',
  `address` char(50) NOT NULL COMMENT '厂家所在地',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `factory_info`
--

INSERT INTO `factory_info` (`id`, `username`, `password`, `truename`, `sex`, `phone`, `description`, `address`) VALUES
(1, 'factory', 'factory', '厂家', '男', '12345', '这是一个厂家简介', '这是厂家地址');

-- --------------------------------------------------------

--
-- 表的结构 `order_list`
--

CREATE TABLE IF NOT EXISTS `order_list` (
  `id` int(11) NOT NULL COMMENT '订单ID',
  `distributor_id` int(11) NOT NULL COMMENT '分销商ID',
  `salesman_id` int(11) NOT NULL COMMENT '零售商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `spec_id` int(11) NOT NULL COMMENT '产品规格ID',
  `amount` int(11) NOT NULL COMMENT '购买数量',
  `unit_price` int(11) NOT NULL COMMENT '单价',
  `total_price` int(11) NOT NULL COMMENT '总价',
  `cTime` int(11) NOT NULL COMMENT '创建时间',
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `product_info`
--

CREATE TABLE IF NOT EXISTS `product_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `name` char(10) NOT NULL COMMENT '产品名称',
  `model` char(10) NOT NULL COMMENT '产品型号',
  `introduction` char(255) NOT NULL COMMENT '产品简介',
  `cost_price` int(11) NOT NULL COMMENT '成本价',
  `distribution_price` int(11) NOT NULL COMMENT '分销价',
  `salesman_price` int(11) NOT NULL COMMENT '零售价',
  `producer` char(10) NOT NULL COMMENT '商品生产商',
  `has_sale` int(11) NOT NULL COMMENT '销量',
  `left` int(11) NOT NULL COMMENT '库存',
  `status` int(11) NOT NULL COMMENT '是否上架',
  `cTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- 转存表中的数据 `product_info`
--

INSERT INTO `product_info` (`id`, `name`, `model`, `introduction`, `cost_price`, `distribution_price`, `salesman_price`, `producer`, `has_sale`, `left`, `status`, `cTime`) VALUES
(1, '产品1', '玩具', '这是一个产品1介绍', 10, 15, 20, '产品1的生产商', 10, 90, 1, '2014-11-14 08:19:12'),
(2, '产品2', '书籍', '这是一个产品2介绍', 10, 15, 20, '产品2的生产商', 5, 95, 1, '2014-11-14 08:19:12'),
(3, '商品3', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, '2014-11-15 12:44:37'),
(4, '商品3', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, '2014-11-15 12:46:53'),
(5, '商品3', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, '2014-11-15 12:49:58'),
(6, '商品3', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, '2014-11-15 12:50:54'),
(7, '商品3', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, '2014-11-15 12:51:30'),
(8, '商品4', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, '2014-11-15 12:54:59'),
(9, '商品9', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, '2014-11-16 02:39:41'),
(10, '商品4', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, '2014-11-16 02:07:56'),
(11, '商品11', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, '2014-11-16 07:08:50'),
(14, '商品11', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, '2014-11-16 06:26:50'),
(15, '商品11', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, '2014-11-16 06:27:02');

-- --------------------------------------------------------

--
-- 表的结构 `salesman_info`
--

CREATE TABLE IF NOT EXISTS `salesman_info` (
  `id` int(11) NOT NULL,
  `username` char(20) NOT NULL,
  `password` char(20) NOT NULL,
  `distributor_id` int(11) NOT NULL,
  `truename` char(10) NOT NULL,
  `sex` varchar(2) NOT NULL,
  `birth` int(11) NOT NULL,
  `identify` char(20) NOT NULL,
  `address` char(255) NOT NULL,
  `QQ` int(11) NOT NULL,
  `phone` char(20) NOT NULL,
  `cTime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `salesman_info`
--

INSERT INTO `salesman_info` (`id`, `username`, `password`, `distributor_id`, `truename`, `sex`, `birth`, `identify`, `address`, `QQ`, `phone`, `cTime`) VALUES
(1, 'salesman1', 'salesman1', 1, '销售员1', '男', 10000000, '1234567891', '这是销售员1的地址', 12345, '123456', 162255),
(2, 'salesman2', 'salesman2', 2, '销售员2', '女', 100000000, '1234567892', '这是销售员2的地址', 12345, '123456', 10000000);

-- --------------------------------------------------------

--
-- 表的结构 `salesman_sale`
--

CREATE TABLE IF NOT EXISTS `salesman_sale` (
  `salesman_id` int(11) NOT NULL COMMENT '零售商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `amount` int(11) NOT NULL COMMENT '销售数量',
  `status` int(11) NOT NULL COMMENT '是否上架',
  `cTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `retailer_id` (`salesman_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `spec_image`
--

CREATE TABLE IF NOT EXISTS `spec_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL COMMENT '商品ID',
  `spec_1` char(20) DEFAULT NULL COMMENT '规格1',
  `spec_2` char(20) DEFAULT NULL COMMENT '规格2',
  `spec_3` char(20) DEFAULT NULL COMMENT '规格3',
  `image_1` char(255) DEFAULT NULL COMMENT '图片地址1',
  `image_2` char(255) DEFAULT NULL COMMENT '图片地址2',
  `image_3` char(255) DEFAULT NULL COMMENT '图片地址3',
  `image_4` char(255) DEFAULT NULL COMMENT '图片地址4',
  `image_5` char(255) DEFAULT NULL COMMENT '图片地址5',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- 转存表中的数据 `spec_image`
--

INSERT INTO `spec_image` (`id`, `product_id`, `spec_1`, `spec_2`, `spec_3`, `image_1`, `image_2`, `image_3`, `image_4`, `image_5`) VALUES
(1, 1, '蓝色', '10寸', '', 'http://t1.baidu.com/it/u=3479053995,2428277289&fm=20', 'http://t12.baidu.com/it/u=1308695678,1521435040&fm=58', '', '', ''),
(2, 1, '黑色', '11寸', '', 'http://t11.baidu.com/it/u=1015626520,2757642155&fm=58', '', '', '', ''),
(5, 4, 'fafa', NULL, NULL, 'fafaf', NULL, NULL, NULL, NULL),
(9, 8, 'fafa', NULL, NULL, '', NULL, NULL, NULL, NULL),
(10, 9, 'fff', 'aaff', NULL, 'aaff', NULL, NULL, NULL, NULL),
(11, 10, 'fafa', 'fafa', NULL, 'fafaf', NULL, NULL, NULL, NULL),
(12, 10, 'fafa', 'fafa', NULL, 'fafaf', NULL, NULL, NULL, NULL),
(15, 11, '红色', '10寸', NULL, '42422223.png', NULL, NULL, NULL, NULL),
(16, 11, '黑色', '11寸', NULL, '43245532.png', NULL, NULL, NULL, NULL),
(21, 14, 'bbb', 'bbb', NULL, 'bbb', NULL, NULL, NULL, NULL),
(22, 14, 'vvv', 'vvv', NULL, 'vvv', NULL, NULL, NULL, NULL),
(23, 15, 'bbb', 'bbb', NULL, 'bbb', NULL, NULL, NULL, NULL),
(24, 15, 'vvv', 'vvv', NULL, 'vvv', NULL, NULL, NULL, NULL);

--
-- 限制导出的表
--

--
-- 限制表 `distributor_sale`
--
ALTER TABLE `distributor_sale`
  ADD CONSTRAINT `distributor_sale_ibfk_3` FOREIGN KEY (`distributor_id`) REFERENCES `distributor_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `order_list`
--
ALTER TABLE `order_list`
  ADD CONSTRAINT `order_list_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `salesman_sale`
--
ALTER TABLE `salesman_sale`
  ADD CONSTRAINT `salesman_sale_ibfk_1` FOREIGN KEY (`salesman_id`) REFERENCES `salesman_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `spec_image`
--
ALTER TABLE `spec_image`
  ADD CONSTRAINT `spec_image_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
