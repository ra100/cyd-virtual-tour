-- phpMyAdmin SQL Dump
-- version 3.3.9.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 02, 2011 at 05:13 PM
-- Server version: 5.0.77
-- PHP Version: 5.3.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `d4ra100`
--

-- --------------------------------------------------------

--
-- Table structure for table `VB_bag`
--

CREATE TABLE IF NOT EXISTS `VB_bag` (
  `id` bigint(20) NOT NULL auto_increment,
  `uid` bigint(20) NOT NULL COMMENT 'user id',
  `iid` bigint(20) default NULL COMMENT 'idem id',
  `status` tinyint(4) default NULL COMMENT '0 - got it, 1 - found and dropped',
  `time` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `uid` (`uid`),
  KEY `iid` (`iid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `VB_bag`
--


-- --------------------------------------------------------

--
-- Table structure for table `VB_extension`
--

CREATE TABLE IF NOT EXISTS `VB_extension` (
  `id` smallint(6) NOT NULL auto_increment,
  `uname` varchar(16) collate utf8_slovak_ci NOT NULL,
  `type` varchar(16) collate utf8_slovak_ci NOT NULL,
  `titlesk` varchar(128) collate utf8_slovak_ci default NULL,
  `titleen` varchar(128) collate utf8_slovak_ci default NULL,
  `contentsk` text collate utf8_slovak_ci,
  `contenten` text collate utf8_slovak_ci,
  `url` varchar(256) collate utf8_slovak_ci default NULL,
  `note` text collate utf8_slovak_ci,
  `visits` bigint(20) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uname` (`uname`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci AUTO_INCREMENT=78 ;

--
-- Dumping data for table `VB_extension`
--

INSERT INTO `VB_extension` (`id`, `uname`, `type`, `titlesk`, `titleen`, `contentsk`, `contenten`, `url`, `note`, `visits`) VALUES
(1, 'help', 'text', 'Virtuálne Brhlovce - Pomocník', 'Virtual Brhlovce - Help', 'Virtuálne Brhlovce', 'Virtual Brhlovce', '', NULL, 0),
(2, 'pano03ext01', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano03ext01.jpg', NULL, 0),
(3, 'pano03ext02', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano03ext02.jpg', NULL, 0),
(4, 'pano03ext03', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano03ext03.jpg', NULL, 0),
(5, 'pano03ext04', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano03ext04.jpg', NULL, 0),
(6, 'pano03ext05', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano03ext05.jpg', NULL, 0),
(7, 'pano03ext06', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano03ext06.jpg', NULL, 0),
(8, 'pano03ext07', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano03ext07.jpg', NULL, 0),
(9, 'pano03ext08', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano03ext08.jpg', NULL, 0),
(10, 'pano03ext09', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano03ext09.jpg', NULL, 0),
(11, 'pano03ext10', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano03ext10.jpg', NULL, 0),
(12, 'pano03ext11', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano03ext11.jpg', NULL, 0),
(13, 'pano03ext12', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano03ext12.jpg', NULL, 0),
(14, 'pano03ext13', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano03ext13.jpg', NULL, 0),
(15, 'pano04ext01', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano03ext01.jpg', NULL, 0),
(16, 'pano04ext02', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano04ext02.jpg', NULL, 0),
(17, 'pano04ext03', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano04ext03.jpg', NULL, 0),
(18, 'pano04ext04', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano04ext04.jpg', NULL, 0),
(19, 'pano04ext05', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano04ext05.jpg', NULL, 0),
(20, 'pano04ext06', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano04ext06.jpg', NULL, 0),
(21, 'pano04ext07', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano04ext07.jpg', NULL, 0),
(22, 'pano05ext01', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano05ext01.jpg', NULL, 0),
(23, 'pano06ext01', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano06ext01.jpg', NULL, 0),
(24, 'pano06ext02', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano06ext02.jpg', NULL, 0),
(25, 'pano06ext03', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano06ext03.jpg', NULL, 0),
(26, 'pano06ext04', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano06ext04.jpg', NULL, 0),
(27, 'pano06ext05', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano06ext05.jpg', NULL, 0),
(28, 'pano06ext06', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano06ext06.jpg', NULL, 0),
(29, 'pano06ext07', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano06ext07.jpg', NULL, 0),
(30, 'pano06ext08', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano06ext08.jpg', NULL, 0),
(31, 'pano06ext09', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano06ext09.jpg', NULL, 0),
(32, 'pano07ext01', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano07ext01.jpg', NULL, 0),
(33, 'pano07ext02', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano07ext02.jpg', NULL, 0),
(34, 'pano08ext01', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano08ext01.jpg', NULL, 0),
(35, 'pano08ext02', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano08ext02.jpg', NULL, 0),
(36, 'pano08ext03', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano08ext03.jpg', NULL, 0),
(37, 'pano08ext04', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano08ext04.jpg', NULL, 0),
(38, 'pano10ext01', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano10ext01.jpg', NULL, 0),
(39, 'pano10ext02', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano10ext02.jpg', NULL, 0),
(40, 'pano11ext01', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano11ext01.jpg', NULL, 0),
(41, 'pano11ext02', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano11ext02.jpg', NULL, 0),
(42, 'pano11ext03', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano11ext03.jpg', NULL, 0),
(43, 'pano11ext04', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano11ext04.jpg', NULL, 0),
(44, 'pano11ext05', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano11ext05.jpg', NULL, 0),
(45, 'pano11ext06', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano11ext06.jpg', NULL, 0),
(46, 'pano14ext01', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano14ext01.jpg', NULL, 0),
(47, 'pano14ext02', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano14ext02.jpg', NULL, 0),
(48, 'pano14ext03', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano14ext03.jpg', NULL, 0),
(49, 'pano14ext04', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano14ext04.jpg', NULL, 0),
(50, 'pano14ext05', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano14ext05.jpg', NULL, 0),
(51, 'pano14ext06', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano14ext06.jpg', NULL, 0),
(52, 'pano14ext07', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano14ext07.jpg', NULL, 0),
(53, 'pano14ext08', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano14ext08.jpg', NULL, 0),
(54, 'pano14ext09', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano14ext09.jpg', NULL, 0),
(55, 'pano14ext10', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano14ext10.jpg', NULL, 0),
(56, 'pano14ext11', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano14ext11.jpg', NULL, 0),
(57, 'pano14ext12', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano14ext12.jpg', NULL, 0),
(58, 'pano14ext13', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano14ext13.jpg', NULL, 0),
(59, 'pano14ext14', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano14ext14.jpg', NULL, 0),
(60, 'pano15ext01', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano15ext01.jpg', NULL, 0),
(61, 'pano15ext02', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano15ext02.jpg', NULL, 0),
(62, 'pano15ext03', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano15ext03.jpg', NULL, 0),
(63, 'pano15ext04', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano15ext04.jpg', NULL, 0),
(64, 'pano15ext05', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano15ext05.jpg', NULL, 0),
(65, 'pano15ext06', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano15ext06.jpg', NULL, 0),
(66, 'pano15ext07', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano15ext07.jpg', NULL, 0),
(67, 'pano15ext08', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano15ext08.jpg', NULL, 0),
(68, 'pano15ext09', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano15ext09.jpg', NULL, 0),
(69, 'pano15ext10', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano15ext10.jpg', NULL, 0),
(70, 'pano15ext11', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano15ext11.jpg', NULL, 0),
(71, 'pano15ext12', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano15ext12.jpg', NULL, 0),
(72, 'pano15ext13', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano15ext13.jpg', NULL, 0),
(73, 'pano15ext14', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano15ext14.jpg', NULL, 0),
(74, 'pano15ext15', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano15ext15.jpg', NULL, 0),
(75, 'pano15ext16', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano15ext16.jpg', NULL, 0),
(76, 'pano15ext17', 'image', NULL, NULL, NULL, NULL, 'http://brhlovce.ra100.net/sites/brhlovce/misc/data/resources/ext/pano15ext17.jpg', NULL, 0),
(77, 'pano16ext01', 'guestbook', NULL, NULL, NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `VB_extensionpath`
--

CREATE TABLE IF NOT EXISTS `VB_extensionpath` (
  `id` bigint(20) NOT NULL auto_increment,
  `eid` bigint(20) NOT NULL,
  `uid` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `uid` (`uid`),
  KEY `eid` (`eid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `VB_extensionpath`
--


-- --------------------------------------------------------

--
-- Table structure for table `VB_guestbook`
--

CREATE TABLE IF NOT EXISTS `VB_guestbook` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `uid` int(11) default NULL COMMENT 'user id',
  `time` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `name` text,
  `text` text,
  UNIQUE KEY `id` (`id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `VB_guestbook`
--

INSERT INTO `VB_guestbook` (`id`, `uid`, `time`, `name`, `text`) VALUES
(2, 0, '2010-04-15 16:27:46', 'anonymous', 'Bol som tu a prídem zas');

-- --------------------------------------------------------

--
-- Table structure for table `VB_highscores`
--

CREATE TABLE IF NOT EXISTS `VB_highscores` (
  `id` bigint(20) NOT NULL auto_increment,
  `uid` bigint(20) default NULL,
  `name` varchar(32) collate utf8_slovak_ci default NULL,
  `totaltime` int(11) default NULL,
  `extensions` int(11) default NULL,
  `panos` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `VB_highscores`
--


-- --------------------------------------------------------

--
-- Table structure for table `VB_items`
--

CREATE TABLE IF NOT EXISTS `VB_items` (
  `id` bigint(20) NOT NULL auto_increment,
  `tid` bigint(20) default NULL COMMENT 'type ID',
  `eid` int(11) default NULL COMMENT 'position - extension ID',
  PRIMARY KEY  (`id`),
  KEY `eid` (`eid`),
  KEY `tid` (`tid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `VB_items`
--


-- --------------------------------------------------------

--
-- Table structure for table `VB_itemtypes`
--

CREATE TABLE IF NOT EXISTS `VB_itemtypes` (
  `id` smallint(6) NOT NULL auto_increment,
  `namesk` varchar(32) collate utf8_slovak_ci default NULL,
  `nameen` varchar(32) collate utf8_slovak_ci default NULL,
  `textsk` text collate utf8_slovak_ci,
  `texten` text collate utf8_slovak_ci,
  `imageurl` varchar(256) collate utf8_slovak_ci default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `VB_itemtypes`
--


-- --------------------------------------------------------

--
-- Table structure for table `VB_pano`
--

CREATE TABLE IF NOT EXISTS `VB_pano` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `uname` varchar(16) collate utf8_slovak_ci default NULL,
  `visits` bigint(20) NOT NULL default '0',
  `totaltime` bigint(20) NOT NULL default '0' COMMENT 'in seconds',
  `activeusers` int(11) NOT NULL default '0',
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `uname` (`uname`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci AUTO_INCREMENT=17 ;

--
-- Dumping data for table `VB_pano`
--

INSERT INTO `VB_pano` (`id`, `uname`, `visits`, `totaltime`, `activeusers`) VALUES
(1, '01', 0, 0, 0),
(2, '02', 0, 0, 0),
(3, '03', 0, 0, 0),
(4, '04', 0, 0, 0),
(5, '05', 0, 0, 0),
(6, '06', 0, 0, 0),
(7, '07', 0, 0, 0),
(8, '08', 0, 0, 0),
(9, '09', 0, 0, 0),
(10, '10', 0, 0, 0),
(11, '11', 0, 0, 0),
(12, '13', 0, 0, 0),
(13, '14', 0, 0, 0),
(14, '15', 0, 0, 0),
(15, '16', 0, 0, 0),
(16, '17', 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `VB_panopath`
--

CREATE TABLE IF NOT EXISTS `VB_panopath` (
  `id` bigint(20) NOT NULL auto_increment,
  `pid` bigint(20) NOT NULL COMMENT 'pano id',
  `prev` bigint(20) default NULL,
  `next` bigint(20) default NULL,
  `uid` bigint(20) NOT NULL COMMENT 'user id',
  `entered` timestamp NULL default CURRENT_TIMESTAMP,
  `exited` timestamp NULL default NULL,
  `duration` int(11) default NULL COMMENT 'sec',
  PRIMARY KEY  (`id`),
  KEY `next` (`next`),
  KEY `prev` (`prev`),
  KEY `pid` (`pid`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci AUTO_INCREMENT=1 ;

--
-- Dumping data for table `VB_panopath`
--


-- --------------------------------------------------------

--
-- Table structure for table `VB_text`
--

CREATE TABLE IF NOT EXISTS `VB_text` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(128) NOT NULL,
  `title` text NOT NULL,
  `content` text NOT NULL,
  `language` varchar(2) NOT NULL,
  `helper` text NOT NULL,
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `VB_text`
--

INSERT INTO `VB_text` (`id`, `name`, `title`, `content`, `language`, `helper`) VALUES
(1, 'pokus', 'lorem ipsum', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\r\n\r\nCurabitur pretium tincidunt lacus. Nulla gravida orci a odio. Nullam varius, turpis et commodo pharetra, est eros bibendum elit, nec luctus magna felis sollicitudin mauris. Integer in mauris eu nibh euismod gravida. Duis ac tellus et risus vulputate vehicula. Donec lobortis risus a elit. Etiam tempor. Ut ullamcorper, ligula eu tempor congue, eros est euismod turpis, id tincidunt sapien risus a quam. Maecenas fermentum consequat mi. Donec fermentum. Pellentesque malesuada nulla a mi. Duis sapien sem, aliquet nec, commodo eget, consequat quis, neque. Aliquam faucibus, elit ut dictum aliquet, felis nisl adipiscing sapien, sed malesuada diam lacus eget erat. Cras mollis scelerisque nunc. Nullam arcu. Aliquam consequat. Curabitur augue lorem, dapibus quis, laoreet et, pretium ac, nisi. Aenean magna nisl, mollis quis, molestie eu, feugiat in, orci. In hac habitasse platea dictumst.', 'sk', ''),
(2, 'help', 'Virtuálne Brhlovce - Pomocník', 'Virtuálne Brhlovce', 'sk', '');

-- --------------------------------------------------------

--
-- Table structure for table `VB_users`
--

CREATE TABLE IF NOT EXISTS `VB_users` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `token` text collate utf8_slovak_ci NOT NULL,
  `logged` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `lastaction` timestamp NULL default '0000-00-00 00:00:00',
  `position` bigint(20) default NULL,
  `panos` int(11) default NULL,
  `extensions` int(11) default NULL,
  `did` bigint(20) default NULL COMMENT 'drupal user id, pre mozno spojenia s registraciou v drupale',
  PRIMARY KEY  (`id`),
  KEY `position` (`position`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_slovak_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `VB_users`
--


-- --------------------------------------------------------

--
-- Table structure for table `VB_visitors`
--

CREATE TABLE IF NOT EXISTS `VB_visitors` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `date` datetime NOT NULL,
  `duration` int(11) NOT NULL,
  `trace` text,
  `helper` text,
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=164 ;

--
-- Dumping data for table `VB_visitors`
--

INSERT INTO `VB_visitors` (`id`, `date`, `duration`, `trace`, `helper`) VALUES
(7, '2010-04-15 12:24:25', 83, 'pano01', ''),
(8, '2010-04-15 12:24:26', 86, 'pano01', ''),
(3, '2010-04-15 10:22:24', 50, 'pano01', ''),
(4, '2010-04-15 10:30:11', 358, 'pano01-122,pano02-47,pano17', ''),
(5, '2010-04-15 10:52:06', 36, 'pano01', ''),
(6, '2010-04-15 10:55:29', 82, 'pano01-35,pano08-12,pano05', ''),
(9, '2010-04-15 12:33:55', 470, 'pano01', ''),
(10, '2010-04-15 12:44:38', 462, 'pano01', ''),
(11, '2010-04-15 13:11:10', 55, 'pano01-17,pano06-23,pano16', ''),
(12, '2010-04-15 13:53:16', 173, 'pano01-12,pano02-76,pano02-8,pano17-2,pano04-15,pano05-25,pano17', ''),
(13, '2010-04-15 13:56:28', 299, 'pano01', ''),
(14, '2010-04-15 14:06:24', 118, 'pano01-58,pano11', ''),
(15, '2010-04-15 14:44:36', 777, 'pano01-79,pano08-232,pano16-67,pano01-6,pano11-27,pano14', ''),
(16, '2010-04-15 14:48:19', 200, 'pano01', ''),
(17, '2010-04-15 15:08:08', 179, 'pano01-86,pano17', ''),
(18, '2010-04-15 15:43:54', 29, 'pano01', ''),
(19, '2010-04-15 16:22:19', 1843, 'pano01-1666,pano11-35,pano05-29,pano13-26,pano02-17,pano01-16,pano15', ''),
(20, '2010-04-15 16:44:26', 302, 'pano01-76,pano15-17,pano16-27,pano11-152,pano05', ''),
(21, '2010-04-15 18:53:19', 81, 'pano01-56,pano08', ''),
(22, '2010-04-16 15:17:55', 94, 'pano01-24,pano02', ''),
(23, '2010-04-16 15:22:17', 240, 'pano01-46,pano15-156,pano06', ''),
(24, '2010-04-16 20:06:58', 111, 'pano01-17,pano14', ''),
(25, '2010-04-17 00:52:42', 61, 'pano01', ''),
(26, '2010-04-17 17:21:50', 192, 'pano01-77,pano13-1,pano13-89,pano09-1,pano09', ''),
(27, '2010-04-17 17:28:44', 101, 'pano01-59,pano15', ''),
(28, '2010-04-17 17:42:43', 61, 'pano01', ''),
(29, '2010-04-17 17:46:37', 28, 'pano01', ''),
(30, '2010-04-17 18:19:13', 265, 'pano01', ''),
(31, '2010-04-17 19:41:51', 172, 'pano01-116,pano13-31,pano14-1,pano15-1,pano08-1,pano08-4,pano02', ''),
(32, '2010-04-17 19:43:54', 25, 'pano01-9,pano16', ''),
(33, '2010-04-17 19:50:57', 233, 'pano01-5,pano08', ''),
(34, '2010-04-17 20:41:08', 1194, 'pano01', ''),
(35, '2010-04-18 08:07:44', 120, 'pano01', ''),
(36, '2010-04-18 08:14:20', 64, 'pano01', ''),
(37, '2010-04-18 23:37:38', 96, 'pano01-17,pano05-19,pano01-6,pano02-28,pano01-2,pano10', ''),
(38, '2010-04-18 23:39:28', 21, 'pano01-7,pano02', ''),
(39, '2010-04-18 23:40:19', 11, 'pano01', ''),
(40, '2010-04-18 23:42:38', 85, 'pano01', ''),
(41, '2010-04-18 23:50:28', 173, 'pano01-81,pano02-28,pano02-3,pano16', ''),
(42, '2010-04-18 23:51:32', 12, 'pano01', ''),
(43, '2010-04-18 23:53:31', 18, 'pano01', ''),
(44, '2010-04-18 23:54:27', 29, 'pano01', ''),
(45, '2010-04-19 00:00:43', 156, 'pano01-42,pano02-11,pano14', ''),
(46, '2010-04-19 00:01:44', 37, 'pano01', ''),
(47, '2010-04-19 00:04:00', 113, 'pano01-13,pano15-75,pano14', ''),
(48, '2010-04-19 00:05:11', 37, 'pano01', ''),
(49, '2010-04-19 00:05:36', 12, 'pano01', ''),
(50, '2010-04-19 00:12:46', 101, 'pano01-4,pano02-34,pano09-4,pano02-1,pano02-2,pano02-1,pano02-7,pano16-4,pano15-11,pano15-5,pano01-2,pano13-2,pano01-2,pano05-1,pano01-1,pano08-3,pano01', ''),
(51, '2010-04-19 15:00:26', 102, 'pano01', ''),
(52, '2010-04-19 15:07:20', 141, 'pano01-43,pano11', ''),
(53, '2010-04-19 22:00:55', 170, 'pano01', ''),
(54, '2010-04-20 16:45:41', 61, 'pano01', ''),
(55, '2010-04-20 18:16:42', 44, 'pano01-26,pano02', ''),
(56, '2010-04-20 22:55:22', 414, 'pano01-252,pano02', ''),
(57, '2010-04-20 23:30:30', 64, 'pano01', ''),
(58, '2010-04-22 21:52:40', 36, 'pano01-14,pano11', ''),
(59, '2010-04-22 21:56:14', 13, 'pano01', ''),
(60, '2010-04-22 21:59:12', 15, 'pano01', ''),
(61, '2010-04-22 22:00:25', 30, 'pano01', ''),
(62, '2010-04-22 22:27:30', 29, 'pano01', ''),
(63, '2010-04-22 22:47:26', 21, 'pano01', ''),
(64, '2010-04-22 22:57:10', 16, 'pano01', ''),
(65, '2010-04-22 22:58:15', 22, 'pano01', ''),
(66, '2010-04-22 23:10:38', 154, 'pano01', ''),
(67, '2010-04-22 23:11:26', 30, 'pano01', ''),
(68, '2010-04-23 09:38:28', 2697, 'pano01-2649,pano02', ''),
(69, '2010-08-26 00:54:19', 192, 'pano01-64,pano05-6,pano11-8,pano14-7,pano16-43,pano15-6,pano14', ''),
(70, '2010-10-12 19:30:39', 87, 'pano01-25,pano02-3,pano16', ''),
(71, '2010-10-14 17:09:17', 132, 'pano01-96,pano14', ''),
(72, '2010-11-19 12:13:12', 484, 'pano01-282,pano11-65,pano16', ''),
(73, '2010-11-21 20:41:16', 162, 'pano01-34,pano04-47,pano17', ''),
(74, '2010-12-04 22:47:39', 79, 'pano01', ''),
(75, '2011-01-28 14:19:38', 344, 'pano01-225,pano11-3,pano05-10,pano07-2,pano09-2,pano16-7,pano07-1,pano04-28,pano07-3,pano10-4,pano06-23,pano07-2,pano14', ''),
(76, '2011-01-28 14:25:58', 17, 'pano01', ''),
(77, '2011-01-29 19:59:57', 35, 'pano01', ''),
(78, '2011-01-29 20:44:15', 60, 'pano01', ''),
(79, '2011-01-29 20:44:59', 23, 'pano01', ''),
(80, '2011-01-29 20:46:17', 19, 'pano01', ''),
(81, '2011-01-29 20:47:33', 41, 'pano01', ''),
(82, '2011-01-29 20:49:26', 72, 'pano01', ''),
(83, '2011-01-29 20:53:52', 15, 'pano01', ''),
(84, '2011-01-29 20:54:48', 26, 'pano01', ''),
(85, '2011-01-29 20:55:41', 18, 'pano01', ''),
(86, '2011-01-29 20:56:21', 10, 'pano01', ''),
(87, '2011-01-29 20:57:55', 24, 'pano01', ''),
(88, '2011-01-29 21:00:43', 18, 'pano01', ''),
(89, '2011-01-29 21:03:40', 17, 'pano01', ''),
(90, '2011-01-29 22:22:42', 21, 'pano01', ''),
(91, '2011-01-30 00:05:43', 230, 'pano01-46,pano15-150,pano14', ''),
(92, '2011-01-30 00:11:32', 310, 'pano01-6,pano11-24,pano01-3,pano15-108,pano14-6,pano01-2,pano16-5,pano02-5,pano09-5,pano10-17,pano06-17,pano10-3,pano07-16,pano02-10,pano09-4,pano10-11,pano09-4,pano07-10,pano09-2,pano13-2,pano09-18,pano05-5,pano09-3,pano11-5,pano05', ''),
(93, '2011-01-30 00:32:03', 39, 'pano01-7,pano14', ''),
(94, '2011-01-30 00:33:44', 42, 'pano01-9,pano14', ''),
(95, '2011-01-30 00:34:32', 28, 'pano01-9,pano14', ''),
(96, '2011-01-30 00:43:44', 65, 'pano01-6,pano14-32,pano16', ''),
(97, '2011-01-30 00:44:17', 15, 'pano01', ''),
(98, '2011-01-30 00:45:43', 45, 'pano01', ''),
(99, '2011-01-30 00:47:50', 43, 'pano01', ''),
(100, '2011-01-30 01:42:21', 52, 'pano01', ''),
(101, '2011-01-30 01:44:17', 33, 'pano01', ''),
(102, '2011-01-30 02:12:35', 92, 'pano01-20,pano14', ''),
(103, '2011-01-30 02:25:35', 26, 'pano01', ''),
(104, '2011-01-30 02:32:47', 31, 'pano01-8,pano14', ''),
(105, '2011-01-30 12:47:03', 78, 'pano01-45,pano14', ''),
(106, '2011-01-30 13:06:00', 89, 'pano01-44,pano14', ''),
(107, '2011-01-30 13:18:19', 34, 'pano01', ''),
(108, '2011-01-30 13:20:29', 35, 'pano01-5,pano14', ''),
(109, '2011-01-30 13:24:44', 171, 'pano01-16,pano14', ''),
(110, '2011-01-30 13:26:27', 39, 'pano01-6,pano14', ''),
(111, '2011-01-30 13:30:25', 140, 'pano01-13,pano14', ''),
(112, '2011-01-30 13:31:41', 40, 'pano01-12,pano14', ''),
(113, '2011-01-30 13:32:48', 27, 'pano01-4,pano14', ''),
(114, '2011-01-30 13:44:41', 34, 'pano01-5,pano14', ''),
(115, '2011-01-30 13:49:06', 156, 'pano01-5,pano14', ''),
(116, '2011-01-30 13:54:46', 26, 'pano01-11,pano14', ''),
(117, '2011-01-30 14:01:35', 214, 'pano01-14,pano15', ''),
(118, '2011-01-30 14:08:08', 15, 'pano01', ''),
(119, '2011-01-30 14:49:32', 13, 'pano01', ''),
(120, '2011-01-30 21:19:36', 100, 'pano01-11,pano14', ''),
(121, '2011-01-30 21:21:19', 80, 'pano01-15,pano14', ''),
(122, '2011-01-30 21:24:38', 95, 'pano01-18,pano14', ''),
(123, '2011-01-30 21:31:05', 295, 'pano01-30,pano14', ''),
(124, '2011-01-30 21:37:48', 144, 'pano01-24,pano14', ''),
(125, '2011-01-30 21:47:41', 197, 'pano01-18,pano14', ''),
(126, '2011-01-30 22:00:10', 90, 'pano01-12,pano14', ''),
(127, '2011-01-30 22:11:03', 111, 'pano01', ''),
(128, '2011-01-30 22:12:40', 81, 'pano01-12,pano14', ''),
(129, '2011-01-30 22:13:53', 56, 'pano01-14,pano14', ''),
(130, '2011-01-30 22:22:34', 93, 'pano01-65,pano14', ''),
(131, '2011-01-30 22:25:07', 80, 'pano01', ''),
(132, '2011-01-30 22:27:29', 124, 'pano01-8,pano14', ''),
(133, '2011-01-30 22:30:00', 61, 'pano01-10,pano14', ''),
(134, '2011-01-30 22:34:14', 38, 'pano01-7,pano14', ''),
(135, '2011-01-30 22:36:36', 120, 'pano01-31,pano14', ''),
(136, '2011-01-30 22:38:02', 67, 'pano01-9,pano14', ''),
(137, '2011-01-30 22:40:57', 116, 'pano01-15,pano14', ''),
(138, '2011-01-30 22:49:04', 287, 'pano01-70,pano14', ''),
(139, '2011-01-30 22:52:41', 164, 'pano01-12,pano14', ''),
(140, '2011-01-30 22:59:25', 106, 'pano01-9,pano14', ''),
(141, '2011-01-30 23:17:17', 79, 'pano01-37,pano07', ''),
(142, '2011-01-31 14:59:24', 216, 'pano01', ''),
(143, '2011-01-31 15:01:47', 133, 'pano01-71,pano09-30,pano02-2,pano16-9,pano14', ''),
(144, '2011-01-31 15:17:03', 16, 'pano01', ''),
(145, '2011-01-31 15:18:16', 20, 'pano01', ''),
(146, '2011-01-31 15:45:44', 17, 'pano01', ''),
(147, '2011-01-31 15:52:22', 11, 'pano01', ''),
(148, '2011-01-31 16:40:07', 441, 'pano01-8,pano02-408,pano04-9,pano09-2,pano16', ''),
(149, '2011-01-31 16:48:52', 245, 'pano01-3,pano02-2,pano09-3,pano07', ''),
(150, '2011-01-31 16:50:56', 108, 'pano01', ''),
(151, '2011-01-31 16:51:56', 32, 'pano01-14,pano09-5,pano07', ''),
(152, '2011-01-31 16:53:35', 39, 'pano01-9,pano02-3,pano17-4,pano03-6,pano07-3,pano09', ''),
(153, '2011-01-31 16:56:10', 82, 'pano01-14,pano02-4,pano09-5,pano05-22,pano09', ''),
(154, '2011-01-31 16:59:28', 28, 'pano01-9,pano02', ''),
(155, '2011-01-31 17:09:16', 467, 'pano01-11,pano09-4,pano07-3,pano03-9,pano07', ''),
(156, '2011-01-31 17:23:04', 168, 'pano01', ''),
(157, '2011-01-31 17:24:49', 25, 'pano01-10,pano11', ''),
(158, '2011-01-31 18:18:45', 55, 'pano01', ''),
(159, '2011-01-31 18:37:42', 24, 'pano01', ''),
(160, '2011-01-31 18:39:06', 46, 'pano01-30,pano11-8,pano16', ''),
(161, '2011-01-31 19:17:30', 88, 'pano01-12,pano11-6,pano05-11,pano08', ''),
(162, '2011-01-31 19:58:34', 12, 'pano01', ''),
(163, '2011-01-31 19:59:43', 44, 'pano01', '');
