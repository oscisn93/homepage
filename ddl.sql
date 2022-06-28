-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 28, 2022 at 03:14 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `university`
--

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `cno` int(4) NOT NULL,
  `title` varchar(64) DEFAULT NULL,
  `units` int(2) DEFAULT NULL,
  `textbook` varchar(64) DEFAULT NULL,
  `dp_no` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `degrees`
--

CREATE TABLE `degrees` (
  `prof_ssn` int(9) NOT NULL,
  `degree` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `dno` int(2) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `phone` int(10) DEFAULT NULL,
  `location` varchar(64) DEFAULT NULL,
  `chair_ssn` int(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `enrollement`
--

CREATE TABLE `enrollement` (
  `E_cno` int(4) NOT NULL,
  `E_sno` int(2) NOT NULL,
  `E_CWID` int(9) NOT NULL,
  `grade` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `minor`
--

CREATE TABLE `minor` (
  `st_CWID` int(9) NOT NULL,
  `minor_dno` int(2) NOT NULL COMMENT 'Unsure how to combined both of these foreign keys into a single primary key, but I think I did it correctly.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `prerequisetes`
--

CREATE TABLE `prerequisetes` (
  `main_cno` int(4) NOT NULL,
  `pre_cno` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `professor`
--

CREATE TABLE `professor` (
  `ssn` int(9) NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `salary` float(8,2) DEFAULT NULL,
  `title` varchar(16) DEFAULT NULL,
  `street` varchar(64) DEFAULT NULL,
  `city` varchar(64) DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `zip` int(5) DEFAULT NULL,
  `area_code` int(3) DEFAULT NULL,
  `phone` int(7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `section`
--

CREATE TABLE `section` (
  `scno` int(4) NOT NULL,
  `sno` int(2) NOT NULL,
  `number_of_seats` int(3) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `meeting_days` varchar(7) DEFAULT NULL,
  `instructor_ssn` int(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `CWID` int(9) NOT NULL,
  `Fname` varchar(64) NOT NULL,
  `Lname` varchar(64) NOT NULL,
  `address` varchar(256) NOT NULL,
  `phone` int(10) NOT NULL,
  `major_dno` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`cno`),
  ADD KEY `course_department` (`dp_no`);

--
-- Indexes for table `degrees`
--
ALTER TABLE `degrees`
  ADD PRIMARY KEY (`prof_ssn`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`dno`),
  ADD KEY `chairman_ssn` (`chair_ssn`) USING BTREE;

--
-- Indexes for table `enrollement`
--
ALTER TABLE `enrollement`
  ADD PRIMARY KEY (`E_cno`,`E_sno`,`E_CWID`) USING BTREE,
  ADD KEY `enrollment_CWID` (`E_CWID`),
  ADD KEY `enrollement_SNO` (`E_sno`);

--
-- Indexes for table `minor`
--
ALTER TABLE `minor`
  ADD PRIMARY KEY (`st_CWID`,`minor_dno`),
  ADD KEY `minor_student_dno` (`minor_dno`);

--
-- Indexes for table `prerequisetes`
--
ALTER TABLE `prerequisetes`
  ADD PRIMARY KEY (`main_cno`,`pre_cno`),
  ADD KEY `prerequisetes_cno_preqreq` (`pre_cno`);

--
-- Indexes for table `professor`
--
ALTER TABLE `professor`
  ADD PRIMARY KEY (`ssn`);

--
-- Indexes for table `section`
--
ALTER TABLE `section`
  ADD PRIMARY KEY (`scno`,`sno`),
  ADD KEY `section_instructor` (`instructor_ssn`),
  ADD KEY `sno` (`sno`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`CWID`),
  ADD KEY `student_major` (`major_dno`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_department` FOREIGN KEY (`dp_no`) REFERENCES `department` (`dno`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `degrees`
--
ALTER TABLE `degrees`
  ADD CONSTRAINT `degrees_prof_ssn` FOREIGN KEY (`prof_ssn`) REFERENCES `professor` (`ssn`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `department_chair_ssn` FOREIGN KEY (`chair_ssn`) REFERENCES `professor` (`ssn`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `enrollement`
--
ALTER TABLE `enrollement`
  ADD CONSTRAINT `enrollement_CNO` FOREIGN KEY (`E_cno`) REFERENCES `course` (`cno`) ON UPDATE CASCADE,
  ADD CONSTRAINT `enrollement_SNO` FOREIGN KEY (`E_sno`) REFERENCES `section` (`sno`) ON UPDATE CASCADE,
  ADD CONSTRAINT `enrollment_CWID` FOREIGN KEY (`E_CWID`) REFERENCES `student` (`CWID`) ON UPDATE CASCADE;

--
-- Constraints for table `minor`
--
ALTER TABLE `minor`
  ADD CONSTRAINT `minor_student_cwid` FOREIGN KEY (`st_CWID`) REFERENCES `student` (`CWID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `minor_student_dno` FOREIGN KEY (`minor_dno`) REFERENCES `department` (`dno`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `prerequisetes`
--
ALTER TABLE `prerequisetes`
  ADD CONSTRAINT `prerequisetes_cno_preqreq` FOREIGN KEY (`pre_cno`) REFERENCES `course` (`cno`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `prerequisetes_main_cno` FOREIGN KEY (`main_cno`) REFERENCES `course` (`cno`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `section`
--
ALTER TABLE `section`
  ADD CONSTRAINT `section_course_num` FOREIGN KEY (`scno`) REFERENCES `course` (`cno`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `section_instructor` FOREIGN KEY (`instructor_ssn`) REFERENCES `professor` (`ssn`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_major` FOREIGN KEY (`major_dno`) REFERENCES `department` (`dno`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
