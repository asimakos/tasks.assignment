-- phpMyAdmin SQL Dump
-- version 4.4.15.9
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 24, 2021 at 09:42 AM
-- Server version: 5.6.37
-- PHP Version: 7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tasks`
--

-- --------------------------------------------------------

--
-- Table structure for table `appeal`
--

CREATE TABLE IF NOT EXISTS `appeal` (
  `id` int(11) NOT NULL,
  `applicant` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `assigner` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `amount` double NOT NULL,
  `assigned` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `appeal`
--

INSERT INTO `appeal` (`id`, `applicant`, `assigner`, `amount`, `assigned`) VALUES
(1, 'Korinthian Palace-Catering AE', 'Περιφέρεια Ηπείρου (Π.Ε. Πρέβεζας)', 117475.85, '2021-01-12'),
(2, 'Αφοί Πιτροπάκη Ο.Ε', 'ΔΕΥΑ Ηρακλείου', 200000, '2021-01-26'),
(3, 'NEW ALERT', 'Ιδρυμα Νεολαίας και Δια Βίου Μάθησης', 499100, '2021-02-09'),
(4, 'ΗΛΕΚΤΩΡ ΑΕ ', 'Δήμος Χίου  ', 3700000, '2021-02-18');

-- --------------------------------------------------------

--
-- Table structure for table `assist`
--

CREATE TABLE IF NOT EXISTS `assist` (
  `id` int(11) NOT NULL,
  `title` text COLLATE utf8_unicode_ci NOT NULL,
  `assigned` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `assist`
--

INSERT INTO `assist` (`id`, `title`, `assigned`) VALUES
(1, 'Ενεργειακή αναβάθμιση κλειστού κολυμβητηρίου Ιωαννίνων (Π.Ε.Α.Κ.Ι.)', '2021-03-18'),
(2, 'Επισκευή, συντήρηση και συμμόρφωση με τις παρατηρήσεις του φορέα πιστοποίησης των ανελκυστήρων για τα κτίρια του Σ.Ε ΑΣΠΑΙΤΕ (αρ. διακήρυξης 621/30/2020) και άλλων αρμοδίων φορέων.', '2021-02-15'),
(3, 'Προμήθεια ελαστικών επίσωτρων και διαφόρων ανταλλακτικών-αναλώσιμων για τα οχήματα του Δήμου Δέλτα', '2021-01-12');

-- --------------------------------------------------------

--
-- Table structure for table `judge`
--

CREATE TABLE IF NOT EXISTS `judge` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `assigned` date NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `judge`
--

INSERT INTO `judge` (`id`, `name`, `assigned`) VALUES
(1, '314-2021', '2021-03-03'),
(2, '420-2021', '2021-03-03'),
(3, 'A32 - 2021', '2021-03-03'),
(4, '299-2021', '2021-03-11'),
(5, '428-2021', '2021-03-11'),
(6, '445-2021', '2021-03-23'),
(7, '485-2021', '2021-04-05');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `activation` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`, `email`, `activation`, `active`) VALUES
(1, 'kostas', 'eawMmfdmaCpCQNApFf79wg==', 'ΚΩΝΣΤΑΝΤΙΝΟΣ ΠΑΠΑΔΟΠΟΥΛΟΣ', 'kon@in.gr', '5B43FAD3-6FF4-4403-B6A24C080C4B7B0D', 1),
(2, 'takis', 'Ifv3vrqNgCmaSierwWHvqg==', 'ΠΑΝΑΓΙΩΤΗΣ ΓΕΩΡΓΙΟΥ', 'takis@in.gr', '6515AE0C-25C7-4D16-815478FEA643A616', 1),
(3, 'asimakos', 'Gv4j0VQAji3P/TlJbhhgIw==', 'ΚΩΣΤΑΣ  ΑΣΗΜΑΚΟΠΟΥΛΟΣ', 'asimkostas@yahoo.com', '6C21C47A-7CA6-4AC2-B37AF7C1E8A6BFDE', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users_appeal`
--

CREATE TABLE IF NOT EXISTS `users_appeal` (
  `userid` int(11) NOT NULL,
  `appealid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users_appeal`
--

INSERT INTO `users_appeal` (`userid`, `appealid`) VALUES
(1, 1),
(1, 2),
(2, 3),
(1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `users_assist`
--

CREATE TABLE IF NOT EXISTS `users_assist` (
  `userid` int(11) NOT NULL,
  `assistid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users_assist`
--

INSERT INTO `users_assist` (`userid`, `assistid`) VALUES
(1, 1),
(1, 2),
(2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `users_judge`
--

CREATE TABLE IF NOT EXISTS `users_judge` (
  `userid` int(11) NOT NULL,
  `judgeid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users_judge`
--

INSERT INTO `users_judge` (`userid`, `judgeid`) VALUES
(1, 1),
(1, 2),
(2, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appeal`
--
ALTER TABLE `appeal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `assist`
--
ALTER TABLE `assist`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `judge`
--
ALTER TABLE `judge`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users_appeal`
--
ALTER TABLE `users_appeal`
  ADD PRIMARY KEY (`userid`,`appealid`),
  ADD KEY `appeal_association` (`appealid`);

--
-- Indexes for table `users_assist`
--
ALTER TABLE `users_assist`
  ADD PRIMARY KEY (`userid`,`assistid`),
  ADD KEY `assist_association` (`assistid`);

--
-- Indexes for table `users_judge`
--
ALTER TABLE `users_judge`
  ADD PRIMARY KEY (`userid`,`judgeid`),
  ADD KEY `judge_association` (`judgeid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appeal`
--
ALTER TABLE `appeal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `assist`
--
ALTER TABLE `assist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `judge`
--
ALTER TABLE `judge`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `users_appeal`
--
ALTER TABLE `users_appeal`
  ADD CONSTRAINT `appeal_association` FOREIGN KEY (`appealid`) REFERENCES `appeal` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `user_relation` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `users_assist`
--
ALTER TABLE `users_assist`
  ADD CONSTRAINT `assist_association` FOREIGN KEY (`assistid`) REFERENCES `assist` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `user_link` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `users_judge`
--
ALTER TABLE `users_judge`
  ADD CONSTRAINT `judge_association` FOREIGN KEY (`judgeid`) REFERENCES `judge` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `user_association` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
