-- MySQL dump 10.13  Distrib 5.7.22, for osx10.9 (x86_64)
--
-- Host: localhost    Database: importing_mysql
-- ------------------------------------------------------
-- Server version	5.7.23

use sqlalchemy_mysql

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `Id` bigint(20) PRIMARY KEY,
  `AcceptedAnswerId` int,
  `AnswerCount` int,
  `Body` text,
  `ClosedDate` datetime,
  `CommentCount` int,
  `CommunityOwnedDate` datetime,
  `CreationDate` datetime,
  `FavoriteCount` int,
  `LastActivityDate` datetime,
  `LastEditDate` datetime,
  `LastEditorDisplayName` text,
  `LastEditorUserId` int,
  `OwnerDisplayName` text,
  `OwnerUserId` int,
  `ParentId` int,
  `PostTypeId` int,
  `Score` float(10,7),
  `Tags` text,
  `Title` text=,
  `ViewCount` text,
  KEY `id_posts_index` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `Id` bigint(20) PRIMARY KEY,
  `Count` int,
  `ExcerptPostId` int,
  `TagName` text NOT NULL,
  `WikiPostId` int,
  KEY `ix_tags_ud` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `Id` bigint(20) PRIMARY KEY,
  `AboutMe` text,
  `AccountId` int,
  `CreationDate` datetime,
  `DisplayName` text,
  `DownVotes` int,
  `LastAccessDate` datetime,
  `Location` text,
  `ProfileImageUrl` text,
  `Reputation` int,
  `UpVotes` int,
  `Views` int,
  `WebsiteUrl` text,
  KEY `ix_users_id` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

