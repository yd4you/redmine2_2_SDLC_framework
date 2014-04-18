-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.66-0+squeeze1


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema redmine_production_ydframework
--

CREATE DATABASE IF NOT EXISTS redmine_production_ydframework;
USE redmine_production_ydframework;

--
-- Definition of table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
CREATE TABLE `attachments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `container_id` int(11) DEFAULT NULL,
  `container_type` varchar(30) DEFAULT NULL,
  `filename` varchar(255) NOT NULL DEFAULT '',
  `disk_filename` varchar(255) NOT NULL DEFAULT '',
  `filesize` int(11) NOT NULL DEFAULT '0',
  `content_type` varchar(255) DEFAULT '',
  `digest` varchar(40) NOT NULL DEFAULT '',
  `downloads` int(11) NOT NULL DEFAULT '0',
  `author_id` int(11) NOT NULL DEFAULT '0',
  `created_on` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_attachments_on_author_id` (`author_id`),
  KEY `index_attachments_on_created_on` (`created_on`),
  KEY `index_attachments_on_container_id_and_container_type` (`container_id`,`container_type`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `attachments`
--

/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
INSERT INTO `attachments` (`id`,`container_id`,`container_type`,`filename`,`disk_filename`,`filesize`,`content_type`,`digest`,`downloads`,`author_id`,`created_on`,`description`) VALUES 
  (29,NULL,NULL,'query_rewrite.patch','130308092019_query_rewrite.patch',7026,'application/octet-stream','6ad0b68c3a6233637c6592e92077df92',0,2,'2013-03-08 09:20:19',NULL);
INSERT INTO `attachments` (`id`,`container_id`,`container_type`,`filename`,`disk_filename`,`filesize`,`content_type`,`digest`,`downloads`,`author_id`,`created_on`,`description`) VALUES 
  (30,NULL,NULL,'query_rewrite.patch','130308092027_query_rewrite.patch',7026,'application/octet-stream','6ad0b68c3a6233637c6592e92077df92',0,2,'2013-03-08 09:20:27',NULL);
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;


--
-- Definition of table `auth_sources`
--

DROP TABLE IF EXISTS `auth_sources`;
CREATE TABLE `auth_sources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) NOT NULL DEFAULT '',
  `name` varchar(60) NOT NULL DEFAULT '',
  `host` varchar(60) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `account` varchar(255) DEFAULT NULL,
  `account_password` varchar(255) DEFAULT '',
  `base_dn` varchar(255) DEFAULT NULL,
  `attr_login` varchar(30) DEFAULT NULL,
  `attr_firstname` varchar(30) DEFAULT NULL,
  `attr_lastname` varchar(30) DEFAULT NULL,
  `attr_mail` varchar(30) DEFAULT NULL,
  `onthefly_register` tinyint(1) NOT NULL DEFAULT '0',
  `tls` tinyint(1) NOT NULL DEFAULT '0',
  `filter` varchar(255) DEFAULT NULL,
  `timeout` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_auth_sources_on_id_and_type` (`id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `auth_sources`
--

/*!40000 ALTER TABLE `auth_sources` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_sources` ENABLE KEYS */;


--
-- Definition of table `boards`
--

DROP TABLE IF EXISTS `boards`;
CREATE TABLE `boards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `position` int(11) DEFAULT '1',
  `topics_count` int(11) NOT NULL DEFAULT '0',
  `messages_count` int(11) NOT NULL DEFAULT '0',
  `last_message_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `boards_project_id` (`project_id`),
  KEY `index_boards_on_last_message_id` (`last_message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `boards`
--

/*!40000 ALTER TABLE `boards` DISABLE KEYS */;
/*!40000 ALTER TABLE `boards` ENABLE KEYS */;


--
-- Definition of table `changes`
--

DROP TABLE IF EXISTS `changes`;
CREATE TABLE `changes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `changeset_id` int(11) NOT NULL,
  `action` varchar(1) NOT NULL DEFAULT '',
  `path` text NOT NULL,
  `from_path` text,
  `from_revision` varchar(255) DEFAULT NULL,
  `revision` varchar(255) DEFAULT NULL,
  `branch` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `changesets_changeset_id` (`changeset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `changes`
--

/*!40000 ALTER TABLE `changes` DISABLE KEYS */;
/*!40000 ALTER TABLE `changes` ENABLE KEYS */;


--
-- Definition of table `changeset_parents`
--

DROP TABLE IF EXISTS `changeset_parents`;
CREATE TABLE `changeset_parents` (
  `changeset_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  KEY `changeset_parents_changeset_ids` (`changeset_id`),
  KEY `changeset_parents_parent_ids` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `changeset_parents`
--

/*!40000 ALTER TABLE `changeset_parents` DISABLE KEYS */;
/*!40000 ALTER TABLE `changeset_parents` ENABLE KEYS */;


--
-- Definition of table `changesets`
--

DROP TABLE IF EXISTS `changesets`;
CREATE TABLE `changesets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `repository_id` int(11) NOT NULL,
  `revision` varchar(255) NOT NULL,
  `committer` varchar(255) DEFAULT NULL,
  `committed_on` datetime NOT NULL,
  `comments` text,
  `commit_date` date DEFAULT NULL,
  `scmid` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `changesets_repos_rev` (`repository_id`,`revision`),
  KEY `index_changesets_on_user_id` (`user_id`),
  KEY `index_changesets_on_repository_id` (`repository_id`),
  KEY `index_changesets_on_committed_on` (`committed_on`),
  KEY `changesets_repos_scmid` (`repository_id`,`scmid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `changesets`
--

/*!40000 ALTER TABLE `changesets` DISABLE KEYS */;
/*!40000 ALTER TABLE `changesets` ENABLE KEYS */;


--
-- Definition of table `changesets_issues`
--

DROP TABLE IF EXISTS `changesets_issues`;
CREATE TABLE `changesets_issues` (
  `changeset_id` int(11) NOT NULL,
  `issue_id` int(11) NOT NULL,
  UNIQUE KEY `changesets_issues_ids` (`changeset_id`,`issue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `changesets_issues`
--

/*!40000 ALTER TABLE `changesets_issues` DISABLE KEYS */;
/*!40000 ALTER TABLE `changesets_issues` ENABLE KEYS */;


--
-- Definition of table `code_review_assignments`
--

DROP TABLE IF EXISTS `code_review_assignments`;
CREATE TABLE `code_review_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issue_id` int(11) DEFAULT NULL,
  `change_id` int(11) DEFAULT NULL,
  `attachment_id` int(11) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `rev` varchar(255) DEFAULT NULL,
  `rev_to` varchar(255) DEFAULT NULL,
  `action_type` varchar(255) DEFAULT NULL,
  `changeset_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `code_review_assignments`
--

/*!40000 ALTER TABLE `code_review_assignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `code_review_assignments` ENABLE KEYS */;


--
-- Definition of table `code_review_project_settings`
--

DROP TABLE IF EXISTS `code_review_project_settings`;
CREATE TABLE `code_review_project_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL,
  `tracker_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `hide_code_review_tab` tinyint(1) DEFAULT '0',
  `auto_relation` int(11) DEFAULT '1',
  `assignment_tracker_id` int(11) DEFAULT NULL,
  `auto_assign` text,
  `lock_version` int(11) NOT NULL DEFAULT '0',
  `tracker_in_review_dialog` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `code_review_project_settings`
--

/*!40000 ALTER TABLE `code_review_project_settings` DISABLE KEYS */;
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (1,1,1,'2013-07-11 09:58:43','2013-07-11 09:58:43',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (2,4,1,'2013-07-11 10:02:37','2013-07-11 10:02:37',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (3,31,1,'2013-07-15 10:07:34','2013-07-15 10:07:34',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (4,8,1,'2013-07-15 10:07:54','2013-07-15 10:07:54',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (5,7,1,'2013-07-15 10:07:56','2013-07-15 10:07:56',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (6,18,1,'2013-07-15 10:17:33','2013-07-15 10:17:33',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (7,19,1,'2013-07-15 10:17:47','2013-07-15 10:17:47',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (8,29,1,'2013-07-15 16:14:54','2013-07-15 16:14:54',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (9,24,1,'2013-07-15 16:18:15','2013-07-15 16:18:15',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (10,32,1,'2013-07-15 16:19:13','2013-07-15 16:19:13',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (11,33,1,'2013-07-15 16:42:20','2013-07-15 16:42:20',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (12,30,1,'2013-07-15 17:12:42','2013-07-15 17:12:42',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (13,23,1,'2013-07-15 17:14:21','2013-07-15 17:14:21',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (14,15,1,'2013-07-15 17:14:24','2013-07-15 17:14:24',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (15,28,1,'2013-07-15 17:14:47','2013-07-15 17:14:47',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (16,11,4,'2013-07-15 17:15:20','2013-07-15 17:15:20',NULL,0,1,4,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (17,25,1,'2013-07-15 17:24:22','2013-07-15 17:24:22',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (18,22,1,'2013-07-15 18:09:25','2013-07-15 18:09:25',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (19,10,1,'2013-07-15 18:25:49','2013-07-15 18:25:49',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (20,9,1,'2013-07-15 18:46:45','2013-07-15 18:46:45',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (21,27,1,'2013-07-16 06:35:41','2013-07-16 06:35:41',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (22,26,1,'2013-07-16 10:54:59','2013-07-16 10:54:59',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (23,16,1,'2013-07-16 11:09:42','2013-07-16 11:09:42',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (24,34,1,'2013-07-17 11:52:59','2013-07-17 11:52:59',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (25,35,6,'2013-07-19 17:07:27','2013-07-19 17:07:27',NULL,0,1,6,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (26,21,1,'2013-07-19 17:51:50','2013-07-19 17:51:50',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (27,36,1,'2013-08-02 17:15:56','2013-08-02 17:15:56',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (28,37,1,'2013-08-13 14:16:34','2013-08-13 14:16:34',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (29,38,1,'2013-08-26 15:38:56','2013-08-26 15:38:56',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (30,39,1,'2013-09-05 11:07:45','2013-09-05 11:07:45',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (31,12,10,'2013-09-19 12:23:54','2013-09-19 12:23:54',NULL,0,1,10,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (32,40,1,'2013-09-27 14:26:50','2013-09-27 14:26:50',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (33,41,1,'2013-10-23 10:46:40','2013-10-23 10:46:40',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (34,42,1,'2013-10-23 11:28:28','2013-10-23 11:28:28',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (35,43,1,'2013-10-23 14:40:52','2013-10-23 14:40:52',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (36,44,1,'2013-10-30 10:53:31','2013-10-30 10:53:31',NULL,0,1,1,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (37,45,3,'2013-11-06 12:18:07','2013-11-06 12:18:07',NULL,0,1,3,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (38,2,12,'2013-11-26 17:18:27','2013-11-26 17:18:27',NULL,0,1,12,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (39,3,18,'2014-01-13 16:25:22','2014-01-13 16:25:22',NULL,0,1,18,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (40,5,18,'2014-03-27 12:34:19','2014-03-27 12:34:19',NULL,0,1,18,'--- \n:enabled: false\n',0,0);
INSERT INTO `code_review_project_settings` (`id`,`project_id`,`tracker_id`,`created_at`,`updated_at`,`updated_by`,`hide_code_review_tab`,`auto_relation`,`assignment_tracker_id`,`auto_assign`,`lock_version`,`tracker_in_review_dialog`) VALUES 
  (41,6,18,'2014-03-27 12:35:21','2014-03-27 12:35:21',NULL,0,1,18,'--- \n:enabled: false\n',0,0);
/*!40000 ALTER TABLE `code_review_project_settings` ENABLE KEYS */;


--
-- Definition of table `code_review_user_settings`
--

DROP TABLE IF EXISTS `code_review_user_settings`;
CREATE TABLE `code_review_user_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `mail_notification` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `code_review_user_settings`
--

/*!40000 ALTER TABLE `code_review_user_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `code_review_user_settings` ENABLE KEYS */;


--
-- Definition of table `code_reviews`
--

DROP TABLE IF EXISTS `code_reviews`;
CREATE TABLE `code_reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL,
  `change_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `line` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `lock_version` int(11) NOT NULL DEFAULT '0',
  `status_changed_from` int(11) DEFAULT NULL,
  `status_changed_to` int(11) DEFAULT NULL,
  `issue_id` int(11) DEFAULT NULL,
  `action_type` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `rev` varchar(255) DEFAULT NULL,
  `rev_to` varchar(255) DEFAULT NULL,
  `attachment_id` int(11) DEFAULT NULL,
  `file_count` int(11) NOT NULL DEFAULT '0',
  `diff_all` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `code_reviews`
--

/*!40000 ALTER TABLE `code_reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `code_reviews` ENABLE KEYS */;


--
-- Definition of table `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commented_type` varchar(30) NOT NULL DEFAULT '',
  `commented_id` int(11) NOT NULL DEFAULT '0',
  `author_id` int(11) NOT NULL DEFAULT '0',
  `comments` text,
  `created_on` datetime NOT NULL,
  `updated_on` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_comments_on_commented_id_and_commented_type` (`commented_id`,`commented_type`),
  KEY `index_comments_on_author_id` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `comments`
--

/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;


--
-- Definition of table `custom_fields`
--

DROP TABLE IF EXISTS `custom_fields`;
CREATE TABLE `custom_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(30) NOT NULL DEFAULT '',
  `name` varchar(30) NOT NULL DEFAULT '',
  `field_format` varchar(30) NOT NULL DEFAULT '',
  `possible_values` text,
  `regexp` varchar(255) DEFAULT '',
  `min_length` int(11) NOT NULL DEFAULT '0',
  `max_length` int(11) NOT NULL DEFAULT '0',
  `is_required` tinyint(1) NOT NULL DEFAULT '0',
  `is_for_all` tinyint(1) NOT NULL DEFAULT '0',
  `is_filter` tinyint(1) NOT NULL DEFAULT '0',
  `position` int(11) DEFAULT '1',
  `searchable` tinyint(1) DEFAULT '0',
  `default_value` text,
  `editable` tinyint(1) DEFAULT '1',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `multiple` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_custom_fields_on_id_and_type` (`id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `custom_fields`
--

/*!40000 ALTER TABLE `custom_fields` DISABLE KEYS */;
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (34,'IssueCustomField','Remaining Hrs','int','--- []\n\n','',0,3,1,0,1,2,0,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (36,'IssueCustomField','Server/Machine Name','string','--- []\n\n','',0,0,1,0,1,3,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (37,'IssueCustomField','Server/Machine IP','string','--- []\n\n','',0,0,1,0,1,4,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (38,'IssueCustomField','Blocker Details','text','--- []\n\n','',0,0,0,0,1,5,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (39,'IssueCustomField','Deliverables','text','--- []\n\n','',0,0,1,0,1,6,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (41,'IssueCustomField','Delivered Items(with SVN path)','text','--- []\n\n','',0,0,1,0,1,7,1,'Not Yet----',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (42,'IssueCustomField','Understanding requirements','list','--- \n- 0=Please Select\n- 1=Poor\n- 2=Below expectation\n- 3=As Expected\n- 4=Good\n- 5=Excellent\n','',0,0,1,0,1,8,1,'0=Please Select',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (43,'IssueCustomField','Communication ','list','--- \n- 0=Please Select\n- 1=Poor\n- 2=Below expectation\n- 3=As Expected\n- 4=Good\n- 5=Excellent\n','',0,0,1,0,1,9,1,'0=Please Select',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (45,'IssueCustomField','Resolution of issues','list','--- \n- 0=Please Select\n- 1=Poor\n- 2=Below expectation\n- 3=As Expected\n- 4=Good\n- 5=Excellent\n','',0,0,1,0,1,10,1,'0=Please Select',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (46,'IssueCustomField','Quality','list','--- \n- 0=Please Select\n- 1=Poor\n- 2=Below expectation\n- 3=As Expected\n- 4=Good\n- 5=Excellent\n','',0,0,1,0,1,11,1,'0=Please Select',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (47,'IssueCustomField','Timely  delivery','list','--- \n- 0=Please Select\n- 1=Poor\n- 2=Below expectation\n- 3=As Expected\n- 4=Good\n- 5=Excellent\n','',0,0,1,0,1,12,1,'0=Please Select',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (48,'IssueCustomField','Comments-Understanding','text','--- []\n\n','',0,0,1,0,1,13,1,'Your comments please',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (49,'IssueCustomField','Complexity (1=Low, 5=High)','list','--- \n- NA\n- \"1\"\n- \"2\"\n- \"3\"\n- \"4\"\n- \"5\"\n','',0,0,0,0,1,18,1,'3',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (50,'IssueCustomField','Comments-Communication','text','--- []\n\n','',0,0,1,0,1,14,1,'Your comments please',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (51,'IssueCustomField','Comments-Resolution','text','--- []\n\n','',0,0,1,0,1,15,1,'Your comments please',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (52,'IssueCustomField','Comments-Quality','text','--- []\n\n','',0,0,1,0,1,16,1,'Your comments please',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (53,'IssueCustomField','Comments-Delivery','text','--- []\n\n','',0,0,1,0,1,17,1,'Your comments please',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (54,'IssueCustomField','Estimated End Date','date','--- []\n\n','',0,0,0,0,1,1,0,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (55,'IssueCustomField','Page Count (Deliverables)','int','--- \n','',0,0,0,0,1,19,0,'0',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (56,'IssueCustomField','Line of code (Deliverables)','int','--- \n','',0,0,0,0,1,20,0,'0',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (69,'IssueCustomField','Customer Oraganization','string','--- \n','',0,0,0,0,1,21,0,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (70,'IssueCustomField','Customer Contact Person','string','--- \n','',0,0,0,0,1,22,0,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (71,'IssueCustomField','Customer Mail-ID','string','--- \n','',0,0,0,0,1,23,0,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (75,'IssueCustomField','Expected Bug Detection Phase','list','--- \n- 0 Not Applicable\n- 1 UT\n- 2 SI\n- 3 IT\n- 4 AT\n- 5 CT\n','',0,0,1,0,1,24,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (76,'IssueCustomField','Reported In Version','list','--- \n- NA\n- \"1.1\"\n- \"1.2\"\n','',0,0,1,0,1,25,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (77,'IssueCustomField','Corrected In Version','list','--- \n- NA\n- \"1.1\"\n- \"1.2\"\n','',0,0,1,0,1,26,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (83,'IssueCustomField','Bug Phenomenon','list','--- \n- 1:Interface error\n- 2:Logical error\n- 3:Data definition error\n- 4:Table definition error\n- 5:Error in format\n- 6:Other\n','',0,0,1,0,1,27,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (91,'IssueCustomField','Horiontal Check Required','list','--- \n- 1.Yes\n- 2.No\n','',0,0,1,0,1,29,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (93,'IssueCustomField','Changes Done for Fixing','text','--- \n','',0,0,1,0,1,28,1,'<<To be filled in by the developer>>',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (96,'IssueCustomField','Test Case Number','string','--- \n','',0,0,1,0,1,30,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (97,'IssueCustomField','Improvement / Suggestion','text','--- \n','',0,0,1,0,1,31,1,'<<To be filled in by Asignee>>',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (99,'IssueCustomField','Found In Phase','list','--- \n- 0 Not Applicable\n- 1 UT\n- 2 SI\n- 3 IT\n- 4 AT\n- 5 CT\n','',0,0,1,0,1,32,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (100,'IssueCustomField','Bug Sub-Type','list','--- \n- 0.NA\n- 1.Software Bug\n- 2.Environment Bug\n- 3.Hardware\n- 4.Other\n','',0,0,1,0,1,33,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (101,'IssueCustomField','Bug Injection Phase','list','--- \n- 00:Not Applicable\n- 1A:RA\n- 1B:HLD\n- 1C:DD-[Detail Design]\n- 1D:PD-[Program Design]\n- 1E:C-[Coding]\n- 1F:Mistake in Bug Fixing\n','',0,0,1,0,1,34,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (102,'IssueCustomField','Why Bugs not found in testing','list','--- \n- 0:Not Applicable\n- 1:Miss-outs in test case\n- 2:Miss-outs in testing\n- 3:Carried to the next phase due to problems in environment\n- 4:Miss in result verification\n- 5:Other\n','',0,0,1,0,1,35,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (103,'IssueCustomField','Functionality-For Bug Analysis','list','--- \n- 0:Not Applicable\n- 1:Input data check function\n- 2:Calculation function\n- 3:Edit data function\n- 4:Update file function\n- 5:Output data function\n- 6:Coupling (combining) process\n- 7:Threshold process\n- 8:Function for detecting ambiguity in external env\n- 9:Other\n','',0,0,1,0,1,36,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (104,'IssueCustomField','Bug Cause-Specs','list','--- \n- 00:Not Applicable\n- 1A:Omission (no description)\n- 1B:Error in input\n- 1C:Ambiguity\n- 1D:Violation of standards\n- 1E:Miss-outs during document modifications\n- 1F:Inconsistency in documents\n- 1G:Other\n','',0,0,1,0,1,37,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (105,'IssueCustomField','Bug Cause-FromSpecs','list','--- \n- 00:Not Applicable\n- 2A:Miss in spec\n- 2B:Lacking in spec understanding\n- 2C:Lacking in spec confirmation\n- 2D:Leakage in Specification Analysis\n- 2E:Other\n','',0,0,1,0,1,38,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (106,'IssueCustomField','BugCause-OtherThanSpec','list','--- \n- 00:Not Applicable\n- 3A:Inadequate knowledge about linguistic terms\n- 3B:Defective communication\n- 3C:Violation of standards\n- 3D:Defects in review of re-using component\n- 3E:Defects in review of modifications\n- 3F:Simple and common errors\n- 3G:Other\n','',0,0,1,0,1,39,1,'',1,1,0);
INSERT INTO `custom_fields` (`id`,`type`,`name`,`field_format`,`possible_values`,`regexp`,`min_length`,`max_length`,`is_required`,`is_for_all`,`is_filter`,`position`,`searchable`,`default_value`,`editable`,`visible`,`multiple`) VALUES 
  (107,'IssueCustomField','Bug-Other Cause','list','--- \n- 00:Not Applicable\n- 4A:Incorrect operation\n- 4B:Without recurrence\n- 4C:Wrong instruction\n- 4D:Duplication\n- 4E:Improper documents\n- 4F:Potential bug (Old version)\n- 4G:Package and Tool\n- 4H:Other\n','',0,0,1,0,1,40,1,'',1,1,0);
/*!40000 ALTER TABLE `custom_fields` ENABLE KEYS */;


--
-- Definition of table `custom_fields_projects`
--

DROP TABLE IF EXISTS `custom_fields_projects`;
CREATE TABLE `custom_fields_projects` (
  `custom_field_id` int(11) NOT NULL DEFAULT '0',
  `project_id` int(11) NOT NULL DEFAULT '0',
  KEY `index_custom_fields_projects_on_custom_field_id_and_project_id` (`custom_field_id`,`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `custom_fields_projects`
--

/*!40000 ALTER TABLE `custom_fields_projects` DISABLE KEYS */;
INSERT INTO `custom_fields_projects` (`custom_field_id`,`project_id`) VALUES 
  (75,6);
INSERT INTO `custom_fields_projects` (`custom_field_id`,`project_id`) VALUES 
  (83,6);
INSERT INTO `custom_fields_projects` (`custom_field_id`,`project_id`) VALUES 
  (91,6);
INSERT INTO `custom_fields_projects` (`custom_field_id`,`project_id`) VALUES 
  (93,6);
INSERT INTO `custom_fields_projects` (`custom_field_id`,`project_id`) VALUES 
  (96,6);
INSERT INTO `custom_fields_projects` (`custom_field_id`,`project_id`) VALUES 
  (97,6);
/*!40000 ALTER TABLE `custom_fields_projects` ENABLE KEYS */;


--
-- Definition of table `custom_fields_trackers`
--

DROP TABLE IF EXISTS `custom_fields_trackers`;
CREATE TABLE `custom_fields_trackers` (
  `custom_field_id` int(11) NOT NULL DEFAULT '0',
  `tracker_id` int(11) NOT NULL DEFAULT '0',
  KEY `index_custom_fields_trackers_on_custom_field_id_and_tracker_id` (`custom_field_id`,`tracker_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `custom_fields_trackers`
--

/*!40000 ALTER TABLE `custom_fields_trackers` DISABLE KEYS */;
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (34,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (34,2);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (34,3);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (34,4);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (34,9);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (34,14);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (34,17);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (36,10);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (36,11);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (37,10);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (37,11);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (38,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (38,2);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (38,3);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (38,4);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (38,8);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (38,9);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (38,14);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (38,17);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (39,4);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (39,14);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (39,17);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (41,4);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (41,14);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (41,17);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (42,12);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (43,12);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (45,12);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (46,12);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (47,12);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (48,12);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (49,4);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (49,17);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (50,12);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (51,12);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (52,12);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (53,12);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (54,17);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (55,17);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (56,17);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (75,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (75,9);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (76,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (76,9);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (77,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (77,9);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (83,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (83,9);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (91,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (91,9);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (93,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (93,9);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (96,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (99,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (99,9);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (100,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (101,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (101,9);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (102,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (102,9);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (103,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (103,9);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (104,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (104,9);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (105,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (105,9);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (106,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (106,9);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (107,1);
INSERT INTO `custom_fields_trackers` (`custom_field_id`,`tracker_id`) VALUES 
  (107,9);
/*!40000 ALTER TABLE `custom_fields_trackers` ENABLE KEYS */;


--
-- Definition of table `custom_values`
--

DROP TABLE IF EXISTS `custom_values`;
CREATE TABLE `custom_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customized_type` varchar(30) NOT NULL DEFAULT '',
  `customized_id` int(11) NOT NULL DEFAULT '0',
  `custom_field_id` int(11) NOT NULL DEFAULT '0',
  `value` text,
  PRIMARY KEY (`id`),
  KEY `custom_values_customized` (`customized_type`,`customized_id`),
  KEY `index_custom_values_on_custom_field_id` (`custom_field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `custom_values`
--

/*!40000 ALTER TABLE `custom_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_values` ENABLE KEYS */;


--
-- Definition of table `documents`
--

DROP TABLE IF EXISTS `documents`;
CREATE TABLE `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL DEFAULT '0',
  `category_id` int(11) NOT NULL DEFAULT '0',
  `title` varchar(60) NOT NULL DEFAULT '',
  `description` text,
  `created_on` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `documents_project_id` (`project_id`),
  KEY `index_documents_on_category_id` (`category_id`),
  KEY `index_documents_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `documents`
--

/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;


--
-- Definition of table `enabled_modules`
--

DROP TABLE IF EXISTS `enabled_modules`;
CREATE TABLE `enabled_modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `enabled_modules_project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `enabled_modules`
--

/*!40000 ALTER TABLE `enabled_modules` DISABLE KEYS */;
INSERT INTO `enabled_modules` (`id`,`project_id`,`name`) VALUES 
  (45,6,'issue_tracking');
INSERT INTO `enabled_modules` (`id`,`project_id`,`name`) VALUES 
  (46,6,'documents');
INSERT INTO `enabled_modules` (`id`,`project_id`,`name`) VALUES 
  (47,6,'wiki');
INSERT INTO `enabled_modules` (`id`,`project_id`,`name`) VALUES 
  (48,6,'gantt');
INSERT INTO `enabled_modules` (`id`,`project_id`,`name`) VALUES 
  (49,6,'code_review');
INSERT INTO `enabled_modules` (`id`,`project_id`,`name`) VALUES 
  (50,6,'work_time');
INSERT INTO `enabled_modules` (`id`,`project_id`,`name`) VALUES 
  (51,6,'importer');
INSERT INTO `enabled_modules` (`id`,`project_id`,`name`) VALUES 
  (52,6,'time_tracking');
INSERT INTO `enabled_modules` (`id`,`project_id`,`name`) VALUES 
  (53,6,'repository');
INSERT INTO `enabled_modules` (`id`,`project_id`,`name`) VALUES 
  (54,6,'files');
INSERT INTO `enabled_modules` (`id`,`project_id`,`name`) VALUES 
  (55,6,'calendar');
/*!40000 ALTER TABLE `enabled_modules` ENABLE KEYS */;


--
-- Definition of table `enumerations`
--

DROP TABLE IF EXISTS `enumerations`;
CREATE TABLE `enumerations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `position` int(11) DEFAULT '1',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `project_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `position_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_enumerations_on_project_id` (`project_id`),
  KEY `index_enumerations_on_id_and_type` (`id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `enumerations`
--

/*!40000 ALTER TABLE `enumerations` DISABLE KEYS */;
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (1,'User documentation',1,0,'DocumentCategory',1,NULL,NULL,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (2,'Technical documentation',2,0,'DocumentCategory',1,NULL,NULL,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (3,'Low',1,0,'IssuePriority',1,NULL,NULL,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (4,'Normal',2,1,'IssuePriority',1,NULL,NULL,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (5,'High',3,0,'IssuePriority',1,NULL,NULL,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (6,'Urgent',4,0,'IssuePriority',1,NULL,NULL,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (7,'Immediate',5,0,'IssuePriority',1,NULL,NULL,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (8,'Preparation',1,0,'TimeEntryActivity',1,NULL,NULL,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (9,'Requirement Analysis',2,0,'TimeEntryActivity',1,NULL,NULL,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (10,'Design',3,0,'TimeEntryActivity',1,5,8,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (11,'Development',4,0,'TimeEntryActivity',1,5,9,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (12,'Design',5,0,'TimeEntryActivity',1,NULL,NULL,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (13,'Test Preparation/Testing',6,0,'TimeEntryActivity',1,NULL,NULL,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (14,'Coding',7,0,'TimeEntryActivity',1,NULL,NULL,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (15,'Installation / Deployment',8,0,'TimeEntryActivity',1,NULL,NULL,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (16,'Other (Meeting..etc)',9,0,'TimeEntryActivity',1,NULL,NULL,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (17,'Requirement Analysis',10,0,'TimeEntryActivity',0,10,9,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (18,'Design',11,0,'TimeEntryActivity',0,10,12,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (19,'Coding',12,0,'TimeEntryActivity',0,10,14,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (20,'Installation / Deployment',13,0,'TimeEntryActivity',0,10,15,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (21,'Translation',14,0,'TimeEntryActivity',1,NULL,NULL,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (45,'Other (Meeting..etc)',15,0,'TimeEntryActivity',0,45,16,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (46,'Installation / Deployment',16,0,'TimeEntryActivity',0,45,15,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (47,'Coding',17,0,'TimeEntryActivity',0,45,14,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (48,'Test Preparation/Testing',18,0,'TimeEntryActivity',0,45,13,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (49,'Design',19,0,'TimeEntryActivity',0,45,12,NULL);
INSERT INTO `enumerations` (`id`,`name`,`position`,`is_default`,`type`,`active`,`project_id`,`parent_id`,`position_name`) VALUES 
  (50,'Requirement Analysis',20,0,'TimeEntryActivity',0,45,9,NULL);
/*!40000 ALTER TABLE `enumerations` ENABLE KEYS */;


--
-- Definition of table `groups_users`
--

DROP TABLE IF EXISTS `groups_users`;
CREATE TABLE `groups_users` (
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  UNIQUE KEY `groups_users_ids` (`group_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `groups_users`
--

/*!40000 ALTER TABLE `groups_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups_users` ENABLE KEYS */;


--
-- Definition of table `impasse_execution_bugs`
--

DROP TABLE IF EXISTS `impasse_execution_bugs`;
CREATE TABLE `impasse_execution_bugs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `execution_id` int(11) DEFAULT NULL,
  `bug_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_IMPASSE_EXECUTION_BUGS_01` (`execution_id`),
  KEY `IDX_IMPASSE_EXECUTION_BUGS_02` (`bug_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `impasse_execution_bugs`
--

/*!40000 ALTER TABLE `impasse_execution_bugs` DISABLE KEYS */;
/*!40000 ALTER TABLE `impasse_execution_bugs` ENABLE KEYS */;


--
-- Definition of table `impasse_execution_histories`
--

DROP TABLE IF EXISTS `impasse_execution_histories`;
CREATE TABLE `impasse_execution_histories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_plan_case_id` int(11) NOT NULL,
  `tester_id` int(11) DEFAULT NULL,
  `build_id` int(11) DEFAULT NULL,
  `expected_date` date DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `execution_ts` datetime NOT NULL,
  `executor_id` int(11) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `IDX_IMPASSE_EXEC_HIST_01` (`test_plan_case_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `impasse_execution_histories`
--

/*!40000 ALTER TABLE `impasse_execution_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `impasse_execution_histories` ENABLE KEYS */;


--
-- Definition of table `impasse_executions`
--

DROP TABLE IF EXISTS `impasse_executions`;
CREATE TABLE `impasse_executions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_plan_case_id` int(11) NOT NULL,
  `tester_id` int(11) DEFAULT NULL,
  `build_id` int(11) DEFAULT NULL,
  `expected_date` date DEFAULT NULL,
  `status` varchar(255) DEFAULT '0',
  `execution_ts` datetime DEFAULT NULL,
  `notes` text,
  `executor_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_IMPASSE_EXECUTIONS_01` (`test_plan_case_id`),
  KEY `IDX_IMPASSE_EXECUTIONS_02` (`tester_id`),
  KEY `IDX_IMPASSE_EXECUTIONS_03` (`execution_ts`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `impasse_executions`
--

/*!40000 ALTER TABLE `impasse_executions` DISABLE KEYS */;
/*!40000 ALTER TABLE `impasse_executions` ENABLE KEYS */;


--
-- Definition of table `impasse_keywords`
--

DROP TABLE IF EXISTS `impasse_keywords`;
CREATE TABLE `impasse_keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) NOT NULL,
  `project_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_IMPASSE_KEYWORDS_01` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `impasse_keywords`
--

/*!40000 ALTER TABLE `impasse_keywords` DISABLE KEYS */;
/*!40000 ALTER TABLE `impasse_keywords` ENABLE KEYS */;


--
-- Definition of table `impasse_node_keywords`
--

DROP TABLE IF EXISTS `impasse_node_keywords`;
CREATE TABLE `impasse_node_keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `keyword_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_IMPASSE_NODE_KEYWORDS_01` (`node_id`,`keyword_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `impasse_node_keywords`
--

/*!40000 ALTER TABLE `impasse_node_keywords` DISABLE KEYS */;
/*!40000 ALTER TABLE `impasse_node_keywords` ENABLE KEYS */;


--
-- Definition of table `impasse_node_types`
--

DROP TABLE IF EXISTS `impasse_node_types`;
CREATE TABLE `impasse_node_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `impasse_node_types`
--

/*!40000 ALTER TABLE `impasse_node_types` DISABLE KEYS */;
INSERT INTO `impasse_node_types` (`id`,`description`) VALUES 
  (1,'testproject');
INSERT INTO `impasse_node_types` (`id`,`description`) VALUES 
  (2,'testsuite');
INSERT INTO `impasse_node_types` (`id`,`description`) VALUES 
  (3,'testcase');
/*!40000 ALTER TABLE `impasse_node_types` ENABLE KEYS */;


--
-- Definition of table `impasse_nodes`
--

DROP TABLE IF EXISTS `impasse_nodes`;
CREATE TABLE `impasse_nodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `node_type_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `node_order` int(11) DEFAULT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_IMPASSE_NODES_01` (`parent_id`),
  KEY `IDX_IMPASSE_NODES_02` (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `impasse_nodes`
--

/*!40000 ALTER TABLE `impasse_nodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `impasse_nodes` ENABLE KEYS */;


--
-- Definition of table `impasse_requirement_cases`
--

DROP TABLE IF EXISTS `impasse_requirement_cases`;
CREATE TABLE `impasse_requirement_cases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `requirement_id` int(11) NOT NULL,
  `test_case_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `impasse_requirement_cases`
--

/*!40000 ALTER TABLE `impasse_requirement_cases` DISABLE KEYS */;
/*!40000 ALTER TABLE `impasse_requirement_cases` ENABLE KEYS */;


--
-- Definition of table `impasse_requirement_issues`
--

DROP TABLE IF EXISTS `impasse_requirement_issues`;
CREATE TABLE `impasse_requirement_issues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issue_id` int(11) NOT NULL,
  `num_of_cases` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `impasse_requirement_issues`
--

/*!40000 ALTER TABLE `impasse_requirement_issues` DISABLE KEYS */;
/*!40000 ALTER TABLE `impasse_requirement_issues` ENABLE KEYS */;


--
-- Definition of table `impasse_settings`
--

DROP TABLE IF EXISTS `impasse_settings`;
CREATE TABLE `impasse_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `bug_tracker_id` int(11) DEFAULT NULL,
  `requirement_tracker` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_IMPASSE_SETTINGS_01` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `impasse_settings`
--

/*!40000 ALTER TABLE `impasse_settings` DISABLE KEYS */;
INSERT INTO `impasse_settings` (`id`,`project_id`,`bug_tracker_id`,`requirement_tracker`) VALUES 
  (1,1,NULL,NULL);
INSERT INTO `impasse_settings` (`id`,`project_id`,`bug_tracker_id`,`requirement_tracker`) VALUES 
  (2,2,NULL,NULL);
INSERT INTO `impasse_settings` (`id`,`project_id`,`bug_tracker_id`,`requirement_tracker`) VALUES 
  (3,3,NULL,NULL);
/*!40000 ALTER TABLE `impasse_settings` ENABLE KEYS */;


--
-- Definition of table `impasse_test_cases`
--

DROP TABLE IF EXISTS `impasse_test_cases`;
CREATE TABLE `impasse_test_cases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `summary` text,
  `preconditions` text,
  `importance` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `impasse_test_cases`
--

/*!40000 ALTER TABLE `impasse_test_cases` DISABLE KEYS */;
/*!40000 ALTER TABLE `impasse_test_cases` ENABLE KEYS */;


--
-- Definition of table `impasse_test_plan_cases`
--

DROP TABLE IF EXISTS `impasse_test_plan_cases`;
CREATE TABLE `impasse_test_plan_cases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_plan_id` int(11) DEFAULT NULL,
  `test_case_id` int(11) DEFAULT NULL,
  `node_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_IMPASSE_TEST_PLAN_CASES_01` (`test_plan_id`,`test_case_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `impasse_test_plan_cases`
--

/*!40000 ALTER TABLE `impasse_test_plan_cases` DISABLE KEYS */;
/*!40000 ALTER TABLE `impasse_test_plan_cases` ENABLE KEYS */;


--
-- Definition of table `impasse_test_plans`
--

DROP TABLE IF EXISTS `impasse_test_plans`;
CREATE TABLE `impasse_test_plans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_IMPASSE_TEST_PLANS_01` (`version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `impasse_test_plans`
--

/*!40000 ALTER TABLE `impasse_test_plans` DISABLE KEYS */;
/*!40000 ALTER TABLE `impasse_test_plans` ENABLE KEYS */;


--
-- Definition of table `impasse_test_steps`
--

DROP TABLE IF EXISTS `impasse_test_steps`;
CREATE TABLE `impasse_test_steps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `test_case_id` int(11) NOT NULL,
  `step_number` int(11) DEFAULT NULL,
  `actions` text,
  `expected_results` text,
  PRIMARY KEY (`id`),
  KEY `IDX_IMPASSE_TEST_STEPS_01` (`test_case_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `impasse_test_steps`
--

/*!40000 ALTER TABLE `impasse_test_steps` DISABLE KEYS */;
/*!40000 ALTER TABLE `impasse_test_steps` ENABLE KEYS */;


--
-- Definition of table `impasse_test_suites`
--

DROP TABLE IF EXISTS `impasse_test_suites`;
CREATE TABLE `impasse_test_suites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `details` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `impasse_test_suites`
--

/*!40000 ALTER TABLE `impasse_test_suites` DISABLE KEYS */;
/*!40000 ALTER TABLE `impasse_test_suites` ENABLE KEYS */;


--
-- Definition of table `import_in_progresses`
--

DROP TABLE IF EXISTS `import_in_progresses`;
CREATE TABLE `import_in_progresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `quote_char` varchar(8) DEFAULT NULL,
  `col_sep` varchar(8) DEFAULT NULL,
  `encoding` varchar(64) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `csv_data` mediumblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `import_in_progresses`
--

/*!40000 ALTER TABLE `import_in_progresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_in_progresses` ENABLE KEYS */;


--
-- Definition of table `issue_categories`
--

DROP TABLE IF EXISTS `issue_categories`;
CREATE TABLE `issue_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(30) NOT NULL DEFAULT '',
  `assigned_to_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `issue_categories_project_id` (`project_id`),
  KEY `index_issue_categories_on_assigned_to_id` (`assigned_to_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `issue_categories`
--

/*!40000 ALTER TABLE `issue_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_categories` ENABLE KEYS */;


--
-- Definition of table `issue_relations`
--

DROP TABLE IF EXISTS `issue_relations`;
CREATE TABLE `issue_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issue_from_id` int(11) NOT NULL,
  `issue_to_id` int(11) NOT NULL,
  `relation_type` varchar(255) NOT NULL DEFAULT '',
  `delay` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_issue_relations_on_issue_from_id_and_issue_to_id` (`issue_from_id`,`issue_to_id`),
  KEY `index_issue_relations_on_issue_from_id` (`issue_from_id`),
  KEY `index_issue_relations_on_issue_to_id` (`issue_to_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `issue_relations`
--

/*!40000 ALTER TABLE `issue_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_relations` ENABLE KEYS */;


--
-- Definition of table `issue_statuses`
--

DROP TABLE IF EXISTS `issue_statuses`;
CREATE TABLE `issue_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `is_closed` tinyint(1) NOT NULL DEFAULT '0',
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `position` int(11) DEFAULT '1',
  `default_done_ratio` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_issue_statuses_on_position` (`position`),
  KEY `index_issue_statuses_on_is_closed` (`is_closed`),
  KEY `index_issue_statuses_on_is_default` (`is_default`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `issue_statuses`
--

/*!40000 ALTER TABLE `issue_statuses` DISABLE KEYS */;
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`) VALUES 
  (1,'New',0,0,1,NULL);
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`) VALUES 
  (2,'In Progress',0,0,2,NULL);
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`) VALUES 
  (3,'Completed',0,0,3,NULL);
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`) VALUES 
  (5,'Closed',1,0,4,NULL);
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`) VALUES 
  (6,'Rejected',0,0,5,NULL);
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`) VALUES 
  (7,'Replied',0,0,6,NULL);
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`) VALUES 
  (8,'Open',0,1,7,NULL);
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`) VALUES 
  (9,'Later',0,0,8,NULL);
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`) VALUES 
  (10,'Env-In Use',0,0,9,NULL);
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`) VALUES 
  (11,'Env-not in use',0,0,10,NULL);
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`) VALUES 
  (12,'Released',0,0,11,NULL);
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`) VALUES 
  (13,'Uninstalled',0,0,12,NULL);
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`) VALUES 
  (14,'Blocked',0,0,13,NULL);
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`) VALUES 
  (15,'Verifying',0,0,14,NULL);
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`) VALUES 
  (16,'Invalid',1,0,15,NULL);
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`) VALUES 
  (17,'Invalid_Closed',1,0,16,NULL);
INSERT INTO `issue_statuses` (`id`,`name`,`is_closed`,`is_default`,`position`,`default_done_ratio`) VALUES 
  (18,'Fixed',1,0,17,NULL);
/*!40000 ALTER TABLE `issue_statuses` ENABLE KEYS */;


--
-- Definition of table `issues`
--

DROP TABLE IF EXISTS `issues`;
CREATE TABLE `issues` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tracker_id` int(11) NOT NULL DEFAULT '0',
  `project_id` int(11) NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `due_date` date DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `status_id` int(11) NOT NULL DEFAULT '0',
  `assigned_to_id` int(11) DEFAULT NULL,
  `priority_id` int(11) NOT NULL DEFAULT '0',
  `fixed_version_id` int(11) DEFAULT NULL,
  `author_id` int(11) NOT NULL DEFAULT '0',
  `lock_version` int(11) NOT NULL DEFAULT '0',
  `created_on` datetime DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `done_ratio` int(11) NOT NULL DEFAULT '0',
  `estimated_hours` float DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `root_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `issues_project_id` (`project_id`),
  KEY `index_issues_on_status_id` (`status_id`),
  KEY `index_issues_on_category_id` (`category_id`),
  KEY `index_issues_on_assigned_to_id` (`assigned_to_id`),
  KEY `index_issues_on_fixed_version_id` (`fixed_version_id`),
  KEY `index_issues_on_tracker_id` (`tracker_id`),
  KEY `index_issues_on_priority_id` (`priority_id`),
  KEY `index_issues_on_author_id` (`author_id`),
  KEY `index_issues_on_created_on` (`created_on`),
  KEY `index_issues_on_root_id_and_lft_and_rgt` (`root_id`,`lft`,`rgt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `issues`
--

/*!40000 ALTER TABLE `issues` DISABLE KEYS */;
/*!40000 ALTER TABLE `issues` ENABLE KEYS */;


--
-- Definition of table `journal_details`
--

DROP TABLE IF EXISTS `journal_details`;
CREATE TABLE `journal_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journal_id` int(11) NOT NULL DEFAULT '0',
  `property` varchar(30) NOT NULL DEFAULT '',
  `prop_key` varchar(30) NOT NULL DEFAULT '',
  `old_value` text,
  `value` text,
  PRIMARY KEY (`id`),
  KEY `journal_details_journal_id` (`journal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `journal_details`
--

/*!40000 ALTER TABLE `journal_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `journal_details` ENABLE KEYS */;


--
-- Definition of table `journals`
--

DROP TABLE IF EXISTS `journals`;
CREATE TABLE `journals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journalized_id` int(11) NOT NULL DEFAULT '0',
  `journalized_type` varchar(30) NOT NULL DEFAULT '',
  `user_id` int(11) NOT NULL DEFAULT '0',
  `notes` text,
  `created_on` datetime NOT NULL,
  `private_notes` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `journals_journalized_id` (`journalized_id`,`journalized_type`),
  KEY `index_journals_on_user_id` (`user_id`),
  KEY `index_journals_on_journalized_id` (`journalized_id`),
  KEY `index_journals_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `journals`
--

/*!40000 ALTER TABLE `journals` DISABLE KEYS */;
/*!40000 ALTER TABLE `journals` ENABLE KEYS */;


--
-- Definition of table `member_roles`
--

DROP TABLE IF EXISTS `member_roles`;
CREATE TABLE `member_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `inherited_from` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_member_roles_on_member_id` (`member_id`),
  KEY `index_member_roles_on_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `member_roles`
--

/*!40000 ALTER TABLE `member_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_roles` ENABLE KEYS */;


--
-- Definition of table `members`
--

DROP TABLE IF EXISTS `members`;
CREATE TABLE `members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `project_id` int(11) NOT NULL DEFAULT '0',
  `created_on` datetime DEFAULT NULL,
  `mail_notification` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_members_on_user_id_and_project_id` (`user_id`,`project_id`),
  KEY `index_members_on_user_id` (`user_id`),
  KEY `index_members_on_project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `members`
--

/*!40000 ALTER TABLE `members` DISABLE KEYS */;
/*!40000 ALTER TABLE `members` ENABLE KEYS */;


--
-- Definition of table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `board_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `content` text,
  `author_id` int(11) DEFAULT NULL,
  `replies_count` int(11) NOT NULL DEFAULT '0',
  `last_reply_id` int(11) DEFAULT NULL,
  `created_on` datetime NOT NULL,
  `updated_on` datetime NOT NULL,
  `locked` tinyint(1) DEFAULT '0',
  `sticky` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `messages_board_id` (`board_id`),
  KEY `messages_parent_id` (`parent_id`),
  KEY `index_messages_on_last_reply_id` (`last_reply_id`),
  KEY `index_messages_on_author_id` (`author_id`),
  KEY `index_messages_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `messages`
--

/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;


--
-- Definition of table `news`
--

DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL,
  `title` varchar(60) NOT NULL DEFAULT '',
  `summary` varchar(255) DEFAULT '',
  `description` text,
  `author_id` int(11) NOT NULL DEFAULT '0',
  `created_on` datetime DEFAULT NULL,
  `comments_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `news_project_id` (`project_id`),
  KEY `index_news_on_author_id` (`author_id`),
  KEY `index_news_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `news`
--

/*!40000 ALTER TABLE `news` DISABLE KEYS */;
/*!40000 ALTER TABLE `news` ENABLE KEYS */;


--
-- Definition of table `open_id_authentication_associations`
--

DROP TABLE IF EXISTS `open_id_authentication_associations`;
CREATE TABLE `open_id_authentication_associations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issued` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `handle` varchar(255) DEFAULT NULL,
  `assoc_type` varchar(255) DEFAULT NULL,
  `server_url` blob,
  `secret` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `open_id_authentication_associations`
--

/*!40000 ALTER TABLE `open_id_authentication_associations` DISABLE KEYS */;
/*!40000 ALTER TABLE `open_id_authentication_associations` ENABLE KEYS */;


--
-- Definition of table `open_id_authentication_nonces`
--

DROP TABLE IF EXISTS `open_id_authentication_nonces`;
CREATE TABLE `open_id_authentication_nonces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` int(11) NOT NULL,
  `server_url` varchar(255) DEFAULT NULL,
  `salt` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `open_id_authentication_nonces`
--

/*!40000 ALTER TABLE `open_id_authentication_nonces` DISABLE KEYS */;
/*!40000 ALTER TABLE `open_id_authentication_nonces` ENABLE KEYS */;


--
-- Definition of table `projects`
--

DROP TABLE IF EXISTS `projects`;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `homepage` varchar(255) DEFAULT '',
  `is_public` tinyint(1) NOT NULL DEFAULT '1',
  `parent_id` int(11) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_projects_on_lft` (`lft`),
  KEY `index_projects_on_rgt` (`rgt`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `projects`
--

/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` (`id`,`name`,`description`,`homepage`,`is_public`,`parent_id`,`created_on`,`updated_on`,`identifier`,`status`,`lft`,`rgt`) VALUES 
  (6,'Template - Fix Bid with All Quality Parameter','','',0,NULL,'2014-03-27 12:35:21','2014-03-27 12:35:21','temp_fixbid_capa',1,1,2);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;


--
-- Definition of table `projects_trackers`
--

DROP TABLE IF EXISTS `projects_trackers`;
CREATE TABLE `projects_trackers` (
  `project_id` int(11) NOT NULL DEFAULT '0',
  `tracker_id` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `projects_trackers_unique` (`project_id`,`tracker_id`),
  KEY `projects_trackers_project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `projects_trackers`
--

/*!40000 ALTER TABLE `projects_trackers` DISABLE KEYS */;
INSERT INTO `projects_trackers` (`project_id`,`tracker_id`) VALUES 
  (6,1);
INSERT INTO `projects_trackers` (`project_id`,`tracker_id`) VALUES 
  (6,4);
INSERT INTO `projects_trackers` (`project_id`,`tracker_id`) VALUES 
  (6,8);
INSERT INTO `projects_trackers` (`project_id`,`tracker_id`) VALUES 
  (6,9);
INSERT INTO `projects_trackers` (`project_id`,`tracker_id`) VALUES 
  (6,14);
/*!40000 ALTER TABLE `projects_trackers` ENABLE KEYS */;


--
-- Definition of table `queries`
--

DROP TABLE IF EXISTS `queries`;
CREATE TABLE `queries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `filters` text,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `column_names` text,
  `sort_criteria` text,
  `group_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_queries_on_project_id` (`project_id`),
  KEY `index_queries_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `queries`
--

/*!40000 ALTER TABLE `queries` DISABLE KEYS */;
/*!40000 ALTER TABLE `queries` ENABLE KEYS */;


--
-- Definition of table `repositories`
--

DROP TABLE IF EXISTS `repositories`;
CREATE TABLE `repositories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  `login` varchar(60) DEFAULT '',
  `password` varchar(255) DEFAULT '',
  `root_url` varchar(255) DEFAULT '',
  `type` varchar(255) DEFAULT NULL,
  `path_encoding` varchar(64) DEFAULT NULL,
  `log_encoding` varchar(64) DEFAULT NULL,
  `extra_info` text,
  `identifier` varchar(255) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_repositories_on_project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `repositories`
--

/*!40000 ALTER TABLE `repositories` DISABLE KEYS */;
/*!40000 ALTER TABLE `repositories` ENABLE KEYS */;


--
-- Definition of table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `position` int(11) DEFAULT '1',
  `assignable` tinyint(1) DEFAULT '1',
  `builtin` int(11) NOT NULL DEFAULT '0',
  `permissions` text,
  `issues_visibility` varchar(30) NOT NULL DEFAULT 'default',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `roles`
--

/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`,`name`,`position`,`assignable`,`builtin`,`permissions`,`issues_visibility`) VALUES 
  (1,'Non member',1,1,1,'--- \n- :add_messages\n- :view_calendar\n- :view_documents\n- :view_files\n- :view_gantt\n- :view_issues\n- :add_issues\n- :add_issue_notes\n- :save_queries\n- :comment_news\n- :browse_repository\n- :view_changesets\n- :view_time_entries\n- :view_wiki_pages\n- :view_wiki_edits\n','default');
INSERT INTO `roles` (`id`,`name`,`position`,`assignable`,`builtin`,`permissions`,`issues_visibility`) VALUES 
  (2,'Anonymous',2,1,2,'--- \n- :view_calendar\n- :view_documents\n- :view_files\n- :view_gantt\n- :view_issues\n- :browse_repository\n- :view_changesets\n- :view_time_entries\n- :view_wiki_pages\n- :view_wiki_edits\n','default');
INSERT INTO `roles` (`id`,`name`,`position`,`assignable`,`builtin`,`permissions`,`issues_visibility`) VALUES 
  (3,'Manager',3,1,0,'--- \n- :add_project\n- :edit_project\n- :close_project\n- :select_project_modules\n- :manage_members\n- :manage_versions\n- :add_subprojects\n- :manage_boards\n- :add_messages\n- :edit_messages\n- :edit_own_messages\n- :delete_messages\n- :delete_own_messages\n- :view_calendar\n- :view_code_review\n- :add_code_review\n- :edit_code_review\n- :delete_code_review\n- :assign_code_review\n- :code_review_setting\n- :manage_documents\n- :view_documents\n- :manage_files\n- :view_files\n- :manage_categories\n- :view_issues\n- :add_issues\n- :edit_issues\n- :manage_issue_relations\n- :manage_subtasks\n- :set_issues_private\n- :set_own_issues_private\n- :add_issue_notes\n- :edit_issue_notes\n- :edit_own_issue_notes\n- :view_private_notes\n- :set_notes_private\n- :move_issues\n- :delete_issues\n- :manage_public_queries\n- :save_queries\n- :view_issue_watchers\n- :add_issue_watchers\n- :delete_issue_watchers\n- :manage_news\n- :comment_news\n- :manage_repository\n- :browse_repository\n- :view_changesets\n- :commit_access\n- :manage_related_issues\n- :log_time\n- :view_time_entries\n- :edit_time_entries\n- :edit_own_time_entries\n- :manage_project_activities\n- :manage_wiki\n- :rename_wiki_pages\n- :delete_wiki_pages\n- :view_wiki_pages\n- :export_wiki_pages\n- :view_wiki_edits\n- :edit_wiki_pages\n- :delete_wiki_pages_attachments\n- :protect_wiki_pages\n- :view_work_time_tab\n- :view_work_time_other_member\n- :edit_work_time_total\n','all');
INSERT INTO `roles` (`id`,`name`,`position`,`assignable`,`builtin`,`permissions`,`issues_visibility`) VALUES 
  (4,'Developer',4,1,0,'--- \n- :add_messages\n- :edit_messages\n- :edit_own_messages\n- :delete_own_messages\n- :view_calendar\n- :view_code_review\n- :add_code_review\n- :edit_code_review\n- :delete_code_review\n- :assign_code_review\n- :view_documents\n- :manage_files\n- :view_files\n- :view_gantt\n- :view_issues\n- :add_issues\n- :edit_issues\n- :manage_issue_relations\n- :manage_subtasks\n- :set_own_issues_private\n- :add_issue_notes\n- :edit_issue_notes\n- :edit_own_issue_notes\n- :view_private_notes\n- :set_notes_private\n- :delete_issues\n- :save_queries\n- :view_issue_watchers\n- :add_issue_watchers\n- :delete_issue_watchers\n- :comment_news\n- :browse_repository\n- :view_changesets\n- :commit_access\n- :manage_related_issues\n- :log_time\n- :view_time_entries\n- :edit_own_time_entries\n- :view_wiki_pages\n- :export_wiki_pages\n- :view_wiki_edits\n- :edit_wiki_pages\n- :delete_wiki_pages_attachments\n- :view_work_time_tab\n- :view_work_time_other_member\n- :edit_work_time_total\n','all');
INSERT INTO `roles` (`id`,`name`,`position`,`assignable`,`builtin`,`permissions`,`issues_visibility`) VALUES 
  (5,'Reporter',5,1,0,'--- \n- :add_messages\n- :edit_own_messages\n- :view_calendar\n- :view_code_review\n- :view_documents\n- :view_files\n- :view_gantt\n- :view_issues\n- :add_issues\n- :add_issue_notes\n- :save_queries\n- :comment_news\n- :browse_repository\n- :view_changesets\n- :log_time\n- :view_time_entries\n- :view_wiki_pages\n- :view_wiki_edits\n','default');
INSERT INTO `roles` (`id`,`name`,`position`,`assignable`,`builtin`,`permissions`,`issues_visibility`) VALUES 
  (7,'Translator',6,1,0,'--- \n- :manage_versions\n- :add_messages\n- :view_calendar\n- :view_code_review\n- :add_code_review\n- :edit_code_review\n- :delete_code_review\n- :assign_code_review\n- :code_review_setting\n- :view_documents\n- :view_files\n- :view_gantt\n- :manage_categories\n- :view_issues\n- :add_issues\n- :edit_issues\n- :manage_issue_relations\n- :manage_subtasks\n- :set_own_issues_private\n- :add_issue_notes\n- :edit_issue_notes\n- :edit_own_issue_notes\n- :view_private_notes\n- :set_notes_private\n- :delete_issues\n- :manage_public_queries\n- :save_queries\n- :view_issue_watchers\n- :add_issue_watchers\n- :delete_issue_watchers\n- :comment_news\n- :browse_repository\n- :view_changesets\n- :commit_access\n- :manage_related_issues\n- :log_time\n- :view_time_entries\n- :edit_own_time_entries\n- :view_wiki_pages\n- :view_wiki_edits\n- :view_work_time_tab\n- :view_work_time_other_member\n- :edit_work_time_total\n','all');
INSERT INTO `roles` (`id`,`name`,`position`,`assignable`,`builtin`,`permissions`,`issues_visibility`) VALUES 
  (8,'Customer',7,1,0,'--- \n- :add_project\n- :edit_project\n- :close_project\n- :select_project_modules\n- :manage_members\n- :manage_versions\n- :add_subprojects\n- :manage_boards\n- :add_messages\n- :edit_messages\n- :edit_own_messages\n- :delete_messages\n- :delete_own_messages\n- :view_calendar\n- :view_code_review\n- :add_code_review\n- :edit_code_review\n- :delete_code_review\n- :assign_code_review\n- :code_review_setting\n- :manage_documents\n- :view_documents\n- :manage_files\n- :view_files\n- :view_gantt\n- :manage_categories\n- :view_issues\n- :add_issues\n- :edit_issues\n- :manage_issue_relations\n- :manage_subtasks\n- :set_issues_private\n- :set_own_issues_private\n- :add_issue_notes\n- :edit_issue_notes\n- :edit_own_issue_notes\n- :move_issues\n- :delete_issues\n- :manage_public_queries\n- :save_queries\n- :view_issue_watchers\n- :add_issue_watchers\n- :delete_issue_watchers\n- :manage_news\n- :comment_news\n- :manage_repository\n- :browse_repository\n- :view_changesets\n- :commit_access\n- :manage_related_issues\n- :log_time\n- :view_time_entries\n- :edit_time_entries\n- :edit_own_time_entries\n- :manage_wiki\n- :rename_wiki_pages\n- :delete_wiki_pages\n- :view_wiki_pages\n- :export_wiki_pages\n- :view_wiki_edits\n- :edit_wiki_pages\n- :delete_wiki_pages_attachments\n- :protect_wiki_pages\n- :view_work_time_tab\n- :view_work_time_other_member\n- :edit_work_time_total\n','all');
INSERT INTO `roles` (`id`,`name`,`position`,`assignable`,`builtin`,`permissions`,`issues_visibility`) VALUES 
  (9,'Leader',8,1,0,'--- \n- :add_messages\n- :view_calendar\n- :view_code_review\n- :add_code_review\n- :edit_code_review\n- :delete_code_review\n- :assign_code_review\n- :code_review_setting\n- :view_documents\n- :view_files\n- :view_gantt\n- :manage_categories\n- :view_issues\n- :add_issues\n- :edit_issues\n- :manage_issue_relations\n- :manage_subtasks\n- :set_own_issues_private\n- :add_issue_notes\n- :edit_own_issue_notes\n- :view_private_notes\n- :set_notes_private\n- :move_issues\n- :delete_issues\n- :manage_public_queries\n- :save_queries\n- :view_issue_watchers\n- :add_issue_watchers\n- :delete_issue_watchers\n- :comment_news\n- :browse_repository\n- :view_changesets\n- :commit_access\n- :manage_related_issues\n- :log_time\n- :view_time_entries\n- :edit_time_entries\n- :edit_own_time_entries\n- :manage_project_activities\n- :manage_wiki\n- :rename_wiki_pages\n- :delete_wiki_pages\n- :view_wiki_pages\n- :export_wiki_pages\n- :view_wiki_edits\n- :edit_wiki_pages\n- :delete_wiki_pages_attachments\n- :protect_wiki_pages\n- :view_work_time_tab\n- :view_work_time_other_member\n- :edit_work_time_total\n','default');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;


--
-- Definition of table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `schema_migrations`
--

/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('1');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('1-advanced_roadmap');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('1-redmine_importer');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('1-redmine_work_time');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('10');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('100');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('101');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('102');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('103');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('104');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('105');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('106');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('107');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('108');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('11');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('12');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('13');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('14');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('15');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('16');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('17');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('18');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('19');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('2');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('2-advanced_roadmap');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('2-redmine_work_time');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20090214190337');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20090312172426');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20090312194159');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20090318181151');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20090323224724');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20090401221305');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20090401231134');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20090403001910');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20090406161854');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20090425161243');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20090503121501');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20090503121505');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20090503121510');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20090614091200');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20090704172350');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20090704172355');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20090704172358');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091010093521');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017212227');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017212457');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017212644');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017212938');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017213027');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017213113');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017213151');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017213228');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017213257');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017213332');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017213444');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017213536');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017213642');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017213716');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017213757');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017213835');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017213910');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017214015');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017214107');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017214136');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017214236');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017214308');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017214336');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017214406');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017214440');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017214519');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017214611');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017214644');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017214720');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091017214750');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091025163651');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091108092559');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091114105931');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091123212029');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091205124427');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091220183509');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091220183727');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091220184736');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091225164732');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20091227112908');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20100129193402');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20100129193813');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20100221100219');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20100313132032');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20100313171051');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20100705164950');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20100819172912');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20101104182107');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20101107130441');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20101114115114');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20101114115359');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110220160626');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110223180944');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110223180953');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110224000000');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110226120112');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110226120132');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110227125750');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110228000000');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110228000100');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110401192910');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110408103312');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110412065600');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110511000000');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110902000000');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110908142214-redmine_multi_calendar');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110908142337-redmine_multi_calendar');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110908142436-redmine_multi_calendar');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110908142502-redmine_multi_calendar');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20110908142531-redmine_multi_calendar');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20111011092201-redmine_impasse');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20111011092256-redmine_impasse');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20111011092515-redmine_impasse');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20111011092621-redmine_impasse');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20111011093032-redmine_impasse');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20111011093136-redmine_impasse');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20111018002623-redmine_impasse');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20111018002749-redmine_impasse');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20111019005654-redmine_impasse');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20111109000327-redmine_impasse');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20111201201315');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20120115143024');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20120115143100');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20120115143126');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20120127174243');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20120205111326');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20120223110929');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20120301153455');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20120330143309-redmine_multi_calendar');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20120503143839-redmine_impasse');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20120503145318-redmine_impasse');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20120813094639-redmine_impasse');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20120813214500-redmine_impasse');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20120823115000-redmine_impasse');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20120823115100-redmine_impasse');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('20120823213100-redmine_impasse');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('21');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('22');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('23');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('24');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('25');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('26');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('27');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('28');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('29');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('3');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('3-redmine_work_time');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('30');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('31');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('32');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('33');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('34');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('35');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('36');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('37');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('38');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('39');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('4');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('4-redmine_work_time');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('40');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('41');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('42');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('43');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('44');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('45');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('46');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('47');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('48');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('49');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('5');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('5-redmine_work_time');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('50');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('51');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('52');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('53');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('54');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('55');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('56');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('57');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('58');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('59');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('6');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('6-redmine_work_time');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('60');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('61');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('62');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('63');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('64');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('65');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('66');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('67');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('68');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('69');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('7');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('7-redmine_work_time');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('70');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('71');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('72');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('73');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('74');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('75');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('76');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('77');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('78');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('79');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('8');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('8-redmine_work_time');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('80');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('81');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('82');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('83');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('84');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('85');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('86');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('87');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('88');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('89');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('9');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('9-redmine_work_time');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('90');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('91');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('92');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('93');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('94');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('95');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('96');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('97');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('98');
INSERT INTO `schema_migrations` (`version`) VALUES 
  ('99');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;


--
-- Definition of table `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_settings_on_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `settings`
--

/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (1,'welcome_text','','2013-07-15 16:28:19');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (2,'app_title','Redmine - <Project Name / Org Name>','2014-03-27 15:06:45');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (3,'activity_days_default','30','2012-11-29 11:38:02');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (4,'host_name','10.0.1.119','2013-07-18 12:18:01');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (5,'per_page_options','100,150,200','2014-01-15 17:56:20');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (6,'attachment_max_size','15120','2013-06-17 10:12:36');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (7,'feeds_limit','15','2012-11-29 11:38:02');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (8,'diff_max_lines_displayed','1500','2012-11-29 11:38:03');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (9,'wiki_compression','','2012-11-29 11:38:03');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (10,'protocol','http','2013-07-15 16:25:47');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (11,'cache_formatted_text','0','2012-11-29 11:38:03');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (12,'repositories_encodings','','2012-11-29 11:38:03');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (13,'file_max_size_displayed','512','2012-11-29 11:38:03');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (14,'text_formatting','textile','2012-11-29 11:38:03');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (15,'user_format','firstname_lastname','2012-11-29 11:38:43');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (16,'start_of_week','1','2012-11-29 11:38:43');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (17,'date_format','%d %B %Y','2012-11-29 11:38:43');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (18,'gravatar_default','monsterid','2012-11-29 11:38:43');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (19,'ui_theme','classic','2012-11-29 11:38:56');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (20,'gravatar_enabled','0','2012-11-29 11:38:43');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (21,'default_language','en','2012-11-29 11:38:43');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (22,'time_format','%I:%M %p','2012-11-29 11:38:43');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (23,'default_projects_public','0','2013-07-26 17:29:00');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (24,'sequential_project_identifiers','1','2014-03-27 15:12:51');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (25,'default_projects_modules','--- \n- issue_tracking\n- time_tracking\n- news\n- documents\n- files\n- wiki\n- repository\n- boards\n- calendar\n- gantt\n- code_review\n- importer\n- work_time\n','2014-03-27 15:06:55');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (26,'issues_export_limit','1000','2013-06-17 10:12:55');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (27,'issue_group_assignment','1','2012-12-11 06:12:22');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (28,'issue_list_default_columns','--- \n- status\n- subject\n- assigned_to\n- fixed_version\n- due_date\n- estimated_hours\n- spent_hours\n- done_ratio\n- cf_34\n- author\n','2014-01-17 18:33:35');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (29,'display_subprojects_issues','1','2012-11-29 11:40:27');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (30,'issue_done_ratio','issue_field','2014-03-27 15:19:12');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (31,'default_issue_start_date_to_creation_date','1','2012-11-29 11:40:27');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (32,'cross_project_issue_relations','1','2012-12-11 06:12:22');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (33,'gantt_items_limit','500','2012-11-29 11:40:27');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (34,'emails_footer','Regards\r\nRedmine - Project Admin, \r\n-------------------------------------------------\r\nThis is system genrated mail, please do not reply\r\n-------------------------------------------------\r\n','2014-04-18 16:53:40');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (35,'default_notification_option','only_my_events','2013-03-14 05:41:14');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (36,'notified_events','--- \n- issue_added\n- issue_updated\n- issue_note_added\n- issue_status_updated\n- issue_priority_updated\n- news_added\n- news_comment_added\n- document_added\n- file_added\n- message_posted\n- wiki_content_added\n- wiki_content_updated\n','2012-12-10 12:16:27');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (37,'mail_from','Admin-Redmine-NoReply@nttdata.com','2013-11-20 11:22:20');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (38,'bcc_recipients','1','2012-11-29 11:41:13');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (39,'plain_text_mail','0','2012-11-29 11:41:13');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (40,'emails_header','','2013-07-18 12:25:43');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (41,'commit_ref_keywords','refs,references,IssueID','2012-11-29 11:41:25');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (42,'sys_api_enabled','0','2012-11-29 11:41:25');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (43,'enabled_scm','--- \n- Subversion\n- Git\n','2013-07-15 16:24:01');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (44,'repository_log_display_limit','100','2012-11-29 11:41:25');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (45,'commit_fix_status_id','0','2012-11-29 11:41:25');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (46,'autofetch_changesets','1','2012-11-29 11:41:25');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (47,'commit_logtime_enabled','0','2012-11-29 11:41:25');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (48,'commit_fix_done_ratio','100','2012-11-29 11:41:25');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (49,'commit_cross_project_ref','0','2012-11-29 11:41:25');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (50,'commit_fix_keywords','fixes,closes','2012-11-29 11:41:25');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (51,'self_registration','2','2013-07-26 17:21:24');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (52,'autologin','0','2012-12-10 06:11:06');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (53,'session_lifetime','1440','2012-12-10 14:03:31');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (54,'rest_api_enabled','1','2012-12-11 08:59:06');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (55,'login_required','1','2012-12-10 14:03:31');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (56,'unsubscribe','0','2012-12-10 14:03:31');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (57,'lost_password','1','2012-12-10 06:11:06');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (58,'password_min_length','4','2012-12-10 06:11:06');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (59,'openid','0','2013-07-26 17:21:25');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (60,'session_timeout','0','2013-05-13 07:16:52');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (61,'plugin_advanced_roadmap','--- !map:HashWithIndifferentAccess \nratio_bad: \"1.2\"\nratio_good: \"0.8\"\ncolor_bad: orange\nsolved_issues_to_estimate: \"5\"\nparallel_effort_custom_field: \"8\"\nratio_very_bad: \"1.5\"\ncolor_very_bad: red\ncolor_good: green\n','2012-12-19 05:19:55');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (62,'cross_project_subtasks','tree','2014-01-17 17:47:34');
INSERT INTO `settings` (`id`,`name`,`value`,`updated_on`) VALUES 
  (63,'non_working_week_days','--- \n- \"6\"\n- \"7\"\n','2014-01-17 17:47:34');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;


--
-- Definition of table `time_entries`
--

DROP TABLE IF EXISTS `time_entries`;
CREATE TABLE `time_entries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `issue_id` int(11) DEFAULT NULL,
  `hours` float NOT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `activity_id` int(11) NOT NULL,
  `spent_on` date NOT NULL,
  `tyear` int(11) NOT NULL,
  `tmonth` int(11) NOT NULL,
  `tweek` int(11) NOT NULL,
  `created_on` datetime NOT NULL,
  `updated_on` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `time_entries_project_id` (`project_id`),
  KEY `time_entries_issue_id` (`issue_id`),
  KEY `index_time_entries_on_activity_id` (`activity_id`),
  KEY `index_time_entries_on_user_id` (`user_id`),
  KEY `index_time_entries_on_created_on` (`created_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `time_entries`
--

/*!40000 ALTER TABLE `time_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_entries` ENABLE KEYS */;


--
-- Definition of table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `action` varchar(30) NOT NULL DEFAULT '',
  `value` varchar(40) NOT NULL DEFAULT '',
  `created_on` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_tokens_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tokens`
--

/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` (`id`,`user_id`,`action`,`value`,`created_on`) VALUES 
  (87,61,'feeds','7a8e9f085ffa0fbdaef6e060e0a4a4b184299e0e','2013-11-08 18:26:17');
INSERT INTO `tokens` (`id`,`user_id`,`action`,`value`,`created_on`) VALUES 
  (234,1,'feeds','3b1509b3a5ee7dab8ab1f99c6698e472b9aa5203','2014-03-27 14:27:31');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;


--
-- Definition of table `trackers`
--

DROP TABLE IF EXISTS `trackers`;
CREATE TABLE `trackers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `is_in_chlog` tinyint(1) NOT NULL DEFAULT '0',
  `position` int(11) DEFAULT '1',
  `is_in_roadmap` tinyint(1) NOT NULL DEFAULT '1',
  `fields_bits` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `trackers`
--

/*!40000 ALTER TABLE `trackers` DISABLE KEYS */;
INSERT INTO `trackers` (`id`,`name`,`is_in_chlog`,`position`,`is_in_roadmap`,`fields_bits`) VALUES 
  (1,'Bug',1,1,0,0);
INSERT INTO `trackers` (`id`,`name`,`is_in_chlog`,`position`,`is_in_roadmap`,`fields_bits`) VALUES 
  (2,'Feature',1,2,1,0);
INSERT INTO `trackers` (`id`,`name`,`is_in_chlog`,`position`,`is_in_roadmap`,`fields_bits`) VALUES 
  (3,'Support',0,3,0,0);
INSERT INTO `trackers` (`id`,`name`,`is_in_chlog`,`position`,`is_in_roadmap`,`fields_bits`) VALUES 
  (4,'Tasks',0,4,1,0);
INSERT INTO `trackers` (`id`,`name`,`is_in_chlog`,`position`,`is_in_roadmap`,`fields_bits`) VALUES 
  (8,'Query',0,5,1,0);
INSERT INTO `trackers` (`id`,`name`,`is_in_chlog`,`position`,`is_in_roadmap`,`fields_bits`) VALUES 
  (9,'Review-Error',0,6,1,0);
INSERT INTO `trackers` (`id`,`name`,`is_in_chlog`,`position`,`is_in_roadmap`,`fields_bits`) VALUES 
  (10,'Machine',0,7,1,198);
INSERT INTO `trackers` (`id`,`name`,`is_in_chlog`,`position`,`is_in_roadmap`,`fields_bits`) VALUES 
  (11,'Software',0,8,1,134);
INSERT INTO `trackers` (`id`,`name`,`is_in_chlog`,`position`,`is_in_roadmap`,`fields_bits`) VALUES 
  (12,'Customer_Feedback',0,9,1,80);
INSERT INTO `trackers` (`id`,`name`,`is_in_chlog`,`position`,`is_in_roadmap`,`fields_bits`) VALUES 
  (14,'Change Request',0,10,1,0);
INSERT INTO `trackers` (`id`,`name`,`is_in_chlog`,`position`,`is_in_roadmap`,`fields_bits`) VALUES 
  (17,'Module',0,11,1,0);
/*!40000 ALTER TABLE `trackers` ENABLE KEYS */;


--
-- Definition of table `user_issue_months`
--

DROP TABLE IF EXISTS `user_issue_months`;
CREATE TABLE `user_issue_months` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `issue` int(11) DEFAULT NULL,
  `odr` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=617 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_issue_months`
--

/*!40000 ALTER TABLE `user_issue_months` DISABLE KEYS */;
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (1,3,5,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (2,3,3,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (3,1,13,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (4,16,26,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (13,17,16,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (14,17,23,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (26,30,54,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (33,30,47,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (34,30,65,3);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (50,30,69,4);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (54,32,30,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (55,31,30,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (58,20,81,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (59,30,30,5);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (71,34,59,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (73,34,35,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (74,34,33,3);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (75,30,110,6);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (76,30,111,7);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (77,34,29,4);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (82,20,120,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (84,34,116,5);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (86,27,105,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (87,27,107,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (96,27,108,3);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (102,22,126,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (111,30,96,8);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (113,28,119,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (114,30,48,9);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (119,34,111,6);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (121,24,136,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (128,21,102,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (131,28,82,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (133,20,141,3);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (134,35,93,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (136,30,66,10);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (139,27,146,4);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (149,26,30,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (150,24,103,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (152,27,145,5);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (153,30,28,11);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (158,21,30,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (159,38,30,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (163,30,27,12);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (165,27,151,6);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (168,24,121,3);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (173,27,179,7);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (174,32,161,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (206,28,178,3);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (207,28,226,4);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (209,30,263,13);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (223,30,484,14);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (229,28,229,5);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (241,30,524,15);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (242,30,525,16);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (243,30,526,17);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (244,30,527,18);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (245,30,528,19);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (246,38,474,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (247,30,538,20);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (248,30,540,21);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (251,30,485,22);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (253,28,560,6);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (255,26,532,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (257,24,517,4);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (259,27,194,8);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (267,32,479,3);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (274,24,632,5);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (275,24,635,6);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (281,26,628,3);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (283,30,644,23);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (296,28,656,7);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (300,26,672,4);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (305,28,675,8);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (312,26,24,5);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (319,38,98,3);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (322,26,697,6);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (323,26,699,7);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (324,26,698,8);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (325,34,306,7);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (326,34,689,8);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (329,26,703,9);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (330,27,135,9);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (334,41,721,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (335,26,706,10);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (336,35,30,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (337,26,712,11);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (339,26,724,12);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (341,27,684,10);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (348,26,733,13);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (355,22,735,3);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (356,26,750,14);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (372,26,776,15);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (374,24,736,7);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (383,22,786,4);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (384,35,715,3);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (389,23,30,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (396,22,30,5);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (398,27,804,11);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (399,24,30,9);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (404,26,817,16);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (405,28,818,9);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (407,15,827,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (408,15,831,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (409,15,830,3);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (415,32,768,4);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (416,35,841,4);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (418,24,854,10);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (423,22,860,6);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (424,27,833,12);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (425,28,819,10);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (427,27,859,13);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (431,24,856,11);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (432,24,857,12);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (435,26,840,17);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (436,41,884,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (440,24,891,13);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (442,35,879,5);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (443,24,895,14);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (445,41,877,3);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (452,41,792,4);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (453,22,904,7);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (455,26,905,18);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (456,41,910,5);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (461,35,916,6);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (463,41,759,6);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (467,21,945,3);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (468,24,952,15);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (470,24,950,16);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (471,24,948,17);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (472,24,947,18);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (473,28,936,11);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (476,26,976,19);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (477,24,967,19);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (478,24,965,20);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (479,24,978,21);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (481,37,885,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (483,21,951,4);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (484,24,959,22);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (487,28,937,12);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (489,24,986,23);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (491,41,989,7);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (492,15,885,4);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (493,36,885,1);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (495,26,994,20);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (496,24,996,24);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (497,21,969,5);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (498,35,828,7);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (499,35,829,8);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (501,35,1011,9);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (502,26,1009,21);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (504,41,1005,8);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (505,24,1060,25);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (506,41,1070,9);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (507,28,1062,13);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (508,23,106,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (509,35,1077,10);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (510,41,796,10);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (511,41,30,11);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (512,24,1084,8);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (513,22,1093,8);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (528,24,1161,26);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (531,23,1179,3);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (532,23,1180,4);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (535,23,1021,5);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (536,37,1192,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (537,35,1191,11);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (538,41,1171,12);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (539,41,1170,13);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (540,41,1181,14);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (541,41,1195,15);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (542,23,1198,6);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (547,23,1218,7);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (548,23,1219,8);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (549,23,1228,9);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (550,41,1232,16);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (551,26,968,22);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (552,26,1257,23);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (553,32,1074,5);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (556,23,1272,10);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (557,23,1269,11);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (558,23,1267,12);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (559,23,1268,13);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (560,37,1291,3);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (561,31,1290,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (562,31,1293,3);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (563,23,1298,14);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (564,23,1274,15);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (565,35,1329,12);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (566,41,1333,17);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (567,41,1323,18);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (568,23,1136,16);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (569,23,1137,17);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (570,23,1336,18);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (571,23,1337,19);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (573,23,1345,20);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (574,23,1346,21);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (579,23,1373,22);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (581,26,1409,24);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (582,41,1261,19);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (583,41,1326,20);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (584,41,1325,21);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (585,41,1230,22);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (586,22,1404,9);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (587,16,885,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (588,32,1476,6);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (589,26,130,25);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (590,26,1489,26);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (591,23,1493,23);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (592,23,1494,24);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (593,38,1489,4);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (596,23,1507,25);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (597,26,1507,27);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (598,22,1288,2);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (599,41,1479,23);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (600,41,1480,24);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (601,41,1481,25);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (602,41,1484,26);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (603,41,1486,27);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (604,31,1525,4);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (605,23,1528,26);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (606,23,1529,27);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (607,23,1530,28);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (608,23,1527,29);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (609,23,1537,30);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (610,23,1555,31);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (611,22,1557,10);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (612,15,1567,5);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (613,41,1574,28);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (614,37,1552,4);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (615,41,1587,29);
INSERT INTO `user_issue_months` (`id`,`uid`,`issue`,`odr`) VALUES 
  (616,32,1590,7);
/*!40000 ALTER TABLE `user_issue_months` ENABLE KEYS */;


--
-- Definition of table `user_preferences`
--

DROP TABLE IF EXISTS `user_preferences`;
CREATE TABLE `user_preferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `others` text,
  `hide_mail` tinyint(1) DEFAULT '0',
  `time_zone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_user_preferences_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_preferences`
--

/*!40000 ALTER TABLE `user_preferences` DISABLE KEYS */;
INSERT INTO `user_preferences` (`id`,`user_id`,`others`,`hide_mail`,`time_zone`) VALUES 
  (2,1,'--- \n:warn_on_leaving_unsaved: \"1\"\n:no_self_notified: false\n:gantt_zoom: 2\n:gantt_months: 6\n:comments_sorting: asc\n',0,'New Delhi');
INSERT INTO `user_preferences` (`id`,`user_id`,`others`,`hide_mail`,`time_zone`) VALUES 
  (53,61,'--- \n:comments_sorting: asc\n:no_self_notified: false\n:warn_on_leaving_unsaved: \"1\"\n',0,'Mumbai');
INSERT INTO `user_preferences` (`id`,`user_id`,`others`,`hide_mail`,`time_zone`) VALUES 
  (54,62,'--- \n:comments_sorting: asc\n:no_self_notified: false\n:warn_on_leaving_unsaved: \"1\"\n',0,'Tokyo');
/*!40000 ALTER TABLE `user_preferences` ENABLE KEYS */;


--
-- Definition of table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(255) NOT NULL DEFAULT '',
  `hashed_password` varchar(40) NOT NULL DEFAULT '',
  `firstname` varchar(30) NOT NULL DEFAULT '',
  `lastname` varchar(30) NOT NULL DEFAULT '',
  `mail` varchar(60) NOT NULL DEFAULT '',
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '1',
  `last_login_on` datetime DEFAULT NULL,
  `language` varchar(5) DEFAULT '',
  `auth_source_id` int(11) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `identity_url` varchar(255) DEFAULT NULL,
  `mail_notification` varchar(255) NOT NULL DEFAULT '',
  `salt` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_users_on_id_and_type` (`id`,`type`),
  KEY `index_users_on_auth_source_id` (`auth_source_id`),
  KEY `index_users_on_type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`,`login`,`hashed_password`,`firstname`,`lastname`,`mail`,`admin`,`status`,`last_login_on`,`language`,`auth_source_id`,`created_on`,`updated_on`,`type`,`identity_url`,`mail_notification`,`salt`) VALUES 
  (1,'admin','20a3d99c5a28643f0f2f399a3a9c94582636f8ae','Redmine','Admin','admin@example.com',1,1,'2014-04-18 14:29:30','en',NULL,'2013-05-01 13:37:47','2014-04-18 14:29:30','User',NULL,'all','JDCXbNyWWbWbwnio');
INSERT INTO `users` (`id`,`login`,`hashed_password`,`firstname`,`lastname`,`mail`,`admin`,`status`,`last_login_on`,`language`,`auth_source_id`,`created_on`,`updated_on`,`type`,`identity_url`,`mail_notification`,`salt`) VALUES 
  (2,'','','','Anonymous','',0,0,NULL,'',NULL,'2013-07-10 06:26:33','2013-07-10 06:26:33','AnonymousUser',NULL,'only_my_events',NULL);
INSERT INTO `users` (`id`,`login`,`hashed_password`,`firstname`,`lastname`,`mail`,`admin`,`status`,`last_login_on`,`language`,`auth_source_id`,`created_on`,`updated_on`,`type`,`identity_url`,`mail_notification`,`salt`) VALUES 
  (25,'','','','Developers','',0,1,NULL,'',NULL,'2012-12-11 05:21:31','2013-11-20 11:48:08','Group',NULL,'',NULL);
INSERT INTO `users` (`id`,`login`,`hashed_password`,`firstname`,`lastname`,`mail`,`admin`,`status`,`last_login_on`,`language`,`auth_source_id`,`created_on`,`updated_on`,`type`,`identity_url`,`mail_notification`,`salt`) VALUES 
  (29,'','','','Translation','',0,1,NULL,'',NULL,'2012-12-11 06:13:59','2013-11-20 11:49:14','Group',NULL,'',NULL);
INSERT INTO `users` (`id`,`login`,`hashed_password`,`firstname`,`lastname`,`mail`,`admin`,`status`,`last_login_on`,`language`,`auth_source_id`,`created_on`,`updated_on`,`type`,`identity_url`,`mail_notification`,`salt`) VALUES 
  (42,'','','','Manager','',0,1,NULL,'',NULL,'2012-12-14 05:59:53','2013-11-20 11:48:58','Group',NULL,'',NULL);
INSERT INTO `users` (`id`,`login`,`hashed_password`,`firstname`,`lastname`,`mail`,`admin`,`status`,`last_login_on`,`language`,`auth_source_id`,`created_on`,`updated_on`,`type`,`identity_url`,`mail_notification`,`salt`) VALUES 
  (45,'','','','Customer','',0,1,NULL,'',NULL,'2013-02-19 14:03:48','2013-11-20 11:48:13','Group',NULL,'',NULL);
INSERT INTO `users` (`id`,`login`,`hashed_password`,`firstname`,`lastname`,`mail`,`admin`,`status`,`last_login_on`,`language`,`auth_source_id`,`created_on`,`updated_on`,`type`,`identity_url`,`mail_notification`,`salt`) VALUES 
  (61,'inadmin','053a1180c45db7bbe996324f5037b26c51691e26','NTTD India','Admin','nttdin@nttdata.com',1,3,'2013-11-08 18:26:17','en',NULL,'2013-11-08 17:49:47','2014-03-27 14:23:38','User',NULL,'none','31d4172a406126915a13f5f26a649149');
INSERT INTO `users` (`id`,`login`,`hashed_password`,`firstname`,`lastname`,`mail`,`admin`,`status`,`last_login_on`,`language`,`auth_source_id`,`created_on`,`updated_on`,`type`,`identity_url`,`mail_notification`,`salt`) VALUES 
  (62,'jpadmin','8d66708d34bb62c1a77c72625b7ad1320476f7b4','NTTD Japan','Admin','nttdossjp@nttdata.com',1,3,NULL,'en',NULL,'2013-11-08 17:50:38','2014-03-27 14:23:40','User',NULL,'none','2950cfb1270459e9ff8cb61a4b1696bf');
INSERT INTO `users` (`id`,`login`,`hashed_password`,`firstname`,`lastname`,`mail`,`admin`,`status`,`last_login_on`,`language`,`auth_source_id`,`created_on`,`updated_on`,`type`,`identity_url`,`mail_notification`,`salt`) VALUES 
  (100,'','','','Leaders','',0,1,NULL,'',NULL,'2013-11-26 18:07:59','2013-11-26 18:07:59','Group',NULL,'',NULL);
INSERT INTO `users` (`id`,`login`,`hashed_password`,`firstname`,`lastname`,`mail`,`admin`,`status`,`last_login_on`,`language`,`auth_source_id`,`created_on`,`updated_on`,`type`,`identity_url`,`mail_notification`,`salt`) VALUES 
  (130,'','','','ServiceOwner','',0,1,NULL,'',NULL,'2014-01-27 10:47:35','2014-01-27 10:47:35','Group',NULL,'',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


--
-- Definition of table `versions`
--

DROP TABLE IF EXISTS `versions`;
CREATE TABLE `versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT '',
  `effective_date` date DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  `wiki_page_title` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'open',
  `sharing` varchar(255) NOT NULL DEFAULT 'none',
  PRIMARY KEY (`id`),
  KEY `versions_project_id` (`project_id`),
  KEY `index_versions_on_sharing` (`sharing`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `versions`
--

/*!40000 ALTER TABLE `versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `versions` ENABLE KEYS */;


--
-- Definition of table `watchers`
--

DROP TABLE IF EXISTS `watchers`;
CREATE TABLE `watchers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `watchable_type` varchar(255) NOT NULL DEFAULT '',
  `watchable_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `watchers_user_id_type` (`user_id`,`watchable_type`),
  KEY `index_watchers_on_user_id` (`user_id`),
  KEY `index_watchers_on_watchable_id_and_watchable_type` (`watchable_id`,`watchable_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `watchers`
--

/*!40000 ALTER TABLE `watchers` DISABLE KEYS */;
/*!40000 ALTER TABLE `watchers` ENABLE KEYS */;


--
-- Definition of table `wiki_content_versions`
--

DROP TABLE IF EXISTS `wiki_content_versions`;
CREATE TABLE `wiki_content_versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wiki_content_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `data` longblob,
  `compression` varchar(6) DEFAULT '',
  `comments` varchar(255) DEFAULT '',
  `updated_on` datetime NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `wiki_content_versions_wcid` (`wiki_content_id`),
  KEY `index_wiki_content_versions_on_updated_on` (`updated_on`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wiki_content_versions`
--

/*!40000 ALTER TABLE `wiki_content_versions` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_content_versions` ENABLE KEYS */;


--
-- Definition of table `wiki_contents`
--

DROP TABLE IF EXISTS `wiki_contents`;
CREATE TABLE `wiki_contents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` int(11) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `text` longtext,
  `comments` varchar(255) DEFAULT '',
  `updated_on` datetime NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `wiki_contents_page_id` (`page_id`),
  KEY `index_wiki_contents_on_author_id` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wiki_contents`
--

/*!40000 ALTER TABLE `wiki_contents` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_contents` ENABLE KEYS */;


--
-- Definition of table `wiki_pages`
--

DROP TABLE IF EXISTS `wiki_pages`;
CREATE TABLE `wiki_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wiki_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `created_on` datetime NOT NULL,
  `protected` tinyint(1) NOT NULL DEFAULT '0',
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wiki_pages_wiki_id_title` (`wiki_id`,`title`),
  KEY `index_wiki_pages_on_wiki_id` (`wiki_id`),
  KEY `index_wiki_pages_on_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wiki_pages`
--

/*!40000 ALTER TABLE `wiki_pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_pages` ENABLE KEYS */;


--
-- Definition of table `wiki_redirects`
--

DROP TABLE IF EXISTS `wiki_redirects`;
CREATE TABLE `wiki_redirects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wiki_id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `redirects_to` varchar(255) DEFAULT NULL,
  `created_on` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `wiki_redirects_wiki_id_title` (`wiki_id`,`title`),
  KEY `index_wiki_redirects_on_wiki_id` (`wiki_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wiki_redirects`
--

/*!40000 ALTER TABLE `wiki_redirects` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_redirects` ENABLE KEYS */;


--
-- Definition of table `wikis`
--

DROP TABLE IF EXISTS `wikis`;
CREATE TABLE `wikis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `start_page` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `wikis_project_id` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wikis`
--

/*!40000 ALTER TABLE `wikis` DISABLE KEYS */;
INSERT INTO `wikis` (`id`,`project_id`,`start_page`,`status`) VALUES 
  (6,6,'Wiki',1);
/*!40000 ALTER TABLE `wikis` ENABLE KEYS */;


--
-- Definition of table `workflows`
--

DROP TABLE IF EXISTS `workflows`;
CREATE TABLE `workflows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tracker_id` int(11) NOT NULL DEFAULT '0',
  `old_status_id` int(11) NOT NULL DEFAULT '0',
  `new_status_id` int(11) NOT NULL DEFAULT '0',
  `role_id` int(11) NOT NULL DEFAULT '0',
  `assignee` tinyint(1) NOT NULL DEFAULT '0',
  `author` tinyint(1) NOT NULL DEFAULT '0',
  `type` varchar(30) DEFAULT NULL,
  `field_name` varchar(30) DEFAULT NULL,
  `rule` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wkfs_role_tracker_old_status` (`role_id`,`tracker_id`,`old_status_id`),
  KEY `index_workflows_on_old_status_id` (`old_status_id`),
  KEY `index_workflows_on_role_id` (`role_id`),
  KEY `index_workflows_on_new_status_id` (`new_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7432 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `workflows`
--

/*!40000 ALTER TABLE `workflows` DISABLE KEYS */;
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (31,2,1,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (32,2,1,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (34,2,1,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (35,2,1,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (36,2,2,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (37,2,2,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (39,2,2,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (40,2,2,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (41,2,3,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (42,2,3,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (44,2,3,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (45,2,3,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (51,2,5,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (52,2,5,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (53,2,5,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (55,2,5,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (56,2,6,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (57,2,6,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (58,2,6,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (60,2,6,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (61,3,1,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (62,3,1,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (64,3,1,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (65,3,1,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (66,3,2,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (67,3,2,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (69,3,2,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (70,3,2,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (71,3,3,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (72,3,3,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (74,3,3,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (75,3,3,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (81,3,5,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (82,3,5,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (83,3,5,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (85,3,5,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (86,3,6,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (87,3,6,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (88,3,6,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (90,3,6,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (91,1,1,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (92,1,1,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (94,1,1,5,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (95,1,2,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (97,1,2,5,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (98,1,3,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (100,1,3,5,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (104,2,1,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (105,2,1,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (107,2,1,5,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (108,2,2,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (110,2,2,5,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (111,2,3,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (113,2,3,5,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (117,3,1,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (118,3,1,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (120,3,1,5,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (121,3,2,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (123,3,2,5,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (124,3,3,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (126,3,3,5,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (130,1,1,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (131,1,2,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (132,1,3,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (135,2,1,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (136,2,2,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (137,2,3,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (140,3,1,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (141,3,2,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (142,3,3,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (191,4,1,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (192,4,2,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (193,4,3,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (403,2,1,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (404,2,1,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (406,2,1,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (407,2,2,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (409,2,2,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (410,2,3,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (412,2,3,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (418,3,1,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (419,3,1,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (421,3,1,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (422,3,2,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (424,3,2,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (425,3,3,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (427,3,3,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (522,1,1,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (523,1,2,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (524,1,3,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (529,1,1,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (530,1,1,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (532,1,1,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (533,1,2,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (535,1,2,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (536,1,3,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (538,1,3,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (610,8,1,8,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (611,8,1,7,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (612,8,1,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (613,8,5,8,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (614,8,5,7,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (615,8,5,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (616,8,7,8,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (617,8,7,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (618,8,8,7,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (619,8,8,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (626,8,1,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (627,8,7,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (628,8,8,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (629,8,1,8,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (630,8,1,7,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (631,8,1,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (632,8,5,8,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (633,8,7,8,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (634,8,7,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (635,8,8,7,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (636,8,8,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (683,9,1,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (684,9,2,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (685,9,3,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (852,10,1,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (853,10,2,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (854,10,3,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (859,10,1,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (860,10,1,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (862,10,1,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (863,10,2,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (865,10,2,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (866,10,3,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (868,10,3,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (952,11,1,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (953,11,2,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (954,11,3,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (959,11,1,9,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (960,11,1,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (962,11,1,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (963,11,1,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (964,11,2,9,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (965,11,2,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (967,11,2,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (968,11,3,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (970,11,3,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (975,11,9,9,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1094,10,1,13,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1095,10,1,12,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1096,10,1,11,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1097,10,1,10,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1098,10,10,13,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1099,10,10,12,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1100,10,10,11,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1101,10,10,10,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1102,10,11,13,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1103,10,11,12,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1104,10,11,11,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1105,10,11,10,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1106,10,12,13,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1107,10,12,12,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1108,10,12,11,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1109,10,12,10,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1110,10,13,13,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1111,10,13,12,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1112,10,13,11,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1113,10,13,10,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1114,11,1,13,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1115,11,1,12,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1116,11,1,11,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1117,11,1,10,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1118,11,10,13,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1119,11,10,11,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1120,11,10,10,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1121,11,11,13,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1122,11,11,11,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1123,11,11,10,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1124,11,13,13,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1125,11,13,12,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1126,11,13,11,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1127,11,13,10,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1128,11,1,13,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1129,11,1,11,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1130,11,1,10,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1131,11,10,13,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1132,11,10,11,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1133,11,10,10,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1134,11,11,13,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1135,11,11,11,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1136,11,11,10,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1137,11,13,13,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1138,11,13,11,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1170,2,1,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1171,2,1,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1173,2,1,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1174,2,1,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1175,2,2,1,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1176,2,2,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1178,2,2,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1179,2,2,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1180,2,3,1,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1181,2,3,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1183,2,3,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1184,2,3,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1190,2,5,1,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1191,2,5,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1192,2,5,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1194,2,5,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1195,2,6,1,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1196,2,6,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1197,2,6,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1199,2,6,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1201,3,1,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1202,3,1,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1204,3,1,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1205,3,1,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1206,3,2,1,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1207,3,2,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1209,3,2,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1210,3,2,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1211,3,3,1,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1212,3,3,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1214,3,3,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1215,3,3,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1221,3,5,1,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1222,3,5,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1223,3,5,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1225,3,5,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1226,3,6,1,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1227,3,6,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1228,3,6,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1230,3,6,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1357,8,1,8,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1358,8,1,7,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1359,8,1,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1360,8,5,8,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1361,8,5,7,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1362,8,5,1,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1363,8,7,8,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1364,8,7,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1365,8,8,7,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1366,8,8,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1403,10,1,13,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1404,10,1,12,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1405,10,1,11,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1406,10,1,10,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1407,10,10,13,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1408,10,10,12,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1409,10,10,11,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1410,10,10,10,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1411,10,11,13,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1412,10,11,12,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1413,10,11,11,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1414,10,11,10,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1415,10,12,13,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1416,10,12,12,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1417,10,12,11,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1418,10,12,10,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1419,10,13,13,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1420,10,13,12,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1421,10,13,11,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1422,10,13,10,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1434,11,1,13,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1435,11,1,12,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1436,11,1,11,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1437,11,1,10,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1438,11,10,13,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1439,11,10,11,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1440,11,10,10,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1441,11,11,13,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1442,11,11,11,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1443,11,11,10,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1444,11,13,13,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1445,11,13,12,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1446,11,13,11,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1447,11,13,10,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1448,10,1,13,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1449,10,1,11,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1450,10,1,10,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1451,10,10,13,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1452,10,10,11,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1453,10,10,10,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1454,10,11,13,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1455,10,11,11,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1456,10,11,10,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1457,10,13,13,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (1458,10,13,11,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2301,4,14,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2303,4,14,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2304,4,14,1,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2305,4,1,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2306,4,1,9,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2307,4,1,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2309,4,1,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2310,4,1,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2311,4,2,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2312,4,2,9,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2313,4,2,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2315,4,2,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2316,4,3,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2317,4,3,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2319,4,3,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2324,4,9,9,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2325,4,9,8,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (2326,4,9,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3010,3,14,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3011,3,14,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3012,3,14,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3013,3,14,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3014,3,14,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3015,3,14,1,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3016,3,15,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3017,3,1,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3018,3,1,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3019,3,1,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3020,3,1,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3021,3,1,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3022,3,1,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3023,3,2,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3024,3,2,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3025,3,2,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3026,3,2,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3027,3,2,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3028,3,3,15,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3029,3,3,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3030,3,3,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3031,3,3,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3032,3,6,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3033,3,6,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3034,3,6,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3035,3,6,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3036,3,8,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3037,3,8,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3038,3,8,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3039,3,8,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3040,3,9,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3041,3,9,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3042,3,9,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3043,3,5,8,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3552,3,14,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3553,3,14,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3554,3,14,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3555,3,14,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3556,3,14,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3557,3,14,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3558,3,14,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3559,3,15,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3560,3,1,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3561,3,1,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3562,3,1,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3563,3,1,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3564,3,1,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3565,3,1,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3566,3,2,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3567,3,2,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3568,3,2,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3569,3,2,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3570,3,2,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3571,3,3,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3572,3,3,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3573,3,3,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3574,3,3,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3575,3,5,8,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3576,3,6,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3577,3,6,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3578,3,6,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3579,3,6,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3580,3,6,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3581,3,8,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3582,3,9,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3583,3,9,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3584,3,9,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3585,3,9,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3649,4,1,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3650,4,1,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3651,4,1,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3652,4,1,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3653,4,1,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3654,4,1,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3655,4,2,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3656,4,2,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3657,4,2,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3658,4,2,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3659,4,2,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3660,4,3,15,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3661,4,3,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3662,4,3,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3663,4,3,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3664,4,5,8,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3665,4,6,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3666,4,6,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3667,4,6,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3668,4,6,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3669,4,6,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3670,4,8,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3671,4,9,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3672,4,9,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3673,4,9,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3674,4,9,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3675,4,14,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3676,4,14,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3677,4,14,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3678,4,14,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3679,4,14,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3680,4,14,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3681,4,14,1,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3682,4,15,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3964,9,1,15,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3965,9,1,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3966,9,1,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3967,9,1,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3968,9,1,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3969,9,1,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3970,9,1,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3971,9,2,15,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3972,9,2,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3973,9,2,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3974,9,2,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3975,9,2,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3976,9,2,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3977,9,3,15,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3978,9,3,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3979,9,3,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3980,9,3,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3981,9,3,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3982,9,3,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3983,9,5,8,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3984,9,5,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3985,9,6,15,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3986,9,6,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3987,9,6,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3988,9,6,8,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3989,9,6,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3990,9,6,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3991,9,6,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3992,9,8,15,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3993,9,8,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3994,9,8,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3995,9,8,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3996,9,8,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3997,9,8,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3998,9,9,15,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (3999,9,9,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4000,9,9,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4001,9,9,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4002,9,9,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4003,9,14,15,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4004,9,14,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4005,9,14,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4006,9,14,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4007,9,14,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4008,9,14,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4009,9,14,1,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4010,9,15,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4027,9,1,15,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4028,9,1,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4029,9,1,6,7,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4030,9,1,5,7,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4031,9,1,9,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4032,9,1,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4033,9,1,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4034,9,2,15,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4035,9,2,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4036,9,2,9,7,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4037,9,2,5,7,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4038,9,2,6,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4039,9,2,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4040,9,3,15,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4041,9,3,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4042,9,3,6,7,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4043,9,3,5,7,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4044,9,3,9,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4045,9,3,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4046,9,5,8,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4047,9,6,15,7,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4048,9,6,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4049,9,6,5,7,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4050,9,6,9,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4051,9,6,8,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4052,9,6,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4053,9,6,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4054,9,8,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4055,9,9,15,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4056,9,9,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4057,9,9,5,7,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4058,9,9,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4059,9,9,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4060,9,14,15,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4061,9,14,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4062,9,14,5,7,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4063,9,14,9,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4064,9,14,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4065,9,14,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4066,9,14,1,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4067,9,15,5,7,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4090,8,1,8,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4091,8,1,7,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4092,8,7,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4093,8,7,8,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4094,8,8,7,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4095,8,8,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4152,1,14,16,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4153,1,14,15,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4154,1,14,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4155,1,14,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4156,1,14,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4157,1,14,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4158,1,14,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4159,1,14,1,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4160,1,15,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4161,1,16,17,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4162,1,17,8,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4163,1,1,16,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4164,1,1,15,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4165,1,1,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4166,1,1,6,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4167,1,1,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4168,1,1,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4169,1,1,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4170,1,1,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4171,1,2,16,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4172,1,2,15,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4173,1,2,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4174,1,2,9,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4175,1,2,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4176,1,2,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4177,1,2,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4178,1,3,15,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4179,1,3,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4180,1,3,6,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4181,1,3,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4182,1,3,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4183,1,3,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4184,1,5,8,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4185,1,6,15,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4186,1,6,16,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4187,1,6,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4188,1,6,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4189,1,6,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4190,1,6,8,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4191,1,6,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4192,1,6,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4193,1,8,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4194,1,9,16,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4195,1,9,15,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4196,1,9,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4197,1,9,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4198,1,9,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4199,1,9,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4323,4,1,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4324,4,1,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4325,4,1,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4326,4,1,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4327,4,1,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4328,4,1,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4329,4,2,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4330,4,2,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4331,4,2,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4332,4,2,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4333,4,2,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4334,4,3,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4335,4,3,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4336,4,3,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4337,4,3,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4338,4,5,8,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4339,4,6,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4340,4,6,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4341,4,6,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4342,4,6,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4343,4,6,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4344,4,8,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4345,4,9,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4346,4,9,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4347,4,9,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4348,4,9,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4349,4,9,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4350,4,14,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4351,4,14,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4352,4,14,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4353,4,14,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4354,4,14,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4355,4,14,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4356,4,14,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4357,4,15,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4358,4,1,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4359,4,1,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4360,4,1,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4361,4,1,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4362,4,1,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4363,4,1,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4364,4,2,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4365,4,2,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4366,4,2,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4367,4,2,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4368,4,2,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4369,4,3,5,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4370,4,3,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4371,4,3,15,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4372,4,3,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4373,4,6,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4374,4,6,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4375,4,6,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4376,4,6,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4377,4,8,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4378,4,8,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4379,4,8,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4380,4,8,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4381,4,9,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4382,4,9,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4383,4,9,1,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4384,4,9,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4385,4,5,8,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4386,4,14,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4387,4,14,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4388,4,14,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4389,4,14,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4390,4,14,1,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4391,4,14,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4392,4,15,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4393,14,1,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4394,14,1,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4395,14,1,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4396,14,1,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4397,14,1,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4398,14,1,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4399,14,2,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4400,14,2,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4401,14,2,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4402,14,2,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4403,14,2,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4404,14,3,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4405,14,3,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4406,14,3,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4407,14,3,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4408,14,5,8,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4409,14,6,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4410,14,6,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4411,14,6,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4412,14,6,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4413,14,6,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4414,14,8,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4415,14,9,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4416,14,9,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4417,14,9,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4418,14,9,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4419,14,9,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4420,14,14,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4421,14,14,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4422,14,14,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4423,14,14,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4424,14,14,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4425,14,14,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4426,14,14,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4427,14,15,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4456,14,1,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4457,14,1,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4458,14,1,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4459,14,1,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4460,14,1,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4461,14,1,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4462,14,2,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4463,14,2,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4464,14,2,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4465,14,2,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4466,14,2,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4467,14,3,5,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4468,14,3,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4469,14,3,15,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4470,14,3,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4471,14,5,8,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4472,14,6,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4473,14,6,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4474,14,6,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4475,14,6,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4476,14,8,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4477,14,8,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4478,14,8,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4479,14,8,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4480,14,9,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4481,14,9,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4482,14,9,1,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4483,14,9,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4484,14,14,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4485,14,14,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4486,14,14,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4487,14,14,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4488,14,14,1,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4489,14,14,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4490,14,15,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4519,14,1,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4520,14,2,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4521,14,3,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4526,14,1,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4527,14,1,9,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4528,14,1,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4530,14,1,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4531,14,1,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4532,14,2,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4533,14,2,9,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4534,14,2,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4536,14,2,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4537,14,3,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4538,14,3,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4540,14,3,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4545,14,9,9,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4546,14,9,8,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4547,14,9,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4548,14,14,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4550,14,14,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4551,14,14,1,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4557,14,1,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4558,14,1,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4559,14,1,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4560,14,1,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4561,14,1,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4562,14,1,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4563,14,2,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4564,14,2,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4565,14,2,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4566,14,2,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4567,14,2,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4568,14,3,15,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4569,14,3,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4570,14,3,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4571,14,3,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4572,14,5,8,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4573,14,6,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4574,14,6,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4575,14,6,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4576,14,6,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4577,14,6,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4578,14,8,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4579,14,9,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4580,14,9,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4581,14,9,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4582,14,9,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4583,14,14,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4584,14,14,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4585,14,14,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4586,14,14,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4587,14,14,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4588,14,14,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4589,14,14,1,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4590,14,15,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4591,12,1,8,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4592,12,1,7,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4593,12,7,8,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4594,12,7,7,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4595,12,8,8,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4596,12,8,7,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4597,12,1,8,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4598,12,8,8,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4599,12,1,8,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4600,12,8,8,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4601,12,1,8,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4602,12,1,7,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4603,12,7,8,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4604,12,7,7,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4605,12,8,8,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4606,12,8,7,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4657,9,15,17,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4658,9,15,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4659,9,14,17,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4660,9,14,16,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4661,9,14,15,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4662,9,14,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4663,9,14,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4664,9,14,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4665,9,14,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4666,9,14,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4667,9,14,1,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4668,9,9,17,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4669,9,9,16,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4670,9,9,15,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4671,9,9,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4672,9,9,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4673,9,9,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4674,9,9,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4675,9,8,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4676,9,6,17,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4677,9,6,15,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4678,9,6,16,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4679,9,6,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4680,9,6,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4681,9,6,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4682,9,6,8,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4683,9,6,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4684,9,6,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4685,9,5,8,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4686,9,3,17,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4687,9,3,16,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4688,9,3,15,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4689,9,3,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4690,9,3,6,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4691,9,3,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4692,9,3,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4693,9,3,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4694,9,2,17,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4695,9,2,16,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4696,9,2,15,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4697,9,2,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4698,9,2,9,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4699,9,2,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4700,9,2,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4701,9,2,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4702,9,1,17,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4703,9,1,16,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4704,9,1,15,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4705,9,1,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4706,9,1,6,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4707,9,1,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4708,9,1,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4709,9,1,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4710,9,1,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4711,9,15,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4712,9,14,17,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4713,9,14,16,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4714,9,14,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4715,9,14,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4716,9,14,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4717,9,14,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4718,9,14,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4719,9,14,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4720,9,14,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4721,9,9,17,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4722,9,9,16,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4723,9,9,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4724,9,9,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4725,9,9,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4726,9,9,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4727,9,9,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4728,9,8,17,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4729,9,8,16,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4730,9,8,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4731,9,8,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4732,9,8,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4733,9,8,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4734,9,8,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4735,9,8,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4736,9,6,17,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4737,9,6,16,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4738,9,6,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4739,9,6,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4740,9,6,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4741,9,6,8,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4742,9,6,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4743,9,6,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4744,9,6,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4745,9,5,17,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4746,9,5,8,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4747,9,5,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4748,9,3,17,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4749,9,3,16,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4750,9,3,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4751,9,3,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4752,9,3,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4753,9,3,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4754,9,3,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4755,9,3,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4756,9,2,17,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4757,9,2,16,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4758,9,2,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4759,9,2,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4760,9,2,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4761,9,2,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4762,9,2,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4763,9,2,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4764,9,1,17,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4765,9,1,16,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4766,9,1,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4767,9,1,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4768,9,1,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4769,9,1,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4770,9,1,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4771,9,1,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4772,9,1,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4773,1,15,17,8,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4774,1,15,5,8,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4775,1,14,17,8,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4776,1,14,16,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4777,1,14,15,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4778,1,14,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4779,1,14,5,8,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4780,1,14,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4781,1,14,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4782,1,14,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4783,1,14,1,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4784,1,9,16,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4785,1,9,15,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4786,1,9,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4787,1,9,5,8,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4788,1,9,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4789,1,9,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4790,1,8,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4791,1,6,17,8,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4792,1,6,15,8,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4793,1,6,16,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4794,1,6,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4795,1,6,5,8,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4796,1,6,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4797,1,6,8,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4798,1,6,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4799,1,6,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4800,1,5,8,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4801,1,3,17,8,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4802,1,3,16,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4803,1,3,15,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4804,1,3,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4805,1,3,6,8,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4806,1,3,5,8,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4807,1,3,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4808,1,3,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4809,1,2,17,8,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4810,1,2,16,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4811,1,2,15,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4812,1,2,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4813,1,2,9,8,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4814,1,2,5,8,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4815,1,2,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4816,1,2,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4817,1,1,17,8,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4818,1,1,16,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4819,1,1,15,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4820,1,1,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4821,1,1,6,8,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4822,1,1,5,8,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4823,1,1,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4824,1,1,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (4825,1,1,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5069,17,1,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5070,17,1,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5071,17,1,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5072,17,1,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5073,17,1,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5074,17,1,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5075,17,2,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5076,17,2,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5077,17,2,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5078,17,2,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5079,17,2,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5080,17,3,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5081,17,3,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5082,17,3,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5083,17,3,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5084,17,5,8,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5085,17,6,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5086,17,6,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5087,17,6,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5088,17,6,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5089,17,6,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5090,17,8,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5091,17,9,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5092,17,9,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5093,17,9,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5094,17,9,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5095,17,14,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5096,17,14,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5097,17,14,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5098,17,14,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5099,17,14,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5100,17,14,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5101,17,14,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5102,17,15,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5132,17,1,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5133,17,1,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5134,17,1,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5135,17,1,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5136,17,1,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5137,17,1,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5138,17,2,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5139,17,2,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5140,17,2,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5141,17,2,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5142,17,2,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5143,17,3,15,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5144,17,3,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5145,17,3,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5146,17,3,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5147,17,5,8,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5148,17,6,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5149,17,6,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5150,17,6,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5151,17,6,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5152,17,8,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5153,17,8,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5154,17,8,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5155,17,8,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5156,17,9,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5157,17,9,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5158,17,9,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5159,17,14,14,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5160,17,14,9,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5161,17,14,6,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5162,17,14,3,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5163,17,14,2,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5164,17,14,1,4,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5165,17,15,5,4,0,1,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5195,17,1,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5196,17,2,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5197,17,3,5,5,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5202,17,1,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5203,17,1,9,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5204,17,1,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5206,17,1,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5207,17,1,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5208,17,2,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5209,17,2,9,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5210,17,2,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5212,17,2,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5213,17,3,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5214,17,3,9,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5215,17,3,5,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5217,17,3,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5221,17,14,14,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5222,17,14,9,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5224,17,14,3,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5225,17,14,2,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5226,17,14,1,7,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5233,17,1,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5234,17,1,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5235,17,1,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5236,17,1,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5237,17,1,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5238,17,1,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5239,17,2,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5240,17,2,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5241,17,2,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5242,17,2,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5243,17,2,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5244,17,3,15,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5245,17,3,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5246,17,3,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5247,17,3,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5248,17,5,8,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5249,17,6,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5250,17,6,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5251,17,6,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5252,17,6,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5253,17,6,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5254,17,8,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5255,17,9,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5256,17,9,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5257,17,9,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5258,17,9,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5259,17,14,14,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5260,17,14,9,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5261,17,14,6,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5262,17,14,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5263,17,14,3,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5264,17,14,2,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5265,17,14,1,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (5266,17,15,5,8,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7355,1,17,8,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7356,1,16,8,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7357,1,15,17,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7358,1,15,16,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7359,1,15,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7360,1,14,16,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7361,1,14,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7362,1,14,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7363,1,14,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7364,1,14,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7365,1,14,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7366,1,14,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7367,1,14,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7368,1,9,16,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7369,1,9,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7370,1,9,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7371,1,9,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7372,1,9,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7373,1,9,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7374,1,8,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7375,1,8,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7376,1,8,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7377,1,8,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7378,1,8,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7379,1,8,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7380,1,6,16,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7381,1,6,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7382,1,6,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7383,1,6,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7384,1,6,8,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7385,1,6,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7387,1,6,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7388,1,6,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7389,1,6,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7390,1,5,8,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7391,1,5,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7392,1,5,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7394,1,5,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7395,1,5,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7396,1,5,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7403,1,3,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7404,1,3,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7405,1,3,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7406,1,3,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7407,1,3,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7409,1,3,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7410,1,3,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7411,1,3,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7412,1,2,16,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7413,1,2,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7414,1,2,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7415,1,2,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7416,1,2,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7417,1,2,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7419,1,2,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7420,1,2,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7421,1,2,1,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7422,1,1,17,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7423,1,1,16,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7424,1,1,15,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7425,1,1,14,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7426,1,1,9,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7427,1,1,6,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7428,1,1,5,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7429,1,1,3,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7430,1,1,2,3,0,0,'WorkflowTransition',NULL,NULL);
INSERT INTO `workflows` (`id`,`tracker_id`,`old_status_id`,`new_status_id`,`role_id`,`assignee`,`author`,`type`,`field_name`,`rule`) VALUES 
  (7431,1,1,1,3,0,0,'WorkflowTransition',NULL,NULL);
/*!40000 ALTER TABLE `workflows` ENABLE KEYS */;


--
-- Definition of table `wt_daily_memos`
--

DROP TABLE IF EXISTS `wt_daily_memos`;
CREATE TABLE `wt_daily_memos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day` date DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wt_daily_memos`
--

/*!40000 ALTER TABLE `wt_daily_memos` DISABLE KEYS */;
INSERT INTO `wt_daily_memos` (`id`,`day`,`user_id`,`created_on`,`updated_on`,`description`) VALUES 
  (1,'2012-12-11',31,'2012-12-11 08:49:37','2012-12-11 08:49:37','');
INSERT INTO `wt_daily_memos` (`id`,`day`,`user_id`,`created_on`,`updated_on`,`description`) VALUES 
  (2,'2012-12-26',31,'2012-12-26 13:49:03','2012-12-26 13:49:03','');
INSERT INTO `wt_daily_memos` (`id`,`day`,`user_id`,`created_on`,`updated_on`,`description`) VALUES 
  (3,'2013-02-01',21,'2013-02-01 05:00:09','2013-02-01 05:00:09','TBD today: \r\nfinalize the network xml\r\nprepare a document to make users understand the configuration parameters and how libvirt actually configures its network. ');
INSERT INTO `wt_daily_memos` (`id`,`day`,`user_id`,`created_on`,`updated_on`,`description`) VALUES 
  (4,'2013-03-01',21,'2013-03-04 06:29:07','2013-03-04 06:29:07','On sick leave.');
INSERT INTO `wt_daily_memos` (`id`,`day`,`user_id`,`created_on`,`updated_on`,`description`) VALUES 
  (5,'2013-03-20',21,'2013-03-20 12:40:01','2013-03-20 12:40:01','I arrived to work an hour late today. ');
INSERT INTO `wt_daily_memos` (`id`,`day`,`user_id`,`created_on`,`updated_on`,`description`) VALUES 
  (6,'2013-06-19',21,'2013-06-24 07:19:30','2013-06-24 07:19:30','I was on half day today. Thats why only 4 hours logged');
INSERT INTO `wt_daily_memos` (`id`,`day`,`user_id`,`created_on`,`updated_on`,`description`) VALUES 
  (7,'2013-07-08',21,'2013-07-25 11:11:04','2013-07-25 11:11:04','Was On leave on Monday 8/07/2013');
INSERT INTO `wt_daily_memos` (`id`,`day`,`user_id`,`created_on`,`updated_on`,`description`) VALUES 
  (8,'2013-07-22',21,'2013-08-05 11:37:51','2013-08-05 11:37:51','On Leave due to sickness');
INSERT INTO `wt_daily_memos` (`id`,`day`,`user_id`,`created_on`,`updated_on`,`description`) VALUES 
  (9,'2013-07-23',21,'2013-08-05 11:38:14','2013-08-05 11:38:14','On leave due to sickness\r\n');
INSERT INTO `wt_daily_memos` (`id`,`day`,`user_id`,`created_on`,`updated_on`,`description`) VALUES 
  (10,'2013-08-30',21,'2013-09-02 11:55:11','2013-09-02 11:55:11','I was on half day today');
INSERT INTO `wt_daily_memos` (`id`,`day`,`user_id`,`created_on`,`updated_on`,`description`) VALUES 
  (11,'2013-09-07',21,'2013-09-30 13:01:26','2013-09-30 13:01:26','This saturday I was working.');
INSERT INTO `wt_daily_memos` (`id`,`day`,`user_id`,`created_on`,`updated_on`,`description`) VALUES 
  (12,'2013-09-09',21,'2013-09-30 13:02:01','2013-09-30 13:02:01','Public holiday!');
INSERT INTO `wt_daily_memos` (`id`,`day`,`user_id`,`created_on`,`updated_on`,`description`) VALUES 
  (13,'2013-09-16',21,'2013-09-30 13:03:33','2013-09-30 13:03:33','On leave');
INSERT INTO `wt_daily_memos` (`id`,`day`,`user_id`,`created_on`,`updated_on`,`description`) VALUES 
  (14,'2013-09-19',21,'2013-09-30 13:04:03','2013-09-30 13:04:03','On leave');
/*!40000 ALTER TABLE `wt_daily_memos` ENABLE KEYS */;


--
-- Definition of table `wt_holidays`
--

DROP TABLE IF EXISTS `wt_holidays`;
CREATE TABLE `wt_holidays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `holiday` date DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `deleted_on` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wt_holidays`
--

/*!40000 ALTER TABLE `wt_holidays` DISABLE KEYS */;
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (1,'2012-12-03','2012-12-03 06:16:02',3,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (2,'2013-01-28','2013-01-28 06:40:28',23,'2013-01-28 06:40:29',23);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (3,'2013-02-11','2013-02-11 05:43:59',27,'2013-02-11 05:44:01',27);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (4,'2013-02-11','2013-02-11 05:44:03',27,'2013-02-11 05:44:32',15);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (5,'2013-02-12','2013-02-11 05:44:37',15,'2013-02-12 13:30:20',15);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (6,'2013-02-21','2013-02-21 10:31:56',38,'2013-02-21 10:31:59',38);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (7,'2013-02-28','2013-02-28 13:07:11',15,'2013-02-28 13:07:12',15);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (8,'2013-04-08','2013-04-08 05:50:09',16,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (9,'2013-10-18','2013-10-18 12:58:06',53,'2013-10-18 12:58:16',53);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (10,'2013-11-07','2013-11-07 12:28:00',15,'2013-11-07 12:29:29',44);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (11,'2013-10-07','2013-11-07 12:29:22',44,'2013-11-07 12:29:24',44);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (12,'2013-11-11','2013-11-07 14:58:51',15,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (13,'2013-11-12','2013-11-07 14:58:55',15,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (14,'2013-11-13','2013-11-07 14:58:58',15,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (15,'2013-11-14','2013-11-07 14:59:02',15,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (16,'2013-11-15','2013-11-07 14:59:04',15,'2013-11-07 17:35:31',15);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (17,'2013-11-18','2013-11-07 15:02:29',16,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (18,'2013-11-19','2013-11-07 15:02:33',16,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (19,'2013-11-20','2013-11-07 15:02:39',16,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (20,'2013-11-21','2013-11-07 15:02:43',16,'2013-11-07 15:03:41',16);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (21,'2013-11-22','2013-11-07 15:02:51',16,'2013-11-07 15:03:37',16);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (22,'2013-11-21','2013-11-07 15:03:44',16,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (23,'2013-11-22','2013-11-07 15:03:47',16,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (24,'2013-11-04','2013-11-07 15:56:27',37,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (25,'2013-11-01','2013-11-07 15:56:43',37,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (26,'2013-10-31','2013-11-07 15:57:34',37,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (27,'2013-10-21','2013-11-07 15:57:45',37,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (28,'2013-10-25','2013-11-07 15:58:40',37,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (29,'2013-10-02','2013-11-07 15:59:00',37,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (30,'2013-12-24','2013-11-07 17:13:42',38,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (31,'2013-11-05','2013-11-07 17:14:28',38,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (32,'2013-11-06','2013-11-07 17:14:32',38,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (33,'2013-12-23','2013-11-07 17:15:33',38,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (34,'2013-11-15','2013-11-07 17:35:33',15,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (35,'2013-11-04','2013-11-07 18:34:37',26,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (36,'2013-11-01','2013-11-07 18:34:57',26,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (37,'2013-11-05','2013-11-07 19:51:07',41,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (38,'2013-11-06','2013-11-07 19:51:20',41,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (39,'2013-11-07','2013-11-07 19:51:35',41,'2013-11-07 19:51:42',41);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (40,'2013-11-08','2013-11-08 18:08:38',41,'2013-11-08 18:08:51',41);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (41,'2013-12-25','2013-11-08 18:26:30',61,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (42,'2014-01-01','2013-11-08 18:27:25',61,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (43,'2013-11-01','2013-11-08 18:28:13',61,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (44,'2013-11-04','2013-11-08 18:28:17',61,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (45,'2013-10-02','2013-11-08 18:28:37',61,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (46,'2013-09-09','2013-11-08 18:28:46',61,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (47,'2013-08-15','2013-11-08 18:28:56',61,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (48,'2013-08-09','2013-11-08 18:29:09',61,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (49,'2013-05-01','2013-11-08 18:29:27',61,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (50,'2013-04-11','2013-11-08 18:29:41',61,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (51,'2013-01-01','2013-11-08 18:29:54',61,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (52,'2013-11-11','2013-11-11 12:31:48',38,'2013-11-11 12:32:35',38);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (53,'2013-11-12','2013-11-11 12:31:55',38,'2013-11-11 12:32:40',38);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (54,'2013-10-14','2013-11-11 12:32:59',38,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (55,'2013-10-15','2013-11-11 12:33:07',38,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (56,'2013-10-16','2013-11-11 12:33:13',38,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (57,'2013-10-17','2013-11-11 12:33:18',38,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (58,'2013-10-18','2013-11-11 12:33:23',38,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (59,'2013-11-12','2013-11-12 12:07:33',31,'2013-11-12 12:07:42',31);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (60,'2013-11-12','2013-11-13 08:42:16',38,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (61,'2013-11-11','2013-11-14 10:32:36',26,NULL,NULL);
INSERT INTO `wt_holidays` (`id`,`holiday`,`created_on`,`created_by`,`deleted_on`,`deleted_by`) VALUES 
  (62,'2013-11-14','2013-11-14 13:48:26',46,NULL,NULL);
/*!40000 ALTER TABLE `wt_holidays` ENABLE KEYS */;


--
-- Definition of table `wt_member_orders`
--

DROP TABLE IF EXISTS `wt_member_orders`;
CREATE TABLE `wt_member_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `prj_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=774 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wt_member_orders`
--

/*!40000 ALTER TABLE `wt_member_orders` DISABLE KEYS */;
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (1,5,1,5);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (2,11,2,5);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (3,6,3,5);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (4,7,4,5);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (5,8,5,5);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (6,3,6,5);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (7,9,7,5);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (8,4,8,5);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (12,1,1,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (18,27,2,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (19,16,3,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (21,22,4,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (23,17,5,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (25,23,6,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (28,24,7,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (30,36,8,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (33,37,9,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (34,26,10,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (35,15,11,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (37,21,12,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (38,38,1,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (39,27,2,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (40,16,3,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (41,33,4,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (42,22,5,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (44,17,6,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (45,34,7,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (46,23,8,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (47,12,9,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (48,1,10,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (49,35,11,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (50,24,12,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (51,41,13,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (52,30,14,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (53,36,15,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (54,31,16,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (56,37,17,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (57,26,18,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (58,15,19,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (59,32,20,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (60,21,21,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (61,27,1,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (62,16,2,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (63,38,3,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (64,22,4,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (65,33,5,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (67,17,6,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (68,23,7,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (69,12,8,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (70,1,9,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (71,34,10,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (72,24,11,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (73,35,12,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (74,41,13,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (75,30,14,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (76,36,15,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (78,31,16,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (79,26,17,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (80,37,18,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (81,15,19,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (82,21,20,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (83,32,21,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (84,33,1,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (85,28,2,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (86,20,3,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (87,15,4,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (88,16,5,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (89,37,6,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (90,38,1,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (91,16,2,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (92,33,3,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (93,34,4,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (94,35,5,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (95,41,6,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (96,30,7,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (97,36,8,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (98,31,9,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (99,37,10,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (100,15,11,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (101,32,12,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (102,44,13,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (103,43,14,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (104,44,13,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (105,46,14,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (106,47,15,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (107,43,16,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (108,44,22,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (109,46,23,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (110,47,24,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (111,43,25,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (112,33,15,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (113,46,16,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (114,47,17,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (115,44,22,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (116,46,23,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (117,47,24,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (118,48,25,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (119,43,26,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (120,48,18,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (121,48,17,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (122,49,7,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (123,44,8,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (124,46,9,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (125,47,10,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (126,48,11,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (127,43,12,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (128,49,18,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (129,49,26,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (130,48,27,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (131,49,27,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (132,50,19,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (133,50,28,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (134,49,19,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (135,50,20,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (136,51,20,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (137,51,21,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (138,53,22,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (139,51,29,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (140,53,30,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (141,54,31,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (142,50,13,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (143,51,14,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (144,53,15,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (145,54,16,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (146,27,1,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (147,16,2,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (148,49,3,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (149,22,4,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (150,44,5,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (151,33,6,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (152,17,7,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (153,50,8,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (154,23,9,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (155,51,10,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (156,24,11,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (157,46,12,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (158,47,13,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (159,36,14,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (160,53,15,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (161,26,16,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (162,15,17,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (163,48,18,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (164,37,19,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (165,21,20,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (166,54,21,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (167,43,22,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (168,38,1,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (169,27,2,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (170,49,3,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (171,16,4,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (172,22,5,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (173,44,6,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (174,33,7,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (175,17,8,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (176,50,9,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (177,34,10,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (178,23,11,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (179,12,12,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (180,1,13,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (181,51,14,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (182,35,15,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (183,24,16,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (184,46,17,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (185,41,18,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (186,30,19,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (187,47,20,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (188,36,21,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (189,31,22,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (190,53,23,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (191,26,24,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (192,48,25,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (193,15,26,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (194,37,27,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (195,32,28,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (196,21,29,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (197,54,30,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (198,43,31,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (199,16,1,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (200,49,2,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (201,38,3,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (202,44,4,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (203,33,5,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (204,50,6,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (205,34,7,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (206,51,8,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (207,46,9,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (208,35,10,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (209,41,11,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (210,30,12,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (211,47,13,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (212,36,14,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (213,53,15,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (214,31,16,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (215,15,17,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (216,48,18,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (217,37,19,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (218,54,20,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (219,43,21,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (220,32,22,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (221,49,1,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (222,16,2,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (223,38,3,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (224,55,4,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (225,44,5,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (226,33,6,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (227,50,7,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (228,56,8,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (229,34,9,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (230,51,10,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (231,57,11,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (232,46,12,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (233,35,13,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (234,41,14,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (235,30,15,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (236,47,16,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (237,36,17,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (238,53,18,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (239,31,19,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (240,48,20,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (241,15,21,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (242,37,22,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (243,54,23,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (244,43,24,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (245,32,25,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (246,55,21,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (247,56,22,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (248,57,23,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (249,53,24,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (250,54,25,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (251,49,1,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (252,16,2,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (253,38,3,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (254,55,4,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (255,44,5,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (256,33,6,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (257,50,7,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (258,56,8,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (259,34,9,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (260,51,10,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (261,57,11,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (262,46,12,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (263,35,13,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (264,41,14,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (265,30,15,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (266,47,16,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (267,36,17,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (268,53,18,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (269,31,19,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (270,48,20,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (271,15,21,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (272,37,22,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (273,54,23,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (274,43,24,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (275,32,25,26);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (276,55,23,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (277,56,24,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (278,57,25,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (279,55,32,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (280,56,33,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (281,57,34,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (282,27,1,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (283,49,2,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (284,16,3,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (285,55,4,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (286,22,5,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (287,44,6,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (288,33,7,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (289,17,8,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (290,50,9,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (291,56,10,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (292,23,11,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (293,51,12,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (294,57,13,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (295,24,14,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (296,46,15,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (297,47,16,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (298,36,17,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (299,53,18,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (300,26,19,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (301,48,20,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (302,15,21,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (303,37,22,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (304,21,23,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (305,54,24,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (306,43,25,19);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (307,38,1,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (308,49,2,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (309,16,3,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (310,55,4,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (311,44,5,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (312,33,6,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (313,50,7,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (314,34,8,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (315,56,9,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (316,51,10,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (317,35,11,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (318,57,12,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (319,46,13,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (320,41,14,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (321,30,15,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (322,47,16,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (323,36,17,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (324,53,18,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (325,31,19,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (326,48,20,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (327,15,21,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (328,37,22,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (329,32,23,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (330,43,24,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (331,54,25,30);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (332,49,1,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (333,16,2,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (334,38,3,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (335,55,4,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (336,44,5,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (337,33,6,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (338,50,7,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (339,56,8,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (340,34,9,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (341,51,10,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (342,57,11,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (343,46,12,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (344,35,13,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (345,41,14,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (346,30,15,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (347,47,16,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (348,36,17,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (349,53,18,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (350,31,19,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (351,48,20,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (352,15,21,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (353,37,22,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (354,54,23,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (355,43,24,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (356,32,25,28);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (357,55,23,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (358,56,24,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (359,57,25,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (360,54,26,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (361,49,1,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (362,27,2,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (363,16,3,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (364,55,4,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (365,44,5,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (366,33,6,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (367,22,7,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (368,50,8,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (369,17,9,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (370,56,10,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (371,23,11,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (372,51,12,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (373,57,13,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (374,46,14,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (375,24,15,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (376,47,16,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (377,36,17,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (378,53,18,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (379,48,19,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (380,37,20,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (381,15,21,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (382,26,22,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (383,54,23,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (384,43,24,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (385,21,25,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (386,55,28,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (387,50,29,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (388,56,30,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (389,51,31,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (390,57,32,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (391,53,33,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (392,54,34,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (393,49,1,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (394,16,2,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (395,55,3,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (396,44,4,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (397,33,5,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (398,22,6,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (399,28,7,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (400,50,8,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (401,56,9,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (402,51,10,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (403,57,11,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (404,46,12,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (405,47,13,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (406,36,14,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (407,53,15,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (408,20,16,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (409,48,17,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (410,37,18,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (411,15,19,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (412,26,20,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (413,54,21,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (414,43,22,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (415,21,23,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (416,49,1,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (417,16,2,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (418,38,3,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (419,27,4,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (420,55,5,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (421,44,6,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (422,33,7,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (423,22,8,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (424,28,9,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (425,50,10,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (426,17,11,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (427,56,12,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (428,34,13,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (429,23,14,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (430,12,15,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (431,1,16,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (432,51,17,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (433,57,18,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (434,46,19,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (435,35,20,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (436,24,21,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (437,41,22,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (438,30,23,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (439,47,24,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (440,36,25,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (441,53,26,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (442,20,27,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (443,31,28,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (444,48,29,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (445,15,30,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (446,37,31,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (447,26,32,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (448,54,33,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (449,43,34,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (450,32,35,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (451,21,36,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (452,44,1,33);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (453,46,2,33);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (454,31,3,33);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (455,15,4,33);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (456,37,5,33);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (457,43,6,33);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (458,32,7,33);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (459,54,8,33);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (460,49,1,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (461,16,2,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (462,38,3,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (463,55,4,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (464,44,5,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (465,33,6,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (466,50,7,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (467,56,8,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (468,34,9,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (469,51,10,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (470,57,11,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (471,46,12,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (472,35,13,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (473,41,14,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (474,30,15,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (475,47,16,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (476,36,17,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (477,53,18,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (478,31,19,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (479,48,20,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (480,15,21,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (481,37,22,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (482,54,23,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (483,43,24,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (484,32,25,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (485,37,1,37);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (486,16,1,36);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (487,46,2,36);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (488,41,3,36);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (489,36,4,36);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (490,15,5,36);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (491,37,6,36);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (492,43,7,36);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (493,49,1,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (494,16,2,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (495,55,3,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (496,44,4,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (497,33,5,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (498,22,6,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (499,50,7,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (500,56,8,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (501,51,9,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (502,57,10,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (503,46,11,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (504,47,12,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (505,36,13,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (506,53,14,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (507,48,15,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (508,37,16,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (509,15,17,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (510,26,18,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (511,54,19,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (512,43,20,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (513,21,21,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (514,55,17,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (515,56,18,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (516,57,19,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (517,58,22,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (518,59,23,31);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (519,58,35,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (520,59,36,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (521,58,26,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (522,59,27,23);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (523,58,37,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (524,59,38,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (525,58,26,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (526,59,27,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (527,58,24,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (528,59,25,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (529,58,26,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (530,59,27,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (531,58,26,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (532,59,27,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (533,58,20,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (534,59,21,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (535,55,32,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (536,56,33,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (537,57,34,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (538,58,35,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (539,59,36,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (540,49,1,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (541,27,2,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (542,16,3,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (543,55,4,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (544,44,5,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (545,33,6,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (546,22,7,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (547,50,8,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (548,17,9,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (549,56,10,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (550,23,11,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (551,51,12,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (552,57,13,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (553,46,14,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (554,24,15,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (555,58,16,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (556,47,17,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (557,36,18,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (558,53,19,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (559,59,20,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (560,48,21,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (561,37,22,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (562,15,23,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (563,26,24,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (564,54,25,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (565,43,26,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (566,21,27,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (567,58,35,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (568,59,36,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (569,52,28,40);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (570,52,39,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (571,52,37,11);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (572,52,28,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (573,55,23,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (574,56,24,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (575,57,25,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (576,52,26,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (577,58,27,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (578,59,28,18);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (579,52,22,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (580,60,40,35);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (581,60,1,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (582,27,2,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (583,16,3,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (584,22,4,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (585,28,5,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (586,50,6,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (587,17,7,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (588,23,8,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (589,51,9,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (590,24,10,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (591,52,11,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (592,36,12,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (593,20,13,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (594,37,14,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (595,15,15,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (596,26,16,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (597,43,17,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (598,21,18,43);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (599,60,37,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (600,52,38,7);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (601,60,26,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (602,52,27,29);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (603,15,1,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (604,60,37,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (605,52,38,21);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (606,60,2,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (607,49,3,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (608,16,4,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (609,55,5,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (610,44,6,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (611,33,7,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (612,50,8,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (613,56,9,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (614,51,10,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (615,57,11,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (616,46,12,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (617,52,13,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (618,58,14,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (619,47,15,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (620,36,16,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (621,53,17,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (622,59,18,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (623,48,19,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (624,37,20,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (625,54,21,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (626,43,22,45);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (627,60,29,9);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (628,60,26,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (629,52,27,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (630,58,28,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (631,59,29,24);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (632,60,27,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (633,52,28,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (634,58,29,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (635,59,30,8);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (636,38,1,42);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (637,44,2,42);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (638,35,3,42);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (639,46,4,42);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (640,36,5,42);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (641,31,6,42);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (642,15,7,42);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (643,37,8,42);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (644,43,9,42);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (645,54,10,42);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (646,60,28,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (647,52,29,25);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (648,60,1,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (649,49,2,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (650,16,3,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (651,38,4,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (652,55,5,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (653,44,6,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (654,33,7,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (655,50,8,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (656,56,9,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (657,34,10,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (658,51,11,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (659,57,12,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (660,46,13,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (661,35,14,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (662,52,15,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (663,41,16,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (664,30,17,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (665,58,18,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (666,47,19,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (667,36,20,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (668,53,21,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (669,31,22,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (670,59,23,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (671,48,24,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (672,15,25,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (673,37,26,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (674,54,27,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (675,43,28,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (676,32,29,15);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (677,38,1,44);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (678,44,2,44);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (679,46,3,44);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (680,36,4,44);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (681,31,5,44);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (682,15,6,44);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (683,37,7,44);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (684,43,8,44);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (685,54,9,44);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (686,38,1,41);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (687,44,2,41);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (688,35,3,41);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (689,46,4,41);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (690,41,5,41);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (691,36,6,41);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (692,31,7,41);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (693,15,8,41);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (694,37,9,41);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (695,43,10,41);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (696,54,11,41);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (697,60,23,10);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (698,60,28,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (699,52,29,16);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (700,85,1,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (701,123,2,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (702,104,3,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (703,76,4,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (704,95,5,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (705,133,6,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (706,105,7,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (707,86,8,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (708,124,9,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (709,67,10,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (710,134,11,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (711,96,12,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (712,77,13,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (713,115,14,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (714,87,15,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (715,125,16,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (716,68,17,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (717,106,18,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (718,135,19,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (719,97,20,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (720,78,21,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (721,116,22,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (722,69,23,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (723,107,24,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (724,12,25,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (725,88,26,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (726,136,27,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (727,98,28,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (728,79,29,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (729,117,30,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (730,108,31,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (731,70,32,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (732,89,33,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (733,127,34,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (734,137,35,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (735,80,36,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (736,118,37,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (737,99,38,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (738,128,39,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (739,109,40,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (740,90,41,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (741,71,42,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (742,138,43,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (743,81,44,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (744,119,45,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (745,15,46,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (746,91,47,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (747,72,48,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (748,110,49,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (749,139,50,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (750,120,51,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (751,63,52,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (752,101,53,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (753,82,54,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (754,111,55,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (755,92,56,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (756,73,57,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (757,140,58,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (758,64,59,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (759,102,60,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (760,83,61,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (761,121,62,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (762,131,63,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (763,74,64,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (764,112,65,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (765,93,66,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (766,65,67,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (767,103,68,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (768,84,69,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (769,122,70,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (770,75,71,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (771,113,72,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (772,94,73,3);
INSERT INTO `wt_member_orders` (`id`,`user_id`,`position`,`prj_id`) VALUES 
  (773,132,74,3);
/*!40000 ALTER TABLE `wt_member_orders` ENABLE KEYS */;


--
-- Definition of table `wt_project_orders`
--

DROP TABLE IF EXISTS `wt_project_orders`;
CREATE TABLE `wt_project_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `dsp_prj` int(11) DEFAULT NULL,
  `dsp_pos` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wt_project_orders`
--

/*!40000 ALTER TABLE `wt_project_orders` DISABLE KEYS */;
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (1,-1,8,4);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (2,-1,7,8);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (3,-1,10,11);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (4,-1,9,12);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (5,-1,11,14);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (6,-1,16,15);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (7,-1,19,17);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (8,-1,15,18);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (9,-1,20,20);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (10,-1,17,23);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (11,-1,45,1);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (12,-1,29,6);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (13,-1,28,9);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (14,-1,41,10);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (15,-1,24,2);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (16,-1,30,3);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (17,-1,40,5);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (18,-1,35,7);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (19,-1,27,13);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (20,-1,23,16);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (21,-1,39,19);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (22,-1,32,21);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (23,-1,33,22);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (24,-1,36,24);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (25,-1,43,25);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (26,-1,31,26);
INSERT INTO `wt_project_orders` (`id`,`uid`,`dsp_prj`,`dsp_pos`) VALUES 
  (27,-1,42,27);
/*!40000 ALTER TABLE `wt_project_orders` ENABLE KEYS */;


--
-- Definition of table `wt_ticket_relays`
--

DROP TABLE IF EXISTS `wt_ticket_relays`;
CREATE TABLE `wt_ticket_relays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issue_id` int(11) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=463 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wt_ticket_relays`
--

/*!40000 ALTER TABLE `wt_ticket_relays` DISABLE KEYS */;
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (1,11,1,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (2,13,2,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (3,15,3,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (4,22,4,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (5,21,5,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (6,17,6,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (7,30,7,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (8,16,8,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (9,23,9,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (10,41,10,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (11,82,11,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (12,81,12,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (13,34,13,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (14,29,14,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (15,51,15,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (16,72,16,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (17,66,17,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (18,70,18,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (19,36,19,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (20,47,20,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (21,69,21,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (22,71,22,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (23,50,23,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (24,92,24,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (25,91,25,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (26,37,26,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (27,19,27,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (28,18,28,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (29,25,29,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (30,95,30,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (31,59,31,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (32,35,32,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (33,33,33,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (34,110,34,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (35,111,35,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (36,113,36,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (37,116,37,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (38,38,38,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (39,40,39,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (40,107,40,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (41,114,41,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (42,115,42,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (43,108,43,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (44,123,44,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (45,121,45,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (46,78,46,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (47,124,47,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (48,126,48,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (49,24,49,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (50,129,50,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (51,136,51,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (52,135,52,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (53,20,53,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (54,102,54,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (55,130,55,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (56,137,56,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (57,145,57,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (58,146,58,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (59,132,59,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (60,28,60,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (61,48,61,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (62,166,62,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (63,167,63,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (64,68,64,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (65,191,65,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (66,195,66,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (67,147,67,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (68,149,68,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (69,150,69,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (70,148,70,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (71,151,71,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (72,152,72,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (73,153,73,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (74,163,74,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (75,169,75,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (76,171,76,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (77,173,77,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (78,172,78,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (79,176,79,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (80,177,80,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (81,175,81,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (82,170,82,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (83,193,83,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (84,182,84,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (85,96,85,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (86,103,86,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (87,109,87,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (88,93,88,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (89,155,89,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (90,159,90,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (91,156,91,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (92,104,92,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (93,154,93,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (94,158,94,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (95,161,95,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (96,160,96,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (97,179,97,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (98,180,98,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (99,97,99,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (100,194,100,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (101,190,101,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (102,197,102,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (103,183,103,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (104,207,104,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (105,208,105,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (106,209,106,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (107,205,107,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (108,206,108,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (109,198,109,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (110,174,110,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (111,394,111,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (112,406,112,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (113,407,113,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (114,226,114,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (115,229,115,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (116,178,116,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (117,409,117,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (118,410,118,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (119,199,119,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (120,203,120,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (121,213,121,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (122,215,122,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (123,217,123,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (124,218,124,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (125,221,125,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (126,211,126,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (127,200,127,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (128,223,128,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (129,224,129,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (130,225,130,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (131,227,131,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (132,253,132,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (133,250,133,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (134,259,134,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (135,260,135,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (136,192,136,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (137,311,137,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (138,310,138,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (139,210,139,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (140,263,140,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (141,389,141,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (142,105,142,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (143,397,143,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (144,318,144,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (145,216,145,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (146,436,146,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (147,455,147,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (148,398,148,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (149,222,149,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (150,470,150,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (151,460,151,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (152,471,152,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (153,472,153,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (154,473,154,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (155,306,155,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (156,474,156,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (157,469,157,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (158,476,158,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (159,477,159,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (160,478,160,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (161,479,161,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (162,313,162,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (163,481,163,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (164,483,164,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (165,484,165,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (166,485,166,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (167,168,167,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (168,482,168,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (169,488,169,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (170,489,170,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (171,490,171,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (172,503,172,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (173,509,173,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (174,512,174,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (175,247,175,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (176,508,176,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (177,511,177,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (178,513,178,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (179,519,179,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (180,506,180,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (181,505,181,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (182,521,182,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (183,529,183,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (184,532,184,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (185,535,185,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (186,537,186,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (187,538,187,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (188,541,188,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (189,530,189,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (190,542,190,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (191,516,191,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (192,546,192,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (193,544,193,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (194,527,194,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (195,552,195,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (196,555,196,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (197,556,197,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (198,557,198,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (199,558,199,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (200,562,200,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (201,564,201,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (202,138,202,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (203,566,203,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (204,554,204,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (205,517,205,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (206,577,206,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (207,573,207,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (208,593,208,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (209,594,209,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (210,575,210,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (211,576,211,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (212,595,212,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (213,598,213,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (214,603,214,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (215,604,215,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (216,605,216,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (217,606,217,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (218,597,218,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (219,608,219,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (220,596,220,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (221,602,221,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (222,607,222,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (223,609,223,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (224,613,224,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (225,614,225,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (226,181,226,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (227,615,227,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (228,616,228,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (229,618,229,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (230,219,230,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (231,617,231,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (232,619,232,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (233,620,233,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (234,629,234,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (235,626,235,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (236,630,236,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (237,628,237,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (238,625,238,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (239,634,239,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (240,637,240,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (241,638,241,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (242,475,242,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (243,633,243,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (244,641,244,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (245,643,245,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (246,644,246,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (247,578,247,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (248,621,248,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (249,642,249,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (250,640,250,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (251,611,251,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (252,610,252,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (253,650,253,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (254,649,254,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (255,480,255,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (256,652,256,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (257,624,257,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (258,623,258,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (259,653,259,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (260,654,260,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (261,655,261,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (262,660,262,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (263,661,263,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (264,515,264,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (265,669,265,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (266,659,266,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (267,636,267,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (268,646,268,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (269,672,269,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (270,543,270,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (271,674,271,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (272,686,272,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (273,776,273,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (274,691,274,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (275,820,275,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (276,787,276,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (277,811,277,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (278,816,278,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (279,769,279,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (280,684,280,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (281,717,281,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (282,711,282,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (283,721,283,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (284,730,284,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (285,731,285,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (286,258,286,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (287,690,287,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (288,518,288,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (289,257,289,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (290,732,290,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (291,685,291,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (292,133,292,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (293,712,293,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (294,740,294,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (295,733,295,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (296,741,296,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (297,742,297,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (298,743,298,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (299,744,299,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (300,688,300,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (301,745,301,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (302,746,302,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (303,738,303,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (304,748,304,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (305,750,305,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (306,752,306,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (307,753,307,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (308,754,308,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (309,729,309,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (310,735,310,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (311,755,311,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (312,749,312,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (313,756,313,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (314,747,314,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (315,757,315,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (316,759,316,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (317,760,317,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (318,761,318,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (319,758,319,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (320,762,320,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (321,763,321,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (322,765,322,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (323,766,323,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (324,767,324,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (325,772,325,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (326,773,326,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (327,774,327,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (328,764,328,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (329,775,329,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (330,777,330,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (331,736,331,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (332,778,332,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (333,779,333,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (334,781,334,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (335,782,335,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (336,783,336,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (337,784,337,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (338,786,338,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (339,785,339,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (340,715,340,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (341,789,341,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (342,790,342,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (343,791,343,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (344,801,344,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (345,796,345,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (346,792,346,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (347,802,347,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (348,803,348,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (349,804,349,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (350,809,350,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (351,810,351,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (352,815,352,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (353,817,359,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (354,1567,358,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (355,1553,357,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (356,1262,356,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (357,1570,355,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (358,885,354,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (359,1266,353,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (360,1146,411,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (361,1160,425,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (362,1207,426,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (363,1307,427,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (364,1313,428,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (365,1456,429,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (366,1354,430,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (367,1394,431,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (368,1463,432,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (369,1464,433,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (370,1362,434,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (371,1465,424,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (372,1408,423,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (373,1377,422,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (374,1149,412,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (375,1467,413,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (376,1079,414,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (377,1468,415,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (378,1469,416,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (379,1344,417,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (380,1281,418,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (381,1474,419,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (382,1472,420,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (383,1473,421,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (384,1316,435,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (385,1246,436,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (386,938,437,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (387,1476,451,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (388,1477,452,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (389,1288,453,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (390,1488,454,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (391,1489,455,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (392,1491,456,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (393,1490,457,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (394,1494,458,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (395,1493,459,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (396,1487,460,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (397,1084,450,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (398,1495,449,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (399,1498,448,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (400,1077,438,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (401,1499,439,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (402,1500,440,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (403,1501,441,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (404,1502,442,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (405,1317,443,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (406,1507,444,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (407,1508,445,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (408,1510,446,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (409,1511,447,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (410,1512,461,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (411,1516,373,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (412,1515,374,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (413,1506,375,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (414,1505,376,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (415,1518,377,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (416,1509,378,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (417,1519,379,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (418,1520,380,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (419,1479,381,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (420,1480,382,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (421,1481,383,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (422,1521,372,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (423,1484,371,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (424,1486,360,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (425,1525,361,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (426,1526,362,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (427,1528,363,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (428,1530,364,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (429,1529,365,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (430,1531,366,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (431,1539,367,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (432,1540,368,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (433,1538,369,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (434,1541,370,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (435,1533,384,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (436,1534,385,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (437,1536,386,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (438,1537,400,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (439,1551,401,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (440,1549,402,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (441,1555,403,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (442,1462,404,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (443,1461,405,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (444,1460,406,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (445,1297,407,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (446,969,408,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (447,1318,409,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (448,1544,399,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (449,1545,398,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (450,1543,397,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (451,1546,387,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (452,1548,388,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (453,1535,389,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (454,1497,390,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (455,1523,391,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (456,1556,392,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (457,1557,393,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (458,1559,394,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (459,1564,395,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (460,1563,396,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (461,1560,410,0);
INSERT INTO `wt_ticket_relays` (`id`,`issue_id`,`position`,`parent`) VALUES 
  (462,1571,462,0);
/*!40000 ALTER TABLE `wt_ticket_relays` ENABLE KEYS */;



--
-- Definition of function `getCurrentWorkingAssignees_SubTask`
--

DROP FUNCTION IF EXISTS `getCurrentWorkingAssignees_SubTask`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` FUNCTION `getCurrentWorkingAssignees_SubTask`(idInput INT) RETURNS double
    READS SQL DATA
BEGIN

DECLARE _spentTime double;
DECLARE _spentTime_return double;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET @spentTime = 0;

	LOOP


  select
		 count(distinct i.assigned_to_id) into @remainingTime
	from
		issues i
		inner join
		(
			SELECT distinct id.root_id, id.lft, id.rgt FROM issues id where id.id=idInput
		) rootTb
		on
			i.root_id=rootTb.root_id and
			(`i`.`lft` >= rootTb.lft AND `i`.`rgt` <= rootTb.rgt)
		left outer join `custom_values` AS `cv`
		ON
			`i`.`id` = `cv`.`customized_id` and cv.custom_field_id = 34
	 where i.id <> idInput and `cv`.`value` <> 0;

	  RETURN @remainingTime;

	END LOOP;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `getHierarchyLevel`
--

DROP FUNCTION IF EXISTS `getHierarchyLevel`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` FUNCTION `getHierarchyLevel`(idInput INT) RETURNS double
    READS SQL DATA
BEGIN

DECLARE _spentTime double;
DECLARE _spentTime_return double;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET @level_output = 0;

	LOOP

		select level_data.`level` into @level_output from
		(
				SELECT  hierarchy_connect_by_parent_eq_prior_id(i.id) AS id, @level as `level`
				FROM    (
						SELECT  @start_with := idInput,
								@id := @start_with,
								@level := 0
						) vars, issues i
				WHERE   @id IS NOT NULL
		) level_data;

	  RETURN @level_output;

	END LOOP;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `getTotalAssignees_SubTask`
--

DROP FUNCTION IF EXISTS `getTotalAssignees_SubTask`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` FUNCTION `getTotalAssignees_SubTask`(idInput INT) RETURNS double
    READS SQL DATA
BEGIN

DECLARE _spentTime double;
DECLARE _spentTime_return double;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET @spentTime = 0;

	LOOP


  select
		 count(distinct i.assigned_to_id) into @remainingTime
	from
		issues i
		inner join
		(
			SELECT distinct id.root_id, id.lft, id.rgt FROM issues id where id.id=idInput
		) rootTb
		on
			i.root_id=rootTb.root_id and
			(`i`.`lft` >= rootTb.lft AND `i`.`rgt` <= rootTb.rgt)
		left outer join `custom_values` AS `cv`
		ON
			`i`.`id` = `cv`.`customized_id` and cv.custom_field_id = 34
	 where i.id <> idInput;

	  RETURN @remainingTime;

	END LOOP;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `getTotalBugCount`
--

DROP FUNCTION IF EXISTS `getTotalBugCount`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` FUNCTION `getTotalBugCount`(idInput INT) RETURNS double
    READS SQL DATA
BEGIN

DECLARE CONTINUE HANDLER FOR NOT FOUND SET @bugCount = 0;

	LOOP


	select
		Count(i.id) into @bugCount
  from
		issues i
		inner join
		(
			SELECT distinct id.root_id, id.lft, id.rgt FROM issues id where id.id=idInput
		) rootTb
		on
			i.root_id=rootTb.root_id and
			(`i`.`lft` >= rootTb.lft AND `i`.`rgt` <= rootTb.rgt)
		left outer join `trackers` AS `tr`
		ON
			`i`.`tracker_id` = `tr`.`id`
  where tr.name like 'Bug';


	  RETURN @bugCount;

	END LOOP; 

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `getTotalLOC`
--

DROP FUNCTION IF EXISTS `getTotalLOC`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` FUNCTION `getTotalLOC`(idInput INT) RETURNS double
    READS SQL DATA
BEGIN


DECLARE CONTINUE HANDLER FOR NOT FOUND SET @totalLOC = 0;

	LOOP


	select
		CEILING(sum(cv.value)) into @totalLOC
	from
		issues i
		inner join
		(
			SELECT distinct id.root_id, id.lft, id.rgt FROM issues id where id.id=idInput
		) rootTb
		on
			i.root_id=rootTb.root_id and
			(`i`.`lft` >= rootTb.lft AND `i`.`rgt` <= rootTb.rgt)
		left outer join `custom_values` AS `cv`
		ON
			`i`.`id` = `cv`.`customized_id`
	 where cv.custom_field_id = 65;


	  RETURN @totalLOC;

	END LOOP; 

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `getTotalPageCount`
--

DROP FUNCTION IF EXISTS `getTotalPageCount`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` FUNCTION `getTotalPageCount`(idInput INT) RETURNS double
    READS SQL DATA
BEGIN


DECLARE CONTINUE HANDLER FOR NOT FOUND SET @totalPageCount = 0;

	LOOP


	select
		CEILING(sum(cv.value)) into @totalPageCount
	from
		issues i
		inner join
		(
			SELECT distinct id.root_id, id.lft, id.rgt FROM issues id where id.id=idInput
		) rootTb
		on
			i.root_id=rootTb.root_id and
			(`i`.`lft` >= rootTb.lft AND `i`.`rgt` <= rootTb.rgt)
		left outer join `custom_values` AS `cv`
		ON
			`i`.`id` = `cv`.`customized_id`
	 where cv.custom_field_id = 64;


	  RETURN @totalPageCount;

	END LOOP; 

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `getTotalRemainingTime`
--

DROP FUNCTION IF EXISTS `getTotalRemainingTime`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` FUNCTION `getTotalRemainingTime`(idInput INT) RETURNS double
    READS SQL DATA
BEGIN

DECLARE _spentTime double;
DECLARE _spentTime_return double;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET @spentTime = 0;

	LOOP


	select
		CEILING(sum(cv.value)) into @remainingTime
	from
		issues i
		inner join
		(
			SELECT distinct id.root_id, id.lft, id.rgt FROM issues id where id.id=idInput
		) rootTb
		on
			i.root_id=rootTb.root_id and
			(`i`.`lft` >= rootTb.lft AND `i`.`rgt` <= rootTb.rgt)
		left outer join `custom_values` AS `cv`
		ON
			`i`.`id` = `cv`.`customized_id`
	 where cv.custom_field_id = 34;

/* only extract remaining time */
/*
		select CEILING(sum(RemainingHrs)) into @remainingTime from
		(
      select i.id, i.parent_id, cv.value as `RemainingHrs`
      from issues as i
      LEFT OUTER JOIN `custom_values` AS `cv` ON `i`.`id` = `cv`.`customized_id`
      where cv.custom_field_id = 34 and
      i.id=idInput
		union all

    SELECT  ho.id, hi.parent_id, cv.value as `RemainingHrs`
		FROM    (
				SELECT  hierarchy_connect_by_parent_eq_prior_id(i.id) AS id
				FROM    (
						SELECT  @start_with := idInput,
								@id := @start_with,
								@level := 1
						) vars, issues i
				WHERE   @id IS NOT NULL
				) ho
		INNER JOIN    issues hi 		ON      hi.id = ho.id
		LEFT OUTER JOIN `custom_values` AS `cv` ON `hi`.`id` = `cv`.`customized_id`
    where cv.custom_field_id = 34
		) spent_hrs;
*/
	  RETURN @remainingTime;

	END LOOP; 

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `getTotalRemainingTime_SubTask`
--

DROP FUNCTION IF EXISTS `getTotalRemainingTime_SubTask`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` FUNCTION `getTotalRemainingTime_SubTask`(idInput INT) RETURNS double
    READS SQL DATA
BEGIN

DECLARE _spentTime double;
DECLARE _spentTime_return double;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET @spentTime = 0;

	LOOP


	select
		CEILING(sum(cv.value)) into @remainingTime
	from
		issues i
		inner join
		(
			SELECT distinct id.root_id, id.lft, id.rgt FROM issues id where id.id=idInput
		) rootTb
		on
			i.root_id=rootTb.root_id and
			(`i`.`lft` >= rootTb.lft AND `i`.`rgt` <= rootTb.rgt)
		left outer join `custom_values` AS `cv`
		ON
			`i`.`id` = `cv`.`customized_id`
	 where cv.custom_field_id = 34 and i.id <> idInput;

/* only extract remaining time */
/*
		select sum(RemainingHrs) into @remainingTime from
		(
    SELECT  ho.id, hi.parent_id, cv.value as `RemainingHrs`
		FROM    (
				SELECT  hierarchy_connect_by_parent_eq_prior_id(i.id) AS id
				FROM    (
						SELECT  @start_with := idInput,
								@id := @start_with,
								@level := 1
						) vars, issues i
				WHERE   @id IS NOT NULL
				) ho
		INNER JOIN    issues hi 		ON      hi.id = ho.id
		LEFT OUTER JOIN `custom_values` AS `cv` ON `hi`.`id` = `cv`.`customized_id`
    where cv.custom_field_id = 34
		) spent_hrs;
*/
	  RETURN @remainingTime;

	END LOOP;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `getTotalReviewCount`
--

DROP FUNCTION IF EXISTS `getTotalReviewCount`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` FUNCTION `getTotalReviewCount`(idInput INT) RETURNS double
    READS SQL DATA
BEGIN

DECLARE CONTINUE HANDLER FOR NOT FOUND SET @bugCount = 0;

	LOOP


	select
		Count(i.id) into @bugCount
  from
		issues i
		inner join
		(
			SELECT distinct id.root_id, id.lft, id.rgt FROM issues id where id.id=idInput
		) rootTb
		on
			i.root_id=rootTb.root_id and
			(`i`.`lft` >= rootTb.lft AND `i`.`rgt` <= rootTb.rgt)
		left outer join `trackers` AS `tr`
		ON
			`i`.`tracker_id` = `tr`.`id`
  where tr.name like 'Review-Error';


	  RETURN @bugCount;

	END LOOP; 

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `getTotalSpentTime`
--

DROP FUNCTION IF EXISTS `getTotalSpentTime`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` FUNCTION `getTotalSpentTime`(idInput INT) RETURNS double
    READS SQL DATA
BEGIN

DECLARE _spentTime double;
DECLARE _spentTime_return double;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET @spentTime = 0;

	LOOP

	select CEILING(sum(t.hours)) into @spentTime
	from
		issues i
		inner join
		(
			SELECT distinct id.root_id, id.lft, id.rgt FROM issues id where id.id=idInput
		) rootTb
		on
			i.root_id=rootTb.root_id and
			(`i`.`lft` >= rootTb.lft AND `i`.`rgt` <= rootTb.rgt)
		left Join time_entries t
			on i.id=t.issue_id;


/*
		select CEILING(sum(hours)) into @spentTime from
		(
		select i.id, i.parent_id, ti.hours from issues i, time_entries ti
		where
		i.id=ti.issue_id
		and i.id=idInput
		union all
		SELECT  ho.id, hi.parent_id, t.hours
		FROM    (
				SELECT  hierarchy_connect_by_parent_eq_prior_id(i.id) AS id
				FROM    (
						SELECT  @start_with := idInput,
								@id := @start_with,
								@level := 1
						) vars, issues i
				WHERE   @id IS NOT NULL
				) ho
		INNER JOIN    issues hi
		ON      hi.id = ho.id
		left Join time_entries t
		on hi.id=t.issue_id
		) spent_hrs;
*/
	  RETURN @spentTime;

	END LOOP;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `hierarchy_connect_by_iscycle`
--

DROP FUNCTION IF EXISTS `hierarchy_connect_by_iscycle`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` FUNCTION `hierarchy_connect_by_iscycle`(node INT) RETURNS int(11)
    READS SQL DATA
BEGIN
        DECLARE _id INT;
        DECLARE _loop INT;
        DECLARE _node INT;
        DECLARE EXIT HANDLER FOR NOT FOUND RETURN 0;
        SET _id = COALESCE(node, @id);
        SET _loop = 0;
        SET _node = 0;
        LOOP
                SELECT  parent_id
                INTO    _id
                FROM    issues
                WHERE   id = _id;
                IF _id = @start_with THEN
                        SET _loop := _loop + 1;
                END IF;
                IF _id = COALESCE(node, @id) THEN
                        SET _node = _node + 1;
                END IF;
                IF _loop >= 2 THEN
                        RETURN _node;
                END IF;
        END LOOP;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `hierarchy_connect_by_parent_eq_prior_id`
--

DROP FUNCTION IF EXISTS `hierarchy_connect_by_parent_eq_prior_id`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` FUNCTION `hierarchy_connect_by_parent_eq_prior_id`(value INT) RETURNS int(11)
    READS SQL DATA
BEGIN
	DECLARE _id INT;
	DECLARE _parent INT;
	DECLARE _next INT;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET @id = NULL;

	SET _parent = @id;
	SET _id = -1;

	IF @id IS NULL THEN
	  RETURN NULL;
	END IF;
	 
	LOOP
		SELECT  MIN(id)
		INTO    @id
		FROM    issues
		WHERE   parent_id = _parent
		AND id > _id;
		IF @id IS NOT NULL OR _parent = @start_with THEN
			SET @level = @level + 1;
			RETURN @id;
		END IF;
		SET @level := @level - 1;
		SELECT  id, parent_id
		INTO    _id, _parent
		FROM    issues
		WHERE   id = _parent;
	END LOOP;      
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `hierarchy_connect_by_parent_eq_prior_id_with_level`
--

DROP FUNCTION IF EXISTS `hierarchy_connect_by_parent_eq_prior_id_with_level`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` FUNCTION `hierarchy_connect_by_parent_eq_prior_id_with_level`(value INT, maxlevel INT) RETURNS int(11)
    READS SQL DATA
BEGIN
        DECLARE _id INT;
        DECLARE _parent INT;
        DECLARE _next INT;
        DECLARE _i INT;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET @id = NULL;

        SET _parent = @id;
        SET _id = -1;
        SET _i = 0;

        IF @id IS NULL THEN
                RETURN NULL;
        END IF;

        LOOP
                SELECT  MIN(id)
                INTO    @id
                FROM    issues
                WHERE   parent_id = _parent
                        AND id > _id
                        AND COALESCE(@level < maxlevel, TRUE);
                IF @id IS NOT NULL OR _parent = @start_with THEN
                        SET @level = @level + 1;
                        RETURN @id;
                END IF;
                SET @level := @level - 1;
                SELECT  id, parent_id
                INTO    _id, _parent
                FROM    issues
                WHERE   id = _parent;
                SET _i = _i + 1;
        END LOOP;
        RETURN NULL;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `hierarchy_connect_by_parent_eq_prior_id_with_level_and_loop`
--

DROP FUNCTION IF EXISTS `hierarchy_connect_by_parent_eq_prior_id_with_level_and_loop`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` FUNCTION `hierarchy_connect_by_parent_eq_prior_id_with_level_and_loop`(value INT, maxlevel INT) RETURNS int(11)
    READS SQL DATA
BEGIN
        DECLARE _id INT;
        DECLARE _parent INT;
        DECLARE _next INT;
        DECLARE _i INT;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET @id = NULL;

        SET _parent = @id;
        SET _id = -1;
        SET _i = 0;

        IF @id IS NULL THEN
                RETURN NULL;
        END IF;

        LOOP
                SELECT  MIN(id)
                INTO    @id
                FROM    issues
                WHERE   parent_id = _parent
                        AND id > _id
                        -- Checking for @start_with in descendants
                        AND id <> @start_with
                        AND COALESCE(@level < maxlevel, TRUE);
                IF @id IS NOT NULL OR _parent = @start_with THEN
                        SET @level = @level + 1;
                        RETURN @id;
                END IF;
                SET @level := @level - 1;
                SELECT  id, parent_id
                INTO    _id, _parent
                FROM    issues
                WHERE   id = _parent;
                SET _i = _i + 1;
        END LOOP;
        RETURN NULL;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of function `hierarchy_sys_connect_by_path`
--

DROP FUNCTION IF EXISTS `hierarchy_sys_connect_by_path`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='' */ $$
CREATE DEFINER=`root`@`%` FUNCTION `hierarchy_sys_connect_by_path`(delimiter TEXT, node INT) RETURNS text CHARSET utf8
    READS SQL DATA
BEGIN
     DECLARE _path TEXT;
     DECLARE _cpath TEXT;
     DECLARE _id INT;
     DECLARE EXIT HANDLER FOR NOT FOUND RETURN _path;
    SET _id = COALESCE(node, @id);
      SET _path = _id;
    LOOP
                SELECT  parent_id
              INTO    _id
         FROM    issues
         WHERE   id = _id
                    AND COALESCE(id <> @start_with, TRUE);
              SET _path = CONCAT(_id, delimiter, _path);
  END LOOP;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
