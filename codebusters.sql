-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: codebusters.cfolwbsu62ee.us-west-2.rds.amazonaws.com:3306
-- Generation Time: Oct 25, 2016 at 11:56 AM
-- Server version: 5.6.27-log
-- PHP Version: 5.5.9-1ubuntu4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codebusters`
--

-- --------------------------------------------------------

--
-- Table structure for table `beds`
--

CREATE TABLE `beds` (
  `shelter_id` int(8) DEFAULT NULL,
  `bed_types` varchar(50) NOT NULL,
  `total` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `beds`
--

INSERT INTO `beds` (`shelter_id`, `bed_types`, `total`) VALUES
(1, '1,3', 20);

-- --------------------------------------------------------

--
-- Table structure for table `homeless`
--

CREATE TABLE `homeless` (
  `id` int(8) NOT NULL,
  `uuid` int(8) NOT NULL COMMENT 'homeless identifier',
  `type` int(4) NOT NULL,
  `size` int(2) NOT NULL DEFAULT '1',
  `invalid` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `homeless`
--

INSERT INTO `homeless` (`id`, `uuid`, `type`, `size`, `invalid`) VALUES
(1, 1, 2, 1, NULL),
(14, 14, 1, 1, NULL),
(15, 15, 1, 1, NULL),
(16, 16, 2, 1, NULL),
(17, 17, 2, 1, NULL),
(18, 18, 2, 1, NULL),
(19, 19, 2, 1, NULL),
(20, 20, 2, 1, NULL),
(21, 21, 2, 1, NULL),
(22, 22, 4, 3, NULL),
(23, 23, 4, 3, NULL),
(24, 24, 1, 1, NULL),
(25, 25, 1, 1, NULL),
(26, 26, 1, 1, NULL),
(27, 27, 1, 1, NULL),
(28, 28, 1, 1, NULL),
(29, 29, 1, 1, NULL),
(30, 30, 1, 1, NULL),
(31, 31, 1, 1, NULL),
(32, 32, 2, 1, NULL),
(33, 32, 1, 1, NULL),
(34, 34, 1, 1, NULL),
(35, 17, 3, 1, NULL),
(36, 36, 1, 1, NULL),
(37, 37, 1, 1, NULL),
(38, 38, 1, 1, NULL),
(39, 39, 1, 1, NULL),
(40, 40, 1, 1, NULL),
(41, 41, 1, 1, NULL),
(42, 42, 1, 1, NULL),
(43, 43, 1, 1, NULL),
(44, 44, 1, 1, NULL),
(45, 45, 1, 1, NULL),
(46, 46, 3, 1, NULL),
(47, 46, 3, 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `homeless_types`
--

CREATE TABLE `homeless_types` (
  `id` int(4) NOT NULL,
  `name` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `homeless_types`
--

INSERT INTO `homeless_types` (`id`, `name`) VALUES
(1, 'male youth'),
(2, 'female youth'),
(3, 'male adult'),
(4, 'female adult'),
(5, 'family');

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `shelter_id` int(8) NOT NULL,
  `type` varchar(50) NOT NULL,
  `total` int(8) NOT NULL,
  `available` int(8) NOT NULL,
  `auto_reset` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `shelters`
--

CREATE TABLE `shelters` (
  `id` int(8) NOT NULL,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `name` varchar(50) NOT NULL,
  `street` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(2) NOT NULL,
  `zip` varchar(5) NOT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL,
  `open` int(2) NOT NULL COMMENT 'hour of day [0-23]',
  `close` int(2) NOT NULL COMMENT 'hour of day [0-23]',
  `auto_check_out` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shelters`
--

INSERT INTO `shelters` (`id`, `username`, `password`, `name`, `street`, `city`, `state`, `zip`, `phone`, `website`, `open`, `close`, `auto_check_out`) VALUES
(1, 'ghs', '5f4dcc3b5aa765d61d8327deb882cf99', 'Gateway Homeless Services', '1000 N 19th Street', 'St. Louis', 'MO', '63106', '3142311515', 'http://www.gateway180.org/', 18, 8, 1),
(3, 'spc', '5f4dcc3b5aa765d61d8327deb882cf99', 'St. Patrick Center', '800 N Tucker Boulevard', 'St. Louis', 'MO', '63108', '3148020700', 'http://www.stpatrickcenter.org/', 19, 7, 1),
(4, 'sm', '5f4dcc3b5aa765d61d8327deb882cf99', 'Sunshine Ministries', '1520 N 13th Street', 'St. Louis', 'MO', '63106', '3142318209', 'http://www.sunshineministries.org/', 18, 8, 1);

-- --------------------------------------------------------

--
-- Table structure for table `shelter_check_in`
--

CREATE TABLE `shelter_check_in` (
  `id` int(8) NOT NULL,
  `shelter_id` int(8) DEFAULT NULL,
  `homeless_id` int(8) DEFAULT NULL,
  `in_timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  `out_timestamp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shelter_check_in`
--

INSERT INTO `shelter_check_in` (`id`, `shelter_id`, `homeless_id`, `in_timestamp`, `out_timestamp`) VALUES
(33, 1, 44, '2016-10-23 17:29:45', NULL),
(34, 1, 45, '2016-10-23 17:32:15', NULL),
(35, 1, 40, '2016-10-23 18:56:51', NULL),
(36, 1, 42, '2016-10-25 11:12:22', NULL),
(37, 1, 46, '2016-10-25 11:20:19', NULL),
(38, 1, 47, '2016-10-25 11:20:38', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `beds`
--
ALTER TABLE `beds`
  ADD KEY `shelter_id` (`shelter_id`);

--
-- Indexes for table `homeless`
--
ALTER TABLE `homeless`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `homeless_types`
--
ALTER TABLE `homeless_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD KEY `shelter_id` (`shelter_id`);

--
-- Indexes for table `shelters`
--
ALTER TABLE `shelters`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `shelter_check_in`
--
ALTER TABLE `shelter_check_in`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shelter_id` (`shelter_id`),
  ADD KEY `homeless_id` (`homeless_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `homeless`
--
ALTER TABLE `homeless`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;
--
-- AUTO_INCREMENT for table `homeless_types`
--
ALTER TABLE `homeless_types`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `shelters`
--
ALTER TABLE `shelters`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `shelter_check_in`
--
ALTER TABLE `shelter_check_in`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `beds`
--
ALTER TABLE `beds`
  ADD CONSTRAINT `beds_ibfk_1` FOREIGN KEY (`shelter_id`) REFERENCES `homeless` (`id`);

--
-- Constraints for table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_ibfk_1` FOREIGN KEY (`shelter_id`) REFERENCES `shelters` (`id`);

--
-- Constraints for table `shelter_check_in`
--
ALTER TABLE `shelter_check_in`
  ADD CONSTRAINT `shelter_check_in_ibfk_1` FOREIGN KEY (`shelter_id`) REFERENCES `shelters` (`id`),
  ADD CONSTRAINT `shelter_check_in_ibfk_2` FOREIGN KEY (`homeless_id`) REFERENCES `homeless` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
