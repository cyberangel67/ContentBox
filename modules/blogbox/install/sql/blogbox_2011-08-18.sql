﻿# ************************************************************
# Sequel Pro SQL dump
# Version 3348
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: Localhost (MySQL 5.1.48)
# Database: blogbox
# Generation Time: 2011-08-18 18:55:03 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table bb_author
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bb_author`;

CREATE TABLE `bb_author` (
  `authorID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'0',
  `lastLogin` datetime DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`authorID`),
  KEY `idx_active` (`isActive`),
  KEY `idx_email` (`email`),
  KEY `idx_login` (`username`,`password`,`isActive`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

LOCK TABLES `bb_author` WRITE;
/*!40000 ALTER TABLE `bb_author` DISABLE KEYS */;

INSERT INTO `bb_author` (`authorID`, `firstName`, `lastName`, `email`, `username`, `password`, `isActive`, `lastLogin`, `createdDate`)
VALUES
	(1,'Luis','Majano','lmajano@gmail.com','lmajano','EE60C08DE56FCDAC31D7A0D8F2C8ED1D550A3670DCF577F43F0A44AB7523ECE6',b'1','2011-08-18 10:53:40','2011-07-08 00:00:00'),
	(7,'BlogBox','Administrator','youremail@email.com','blogbox','4C8FAE24422D4D3BD85CE10EB3366B4CEB48E370CB7C03BBE5A684234C0E8ABA',b'1',NULL,'2011-07-30 10:48:37');

/*!40000 ALTER TABLE `bb_author` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table bb_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bb_category`;

CREATE TABLE `bb_category` (
  `categoryID` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  PRIMARY KEY (`categoryID`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

LOCK TABLES `bb_category` WRITE;
/*!40000 ALTER TABLE `bb_category` DISABLE KEYS */;

INSERT INTO `bb_category` (`categoryID`, `category`, `slug`)
VALUES
	(1,'General','general'),
	(2,'Adobe Air','adobe-air'),
	(6,'Software Engineering','software-engineering'),
	(7,'ColdFusion','coldfusion'),
	(9,'ColdBox','coldbox'),
	(10,'Flex','flex');

/*!40000 ALTER TABLE `bb_category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table bb_comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bb_comment`;

CREATE TABLE `bb_comment` (
  `commentID` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext NOT NULL,
  `author` varchar(100) NOT NULL,
  `authorIP` varchar(100) NOT NULL,
  `authorEmail` varchar(255) NOT NULL,
  `authorURL` varchar(255) DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `isApproved` bit(1) NOT NULL DEFAULT b'0',
  `FK_entryID` int(11) DEFAULT NULL,
  `FK_pageID` int(11) DEFAULT NULL,
  PRIMARY KEY (`commentID`),
  KEY `idx_pageComment` (`isApproved`,`FK_pageID`),
  KEY `idx_approved` (`isApproved`),
  KEY `idx_entryComment` (`isApproved`,`FK_entryID`),
  KEY `idx_createdDate` (`createdDate`),
  KEY `FKB856160913DC393` (`FK_pageID`),
  KEY `FKB85616066ED93A5` (`FK_entryID`),
  CONSTRAINT `FKB85616066ED93A5` FOREIGN KEY (`FK_entryID`) REFERENCES `bb_entry` (`entryID`),
  CONSTRAINT `FKB856160913DC393` FOREIGN KEY (`FK_pageID`) REFERENCES `bb_page` (`pageID`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

LOCK TABLES `bb_comment` WRITE;
/*!40000 ALTER TABLE `bb_comment` DISABLE KEYS */;

INSERT INTO `bb_comment` (`commentID`, `content`, `author`, `authorIP`, `authorEmail`, `authorURL`, `createdDate`, `isApproved`, `FK_entryID`, `FK_pageID`)
VALUES
	(22,'WOW! I really need to use this in all my sites now!','Luis Majano','127.0.0.1','blogbox@ortussolutions.com','www.ortussolutions.com','2011-07-30 10:10:32',b'1',5,NULL),
	(23,'ColdBox has changed my life, I really recommend it.','Luis Majano','127.0.0.1','lmajano@gmail.com','www.luismajano.com','2011-07-30 10:11:22',b'0',5,NULL);

/*!40000 ALTER TABLE `bb_comment` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table bb_customhtml
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bb_customhtml`;

CREATE TABLE `bb_customhtml` (
  `contentID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `description` longtext,
  `content` longtext NOT NULL,
  `createdDate` datetime NOT NULL,
  PRIMARY KEY (`contentID`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bb_entry
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bb_entry`;

CREATE TABLE `bb_entry` (
  `entryID` int(11) NOT NULL AUTO_INCREMENT,
  `hits` bigint(20) DEFAULT '0',
  `HTMLKeywords` varchar(160) DEFAULT NULL,
  `publishedDate` datetime DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `excerpt` longtext,
  `slug` varchar(200) NOT NULL,
  `passwordProtection` varchar(100) DEFAULT NULL,
  `allowComments` bit(1) NOT NULL DEFAULT b'1',
  `content` longtext NOT NULL,
  `HTMLDescription` varchar(160) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `isPublished` bit(1) NOT NULL DEFAULT b'1',
  `FK_authorID` int(11) DEFAULT NULL,
  PRIMARY KEY (`entryID`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_slug` (`slug`),
  KEY `idx_published` (`isPublished`),
  KEY `idx_publishedSlug` (`slug`,`isPublished`),
  KEY `idx_createdDate` (`createdDate`),
  KEY `idx_search` (`title`,`isPublished`),
  KEY `FKAC3547B34289940B` (`FK_authorID`),
  CONSTRAINT `FKAC3547B34289940B` FOREIGN KEY (`FK_authorID`) REFERENCES `bb_author` (`authorID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

LOCK TABLES `bb_entry` WRITE;
/*!40000 ALTER TABLE `bb_entry` DISABLE KEYS */;

INSERT INTO `bb_entry` (`entryID`, `hits`, `HTMLKeywords`, `publishedDate`, `createdDate`, `excerpt`, `slug`, `passwordProtection`, `allowComments`, `content`, `HTMLDescription`, `title`, `isPublished`, `FK_authorID`)
VALUES
	(5,391,'','2011-07-17 00:00:00','2011-07-17 17:40:22','','what-is-coldbox','',b'1','<p>\r\n	ColdBox is an event-driven, convention, based ColdFusion Development Platform. It provides a set of reusable code and tools that can be used to increase your development productivity, as well as a development standard for working in team environments. ColdBox is comprehensive and modular, which helps address most infrastructure concerns of typical ColdFusion applications. It also goes places that other frameworks do not.</p>\r\n<div align=\"center\">\r\n	<p style=\"padding-top: 5px; padding-right: 0px; padding-bottom: 5px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(68, 68, 68); line-height: 1.8em; \">\r\n		<a href=\"http://wiki.coldbox.org/imagelibrary/ColdBoxPlatform.jpg\" style=\"color: rgb(0, 88, 175); background-color: inherit; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; \"><img src=\"http://wiki.coldbox.org/imagelibrary/ColdBoxPlatform.jpg\" style=\"vertical-align: middle; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: outset; border-right-style: outset; border-bottom-style: outset; border-left-style: outset; border-top-color: rgb(234, 234, 234); border-right-color: rgb(234, 234, 234); border-bottom-color: rgb(234, 234, 234); border-left-color: rgb(234, 234, 234); \" width=\"550\" /></a></p>\r\n</div>\r\n<p style=\"padding-top: 5px; padding-right: 0px; padding-bottom: 5px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(68, 68, 68); line-height: 1.8em; \">\r\n	In this guide you will have an overview of the main components of this Object Oriented Framework. Below are some good resources for you to read about design patterns and some object orientation goodness. Having some basic object oriented knowledge will help you tremendously during your initial stages of ColdBox development. However, if you are not an OO guru, no worries, the guides contained in this wiki will help you and take you to several learning paths of object orientation and software development. This is just an introductory guide, so you might encounter new terminology or features of the framework that you might have no clue about. I urge you to continue reading the guides in order to find a cohesive outlook of what is ColdBox</p>\r\n<ul style=\"list-style-type: square; padding-top: 0px; padding-right: 20px; padding-bottom: 0px; padding-left: 20px; \">\r\n	<li style=\"padding-top: 3px; padding-right: 5px; padding-bottom: 3px; padding-left: 5px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; \">\r\n		<a class=\"externallink\" href=\"http://java.sun.com/blueprints/corej2eepatterns/Patterns/index.html\" rel=\"nofollow\" style=\"color: rgb(0, 88, 175); background-color: transparent; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; background-image: url(http://wiki.coldbox.org/includes/images/external.png); background-attachment: scroll; background-origin: initial; background-clip: initial; padding-left: 13px; background-position: 0% 50%; background-repeat: no-repeat no-repeat; \">Sun&#39;s Core J2EE Patterns Catalog</a></li>\r\n	<li style=\"padding-top: 3px; padding-right: 5px; padding-bottom: 3px; padding-left: 5px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; \">\r\n		<a class=\"externallink\" href=\"http://martinfowler.com/eaaCatalog/\" rel=\"nofollow\" style=\"color: rgb(0, 88, 175); background-color: transparent; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; background-image: url(http://wiki.coldbox.org/includes/images/external.png); background-attachment: scroll; background-origin: initial; background-clip: initial; padding-left: 13px; background-position: 0% 50%; background-repeat: no-repeat no-repeat; \">Catalog Of Patterns of Enterprise Application Architecture</a></li>\r\n	<li style=\"padding-top: 3px; padding-right: 5px; padding-bottom: 3px; padding-left: 5px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; \">\r\n		<a href=\"http://wiki.coldbox.org/wiki/MVC.cfm\" style=\"color: rgb(0, 88, 175); background-color: inherit; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; \">What is MVC</a></li>\r\n	<li style=\"padding-top: 3px; padding-right: 5px; padding-bottom: 3px; padding-left: 5px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; \">\r\n		<a class=\"externallink\" href=\"http://www.adobe.com/devnet/coldfusion/articles/intro_cfcs.html\" rel=\"nofollow\" style=\"color: rgb(0, 88, 175); background-color: transparent; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; background-image: url(http://wiki.coldbox.org/includes/images/external.png); background-attachment: scroll; background-origin: initial; background-clip: initial; padding-left: 13px; background-position: 0% 50%; background-repeat: no-repeat no-repeat; \">What are CFC&#39;s by Ben Forta</a></li>\r\n	<li style=\"padding-top: 3px; padding-right: 5px; padding-bottom: 3px; padding-left: 5px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; \">\r\n		<a class=\"externallink\" href=\"http://www.oreillynet.com/pub/a/javascript/2003/09/24/coldfusion_tips.html\" rel=\"nofollow\" style=\"color: rgb(0, 88, 175); background-color: transparent; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; background-image: url(http://wiki.coldbox.org/includes/images/external.png); background-attachment: scroll; background-origin: initial; background-clip: initial; padding-left: 13px; background-position: 0% 50%; background-repeat: no-repeat no-repeat; \">ColdFusion CFC Tips</a></li>\r\n</ul>\r\n<p>\r\n	<a id=\"What_are_some_of_ColdBox\'s_Novel_Features\" name=\"What_are_some_of_ColdBox\'s_Novel_Features\" style=\"color: rgb(0, 88, 175); background-color: inherit; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; \"></a></p>\r\n<h2 style=\"font-weight: bold; color: rgb(51, 51, 51); padding-top: 10px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-size: 20px; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: rgb(170, 170, 170); \">\r\n	What are some of ColdBox&#39;s Novel Features</h2>\r\n<p style=\"padding-top: 5px; padding-right: 0px; padding-bottom: 5px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(68, 68, 68); line-height: 1.8em; \">\r\n	Let&#39;s discuss some high level overviews of what ColdBox can bring to the application development table:</p>\r\n<p>\r\n	<a id=\"Documentation\" name=\"Documentation\" style=\"color: rgb(0, 88, 175); background-color: inherit; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; \"></a></p>\r\n<h3 style=\"font-weight: bold; color: rgb(0, 51, 102); padding-top: 10px; padding-right: 0px; padding-bottom: 10px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-size: 16px; \">\r\n	Documentation</h3>\r\n<p style=\"padding-top: 5px; padding-right: 0px; padding-bottom: 5px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(68, 68, 68); line-height: 1.8em; \">\r\n	We are firm believers in developer education. We have over 30 step by step guides and over 550 pages worth of documentation right in this wiki. We believe that by empowering the user with knowledge, the adaptation rate will increase and the ability of the developer to find what they need will make their productivity increase.</p>\r\n<p>\r\n	<a id=\"Conventions_Over_Configurations\" name=\"Conventions_Over_Configurations\" style=\"color: rgb(0, 88, 175); background-color: inherit; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; \"></a></p>\r\n<h3 style=\"font-weight: bold; color: rgb(0, 51, 102); padding-top: 10px; padding-right: 0px; padding-bottom: 10px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-size: 16px; \">\r\n	Conventions Over Configurations</h3>\r\n<p style=\"padding-top: 5px; padding-right: 0px; padding-bottom: 5px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(68, 68, 68); line-height: 1.8em; \">\r\n	Conventions over configurations is our motto. We get rid of verbosity of xml logic and use ColdFusion and a set of conventions for our applications. With ColdBox you can even define your own application layouts and conventions. This gives great flexibility to developers who are used to their own application layouts and conventions. Conventions are also used for registering events, interceptors, plugins and much more. The use of conventions over configurations is what makes ColdBox unique.</p>\r\n<p>\r\n	<a id=\"Coldfusion_Controllers_instead_of_XML_Controllers\" name=\"Coldfusion_Controllers_instead_of_XML_Controllers\" style=\"color: rgb(0, 88, 175); background-color: inherit; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; \"></a></p>\r\n<h3 style=\"font-weight: bold; color: rgb(0, 51, 102); padding-top: 10px; padding-right: 0px; padding-bottom: 10px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-size: 16px; \">\r\n	Coldfusion Controllers instead of XML Controllers</h3>\r\n<p style=\"padding-top: 5px; padding-right: 0px; padding-bottom: 5px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(68, 68, 68); line-height: 1.8em; \">\r\n	ColdBox doesn&#39;t rely on XML declarative logic where you have to define an event, what it does and where does it go. ColdBox is a conventions based framework that will let you program in ColdFusion to get things done. You basically expose methods on event handler CFC&#39;s (Controller Layer) by turning their access to public or remote. The framework then will auto-register the handler CFC&#39;s and now you are able to use the methods as ColdBox Events. So instead of working with a long and complex configuration file all the time, you are mostly working with ColdFusion code all the time, ColdBox is just an&nbsp;<a class=\"externallink\" href=\"http://en.wikipedia.org/wiki/Application_programming_interface\" rel=\"nofollow\" style=\"color: rgb(0, 88, 175); background-color: transparent; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; background-image: url(http://wiki.coldbox.org/includes/images/external.png); background-attachment: scroll; background-origin: initial; background-clip: initial; padding-left: 13px; background-position: 0% 50%; background-repeat: no-repeat no-repeat; \">API</a>.</p>\r\n<p>\r\n	<a id=\"Modular_Architecture\" name=\"Modular_Architecture\" style=\"color: rgb(0, 88, 175); background-color: inherit; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; \"></a></p>\r\n<h3 style=\"font-weight: bold; color: rgb(0, 51, 102); padding-top: 10px; padding-right: 0px; padding-bottom: 10px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-size: 16px; \">\r\n	Modular Architecture</h3>\r\n<p style=\"padding-top: 5px; padding-right: 0px; padding-bottom: 5px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(68, 68, 68); line-height: 1.8em; \">\r\n	ColdBox is built on the concepts of modular architecture and sports a wide array of best practices, tools and services to help you build applications using modules instead of a big monolithic application. Even the framework itself assembles its internal modules once your application loads up and only uses what you tell it to use. ColdBox can be as simple as just core MVC or complex enough to power mission critical enterprise applications.</p>\r\n<p>\r\n	<a id=\"RESTFul_Services\" name=\"RESTFul_Services\" style=\"color: rgb(0, 88, 175); background-color: inherit; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; \"></a></p>\r\n<h3 style=\"font-weight: bold; color: rgb(0, 51, 102); padding-top: 10px; padding-right: 0px; padding-bottom: 10px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-size: 16px; \">\r\n	RESTFul Services</h3>\r\n<p style=\"padding-top: 5px; padding-right: 0px; padding-bottom: 5px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(68, 68, 68); line-height: 1.8em; \">\r\n	We encourage you to build applications that can be organized around resources and standard HTTP verbs, especially for exposing services to multi-faceted applications. We have incredible URL mapping and RESTful support that will help you build not only MVC applications but also power any mobile application.</p>\r\n<p>\r\n	<a id=\"Aspect_programming\" name=\"Aspect_programming\" style=\"color: rgb(0, 88, 175); background-color: inherit; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; \"></a></p>\r\n<h3 style=\"font-weight: bold; color: rgb(0, 51, 102); padding-top: 10px; padding-right: 0px; padding-bottom: 10px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-size: 16px; \">\r\n	Aspect programming</h3>\r\n<p style=\"padding-top: 5px; padding-right: 0px; padding-bottom: 5px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(68, 68, 68); line-height: 1.8em; \">\r\n	ColdBox comes bundled with an extensive set of plugins and interceptors that will help you on every day software application tasks like notifications, AOP file logging with auto-archiving, per-environment settings, storage facilities for cluster environments, object caching, datasource declarations, web services integrations, i18n, dependency injection, application security, and so much more. ColdBox is not only an MVC framework but a development platform.</p>\r\n<p>\r\n	<a id=\"Unit_Testing\" name=\"Unit_Testing\" style=\"color: rgb(0, 88, 175); background-color: inherit; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; \"></a></p>\r\n<h3 style=\"font-weight: bold; color: rgb(0, 51, 102); padding-top: 10px; padding-right: 0px; padding-bottom: 10px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-size: 16px; \">\r\n	Unit Testing</h3>\r\n<p style=\"padding-top: 5px; padding-right: 0px; padding-bottom: 5px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(68, 68, 68); line-height: 1.8em; \">\r\n	ColdBox is a framework based on objects and Unit Testing is an integral part of development, then why shouldn&#39;t you be able to unit test your application in its entirety? We are tightly integrated with&nbsp;<a class=\"externallink\" href=\"http://mxunit.org/\" rel=\"nofollow\" style=\"color: rgb(0, 88, 175); background-color: transparent; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; background-image: url(http://wiki.coldbox.org/includes/images/external.png); background-attachment: scroll; background-origin: initial; background-clip: initial; padding-left: 13px; background-position: 0% 50%; background-repeat: no-repeat no-repeat; \">MXUnit</a>&nbsp;to deliver different types of testing so you can test all development layers. Integration testing is core to ColdBox and you can test your entire application (top-down) without the need of a browser, from testing incoming form/url variables to even browser headers and relocations.</p>\r\n<p>\r\n	<a id=\"ColdBox_Proxy:_Flex/Air/Remote_Integration\" name=\"ColdBox_Proxy:_Flex/Air/Remote_Integration\" style=\"color: rgb(0, 88, 175); background-color: inherit; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; \"></a></p>\r\n<h3 style=\"font-weight: bold; color: rgb(0, 51, 102); padding-top: 10px; padding-right: 0px; padding-bottom: 10px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; font-size: 16px; \">\r\n	ColdBox Proxy: Flex/Air/Remote Integration</h3>\r\n<div align=\"center\">\r\n	<p style=\"padding-top: 5px; padding-right: 0px; padding-bottom: 5px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(68, 68, 68); line-height: 1.8em; \">\r\n		<a href=\"http://wiki.coldbox.org/imagelibrary/coldboxproxy_overview.png\" style=\"color: rgb(0, 88, 175); background-color: inherit; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; \"><img src=\"http://wiki.coldbox.org/imagelibrary/coldboxproxy_overview.png\" style=\"vertical-align: middle; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: outset; border-right-style: outset; border-bottom-style: outset; border-left-style: outset; border-top-color: rgb(234, 234, 234); border-right-color: rgb(234, 234, 234); border-bottom-color: rgb(234, 234, 234); border-left-color: rgb(234, 234, 234); \" width=\"550\" /></a></p>\r\n</div>\r\n<p style=\"padding-top: 5px; padding-right: 0px; padding-bottom: 5px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(68, 68, 68); line-height: 1.8em; \">\r\n	The ColdBox proxy enables remote applications like Flex, AIR, WSDL web services to communicate with ColdBox and provide an event model for your applications. You can create a Service Layer with built-in environmental settings, logging, error handling, event interception and chaining, you name it, and the possibilities are endless. This integration will provide you with the capability to create any amount of front ends using the same reusable ColdBox and model code.</p>\r\n','','What is ColdBox?',b'1',1),
	(7,7,'','2011-07-19 00:00:00','2011-07-19 12:41:49','<p>\r\n	&nbsp;</p>\r\n<p style=\"margin-top: 0px; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; outline-width: 0px; outline-style: initial; outline-color: initial; font-size: 13px; vertical-align: baseline; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: transparent; display: inline !important; \">\r\n	<b>Odio, ac sagittis ac egestas porta sagittis in sagittis ac ultrices sit cras tortor habitasse enim amet. Etiam tempor. Dictumst enim etiam enim. Facilisis risus? Nunc tempor mattis! Turpis? Ultricies dis, augue eros porta parturient pid sit facilisis dolor nunc natoque aenean porta elementum sed? A aenean arcu ac arcu sit nunc est proin sit arcu in! Placerat odio. Et eu non dictumst eu dolor sed pellentesque nec! Enim eros urna, augue diam, integer turpis elementum proin! Risus nec! Mauris vut in etiam phasellus pellentesque ut et? Platea eu natoque elit tortor sit placerat enim, turpis augue sociis, elementum, massa dapibus duis duis, nunc aliquam lorem habitasse! Aliquet mauris cras? In habitasse vut. Porta, ultricies proin? Est integer, elementum.</b></p>\r\n','this-is-my-very-first-entry-dudes','',b'1','<p>\r\n	&nbsp;</p>\r\n<p style=\"margin-top: 0px; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; outline-width: 0px; outline-style: initial; outline-color: initial; font-size: 13px; vertical-align: baseline; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: transparent; background-position: initial initial; background-repeat: initial initial; \">\r\n	Turpis vut magnis dapibus ac, sed? Augue, scelerisque lundium enim diam enim tincidunt, in ut hac porta urna! Duis. Porta dapibus mattis etiam aenean, mid arcu adipiscing! Sit? Lacus ridiculus elementum a! Integer magnis nascetur, in! Tempor eu et arcu? Eu nascetur, mauris rhoncus enim pid nec integer a habitasse! Platea aenean, tempor, arcu, amet ac nec, a turpis aliquet dapibus et ut nisi lectus scelerisque. Ac tristique montes odio tristique penatibus, magna platea nunc. Tempor massa, dis? Augue rhoncus etiam purus lundium tincidunt tincidunt porta scelerisque dapibus mid etiam, placerat placerat. Natoque nisi a porttitor. Magna massa porttitor augue ultrices tristique integer natoque, arcu, vel auctor amet augue, pulvinar, rhoncus dis, porttitor turpis. Placerat enim arcu, magnis porta, risus.</p>\r\n<p style=\"margin-top: 0px; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; outline-width: 0px; outline-style: initial; outline-color: initial; font-size: 13px; vertical-align: baseline; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: transparent; background-position: initial initial; background-repeat: initial initial; \">\r\n	Non amet ac nascetur, nascetur ultricies urna, elementum adipiscing pellentesque porttitor? Ut nisi aliquet. In! Amet aliquet augue odio, ut amet, proin tortor! Cum dictumst augue pid magna. Dictumst tristique amet sit habitasse ultrices, tincidunt, turpis dis sociis! Mid porta. Magna. Turpis hac aliquam turpis ridiculus amet ac porta magnis nec, odio ac, porttitor pid elit elementum nisi platea tristique ut mid odio, et tempor dolor rhoncus sit vel porta urna, sociis purus nisi massa dignissim aliquam. Aenean auctor? Mid et, pid facilisis sed ridiculus ac pellentesque vel pid! Tincidunt, tristique diam ac tristique eros, tincidunt urna pellentesque. Ridiculus diam nec, sit eros? Lacus. Et pid a tristique penatibus et odio a dapibus! Tristique sed duis ut non purus.</p>\r\n<p style=\"margin-top: 0px; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; outline-width: 0px; outline-style: initial; outline-color: initial; font-size: 13px; vertical-align: baseline; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: transparent; background-position: initial initial; background-repeat: initial initial; \">\r\n	Nec et sit. Porttitor! Et? In risus quis ultricies augue dapibus? A? A nisi! Porta platea mid et, aliquam tincidunt in aliquet sed, rhoncus dolor, aenean purus tristique sed, integer scelerisque proin sociis nunc, lundium? Mid lectus rhoncus vel, rhoncus porttitor, urna sed turpis, elit, ut tincidunt, sed in elementum turpis turpis tortor? Purus, aliquet pid lorem tincidunt enim purus lundium enim lundium. Et elementum? Magna montes? Rhoncus turpis! Montes duis urna quis sed? Tortor a in dictumst cum mid, turpis a sed platea vel et tristique, augue nec, habitasse platea sociis aenean porta nec lectus purus, cursus placerat parturient! Tempor! Pid elementum placerat, lorem lundium, elementum hac proin et tincidunt. Porta mus eu dignissim et, nisi nascetur diam.</p>\r\n<p style=\"margin-top: 0px; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; outline-width: 0px; outline-style: initial; outline-color: initial; font-size: 13px; vertical-align: baseline; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: transparent; background-position: initial initial; background-repeat: initial initial; \">\r\n	Odio, ac sagittis ac egestas porta sagittis in sagittis ac ultrices sit cras tortor habitasse enim amet. Etiam tempor. Dictumst enim etiam enim. Facilisis risus? Nunc tempor mattis! Turpis? Ultricies dis, augue eros porta parturient pid sit facilisis dolor nunc natoque aenean porta elementum sed? A aenean arcu ac arcu sit nunc est proin sit arcu in! Placerat odio. Et eu non dictumst eu dolor sed pellentesque nec! Enim eros urna, augue diam, integer turpis elementum proin! Risus nec! Mauris vut in etiam phasellus pellentesque ut et? Platea eu natoque elit tortor sit placerat enim, turpis augue sociis, elementum, massa dapibus duis duis, nunc aliquam lorem habitasse! Aliquet mauris cras? In habitasse vut. Porta, ultricies proin? Est integer, elementum.</p>\r\n','','This is my very first entry dudes!',b'1',1),
	(8,4,'','2011-07-19 00:00:00','2011-07-19 17:08:50','','a-great-ipsum-lorem-article','',b'1','<p style=\"margin-top: 0px; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; outline-width: 0px; outline-style: initial; outline-color: initial; font-size: 13px; vertical-align: baseline; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: transparent; background-position: initial initial; background-repeat: initial initial; \">\r\n	Turpis vut magnis dapibus ac, sed? Augue, scelerisque lundium enim diam enim tincidunt, in ut hac porta urna! Duis. Porta dapibus mattis etiam aenean, mid arcu adipiscing! Sit? Lacus ridiculus elementum a! Integer magnis nascetur, in! Tempor eu et arcu? Eu nascetur, mauris rhoncus enim pid nec integer a habitasse! Platea aenean, tempor, arcu, amet ac nec, a turpis aliquet dapibus et ut nisi lectus scelerisque. Ac tristique montes odio tristique penatibus, magna platea nunc. Tempor massa, dis? Augue rhoncus etiam purus lundium tincidunt tincidunt porta scelerisque dapibus mid etiam, placerat placerat. Natoque nisi a porttitor. Magna massa porttitor augue ultrices tristique integer natoque, arcu, vel auctor amet augue, pulvinar, rhoncus dis, porttitor turpis. Placerat enim arcu, magnis porta, risus.</p>\r\n<p style=\"margin-top: 0px; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; outline-width: 0px; outline-style: initial; outline-color: initial; font-size: 13px; vertical-align: baseline; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: transparent; background-position: initial initial; background-repeat: initial initial; \">\r\n	Non amet ac nascetur, nascetur ultricies urna, elementum adipiscing pellentesque porttitor? Ut nisi aliquet. In! Amet aliquet augue odio, ut amet, proin tortor! Cum dictumst augue pid magna. Dictumst tristique amet sit habitasse ultrices, tincidunt, turpis dis sociis! Mid porta. Magna. Turpis hac aliquam turpis ridiculus amet ac porta magnis nec, odio ac, porttitor pid elit elementum nisi platea tristique ut mid odio, et tempor dolor rhoncus sit vel porta urna, sociis purus nisi massa dignissim aliquam. Aenean auctor? Mid et, pid facilisis sed ridiculus ac pellentesque vel pid! Tincidunt, tristique diam ac tristique eros, tincidunt urna pellentesque. Ridiculus diam nec, sit eros? Lacus. Et pid a tristique penatibus et odio a dapibus! Tristique sed duis ut non purus.</p>\r\n<p style=\"margin-top: 0px; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; outline-width: 0px; outline-style: initial; outline-color: initial; font-size: 13px; vertical-align: baseline; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: transparent; background-position: initial initial; background-repeat: initial initial; \">\r\n	Nec et sit. Porttitor! Et? In risus quis ultricies augue dapibus? A? A nisi! Porta platea mid et, aliquam tincidunt in aliquet sed, rhoncus dolor, aenean purus tristique sed, integer scelerisque proin sociis nunc, lundium? Mid lectus rhoncus vel, rhoncus porttitor, urna sed turpis, elit, ut tincidunt, sed in elementum turpis turpis tortor? Purus, aliquet pid lorem tincidunt enim purus lundium enim lundium. Et elementum? Magna montes? Rhoncus turpis! Montes duis urna quis sed? Tortor a in dictumst cum mid, turpis a sed platea vel et tristique, augue nec, habitasse platea sociis aenean porta nec lectus purus, cursus placerat parturient! Tempor! Pid elementum placerat, lorem lundium, elementum hac proin et tincidunt. Porta mus eu dignissim et, nisi nascetur diam.</p>\r\n<p style=\"margin-top: 0px; margin-right: 0px; margin-bottom: 10px; margin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; outline-width: 0px; outline-style: initial; outline-color: initial; font-size: 13px; vertical-align: baseline; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: transparent; background-position: initial initial; background-repeat: initial initial; \">\r\n	Odio, ac sagittis ac egestas porta sagittis in sagittis ac ultrices sit cras tortor habitasse enim amet. Etiam tempor. Dictumst enim etiam enim. Facilisis risus? Nunc tempor mattis! Turpis? Ultricies dis, augue eros porta parturient pid sit facilisis dolor nunc natoque aenean porta elementum sed? A aenean arcu ac arcu sit nunc est proin sit arcu in! Placerat odio. Et eu non dictumst eu dolor sed pellentesque nec! Enim eros urna, augue diam, integer turpis elementum proin! Risus nec! Mauris vut in etiam phasellus pellentesque ut et? Platea eu natoque elit tortor sit placerat enim, turpis augue sociis, elementum, massa dapibus duis duis, nunc aliquam lorem habitasse! Aliquet mauris cras? In habitasse vut. Porta, ultricies proin? Est integer, elementum.</p>\r\n','','A great ipsum lorem article',b'1',1),
	(9,64,'','2011-07-27 00:00:00','2011-07-27 00:11:54','','coldbox-universe','',b'1','<p>\r\n	 </p>\r\n<div align=\"center\">\r\n	<p style=\"padding-top: 5px; padding-right: 0px; padding-bottom: 5px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(68, 68, 68); line-height: 1.8em; \">\r\n		<img src=\"http://wiki.coldbox.org/imagelibrary/ColdBoxUniverse.jpg\" style=\"vertical-align: middle; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-top-style: outset; border-right-style: outset; border-bottom-style: outset; border-left-style: outset; border-top-color: rgb(234, 234, 234); border-right-color: rgb(234, 234, 234); border-bottom-color: rgb(234, 234, 234); border-left-color: rgb(234, 234, 234); \" width=\"450\" /></p>\r\n</div>\r\n<p style=\"padding-top: 5px; padding-right: 0px; padding-bottom: 5px; padding-left: 0px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; color: rgb(68, 68, 68); line-height: 1.8em; \">\r\n	We already mentioned that ColdBox is built modularly and here are the major libraries/frameworks that compose the ColdBox Platform. Please note that each of these libraries/frameworks are completely standalone and can be used with any other ColdFusion framework or ColdFusion application. The importance of these libraries are that they are decoupled from each other and you can pick, mix and match and use them in your applications as you see fit.</p>\r\n<ul style=\"list-style-type: square; padding-top: 0px; padding-right: 20px; padding-bottom: 0px; padding-left: 20px; \">\r\n	<li style=\"padding-top: 3px; padding-right: 5px; padding-bottom: 3px; padding-left: 5px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; \">\r\n		<a href=\"http://wiki.coldbox.org/wiki/WireBox.cfm\" style=\"color: rgb(0, 88, 175); background-color: inherit; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; \">WireBox</a> - Dependency Injection and Aspect Oriented Programming (AOP) Framework</li>\r\n	<li style=\"padding-top: 3px; padding-right: 5px; padding-bottom: 3px; padding-left: 5px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; \">\r\n		<a href=\"http://wiki.coldbox.org/wiki/LogBox.cfm\" style=\"color: rgb(0, 88, 175); background-color: inherit; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; \">LogBox</a> - Enterprise ColdFusion logging library inspired by Log4J</li>\r\n	<li style=\"padding-top: 3px; padding-right: 5px; padding-bottom: 3px; padding-left: 5px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; \">\r\n		<a href=\"http://wiki.coldbox.org/wiki/CacheBox.cfm\" style=\"color: rgb(0, 88, 175); background-color: inherit; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; \">CacheBox</a> - Enterprise ColdFusion caching engine, aggregator and API</li>\r\n	<li style=\"padding-top: 3px; padding-right: 5px; padding-bottom: 3px; padding-left: 5px; margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; \">\r\n		<a href=\"http://wiki.coldbox.org/wiki/MockBox.cfm\" style=\"color: rgb(0, 88, 175); background-color: inherit; text-decoration: none; border-bottom-width: 0px !important; border-bottom-style: dotted; border-bottom-color: rgb(0, 51, 102); border-top-width: 0px !important; border-right-width: 0px !important; border-left-width: 0px !important; border-style: initial !important; border-color: initial !important; \">MockBox</a> - Mocking/Stubbing framework</li>\r\n</ul>\r\n','','ColdBox Universe',b'1',1);

/*!40000 ALTER TABLE `bb_entry` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table bb_entryCategories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bb_entryCategories`;

CREATE TABLE `bb_entryCategories` (
  `FK_categoryID` int(11) NOT NULL,
  `FK_entryID` int(11) NOT NULL,
  KEY `FKFB8AA62F1AC77BB1` (`FK_categoryID`),
  KEY `FKFB8AA62F66ED93A5` (`FK_entryID`),
  CONSTRAINT `FKFB8AA62F1AC77BB1` FOREIGN KEY (`FK_categoryID`) REFERENCES `bb_category` (`categoryID`),
  CONSTRAINT `FKFB8AA62F66ED93A5` FOREIGN KEY (`FK_entryID`) REFERENCES `bb_entry` (`entryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `bb_entryCategories` WRITE;
/*!40000 ALTER TABLE `bb_entryCategories` DISABLE KEYS */;

INSERT INTO `bb_entryCategories` (`FK_categoryID`, `FK_entryID`)
VALUES
	(9,5),
	(7,5),
	(7,7),
	(9,9),
	(7,9);

/*!40000 ALTER TABLE `bb_entryCategories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table bb_page
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bb_page`;

CREATE TABLE `bb_page` (
  `pageID` int(11) NOT NULL AUTO_INCREMENT,
  `hits` bigint(20) DEFAULT '0',
  `HTMLKeywords` varchar(160) DEFAULT NULL,
  `publishedDate` datetime DEFAULT NULL,
  `createdDate` datetime NOT NULL,
  `slug` varchar(200) NOT NULL,
  `passwordProtection` varchar(100) DEFAULT NULL,
  `allowComments` bit(1) NOT NULL DEFAULT b'1',
  `content` longtext NOT NULL,
  `HTMLDescription` varchar(160) DEFAULT NULL,
  `layout` varchar(200) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `isPublished` bit(1) NOT NULL DEFAULT b'1',
  `FK_authorID` int(11) DEFAULT NULL,
  `FK_parentID` int(11) DEFAULT NULL,
  `order` int(11) DEFAULT '0',
  PRIMARY KEY (`pageID`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_slug` (`slug`),
  KEY `idx_published` (`isPublished`),
  KEY `idx_publishedSlug` (`slug`,`isPublished`),
  KEY `idx_createdDate` (`createdDate`),
  KEY `idx_search` (`title`,`isPublished`),
  KEY `FKECCCB72E4289940B` (`FK_authorID`),
  KEY `FKECCCB72E6608086E` (`FK_parentID`),
  CONSTRAINT `FKECCCB72E4289940B` FOREIGN KEY (`FK_authorID`) REFERENCES `bb_author` (`authorID`),
  CONSTRAINT `FKECCCB72E6608086E` FOREIGN KEY (`FK_parentID`) REFERENCES `bb_page` (`pageID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

LOCK TABLES `bb_page` WRITE;
/*!40000 ALTER TABLE `bb_page` DISABLE KEYS */;

INSERT INTO `bb_page` (`pageID`, `hits`, `HTMLKeywords`, `publishedDate`, `createdDate`, `slug`, `passwordProtection`, `allowComments`, `content`, `HTMLDescription`, `layout`, `title`, `isPublished`, `FK_authorID`, `FK_parentID`, `order`)
VALUES
	(2,52,'','2011-08-10 17:25:00','2011-08-10 17:25:28','about-us','',b'0','<p>\r\n	Welcome to your BlogBox installation. Enjoy it!</p>\r\n','','pages','About Us',b'1',1,NULL,0),
	(3,94,'','2011-08-16 18:28:00','2011-08-16 18:28:56','projects','',b'1','<p>\r\n	Where al my cool projects are</p>\r\n','','pages','Projects',b'1',1,NULL,1),
	(4,10,'','2011-08-16 18:37:00','2011-08-16 18:37:15','contact-us','',b'1','<p>\r\n	This is my contact us page</p>\r\n','','pages','Contact Us',b'1',1,NULL,2),
	(5,23,'','2011-08-16 18:41:00','2011-08-16 18:42:08','project-1','',b'1','<p>\r\n	This is project 1</p>\r\n','','pages','Project 1',b'1',1,3,0),
	(6,21,'','2011-08-16 20:41:00','2011-08-16 20:41:26','project-2','',b'1','<p>\r\n	Project 2 Project 2 Project 2</p>\r\n','','pages','Project 2',b'1',1,3,1);

/*!40000 ALTER TABLE `bb_page` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table bb_setting
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bb_setting`;

CREATE TABLE `bb_setting` (
  `settingID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`settingID`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

LOCK TABLES `bb_setting` WRITE;
/*!40000 ALTER TABLE `bb_setting` DISABLE KEYS */;

INSERT INTO `bb_setting` (`settingID`, `name`, `value`)
VALUES
	(3,'bb_site_name','BlogBox by ColdBox'),
	(4,'bb_site_email','myemail@email.com'),
	(5,'bb_site_tagline','An Awesome Blogging Platform'),
	(6,'bb_paging_maxrows','20'),
	(7,'bb_paging_bandgap','5'),
	(8,'bb_gravatar_display','true'),
	(9,'bb_gravatar_rating','PG'),
	(11,'bb_comments_whoisURL','http://whois.arin.net/ui/query.do?q'),
	(12,'bb_comments_maxDisplayChars','500'),
	(13,'bb_dashboard_recentEntries','5'),
	(14,'bb_dashboard_recentComments','5'),
	(15,'bb_comments_enabled','true'),
	(16,'bb_comments_urltranslations','true'),
	(17,'bb_comments_moderation','true'),
	(18,'bb_comments_moderation_whitelist','true'),
	(19,'bb_comments_notify','true'),
	(20,'bb_comments_moderation_notify','true'),
	(21,'bb_comments_notifyemails',''),
	(22,'bb_site_description','Welcome to the most awesomest blogging platform on planet earth!  Please feel free to poke around and learn about BlogBox, a blogging platform powered by ColdBox.'),
	(23,'bb_comments_moderation_blacklist',''),
	(24,'bb_comments_moderation_blockedlist',''),
	(25,'bb_site_keywords','BlogBox,ColdBox Platform,Blogging Platform, Blog,Enterprise Blog,ColdFusion Blog,coldfusion,adobe,railo,flex,air,RESTful blog'),
	(26,'bb_notify_author','false'),
	(27,'bb_paging_maxentries','10'),
	(29,'bb_notify_entry','true'),
	(30,'bb_site_outgoingEmail','myemail@email.com'),
	(37,'bb_site_layout','reddy'),
	(38,'bb_comments_captcha','true'),
	(39,'bb_paging_maxRSSComments','10'),
	(40,'bb_rss_cachingTimeout','60'),
	(41,'bb_rss_maxEntries','10'),
	(42,'bb_rss_caching','false'),
	(43,'bb_rss_maxComments','10'),
	(45,'bb_rss_cachingTimeoutIdle','15'),
	(46,'bb_site_homepage','bbBlog');

/*!40000 ALTER TABLE `bb_setting` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
