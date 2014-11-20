-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2014 年 11 月 20 日 10:09
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
(1, 'custom1', 'custom1', '客户1', 10000000, 12345, '123456', 1416310026),
(2, 'custom2', 'custom2', '客户2', 10000000, 12345, '123456', 1416310026);

-- --------------------------------------------------------

--
-- 表的结构 `distributor_info`
--

CREATE TABLE IF NOT EXISTS `distributor_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` char(20) NOT NULL,
  `password` char(20) NOT NULL,
  `truename` char(10) NOT NULL,
  `identify` char(20) DEFAULT NULL,
  `bank_card` int(20) NOT NULL,
  `company` char(20) NOT NULL,
  `sex` varchar(2) DEFAULT NULL,
  `birth` int(11) DEFAULT NULL,
  `QQ` int(11) DEFAULT NULL,
  `phone` char(20) NOT NULL,
  `address` char(255) NOT NULL,
  `cTime` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '是否审核通过',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- 转存表中的数据 `distributor_info`
--

INSERT INTO `distributor_info` (`id`, `username`, `password`, `truename`, `identify`, `bank_card`, `company`, `sex`, `birth`, `QQ`, `phone`, `address`, `cTime`, `status`) VALUES
(1, 'distributior1', 'distributior1', '分销商1', '123456789', 1234567890, '分销商公司', '男', 100000001, 12345, '123456', '分销商1地址', 1416310026, 0),
(2, 'distributior2', 'distributior2', '分销商2', '123456789', 1234567890, '分销商公司', '女', 100000000, 12345, '123456', '分销商2地址', 1416310026, 1),
(3, 'user1416222830', 'user1416222830', '郭麦冬', NULL, 123456789, '分销商所在地', NULL, NULL, NULL, '13610063905', '分销商地址', 1416310026, 1),
(4, 'user1416223423', 'user1416223423', '郭麦冬', NULL, 123456788, '分销商所在地', NULL, NULL, NULL, '13610063906', '分销商地址', 2147483647, 0),
(5, 'distributior5', 'distributior5', '分销商5', '123456789', 123456789, '分销商5公司', NULL, NULL, NULL, '123456', '分销商5地址', 1416310026, 0),
(6, 'user1416399001', 'user1416399001', '郭麦冬', NULL, 123456788, '分销商所在地', NULL, NULL, NULL, '13610063906', '分销商地址', 0, 1),
(7, 'user1416399011', 'user1416399011', '', NULL, 123456788, '分销商所在地', NULL, NULL, NULL, '13610063906', '分销商地址', 0, 1),
(8, 'user1416399080', 'user1416399080', '', NULL, 123456788, '分销商所在地', NULL, NULL, NULL, '13610063906', '分销商地址', 0, 1),
(9, 'user1416399293', 'user1416399293', '郭麦冬', NULL, 123456788, '分销商9所在地', NULL, NULL, NULL, '13610063906', '分销商9地址', 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `distributor_sale`
--

CREATE TABLE IF NOT EXISTS `distributor_sale` (
  `distributor_id` int(11) NOT NULL COMMENT '分销商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `amount` int(11) NOT NULL COMMENT '销售数量',
  `status` int(11) NOT NULL COMMENT '是否上架',
  `cTime` int(11) NOT NULL,
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
  `company` char(50) NOT NULL,
  `description` char(255) NOT NULL COMMENT '厂家描述',
  `address` char(50) NOT NULL COMMENT '厂家所在地',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `factory_info`
--

INSERT INTO `factory_info` (`id`, `username`, `password`, `truename`, `sex`, `phone`, `company`, `description`, `address`) VALUES
(1, 'factory', 'factory', '厂家', '男', '13610063906', '厂家公司名', '这是一个厂家简介', '公司地址');

-- --------------------------------------------------------

--
-- 表的结构 `order_list`
--

CREATE TABLE IF NOT EXISTS `order_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '保持唯一',
  `order_id` int(11) NOT NULL,
  `custom_id` int(11) NOT NULL,
  `distributor_id` int(11) NOT NULL COMMENT '分销商ID',
  `salesman_id` int(11) NOT NULL COMMENT '零售商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `spec_id` int(11) NOT NULL COMMENT '产品规格ID',
  `amount` int(11) NOT NULL COMMENT '购买数量',
  `unit_price` int(11) NOT NULL COMMENT '单价',
  `salesman_profit` int(11) NOT NULL COMMENT '销售员利润',
  `distributor_profit` int(11) NOT NULL,
  `factory_profit` int(11) NOT NULL,
  `total_price` int(11) NOT NULL COMMENT '总价',
  `address` char(255) NOT NULL COMMENT '送货地址',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '订单的状态0：下单、1：未付款、2：已付款、3：货到付款、4：配送中、5：成功',
  `confirm` int(11) DEFAULT NULL COMMENT '确认订单  0：取消、1：确认',
  `cTime` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `order_list`
--

INSERT INTO `order_list` (`id`, `order_id`, `custom_id`, `distributor_id`, `salesman_id`, `product_id`, `spec_id`, `amount`, `unit_price`, `salesman_profit`, `distributor_profit`, `factory_profit`, `total_price`, `address`, `status`, `confirm`, `cTime`) VALUES
(1, 900, 1, 1, 1, 1, 1, 10, 100, 0, 0, 0, 1000, '', 0, 1, 1416310026),
(2, 902, 1, 2, 2, 11, 15, 1, 12, 0, 0, 0, 12, '', 0, 1, 1416000026),
(3, 901, 1, 1, 1, 1, 1, 10, 100, 0, 0, 0, 1000, '', 0, 1, 1416010026),
(4, 901, 1, 2, 2, 11, 15, 1, 12, 0, 0, 0, 12, '', 0, 1, 1415310026),
(5, 902, 1, 2, 2, 11, 16, 10, 10, 0, 0, 0, 100, '', 0, 1, 1416000026),
(6, 900, 1, 1, 1, 11, 16, 10, 10, 0, 0, 0, 100, '', 0, 1, 1416310026);

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
  `distributor_price` int(11) NOT NULL COMMENT '分销价',
  `salesman_price` int(11) NOT NULL COMMENT '零售价',
  `producer` char(10) NOT NULL COMMENT '商品生产商',
  `has_sale` int(11) NOT NULL COMMENT '销量',
  `left` int(11) NOT NULL COMMENT '库存',
  `status` int(11) NOT NULL COMMENT '是否上架',
  `cTime` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- 转存表中的数据 `product_info`
--

INSERT INTO `product_info` (`id`, `name`, `model`, `introduction`, `cost_price`, `distributor_price`, `salesman_price`, `producer`, `has_sale`, `left`, `status`, `cTime`) VALUES
(1, '产品1', '玩具', '这是一个产品1介绍', 10, 15, 20, '产品1的生产商', 10, 90, 1, 1416000026),
(2, '产品2', '书籍', '这是一个产品2介绍', 10, 15, 20, '产品2的生产商', 5, 95, 1, 1416000026),
(3, '商品3', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, 1416000026),
(4, '商品3', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, 1416000026),
(5, '商品3', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, 1416000026),
(6, '商品3', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, 1416000026),
(7, '商品3', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, 1416000026),
(8, '商品4', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, 1416000026),
(9, '商品9', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, 1416000026),
(10, '商品4', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, 1416000026),
(11, '商品11', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 1, 1416000026),
(14, '商品11', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 0, 1416000026),
(15, '商品11', '贺卡', '描述', 10, 12, 20, '某地', 10, 0, 0, 1416000026);

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
  `bank_card` int(11) NOT NULL,
  `address` char(255) NOT NULL,
  `QQ` int(11) NOT NULL,
  `phone` char(20) NOT NULL,
  `cTime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `salesman_info`
--

INSERT INTO `salesman_info` (`id`, `username`, `password`, `distributor_id`, `truename`, `sex`, `birth`, `identify`, `bank_card`, `address`, `QQ`, `phone`, `cTime`) VALUES
(1, 'salesman1', 'salesman1', 1, '销售员1', '男', 10000000, '1234567891', 0, '这是销售员1的地址', 12345, '123456', 1416000026),
(2, 'salesman2', 'salesman2', 2, '销售员2', '女', 100000000, '1234567892', 0, '这是销售员2的地址', 12345, '123456', 1416000026);

-- --------------------------------------------------------

--
-- 表的结构 `salesman_sale`
--

CREATE TABLE IF NOT EXISTS `salesman_sale` (
  `salesman_id` int(11) NOT NULL COMMENT '零售商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `amount` int(11) NOT NULL COMMENT '销售数量',
  `status` int(11) NOT NULL COMMENT '是否上架',
  `cTime` int(11) NOT NULL,
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
(1, 1, '蓝色', '10寸', '', '546771f1b9e2e.png', '546771f1b9e2e.png', '', '', ''),
(2, 1, '黑色', '11寸', '', '546771f1b9e2e.png', '', '', '', ''),
(5, 4, '蓝色', NULL, NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL),
(9, 8, '黑色', NULL, NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL),
(10, 9, '黑色', '黑色', NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL),
(11, 10, '黑色', '黑色', NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL),
(12, 10, '黑色', '黑色', NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL),
(15, 11, '黄色', '10寸', NULL, '546771f1c4b6d.png', NULL, NULL, NULL, NULL),
(16, 11, '蓝色', '11寸', NULL, '546771f1c4b6d.png', NULL, NULL, NULL, NULL),
(21, 14, 'bbb', 'bbb', NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL),
(22, 14, 'vvv', 'vvv', NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL),
(23, 15, 'bbb', 'bbb', NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL),
(24, 15, 'vvv', 'vvv', NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL);

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
