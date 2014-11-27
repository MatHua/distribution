-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2014 年 11 月 24 日 12:36
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- 转存表中的数据 `custom_info`
--

INSERT INTO `custom_info` (`id`, `username`, `password`, `truename`, `birth`, `QQ`, `phone`, `cTime`) VALUES
(3, 'user1', 'user1', '王晓欣', 1416017707, 529242355, '13610063908', 1416717707);

-- --------------------------------------------------------

--
-- 表的结构 `delivery_info`
--

CREATE TABLE IF NOT EXISTS `delivery_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `custom_id` int(11) NOT NULL COMMENT '客户ID',
  `phone` char(20) NOT NULL COMMENT '送货电话',
  `address` char(255) NOT NULL COMMENT '送货地址',
  `name` char(20) NOT NULL COMMENT '送货姓名',
  PRIMARY KEY (`id`),
  KEY `custom_id` (`custom_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- 转存表中的数据 `delivery_info`
--

INSERT INTO `delivery_info` (`id`, `custom_id`, `phone`, `address`, `name`) VALUES
(1, 3, '13610063905', '广东省广州市广州大学城', '王晓欣'),
(2, 3, '13610063908', '广东省广州市海珠区', '王磊');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `distributor_info`
--

INSERT INTO `distributor_info` (`id`, `username`, `password`, `truename`, `identify`, `bank_card`, `company`, `sex`, `birth`, `QQ`, `phone`, `address`, `cTime`, `status`) VALUES
(1, 'user1416713371', 'user1416713371', '小新', NULL, 2147483647, '某某分销商单位', NULL, NULL, NULL, '13610063906', '广东省广州市广州大学城', 0, 1),
(2, 'user1416713422', 'user1416713422', '小红', NULL, 2147483647, '小红分销商单位', NULL, NULL, NULL, '13610063906', '广东省广州市广州大学城', 0, 1),
(3, 'user1416713496', 'user1416713496', '小李', NULL, 2147483647, '小李分销商单位', NULL, NULL, NULL, '13610063906', '广东省广州市广州大学城', 0, 1),
(4, 'user1416713516', 'user1416713516', '小可', NULL, 2147483647, '小可分销商单位', NULL, NULL, NULL, '13610063906', '广东省广州市广州大学城', 0, 1),
(5, 'user1416713540', 'user1416713540', '小志', NULL, 2147483647, '小志分销商单位', NULL, NULL, NULL, '13610063906', '广东省广州市广州大学城', 0, 1),
(6, 'user1416713571', 'user1416713571', '小林', NULL, 2147483647, '小林分销商单位', NULL, NULL, NULL, '13610063906', '广东省广州市广州大学城', 0, 1);

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
(1, 'admin', 'admin', '王小明', '男', '13610063906', '某某生产公司5', '本厂是专门生产各种玩具的工厂', '广东省广州市广州大学城');

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
  `product_id` char(20) NOT NULL COMMENT '产品ID',
  `spec_id` int(11) NOT NULL COMMENT '产品规格ID',
  `amount` int(11) NOT NULL COMMENT '购买数量',
  `unit_price` int(11) NOT NULL COMMENT '单价',
  `salesman_profit` int(11) NOT NULL COMMENT '销售员利润',
  `factory_profit` int(11) NOT NULL DEFAULT '0',
  `distributor_profit` int(11) NOT NULL,
  `total_price` int(11) NOT NULL COMMENT '总价',
  `address` char(255) NOT NULL COMMENT '送货地址',
  `phone` char(20) NOT NULL COMMENT '送货电话',
  `name` char(20) NOT NULL COMMENT '签收人',
  `status` int(11) NOT NULL COMMENT '订单的状态0：失败、1：未付款、2：已付款、3：货到付款、4：已付款、5、配送中、6：成功',
  `cTime` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=46 ;

--
-- 转存表中的数据 `order_list`
--

INSERT INTO `order_list` (`id`, `order_id`, `custom_id`, `distributor_id`, `salesman_id`, `product_id`, `spec_id`, `amount`, `unit_price`, `salesman_profit`, `factory_profit`, `distributor_profit`, `total_price`, `address`, `phone`, `name`, `status`, `cTime`) VALUES
(23, 1416726085, 3, 1, 1, 'P1416717224', 16, 10, 29, 0, 0, 60, 330, '2', '', '', 2, 1416726085),
(24, 1416726085, 3, 1, 1, 'P1416717130', 13, 10, 29, 0, 0, 60, 290, '2', '', '', 2, 1416726085),
(39, 1416728951, 3, 1, 1, 'P1416717224', 16, 10, 30, 0, 0, 60, 330, '1', '13610063903', '小林', 2, 1416728951),
(40, 1416728951, 3, 1, 1, 'P1416717224', 13, 10, 29, 0, 0, 60, 290, '1', '13610063903', '小林', 2, 1416728951),
(41, 1416728952, 3, 1, 1, 'P1416717224', 16, 10, 31, 0, 100, 60, 200, '广东省广州市广州大学城', '13610063903', '王小芯', 2, 1416729219),
(42, 1416729814, 1, 1, 1, 'P1416717707', 1, 11, 20, 0, 0, 66, 210, '1', '', '', 2, 1416729814),
(44, 1416824170, 1, 1, 1, 'P1416717130', 12, 10, 29, 0, 60, 30, 290, '广东省广州市广州大学城', '13610063907', '郭予雄', 0, 1416824170),
(45, 1416824170, 1, 1, 1, 'P1416717224', 16, 10, 30, 0, 100, 50, 300, '广东省广州市广州大学城', '13610063907', '郭予雄', 0, 1416824170);

-- --------------------------------------------------------

--
-- 表的结构 `product_info`
--

CREATE TABLE IF NOT EXISTS `product_info` (
  `id` char(20) NOT NULL COMMENT '产品ID',
  `name` char(10) NOT NULL COMMENT '产品名称',
  `model` char(10) NOT NULL COMMENT '产品型号',
  `introduction` char(255) NOT NULL COMMENT '产品简介',
  `description` longtext NOT NULL,
  `cost_price` int(11) NOT NULL COMMENT '成本价',
  `distributor_price` int(11) NOT NULL COMMENT '分销价',
  `salesman_price` int(11) NOT NULL COMMENT '零售价',
  `producer` char(10) NOT NULL COMMENT '商品生产商',
  `has_sale` int(11) NOT NULL COMMENT '销量',
  `left` int(11) NOT NULL COMMENT '库存',
  `status` int(11) NOT NULL COMMENT '是否上架',
  `cTime` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `product_info`
--

INSERT INTO `product_info` (`id`, `name`, `model`, `introduction`, `description`, `cost_price`, `distributor_price`, `salesman_price`, `producer`, `has_sale`, `left`, `status`, `cTime`) VALUES
('P1416717130', '海贼王漫画', '漫画', '这个是未终结版的海贼王漫画', '本漫画主要讲述海上的战争', 20, 26, 29, '深圳某漫画分公司', 0, 1000, 1, 0),
('P1416717189', '火影忍者漫画', '漫画', '这个是未终结版的火影忍者漫画', '本漫画主要讲述忍者村的战争', 20, 26, 29, '上海某漫画分公司', 0, 1000, 1, 0),
('P1416717224', '火影漫画', '漫画', '这个是终结版的火影忍者', '本漫画主要讲述忍者村之间的战争', 15, 25, 30, '上海某漫画分公司', 10, 1000, 1, 0),
('P1416717707', '海贼王漫画', '漫画', '这个是未终结版的海贼王', '本漫画主要讲述海上的战争', 15, 25, 30, '上海某漫画分公司', 10, 1000, 1, 1416717707),
('P1416813487', '火影漫画', '漫画', '这个是终结版的火影忍者', '本漫画主要讲述忍者村之间的战争', 15, 25, 30, '上海某漫画分公司', 10, 1000, 0, 1416813487);

-- --------------------------------------------------------

--
-- 表的结构 `salesman_info`
--

CREATE TABLE IF NOT EXISTS `salesman_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `salesman_info`
--

INSERT INTO `salesman_info` (`id`, `username`, `password`, `distributor_id`, `truename`, `sex`, `birth`, `identify`, `bank_card`, `address`, `QQ`, `phone`, `cTime`) VALUES
(1, 'user1', 'user1', 1, '王小蒙', '女', 1416717224, '', 2147483647, '广东省湛江市', 529242358, '13610063907', 1416727224);

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
  `product_id` char(20) NOT NULL COMMENT '商品ID',
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- 转存表中的数据 `spec_image`
--

INSERT INTO `spec_image` (`id`, `product_id`, `spec_1`, `spec_2`, `spec_3`, `image_1`, `image_2`, `image_3`, `image_4`, `image_5`) VALUES
(12, 'P1416717130', '黑色', '10寸', NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL),
(13, 'P1416717130', '蓝色', '10寸', NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL),
(14, 'P1416717189', '黑色', '10寸', NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL),
(15, 'P1416717189', '蓝色', '10寸', NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL),
(16, 'P1416717224', '黑色', '10寸', NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL),
(17, 'P1416717224', '蓝色', '10寸', NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL),
(18, 'P1416717707', '蓝色', '10寸', NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL),
(19, 'P1416717707', '黄色', '10寸', NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL),
(22, 'P1416813487', '蓝色', '10寸', NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL),
(23, 'P1416813487', '黑色', '10寸', NULL, '546771f1b9e2e.png', NULL, NULL, NULL, NULL);

--
-- 限制导出的表
--

--
-- 限制表 `delivery_info`
--
ALTER TABLE `delivery_info`
  ADD CONSTRAINT `delivery_info_ibfk_1` FOREIGN KEY (`custom_id`) REFERENCES `custom_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- 限制表 `distributor_sale`
--
ALTER TABLE `distributor_sale`
  ADD CONSTRAINT `distributor_sale_ibfk_1` FOREIGN KEY (`distributor_id`) REFERENCES `distributor_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
