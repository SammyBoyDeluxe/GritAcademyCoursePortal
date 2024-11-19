-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Värd: 127.0.0.1:3307
-- Tid vid skapande: 09 aug 2024 kl 19:30
-- Serverversion: 11.2.2-MariaDB
-- PHP-version: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databas: `gritacademycoursesportaldb2.0`
--

DELIMITER $$
--
-- Procedurer
--
DROP PROCEDURE IF EXISTS `verify_user`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `verify_user` (IN `usernamein` VARCHAR(200), IN `passwordin` VARCHAR(200), OUT `o_usertype` VARCHAR(200), OUT `o_dbpassword` VARCHAR(200), OUT `o_fname` VARCHAR(200), OUT `o_lname` VARCHAR(200), OUT `o_id` INT)   BEGIN 
DECLARE rowusertype VARCHAR(200);
DECLARE rowdbpassword VARCHAR(200); 
DECLARE rowfname VARCHAR(200);
DECLARE rowlname VARCHAR(200);
DECLARE userid INT;
SELECT users.usertype, users.dbpassword, users.fname, users.lname, users.id INTO rowusertype,rowdbpassword,rowfname,rowlname,userid FROM users WHERE users.username = usernamein AND users.`password`= passwordin;

IF rowusertype IS NULL THEN
	SET o_usertype = 'guest';
	SET o_dbpassword = '';
	SET o_lname = '';
	SET o_fname = '';
	SET o_id = -1;
ELSE
	SET o_usertype = rowusertype;
	SET o_dbpassword = rowdbpassword;
	SET o_fname =  rowfname;
	SET o_lname = rowlname;
	SET o_id = userid;
END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabellstruktur `attendance`
--

DROP TABLE IF EXISTS `attendance`;
CREATE TABLE IF NOT EXISTS `attendance` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `studentid` int(10) UNSIGNED NOT NULL,
  `courseid` int(10) UNSIGNED NOT NULL,
  `lessondate` date DEFAULT NULL,
  `attended` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courseid` (`courseid`),
  KEY `studentid` (`studentid`)
) ENGINE=MyISAM AUTO_INCREMENT=127 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumpning av Data i tabell `attendance`
--

INSERT INTO `attendance` (`id`, `studentid`, `courseid`, `lessondate`, `attended`) VALUES
(31, 1, 1, '2024-01-15', 1),
(32, 2, 1, '2024-01-15', 1),
(33, 7, 1, '2024-01-15', 1),
(34, 9, 1, '2024-01-15', 1),
(35, 11, 1, '2024-01-15', 1),
(36, 16, 1, '2024-01-15', 1),
(37, 18, 1, '2024-01-15', 1),
(38, 21, 1, '2024-01-15', 1),
(39, 23, 1, '2024-01-15', 1),
(40, 13, 1, '2024-01-15', 1),
(41, 1, 1, '2024-02-01', 1),
(42, 2, 1, '2024-02-01', 1),
(43, 7, 1, '2024-02-01', 1),
(44, 9, 1, '2024-02-01', 0),
(45, 11, 1, '2024-02-01', 1),
(46, 16, 1, '2024-02-01', 1),
(47, 18, 1, '2024-02-01', 1),
(48, 21, 1, '2024-02-01', 1),
(49, 23, 1, '2024-02-01', 0),
(50, 13, 1, '2024-02-01', 1),
(51, 1, 2, '2024-02-15', 1),
(52, 3, 2, '2024-02-15', 1),
(53, 6, 2, '2024-02-15', 1),
(54, 8, 2, '2024-02-15', 1),
(55, 10, 2, '2024-02-15', 1),
(56, 14, 2, '2024-02-15', 1),
(57, 19, 2, '2024-02-15', 1),
(58, 22, 2, '2024-02-15', 1),
(59, 24, 2, '2024-02-15', 1),
(60, 25, 2, '2024-02-15', 1),
(61, 1, 2, '2024-03-01', 0),
(62, 3, 2, '2024-03-01', 1),
(63, 6, 2, '2024-03-01', 1),
(64, 8, 2, '2024-03-01', 1),
(65, 10, 2, '2024-03-01', 1),
(66, 14, 2, '2024-03-01', 1),
(67, 19, 2, '2024-03-01', 1),
(68, 22, 2, '2024-03-01', 1),
(69, 24, 2, '2024-03-01', 0),
(70, 25, 2, '2024-03-01', 1),
(71, 2, 3, '2024-02-15', 1),
(72, 4, 3, '2024-02-15', 1),
(73, 6, 3, '2024-02-15', 1),
(74, 12, 3, '2024-02-15', 1),
(75, 14, 3, '2024-02-15', 1),
(76, 17, 3, '2024-02-15', 1),
(77, 19, 3, '2024-02-15', 1),
(78, 22, 3, '2024-02-15', 1),
(79, 24, 3, '2024-02-15', 1),
(80, 15, 3, '2024-02-15', 1),
(81, 2, 3, '2024-03-01', 1),
(82, 4, 3, '2024-03-01', 0),
(83, 6, 3, '2024-03-01', 1),
(84, 12, 3, '2024-03-01', 1),
(85, 14, 3, '2024-03-01', 1),
(86, 17, 3, '2024-03-01', 1),
(87, 19, 3, '2024-03-01', 1),
(88, 22, 3, '2024-03-01', 1),
(89, 24, 3, '2024-03-01', 1),
(90, 15, 3, '2024-03-01', 0),
(91, 3, 4, '2024-02-15', 1),
(92, 5, 4, '2024-02-15', 1),
(93, 10, 4, '2024-02-15', 1),
(94, 12, 4, '2024-02-15', 1),
(95, 15, 4, '2024-02-15', 1),
(96, 17, 4, '2024-02-15', 1),
(97, 20, 4, '2024-02-15', 1),
(98, 25, 4, '2024-02-15', 1),
(99, 4, 4, '2024-02-15', 1),
(100, 3, 4, '2024-03-01', 1),
(101, 5, 4, '2024-03-01', 0),
(102, 10, 4, '2024-03-01', 1),
(103, 12, 4, '2024-03-01', 1),
(104, 15, 4, '2024-03-01', 1),
(105, 17, 4, '2024-03-01', 1),
(106, 20, 4, '2024-03-01', 1),
(107, 25, 4, '2024-03-01', 1),
(108, 4, 4, '2024-03-01', 1),
(109, 5, 5, '2024-02-15', 1),
(110, 8, 5, '2024-02-15', 1),
(111, 10, 5, '2024-02-15', 1),
(112, 13, 5, '2024-02-15', 1),
(113, 18, 5, '2024-02-15', 1),
(114, 20, 5, '2024-02-15', 1),
(115, 23, 5, '2024-02-15', 1),
(116, 25, 5, '2024-02-15', 1),
(117, 15, 5, '2024-02-15', 1),
(118, 5, 5, '2024-03-01', 1),
(119, 8, 5, '2024-03-01', 1),
(120, 10, 5, '2024-03-01', 1),
(121, 13, 5, '2024-03-01', 1),
(122, 18, 5, '2024-03-01', 0),
(123, 20, 5, '2024-03-01', 1),
(124, 23, 5, '2024-03-01', 1),
(125, 25, 5, '2024-03-01', 1),
(126, 15, 5, '2024-03-01', 1);

-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `attendancelist`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `attendancelist`;
CREATE TABLE IF NOT EXISTS `attendancelist` (
`#` int(10) unsigned
,`Förnamn:` varchar(200)
,`Efternamn:` varchar(200)
,`Kursnamn:` varchar(255)
,`Lektionsdatum:` date
,`Närvaro:` tinyint(1)
);

-- --------------------------------------------------------

--
-- Tabellstruktur `attendancetable`
--

DROP TABLE IF EXISTS `attendancetable`;
CREATE TABLE IF NOT EXISTS `attendancetable` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `usercourseid` int(10) UNSIGNED NOT NULL,
  `lessondate` date NOT NULL,
  `attended` tinyint(1) NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `usercourseid` (`usercourseid`)
) ENGINE=MyISAM AUTO_INCREMENT=251 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumpning av Data i tabell `attendancetable`
--

INSERT INTO `attendancetable` (`id`, `usercourseid`, `lessondate`, `attended`) VALUES
(1, 6, '2024-01-01', 0),
(2, 6, '2024-01-08', 1),
(3, 6, '2024-01-15', 0),
(4, 6, '2024-01-22', 1),
(5, 6, '2024-01-29', 0),
(6, 7, '2024-02-02', 0),
(7, 7, '2024-02-09', 1),
(8, 7, '2024-02-16', 0),
(9, 7, '2024-02-23', 1),
(10, 7, '2024-03-01', 0),
(11, 8, '2024-01-01', 0),
(12, 8, '2024-01-08', 1),
(13, 8, '2024-01-15', 0),
(14, 8, '2024-01-22', 1),
(15, 8, '2024-01-29', 0),
(16, 9, '2024-02-02', 0),
(17, 9, '2024-02-09', 1),
(18, 9, '2024-02-16', 0),
(19, 9, '2024-02-23', 1),
(20, 9, '2024-03-01', 0),
(21, 10, '2024-02-02', 0),
(22, 10, '2024-02-09', 1),
(23, 10, '2024-02-16', 0),
(24, 10, '2024-02-23', 1),
(25, 10, '2024-03-01', 0),
(26, 11, '2024-02-02', 0),
(27, 11, '2024-02-09', 1),
(28, 11, '2024-02-16', 0),
(29, 11, '2024-02-23', 1),
(30, 11, '2024-03-01', 0),
(31, 12, '2024-02-02', 0),
(32, 12, '2024-02-09', 1),
(33, 12, '2024-02-16', 0),
(34, 12, '2024-02-23', 1),
(35, 12, '2024-03-01', 0),
(36, 13, '2024-02-02', 0),
(37, 13, '2024-02-09', 1),
(38, 13, '2024-02-16', 0),
(39, 13, '2024-02-23', 1),
(40, 13, '2024-03-01', 0),
(41, 14, '2024-02-02', 0),
(42, 14, '2024-02-09', 1),
(43, 14, '2024-02-16', 0),
(44, 14, '2024-02-23', 1),
(45, 14, '2024-03-01', 0),
(46, 15, '2024-02-02', 0),
(47, 15, '2024-02-09', 1),
(48, 15, '2024-02-16', 0),
(49, 15, '2024-02-23', 1),
(50, 15, '2024-03-01', 0),
(51, 16, '2024-02-02', 0),
(52, 16, '2024-02-09', 1),
(53, 16, '2024-02-16', 0),
(54, 16, '2024-02-23', 1),
(55, 16, '2024-03-01', 0),
(56, 17, '2024-02-02', 0),
(57, 17, '2024-02-09', 1),
(58, 17, '2024-02-16', 0),
(59, 17, '2024-02-23', 1),
(60, 17, '2024-03-01', 0),
(61, 18, '2024-01-01', 0),
(62, 18, '2024-01-08', 1),
(63, 18, '2024-01-15', 0),
(64, 18, '2024-01-22', 1),
(65, 18, '2024-01-29', 0),
(66, 19, '2024-02-02', 0),
(67, 19, '2024-02-09', 1),
(68, 19, '2024-02-16', 0),
(69, 19, '2024-02-23', 1),
(70, 19, '2024-03-01', 0),
(71, 20, '2024-02-02', 0),
(72, 20, '2024-02-09', 1),
(73, 20, '2024-02-16', 0),
(74, 20, '2024-02-23', 1),
(75, 20, '2024-03-01', 0),
(76, 21, '2024-02-02', 0),
(77, 21, '2024-02-09', 1),
(78, 21, '2024-02-16', 0),
(79, 21, '2024-02-23', 1),
(80, 21, '2024-03-01', 0),
(81, 22, '2024-01-01', 0),
(82, 22, '2024-01-08', 1),
(83, 22, '2024-01-15', 0),
(84, 22, '2024-01-22', 1),
(85, 22, '2024-01-29', 0),
(86, 23, '2024-02-02', 0),
(87, 23, '2024-02-09', 1),
(88, 23, '2024-02-16', 0),
(89, 23, '2024-02-23', 1),
(90, 23, '2024-03-01', 0),
(91, 24, '2024-02-02', 0),
(92, 24, '2024-02-09', 1),
(93, 24, '2024-02-16', 0),
(94, 24, '2024-02-23', 1),
(95, 24, '2024-03-01', 0),
(96, 25, '2024-02-02', 0),
(97, 25, '2024-02-09', 1),
(98, 25, '2024-02-16', 0),
(99, 25, '2024-02-23', 1),
(100, 25, '2024-03-01', 0),
(101, 26, '2024-01-01', 0),
(102, 26, '2024-01-08', 1),
(103, 26, '2024-01-15', 0),
(104, 26, '2024-01-22', 1),
(105, 26, '2024-01-29', 0),
(106, 27, '2024-02-02', 0),
(107, 27, '2024-02-09', 1),
(108, 27, '2024-02-16', 0),
(109, 27, '2024-02-23', 1),
(110, 27, '2024-03-01', 0),
(111, 28, '2024-02-02', 0),
(112, 28, '2024-02-09', 1),
(113, 28, '2024-02-16', 0),
(114, 28, '2024-02-23', 1),
(115, 28, '2024-03-01', 0),
(116, 29, '2024-02-02', 0),
(117, 29, '2024-02-09', 1),
(118, 29, '2024-02-16', 0),
(119, 29, '2024-02-23', 1),
(120, 29, '2024-03-01', 0),
(121, 30, '2024-02-02', 0),
(122, 30, '2024-02-09', 1),
(123, 30, '2024-02-16', 0),
(124, 30, '2024-02-23', 1),
(125, 30, '2024-03-01', 0),
(126, 31, '2024-01-01', 0),
(127, 31, '2024-01-08', 1),
(128, 31, '2024-01-15', 0),
(129, 31, '2024-01-22', 1),
(130, 31, '2024-01-29', 0),
(131, 32, '2024-02-02', 0),
(132, 32, '2024-02-09', 1),
(133, 32, '2024-02-16', 0),
(134, 32, '2024-02-23', 1),
(135, 32, '2024-03-01', 0),
(136, 33, '2024-02-02', 0),
(137, 33, '2024-02-09', 1),
(138, 33, '2024-02-16', 0),
(139, 33, '2024-02-23', 1),
(140, 33, '2024-03-01', 0),
(141, 34, '2024-02-02', 0),
(142, 34, '2024-02-09', 1),
(143, 34, '2024-02-16', 0),
(144, 34, '2024-02-23', 1),
(145, 34, '2024-03-01', 0),
(146, 35, '2024-02-02', 0),
(147, 35, '2024-02-09', 1),
(148, 35, '2024-02-16', 0),
(149, 35, '2024-02-23', 1),
(150, 35, '2024-03-01', 0),
(151, 36, '2024-01-01', 0),
(152, 36, '2024-01-08', 1),
(153, 36, '2024-01-15', 0),
(154, 36, '2024-01-22', 1),
(155, 36, '2024-01-29', 0),
(156, 37, '2024-02-02', 0),
(157, 37, '2024-02-09', 1),
(158, 37, '2024-02-16', 0),
(159, 37, '2024-02-23', 1),
(160, 37, '2024-03-01', 0),
(161, 38, '2024-02-02', 0),
(162, 38, '2024-02-09', 1),
(163, 38, '2024-02-16', 0),
(164, 38, '2024-02-23', 1),
(165, 38, '2024-03-01', 0),
(166, 39, '2024-02-02', 0),
(167, 39, '2024-02-09', 1),
(168, 39, '2024-02-16', 0),
(169, 39, '2024-02-23', 1),
(170, 39, '2024-03-01', 0),
(171, 40, '2024-02-02', 0),
(172, 40, '2024-02-09', 1),
(173, 40, '2024-02-16', 0),
(174, 40, '2024-02-23', 1),
(175, 40, '2024-03-01', 0),
(176, 41, '2024-01-01', 0),
(177, 41, '2024-01-08', 1),
(178, 41, '2024-01-15', 0),
(179, 41, '2024-01-22', 1),
(180, 41, '2024-01-29', 0),
(181, 42, '2024-02-02', 0),
(182, 42, '2024-02-09', 1),
(183, 42, '2024-02-16', 0),
(184, 42, '2024-02-23', 1),
(185, 42, '2024-03-01', 0),
(186, 43, '2024-02-02', 0),
(187, 43, '2024-02-09', 1),
(188, 43, '2024-02-16', 0),
(189, 43, '2024-02-23', 1),
(190, 43, '2024-03-01', 0),
(191, 44, '2024-02-02', 0),
(192, 44, '2024-02-09', 1),
(193, 44, '2024-02-16', 0),
(194, 44, '2024-02-23', 1),
(195, 44, '2024-03-01', 0),
(196, 45, '2024-02-02', 0),
(197, 45, '2024-02-09', 1),
(198, 45, '2024-02-16', 0),
(199, 45, '2024-02-23', 1),
(200, 45, '2024-03-01', 0),
(201, 46, '2024-01-01', 0),
(202, 46, '2024-01-08', 1),
(203, 46, '2024-01-15', 0),
(204, 46, '2024-01-22', 1),
(205, 46, '2024-01-29', 0),
(206, 47, '2024-02-02', 0),
(207, 47, '2024-02-09', 1),
(208, 47, '2024-02-16', 0),
(209, 47, '2024-02-23', 1),
(210, 47, '2024-03-01', 0),
(211, 48, '2024-02-02', 0),
(212, 48, '2024-02-09', 1),
(213, 48, '2024-02-16', 0),
(214, 48, '2024-02-23', 1),
(215, 48, '2024-03-01', 0),
(216, 49, '2024-02-02', 0),
(217, 49, '2024-02-09', 1),
(218, 49, '2024-02-16', 0),
(219, 49, '2024-02-23', 1),
(220, 49, '2024-03-01', 0),
(221, 50, '2024-02-02', 0),
(222, 50, '2024-02-09', 1),
(223, 50, '2024-02-16', 0),
(224, 50, '2024-02-23', 1),
(225, 50, '2024-03-01', 0),
(226, 51, '2024-01-01', 0),
(227, 51, '2024-01-08', 1),
(228, 51, '2024-01-15', 0),
(229, 51, '2024-01-22', 1),
(230, 51, '2024-01-29', 0),
(231, 52, '2024-02-02', 0),
(232, 52, '2024-02-09', 1),
(233, 52, '2024-02-16', 0),
(234, 52, '2024-02-23', 1),
(235, 52, '2024-03-01', 0),
(236, 53, '2024-02-02', 0),
(237, 53, '2024-02-09', 1),
(238, 53, '2024-02-16', 0),
(239, 53, '2024-02-23', 1),
(240, 53, '2024-03-01', 0),
(241, 54, '2024-02-02', 0),
(242, 54, '2024-02-09', 1),
(243, 54, '2024-02-16', 0),
(244, 54, '2024-02-23', 1),
(245, 54, '2024-03-01', 0),
(246, 55, '2024-02-02', 0),
(247, 55, '2024-02-09', 1),
(248, 55, '2024-02-16', 0),
(249, 55, '2024-02-23', 1),
(250, 55, '2024-03-01', 0);

-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `attendancetablelist`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `attendancetablelist`;
CREATE TABLE IF NOT EXISTS `attendancetablelist` (
`id` int(10) unsigned
,`fname` varchar(200)
,`lname` varchar(200)
,`name` varchar(255)
,`lessondate` date
,`attended` tinyint(1)
);

-- --------------------------------------------------------

--
-- Tabellstruktur `courses`
--

DROP TABLE IF EXISTS `courses`;
CREATE TABLE IF NOT EXISTS `courses` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `yhp` decimal(3,1) UNSIGNED NOT NULL,
  `description` varchar(700) NOT NULL,
  `startdate` date NOT NULL,
  `enddate` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumpning av Data i tabell `courses`
--

INSERT INTO `courses` (`id`, `name`, `yhp`, `description`, `startdate`, `enddate`) VALUES
(1, 'Frontend JavaScript 1', 40.0, 'I kursen Frontend JavaScript får du lära dig hur JavaScript fungerar och hur det används för att skapa dynamiska hemsidor. Du kommer under kursen få en gedigen översikt och grundläggande kunskaper i JavaScript och kommer efter genomgången kurs kunna använda dessa kunskaper till att själv bygga hemsidor.', '2024-01-01', '2024-12-21'),
(2, 'Databashantering', 25.0, 'I kursen databashantering får du lära dig att hantera databaser, får kännedom om databasstruktur och hur olika programmerings- och scriptspråk används för att bygga och underhålla databaser. Genom att få en fördjupad kunskap om databaser i e-handelsapplikationer och hanterandet, lagrandet och analyserandet av information om varor, produkter och användare kommer du kunna skapa databaslösningar som är optimala för e-handel', '2024-02-02', '2024-12-21'),
(3, 'Design och UX', 20.0, 'För att ett företags e-handel ska fungera optimalt krävs inte bara en robust teknisk infrastruktur. Hemsidor och applikationer måste dessutom vara attraktiva och användarvänliga. I denna kurs får du lära dig design och utformning utifrån designteori, färglära, strukturanpassning, användartestning, navigering och köpbeteende. Utifrån detta kommer du att kunna skapa genomtänkta och användarvänliga e-handelsplattformar.', '2024-02-02', '2024-12-21'),
(4, 'Digitala affärer och digital marknadsföring', 20.0, 'Här kommer du att få en holistisk förståelse för relationen mellan marknadsföring, köpbeteende och tekniska lösningar – utifrån vilken du kommer kunna kartlägga kunders beteende och optimera e-handelsapplikationer. Du kommer även lära dig hur man som digital marknadsförare använder analysverktyg och hur man mäter, utvärderar och analyserar marknadsföringsinsatser med ett fokus på ökad trafik, konverteringsgrad och lönsamhet.', '2024-02-02', '2024-12-21'),
(5, 'E-handelsplattformar', 40.0, 'Här får du bekanta dig med de ledande e-handelsplattformarna som utgör branschstandarden, såsom WordPress, Webcommerce och Shopify. Du kommer att lära dig om de olika e-handelsplattformarnas användningsområden, uppbyggnad, struktur och funktioner och hur du som webbutvecklare arbetar med dessa för att skapa effektiva e-handelsplattformar.', '2024-02-02', '2024-12-21'),
(10, 'Matematisk modellering i Java', 8.0, 'iubiu', '2024-07-04', '2024-07-30'),
(11, 'C++-programmering 1', 15.0, 'GrundlÃ¤ggande kurs i c++', '2024-08-05', '2024-08-27');

-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `studentcourselist`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `studentcourselist`;
CREATE TABLE IF NOT EXISTS `studentcourselist` (
`Förnamn:` varchar(200)
,`Efternamn:` varchar(200)
,`Kursnamn:` varchar(255)
,`YHP:` decimal(3,1) unsigned
,`Start-datum:` date
,`Slut-datum:` date
);

-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `students`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `students`;
CREATE TABLE IF NOT EXISTS `students` (
`id` int(10) unsigned
,`fname` varchar(200)
,`lname` varchar(200)
,`city` varchar(200)
,`phone` varchar(10)
);

-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `teachers`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `teachers`;
CREATE TABLE IF NOT EXISTS `teachers` (
`id` int(10) unsigned
,`fname` varchar(200)
,`lname` varchar(200)
,`city` varchar(200)
,`phone` varchar(10)
,`username` varchar(200)
,`password` varchar(200)
,`usertype` enum('Student','Teacher')
,`dbpassword` enum('123','1234')
);

-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `usercourselist`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `usercourselist`;
CREATE TABLE IF NOT EXISTS `usercourselist` (
`id` int(10) unsigned
,`usertype` enum('Student','Teacher')
,`fname` varchar(200)
,`lname` varchar(200)
,`name` varchar(255)
,`yhp` decimal(3,1) unsigned
,`startdate` date
,`enddate` date
);

-- --------------------------------------------------------

--
-- Tabellstruktur `usercourses`
--

DROP TABLE IF EXISTS `usercourses`;
CREATE TABLE IF NOT EXISTS `usercourses` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` int(10) UNSIGNED NOT NULL,
  `courseid` int(10) UNSIGNED NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `userid` (`userid`),
  KEY `courseid` (`courseid`)
) ENGINE=MyISAM AUTO_INCREMENT=58 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumpning av Data i tabell `usercourses`
--

INSERT INTO `usercourses` (`id`, `userid`, `courseid`) VALUES
(1, 26, 1),
(2, 27, 2),
(3, 28, 3),
(4, 29, 4),
(5, 30, 5),
(6, 1, 1),
(7, 1, 2),
(8, 2, 1),
(9, 2, 3),
(10, 3, 2),
(11, 3, 4),
(12, 4, 3),
(13, 4, 5),
(14, 5, 4),
(15, 5, 5),
(16, 6, 2),
(17, 6, 3),
(18, 7, 1),
(19, 7, 4),
(20, 8, 2),
(21, 8, 5),
(22, 9, 1),
(23, 9, 3),
(24, 10, 4),
(25, 10, 5),
(26, 11, 1),
(27, 11, 2),
(28, 12, 3),
(29, 12, 4),
(30, 13, 5),
(31, 13, 1),
(32, 14, 2),
(33, 14, 3),
(34, 15, 4),
(35, 15, 5),
(36, 16, 1),
(37, 16, 2),
(38, 17, 3),
(39, 17, 4),
(40, 18, 5),
(41, 18, 1),
(42, 19, 2),
(43, 19, 3),
(44, 20, 4),
(45, 20, 5),
(46, 21, 1),
(47, 21, 2),
(48, 22, 3),
(49, 22, 4),
(50, 23, 5),
(51, 23, 1),
(52, 24, 2),
(53, 24, 3),
(54, 25, 4),
(55, 25, 5),
(56, 26, 10),
(57, 26, 11);

-- --------------------------------------------------------

--
-- Ersättningsstruktur för vy `userlist`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `userlist`;
CREATE TABLE IF NOT EXISTS `userlist` (
`id` int(10) unsigned
,`fname` varchar(200)
,`lname` varchar(200)
,`city` varchar(200)
,`phone` varchar(10)
,`usertype` enum('Student','Teacher')
);

-- --------------------------------------------------------

--
-- Tabellstruktur `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fname` varchar(200) NOT NULL,
  `lname` varchar(200) NOT NULL,
  `city` varchar(200) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `username` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `usertype` enum('Student','Teacher') DEFAULT NULL,
  `dbpassword` enum('123','1234') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumpning av Data i tabell `users`
--

INSERT INTO `users` (`id`, `fname`, `lname`, `city`, `phone`, `username`, `password`, `usertype`, `dbpassword`) VALUES
(1, 'Anna', 'Svensson', 'Malmö', '0701234560', 'asvensson', 'password1', 'Student', '123'),
(2, 'Björn', 'Johansson', 'Lund', '0701234561', 'bjohansson', 'password2', 'Student', '123'),
(3, 'Carina', 'Karlsson', 'Helsingborg', '0701234562', 'ckarlsson', 'password3', 'Student', '123'),
(4, 'David', 'Andersson', 'Kristianstad', '0701234563', 'dandersson', 'password4', 'Student', '123'),
(5, 'Eva', 'Nilsson', 'Landskrona', '0701234564', 'enilsson', 'password5', 'Student', '123'),
(6, 'Filip', 'Eriksson', 'Trelleborg', '0701234565', 'feriksson', 'password6', 'Student', '123'),
(7, 'Greta', 'Persson', 'Ystad', '0701234566', 'gpersson', 'password7', 'Student', '123'),
(8, 'Henrik', 'Svensson', 'Ängelholm', '0701234567', 'hsvensson', 'password8', 'Student', '123'),
(9, 'Ingrid', 'Gustafsson', 'Malmö', '0701234568', 'igustafsson', 'password9', 'Student', '123'),
(10, 'Jakob', 'Lindberg', 'Lund', '0701234569', 'jlindberg', 'password10', 'Student', '123'),
(11, 'Karin', 'Olsson', 'Helsingborg', '0701234570', 'kolsson', 'password11', 'Student', '123'),
(12, 'Lars', 'Larsson', 'Kristianstad', '0701234571', 'llarsson', 'password12', 'Student', '123'),
(13, 'Maria', 'Nilsson', 'Landskrona', '0701234572', 'mnilsson', 'password13', 'Student', '123'),
(14, 'Nils', 'Jönsson', 'Trelleborg', '0701234573', 'njonsson', 'password14', 'Student', '123'),
(15, 'Oskar', 'Petersson', 'Ystad', '0701234574', 'opetersson', 'password15', 'Student', '123'),
(16, 'Petra', 'Eriksson', 'Ängelholm', '0701234575', 'periksson', 'password16', 'Student', '123'),
(17, 'Quentin', 'Fredriksson', 'Malmö', '0701234576', 'qfredriksson', 'password17', 'Student', '123'),
(18, 'Rita', 'Andersson', 'Lund', '0701234577', 'randersson', 'password18', 'Student', '123'),
(19, 'Simon', 'Svensson', 'Helsingborg', '0701234578', 'ssvensson', 'password19', 'Student', '123'),
(20, 'Tina', 'Nilsson', 'Kristianstad', '0701234579', 'tnilsson', 'password20', 'Student', '123'),
(21, 'Ulf', 'Karlsson', 'Landskrona', '0701234580', 'ukarlsson', 'password21', 'Student', '123'),
(22, 'Viktor', 'Eriksson', 'Trelleborg', '0701234581', 'veriksson', 'password22', 'Student', '123'),
(23, 'Wilma', 'Persson', 'Ystad', '0701234582', 'wpersson', 'password23', 'Student', '123'),
(24, 'Xander', 'Svensson', 'Ängelholm', '0701234583', 'xsvensson', 'password24', 'Student', '123'),
(25, 'Yvonne', 'Gustafsson', 'Malmö', '0701234584', 'ygustafsson', 'password25', 'Student', '123'),
(26, 'Zacharias', 'Lindberg', 'Lund', '0701234585', 'zlindberg', 'password26', 'Teacher', '1234'),
(27, 'Åsa', 'Olsson', 'Helsingborg', '0701234586', 'aolsson', 'password27', 'Teacher', '1234'),
(28, 'Ängla', 'Larsson', 'Kristianstad', '0701234587', 'alarsson', 'password28', 'Teacher', '1234'),
(29, 'Örjan', 'Nilsson', 'Landskrona', '0701234588', 'onilsson', 'password29', 'Teacher', '1234'),
(30, 'Östen', 'Jönsson', 'Trelleborg', '0701234589', 'ojonsson', 'password30', 'Teacher', '1234');

-- --------------------------------------------------------

--
-- Struktur för vy `attendancelist`
--
DROP TABLE IF EXISTS `attendancelist`;

DROP VIEW IF EXISTS `attendancelist`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `attendancelist`  AS SELECT `attendance`.`id` AS `#`, `students`.`fname` AS `Förnamn:`, `students`.`lname` AS `Efternamn:`, `courses`.`name` AS `Kursnamn:`, `attendance`.`lessondate` AS `Lektionsdatum:`, `attendance`.`attended` AS `Närvaro:` FROM ((`attendance` join `students` on(`attendance`.`studentid` = `students`.`id`)) join `courses` on(`attendance`.`courseid` = `courses`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur för vy `attendancetablelist`
--
DROP TABLE IF EXISTS `attendancetablelist`;

DROP VIEW IF EXISTS `attendancetablelist`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `attendancetablelist`  AS SELECT `users`.`id` AS `id`, `users`.`fname` AS `fname`, `users`.`lname` AS `lname`, `courses`.`name` AS `name`, `attendancetable`.`lessondate` AS `lessondate`, `attendancetable`.`attended` AS `attended` FROM (((`attendancetable` join `usercourses` on(`attendancetable`.`usercourseid` = `usercourses`.`id`)) join `courses` on(`usercourses`.`courseid` = `courses`.`id`)) join `users` on(`usercourses`.`userid` = `users`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur för vy `studentcourselist`
--
DROP TABLE IF EXISTS `studentcourselist`;

DROP VIEW IF EXISTS `studentcourselist`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `studentcourselist`  AS SELECT DISTINCT `students`.`fname` AS `Förnamn:`, `students`.`lname` AS `Efternamn:`, `courses`.`name` AS `Kursnamn:`, `courses`.`yhp` AS `YHP:`, `courses`.`startdate` AS `Start-datum:`, `courses`.`enddate` AS `Slut-datum:` FROM ((`attendance` join `students` on(`attendance`.`studentid` = `students`.`id`)) join `courses` on(`attendance`.`courseid` = `courses`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur för vy `students`
--
DROP TABLE IF EXISTS `students`;

DROP VIEW IF EXISTS `students`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `students`  AS SELECT `users`.`id` AS `id`, `users`.`fname` AS `fname`, `users`.`lname` AS `lname`, `users`.`city` AS `city`, `users`.`phone` AS `phone` FROM `users` WHERE `users`.`usertype` = 'Student' ;

-- --------------------------------------------------------

--
-- Struktur för vy `teachers`
--
DROP TABLE IF EXISTS `teachers`;

DROP VIEW IF EXISTS `teachers`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `teachers`  AS SELECT `users`.`id` AS `id`, `users`.`fname` AS `fname`, `users`.`lname` AS `lname`, `users`.`city` AS `city`, `users`.`phone` AS `phone`, `users`.`username` AS `username`, `users`.`password` AS `password`, `users`.`usertype` AS `usertype`, `users`.`dbpassword` AS `dbpassword` FROM `users` WHERE `users`.`usertype` = 'Teacher' ;

-- --------------------------------------------------------

--
-- Struktur för vy `usercourselist`
--
DROP TABLE IF EXISTS `usercourselist`;

DROP VIEW IF EXISTS `usercourselist`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `usercourselist`  AS SELECT `users`.`id` AS `id`, `users`.`usertype` AS `usertype`, `users`.`fname` AS `fname`, `users`.`lname` AS `lname`, `courses`.`name` AS `name`, `courses`.`yhp` AS `yhp`, `courses`.`startdate` AS `startdate`, `courses`.`enddate` AS `enddate` FROM ((`usercourses` join `users` on(`usercourses`.`userid` = `users`.`id`)) join `courses` on(`usercourses`.`courseid` = `courses`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur för vy `userlist`
--
DROP TABLE IF EXISTS `userlist`;

DROP VIEW IF EXISTS `userlist`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `userlist`  AS SELECT `users`.`id` AS `id`, `users`.`fname` AS `fname`, `users`.`lname` AS `lname`, `users`.`city` AS `city`, `users`.`phone` AS `phone`, `users`.`usertype` AS `usertype` FROM `users` ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
