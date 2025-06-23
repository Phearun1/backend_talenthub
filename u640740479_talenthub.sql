-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 23, 2025 at 09:05 AM
-- Server version: 10.11.10-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u640740479_talenthub`
--

-- --------------------------------------------------------

--
-- Table structure for table `achievements`
--

CREATE TABLE `achievements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `portfolio_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `issued_by` varchar(255) DEFAULT NULL,
  `issue_month` varchar(255) DEFAULT NULL,
  `issue_year` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `achievements`
--

INSERT INTO `achievements` (`id`, `portfolio_id`, `title`, `issued_by`, `issue_month`, `issue_year`, `description`, `image`, `created_at`, `updated_at`) VALUES
(32, 40, 'Network Mastery for Ethical Hacking', 'Udemy', 'April', '2025', 'This course teaches you the foundation of networking.', 'https://talenthub.newlinkmarketing.com/storage/achievements/BDHXuQsfmqSzI6jOaROnz7MK6a3FyBwCZSIVJWte.png', '2025-04-27 15:07:28', '2025-05-12 07:22:36'),
(34, 59, 'I got nth', 'paragon', 'December', '2023', 'asfasdfsdf', 'https://talenthub.newlinkmarketing.com/storage/achievements/3m4Mf12otgHJF3S7JFP5fO3RFhFZTYMaug93i3JK.jpg', '2025-05-12 06:51:45', '2025-05-12 06:51:45'),
(37, 64, 'Network Scanning', 'Udemy', 'March', '2025', 'I have completed a course where I learnt the fundamental of network scanning.', 'https://talenthub.newlinkmarketing.com/storage/achievements/BPO88pnjHt3axE1SpzmWXS5AIB8Kmgdnc4Y7y3ff.png', '2025-05-25 09:14:08', '2025-06-18 15:32:30'),
(39, 77, 'Course Certificate in Write With AI.', 'Sololearn', 'March', '2025', 'I have successfully completed the course by demonstrating theoretical and practical understanding of \"Write With AI\"', 'https://talenthub.newlinkmarketing.com/storage/achievements/ZyWdflT1QpWivzia8s0BGbMqyoFEaT14WWm5BA2P.jpg', '2025-05-29 06:23:12', '2025-05-29 06:23:12'),
(40, 77, 'Course Certificate in Introduction to C++', 'Sololearn', 'March', '2025', 'I have successfully completed the course by demonstrating theoretical and practical understanding of \'\'Introduction to C++\'\'.', 'https://talenthub.newlinkmarketing.com/storage/achievements/qdeCIVg2izJpHqMhhKzWEgDOld5msUKSaQ1PnOmh.jpg', '2025-05-29 06:26:38', '2025-05-29 06:26:38'),
(41, 93, 'ths', 'asd', 'March', '2023', 'asdad', 'https://talenthub.newlinkmarketing.com/storage/achievements/yD9odn1CldLAQrbPNLpAngoq42IfdlNc9e8jx7zr.png', '2025-05-31 05:54:56', '2025-05-31 05:54:56'),
(42, 113, 'Communist party outstanding certificate', 'Communist party', 'February', '2021', 'that\'s great', 'https://talenthub.newlinkmarketing.com/storage/achievements/Cz0wi3VjqxmLqM3CCqX37L9PDbcO9g6fhulTRq9P.jpg', '2025-06-02 08:04:06', '2025-06-02 08:04:06'),
(43, 115, 'test', 'test', 'January', '2025', 'test', 'https://talenthub.newlinkmarketing.com/storage/achievements/wYZAUHPGSLZizrbunOgiJw3JbfaJ1FJdiSUp8xAt.png', '2025-06-02 11:46:11', '2025-06-02 11:46:11');

-- --------------------------------------------------------

--
-- Table structure for table `achievement_endorsement_statuses`
--

CREATE TABLE `achievement_endorsement_statuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `achievement_id` int(11) NOT NULL,
  `endorsement_status_id` int(11) NOT NULL,
  `endorser_id` varchar(225) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `achievement_endorsement_statuses`
--

INSERT INTO `achievement_endorsement_statuses` (`id`, `achievement_id`, `endorsement_status_id`, `endorser_id`, `created_at`, `updated_at`) VALUES
(53, 32, 2, '105112392647691820585', '2025-05-12 07:17:33', '2025-05-12 07:17:42'),
(54, 32, 1, '116476710830297179900', '2025-05-12 07:22:36', '2025-05-12 07:22:36'),
(57, 37, 2, '118098064367283271535', '2025-06-18 15:30:01', '2025-06-18 15:30:11');

-- --------------------------------------------------------

--
-- Table structure for table `achievement_endorsers`
--

CREATE TABLE `achievement_endorsers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `achievement_id` int(11) NOT NULL,
  `user_id` varchar(110) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `achievement_endorsers`
--

INSERT INTO `achievement_endorsers` (`id`, `achievement_id`, `user_id`, `created_at`, `updated_at`) VALUES
(57, 32, '105112392647691820585', '2025-05-12 07:17:33', '2025-05-12 07:17:33'),
(58, 32, '116476710830297179900', '2025-05-12 07:22:36', '2025-05-12 07:22:36'),
(61, 37, '118098064367283271535', '2025-06-18 15:30:01', '2025-06-18 15:30:01');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `is_super_admin` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `email`, `name`, `password`, `role_id`, `is_super_admin`, `created_at`, `updated_at`) VALUES
(6, 'phearun6600@gmail.com', 'Phearun', '$2y$12$oG39gCKHQXG1H/J0BfNDOO.NU26KtNDqQojUuCdcGAshyjA8JW5KC', 3, 1, '2025-05-20 04:11:59', '2025-05-20 04:15:02'),
(7, 'salduong97@gmail.com', 'visal', '$2y$12$bQdD0DNeFDNVdLRqTuLYVe1S1zkFiulaYzEPFDsJip076HxPInMZ.', 3, 0, '2025-06-18 14:41:15', '2025-06-18 14:41:15');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `company_name`, `created_at`, `updated_at`) VALUES
(1, 'Microsoft Corporation', '2025-04-01 07:26:18', '2025-04-01 07:26:18'),
(2, 'Google LLC', '2025-04-01 07:26:18', '2025-04-01 07:26:18'),
(3, 'Amazon Web Services', '2025-04-01 07:26:18', '2025-04-01 07:26:18'),
(4, 'Apple Inc.', '2025-04-01 07:26:18', '2025-04-01 07:26:18'),
(5, 'Meta Platforms', '2025-04-01 07:26:18', '2025-04-01 07:26:18'),
(6, 'Tesla, Inc.', '2025-04-01 07:26:18', '2025-04-01 07:26:18'),
(7, 'Netflix, Inc.', '2025-04-01 07:26:18', '2025-04-01 07:26:18'),
(8, 'IBM Corporation', '2025-04-01 07:26:18', '2025-04-01 07:26:18'),
(9, 'Oracle Corporation', '2025-04-01 07:26:18', '2025-04-01 07:26:18'),
(10, 'Salesforce, Inc.', '2025-04-01 07:26:18', '2025-04-01 07:26:18'),
(11, 'Adobe Inc.', '2025-04-01 07:26:18', '2025-04-01 07:26:18'),
(12, 'Cisco Systems', '2025-04-01 07:26:18', '2025-04-01 07:26:18'),
(13, 'Intel Corporation', '2025-04-01 07:26:18', '2025-04-01 07:26:18'),
(14, 'NVIDIA Corporation', '2025-04-01 07:26:18', '2025-04-01 07:26:18'),
(15, 'Samsung Electronics', '2025-04-01 07:26:18', '2025-04-01 07:26:18'),
(16, 'asdf', '2025-04-01 15:00:29', '2025-04-01 15:00:29'),
(17, 'Facebook', '2025-04-01 16:09:20', '2025-04-01 16:09:20'),
(18, 'Saat', '2025-04-01 16:15:16', '2025-04-01 16:15:16'),
(19, 'Apples', '2025-04-01 16:35:37', '2025-04-01 16:35:37'),
(20, 'Phearun Company', '2025-04-02 06:33:34', '2025-04-02 06:33:34'),
(21, 'Visal Company', '2025-04-02 06:43:58', '2025-04-02 06:43:58'),
(22, 'Apple', '2025-04-02 07:40:07', '2025-04-02 07:40:07'),
(23, 'te', '2025-04-02 07:47:19', '2025-04-02 07:47:19'),
(24, 'Phearun Company', '2025-04-02 08:25:49', '2025-04-02 08:25:49'),
(25, 'Phearun Company', '2025-04-02 14:28:32', '2025-04-02 14:28:32'),
(26, 'Tes', '2025-04-03 02:21:35', '2025-04-03 02:21:35'),
(27, 'test', '2025-04-03 02:25:26', '2025-04-03 02:25:26'),
(28, 'Saa', '2025-04-03 15:33:30', '2025-04-03 15:33:30'),
(29, 't', '2025-04-26 16:13:35', '2025-04-26 16:13:35'),
(30, 'Paragon International University', '2025-05-03 09:33:29', '2025-05-03 09:33:29'),
(31, 'Smart', '2025-05-12 06:50:17', '2025-05-12 06:50:17'),
(32, 'Udaya Technology', '2025-05-22 10:03:34', '2025-05-22 10:03:34'),
(33, 'dreamslab', '2025-05-27 15:52:10', '2025-05-27 15:52:10'),
(34, 'Goose Pala', '2025-05-28 08:27:11', '2025-05-28 08:27:11'),
(35, 'Self-employed', '2025-05-29 06:45:26', '2025-05-29 06:45:26'),
(36, 'Self-employed.', '2025-05-29 06:45:46', '2025-05-29 06:45:46'),
(37, 'AppSOTH', '2025-05-30 04:14:14', '2025-05-30 04:14:14'),
(38, 'Joe\'s Donut', '2025-06-02 08:00:44', '2025-06-02 08:00:44');

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `google_id` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`id`, `google_id`, `email`, `phone_number`, `created_at`, `updated_at`) VALUES
(2, '106199674194179636945', 'phearuntesting@gmail.com', '012312312', '2025-06-13 03:38:27', '2025-06-13 03:39:14'),
(21, '115609318949887683531', 'salduong97@gmail.com', '017614694', '2025-06-17 16:00:53', '2025-06-17 16:02:28'),
(28, '105664580476841290147', 'dara@gmail.com', '016805280', '2025-06-18 16:20:50', '2025-06-18 16:20:50');

-- --------------------------------------------------------

--
-- Table structure for table `education`
--

CREATE TABLE `education` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `portfolio_id` int(11) NOT NULL,
  `education_center` varchar(255) NOT NULL,
  `field_of_study` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `start_month` varchar(255) NOT NULL,
  `end_month` varchar(255) DEFAULT NULL,
  `start_year` varchar(255) NOT NULL,
  `end_year` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `education`
--

INSERT INTO `education` (`id`, `portfolio_id`, `education_center`, `field_of_study`, `description`, `start_month`, `end_month`, `start_year`, `end_year`, `created_at`, `updated_at`) VALUES
(31, 40, 'Paragon International Universitys', 'Computer Science', 'I am a senior in ParagonIU, where I am majoring in Computer Science. I have learnt a lot throughout these 3 years.', 'February', NULL, '2022', '2024', '2025-04-03 15:34:28', '2025-05-20 02:14:34'),
(33, 41, 'asffaUniversity of Example', 'Computer Science', 'Bachelor of Science in Computer Science', 'March', 'Dahi', '2015', '2019', '2025-04-05 09:13:05', '2025-04-05 09:13:05'),
(42, 59, 'paragon', 'Information technology', 'ok', 'December', NULL, '2024', NULL, '2025-05-12 06:49:23', '2025-05-12 06:49:23'),
(44, 64, 'Paragon International University', 'Computer Science', 'I am majoring in Computer Science at PIU, where I am learning a lot and have been developing multiple projects.', 'January', NULL, '2022', NULL, '2025-05-25 09:12:06', '2025-05-25 09:12:06'),
(45, 60, 'Paragon International University', 'Computer science', 'I study computer science', 'January', 'July', '2021', '2025', '2025-05-27 15:53:08', '2025-05-27 15:53:08'),
(46, 71, 'Paragon', 'Management Info System', 'blah testing', 'February', NULL, '2022', NULL, '2025-05-28 13:51:16', '2025-05-28 13:51:33'),
(47, 77, 'Paragon International University.', 'Digital Art and Design.', 'I am majoring in Digital Art and Design at Paragon International University.', 'December', NULL, '2024', NULL, '2025-05-29 06:18:34', '2025-05-29 06:18:34'),
(48, 80, 'Paragon International University', 'Computer Science', 'Majoring in Computer Science. Learn and improve a lot from this university', 'January', 'August', '2022', NULL, '2025-05-29 13:18:44', '2025-05-29 13:18:51'),
(49, 85, 'Paragon International University', 'Computer Science', 'Senior at ParagonIU', 'January', 'August', '2022', '2025', '2025-05-30 06:50:54', '2025-05-30 06:50:54'),
(50, 49, 'test', 'test', 'saddasd', 'January', NULL, '2022', NULL, '2025-06-01 13:39:12', '2025-06-01 13:39:12'),
(51, 115, 'test', 'test', 'testt', 'February', NULL, '2025', NULL, '2025-06-02 11:44:31', '2025-06-02 11:44:31'),
(52, 115, 'testest', 'test', 'test', 'January', 'January', '2007', '2007', '2025-06-02 11:44:52', '2025-06-02 11:44:52');

-- --------------------------------------------------------

--
-- Table structure for table `endorsement_statuses`
--

CREATE TABLE `endorsement_statuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `endorsement_statuses`
--

INSERT INTO `endorsement_statuses` (`id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Pending', '2025-03-31 03:10:33', '2025-03-31 03:10:33'),
(2, 'Approved', '2025-03-31 03:10:33', '2025-03-31 03:10:33'),
(3, 'Declined', '2025-03-31 03:10:33', '2025-03-31 03:10:33'),
(4, 'Banned', '2025-03-31 03:10:33', '2025-03-31 03:10:33');

-- --------------------------------------------------------

--
-- Table structure for table `endorser_request`
--

CREATE TABLE `endorser_request` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `contact` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `company` varchar(255) NOT NULL,
  `working_position` varchar(255) NOT NULL,
  `student_name` text DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  `status` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `experiences`
--

CREATE TABLE `experiences` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `portfolio_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `work_title` varchar(256) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `employment_type` varchar(255) DEFAULT NULL,
  `start_month` varchar(255) NOT NULL,
  `start_year` varchar(255) NOT NULL,
  `end_month` varchar(255) DEFAULT NULL,
  `end_year` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `experiences`
--

INSERT INTO `experiences` (`id`, `portfolio_id`, `company_id`, `work_title`, `description`, `employment_type`, `start_month`, `start_year`, `end_month`, `end_year`, `created_at`, `updated_at`) VALUES
(68, 40, 18, 'Full-stack developer', 'I developed mobile application using Flutter, API and backend systems using Laravel.', 'Internship', 'March', '2024', NULL, NULL, '2025-04-03 15:33:30', '2025-05-20 02:04:54'),
(73, 49, 21, 'Software Developer', 'Developed and maintained web applications.', 'Part-time', 'January', '2020', 'December', '2022', '2025-04-07 07:17:48', '2025-06-18 15:25:01'),
(80, 55, 3, 'Developer', 'Develop ERP system of Amazon warehouse.', 'Internship', 'February', '2013', NULL, NULL, '2025-05-04 10:10:09', '2025-05-04 10:13:17'),
(81, 57, 3, 'UX/UI Developer', 'Develop ERP system of Amazon warehouse.', 'Internship', 'February', '2013', NULL, NULL, '2025-05-04 10:10:09', '2025-05-04 10:13:17'),
(82, 58, 3, 'Software Developer', 'Develop ERP system of Amazon warehouse.', 'Internship', 'February', '2013', NULL, NULL, '2025-05-04 10:10:09', '2025-05-04 10:13:17'),
(84, 59, 31, 'Billing admin', 'asfasdfad', 'Full-time', 'August', '2024', NULL, NULL, '2025-05-12 06:50:17', '2025-05-12 06:50:17'),
(85, 64, 32, 'Mobile Developers', 'Built and debugged mobile applications using Flutter.\nIntegrated APIs to optimize frontend-backend communication.', 'Internship', 'August', '2023', 'November', '2023', '2025-05-22 10:03:34', '2025-06-17 14:54:28'),
(86, 60, 33, 'game developer', 'built a 3d game from scratch using unity. followed deadlines from project manager.', 'Internship', 'July', '2024', 'October', '2024', '2025-05-27 15:52:10', '2025-05-27 15:52:10'),
(87, 67, 34, 'Goose Farmer', 'raises and tends to geese for various purposes. Geese farming has gained popularity among farmers for its benefits, which include meat production, egg harvesting, and even pest control.', 'Full-time', 'January', '2000', NULL, NULL, '2025-05-28 08:27:11', '2025-05-28 08:27:11'),
(88, 77, 36, 'Graphic designer', 'Providing services such as Social Media advertisement, Banners, Poster, Flyers, Logos, Thumbnail, Digital Artist & hand-base drawing art, Write with AI.', 'Freelance', 'February', '2024', NULL, NULL, '2025-05-29 06:45:26', '2025-06-04 08:38:39'),
(89, 85, 30, 'Backend Developer', 'Manage backend code for Paragon.U systems.', 'Full-time', 'April', '2025', NULL, NULL, '2025-05-30 04:11:19', '2025-05-30 06:35:18'),
(90, 85, 37, 'Backend Developer', 'Develop outsourcing projects', 'Freelance', 'November', '2023', NULL, NULL, '2025-05-30 04:14:14', '2025-05-30 04:14:14'),
(91, 90, 35, 'Full-stack Developer', 'Lorem asdasdasdasdasd', 'Freelance', 'January', '2024', NULL, NULL, '2025-05-30 08:37:26', '2025-05-30 08:37:26'),
(92, 113, 38, 'Janitor', 'I washed out the entire company', 'Full-time', 'February', '2008', 'April', '2010', '2025-06-02 08:00:44', '2025-06-02 08:00:44'),
(93, 115, 27, 'test', 'test', 'Internship', 'January', '2007', NULL, NULL, '2025-06-02 11:44:06', '2025-06-02 11:44:06'),
(94, 54, 18, 'Full Stack Developer', 'Worked as a full stack developer, utilizing flutter to develop mobile app, laravel and reactjs to develop a full stack web application.', 'Internship', 'March', '2024', NULL, NULL, '2025-06-17 14:52:26', '2025-06-17 14:52:26');

-- --------------------------------------------------------

--
-- Table structure for table `experience_endorsement_statuses`
--

CREATE TABLE `experience_endorsement_statuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `experience_id` int(11) NOT NULL,
  `experience_status_id` int(11) NOT NULL,
  `endorser_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `experience_endorsement_statuses`
--

INSERT INTO `experience_endorsement_statuses` (`id`, `experience_id`, `experience_status_id`, `endorser_id`, `created_at`, `updated_at`) VALUES
(104, 73, 2, '116476710830297179900', '2025-04-07 07:17:48', '2025-05-27 07:29:59'),
(108, 68, 2, '105112392647691820585', '2025-05-13 07:46:10', '2025-05-13 07:46:19'),
(112, 85, 2, '116973618827169503318', '2025-05-30 04:12:37', '2025-05-30 04:13:02'),
(113, 89, 2, '110615078229468432506', '2025-05-30 06:34:49', '2025-05-30 06:35:09'),
(114, 85, 2, '118402940873463506267', '2025-05-31 05:59:01', '2025-05-31 05:59:43');

-- --------------------------------------------------------

--
-- Table structure for table `experience_endorsers`
--

CREATE TABLE `experience_endorsers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `experience_id` int(11) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `experience_endorsers`
--

INSERT INTO `experience_endorsers` (`id`, `experience_id`, `user_id`, `created_at`, `updated_at`) VALUES
(108, 73, '116476710830297179900', '2025-04-07 07:17:48', '2025-04-07 07:17:48'),
(112, 68, '105112392647691820585', '2025-05-13 07:46:10', '2025-05-13 07:46:10'),
(116, 85, '116973618827169503318', '2025-05-30 04:12:37', '2025-05-30 04:12:37'),
(117, 89, '110615078229468432506', '2025-05-30 06:34:49', '2025-05-30 06:34:49'),
(118, 85, '118402940873463506267', '2025-05-31 05:59:01', '2025-05-31 05:59:01');

-- --------------------------------------------------------

--
-- Table structure for table `majors`
--

CREATE TABLE `majors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `major` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `majors`
--

INSERT INTO `majors` (`id`, `major`, `created_at`, `updated_at`) VALUES
(1, 'Computer Science', '2025-03-25 20:37:22', '2025-03-25 20:37:22'),
(2, 'Management of Information System', '2025-03-25 20:37:22', '2025-03-25 20:37:22'),
(3, 'Digital Arts and Design', '2025-03-25 20:37:22', '2025-03-25 20:37:22');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2025_03_21_074522_create_users_table', 1),
(2, '2025_03_21_075047_create_admins_table', 1),
(3, '2025_03_21_080724_create_portfolios_table', 1),
(4, '2025_03_21_081916_create_projects_table', 1),
(5, '2025_03_21_082536_create_experiences_table', 1),
(6, '2025_03_21_083021_create_education_table', 1),
(7, '2025_03_21_083401_create_achievements_table', 1),
(8, '2025_03_21_083931_create_skills_table', 1),
(9, '2025_03_21_084153_create_project_endorsers_table', 1),
(10, '2025_03_21_084947_create_experience_endorsers_table', 1),
(11, '2025_03_21_085014_create_education_endorsers_table', 1),
(12, '2025_03_21_085101_create_achievement_endorsers_table', 1),
(13, '2025_03_21_085117_create_skill_endorsers_table', 1),
(14, '2025_03_21_085146_create_project_collaborators_table', 1),
(15, '2025_03_21_085317_create_roles_table', 1),
(16, '2025_03_21_085350_create_majors_table', 1),
(17, '2025_03_21_092250_create_project_languages_table', 1),
(18, '2025_03_21_092326_create_programming_languages_table', 1),
(19, '2025_03_21_092426_create_project_images_table', 1),
(20, '2025_03_21_092527_create_companies_table', 1),
(21, '2025_03_21_092555_create_endorsement_statuses_table', 1),
(22, '2025_03_21_092645_create_project_endorsement_statuses_table', 1),
(23, '2025_03_21_092758_create_experience_endorsement_statuses_table', 1),
(24, '2025_03_21_094612_create_achievement_endorsement_statuses_table', 1),
(25, '2025_03_21_094645_create_skill_endorsement_statuses_table', 1),
(26, '2025_03_24_042752_create_project_collaboration_statuses_table', 1),
(27, '2025_03_24_043620_create_project_collaborator_invitation_statuses_table', 1),
(28, '2025_03_24_045658_create_personal_access_tokens_table', 2),
(29, '2025_03_24_074111_create_cache_table', 3),
(30, '2019_12_14_000001_create_personal_access_tokens_table', 4),
(31, '2025_03_25_043209_create_sessions_table', 5);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'API Token', 'aa698d64e624e6c00390410ef4ec786df589113f060bf4a991c2bee5092221b6', '[\"*\"]', NULL, NULL, '2025-03-24 01:21:06', '2025-03-24 01:21:06'),
(27, 'App\\Models\\Admin', 1, 'API Token', 'b1686cfb0c43e36dd354fe1895534d883762567853558ec1beb6f0547f7aeef1', '[\"*\"]', '2025-03-27 02:48:55', '2025-04-08 00:13:10', '2025-03-25 00:13:10', '2025-03-27 02:48:55'),
(28, 'App\\Models\\Admin', 2, 'API Token', 'c4d0cc3bd91836ca8ad6c8b137a42d30dddc2c898caf406093090d0949952d93', '[\"*\"]', NULL, '2025-04-08 00:15:37', '2025-03-25 00:15:37', '2025-03-25 00:15:37'),
(29, 'App\\Models\\Admin', 2, 'API Token', '6e0cc4164577ad7668627d4d4f7e1fd88ed18285bb71db531b582a107ca3977f', '[\"*\"]', NULL, '2025-04-08 01:04:11', '2025-03-25 01:04:11', '2025-03-25 01:04:11'),
(30, 'App\\Models\\User', 4, 'API Token', '330f3e32901a332e9bc554c1392201d94b6c7b59da0d6f55cff5a7ebbfe3b072', '[\"*\"]', NULL, '2025-04-08 01:04:27', '2025-03-25 01:04:27', '2025-03-25 01:04:27'),
(31, 'App\\Models\\User', 6, 'API Token', 'bbaaea49710bbcb14dc019dab6d936e50461c422d139164e93f2abe4dfaf2140', '[\"*\"]', NULL, '2025-04-08 01:04:33', '2025-03-25 01:04:33', '2025-03-25 01:04:33'),
(32, 'App\\Models\\User', 6, 'API Token', 'b5e7326a998ecee58acc5fa2fcf95f6b342a8acfd91f73ac6e2efe38203d2e87', '[\"*\"]', NULL, '2025-04-08 01:04:37', '2025-03-25 01:04:37', '2025-03-25 01:04:37'),
(33, 'App\\Models\\User', 4, 'API Token', '792e3507311d389ba8fb03d958aee519554798f73b4d9498616052e035007679', '[\"*\"]', '2025-03-25 02:01:58', '2025-04-08 01:33:32', '2025-03-25 01:33:32', '2025-03-25 02:01:58'),
(34, 'App\\Models\\User', 4, 'API Token', 'dfe2a1f9579bb2afc10b03f3c38b829be431374254c8acea874d1199ed38fc83', '[\"*\"]', NULL, '2025-04-08 01:55:25', '2025-03-25 01:55:25', '2025-03-25 01:55:25'),
(35, 'App\\Models\\User', 4, 'API Token', 'aa5dbf94c881c38b323d582205b91ca29836cb398905f834e3e0d38ce7b6dbde', '[\"*\"]', NULL, '2025-04-08 21:05:44', '2025-03-25 21:05:44', '2025-03-25 21:05:44'),
(36, 'App\\Models\\User', 17, 'API Token', 'e588820f7d8c94286349f5b27c5e2a2963fa7ce21c02bdc0cf46abead52102d0', '[\"*\"]', NULL, '2025-04-08 21:06:10', '2025-03-25 21:06:10', '2025-03-25 21:06:10'),
(37, 'App\\Models\\User', 4, 'API Token', '65b0d3ca8c11eae10ad7eb06d0d248b5f66012a49e57fe4e46637685ff9a3827', '[\"*\"]', NULL, '2025-04-08 21:21:20', '2025-03-25 21:21:20', '2025-03-25 21:21:20'),
(38, 'App\\Models\\User', 18, 'API Token', '53a5f716678d45b8e13e7d17747c27df52b0843558a6805432e3ea4493e7af3b', '[\"*\"]', NULL, '2025-04-08 21:24:18', '2025-03-25 21:24:18', '2025-03-25 21:24:18'),
(39, 'App\\Models\\User', 19, 'API Token', '98193a81b00e62233e530451ae0c409ef956a61788c278e8ce38cfe4d39f52a0', '[\"*\"]', NULL, '2025-04-08 21:24:40', '2025-03-25 21:24:40', '2025-03-25 21:24:40'),
(40, 'App\\Models\\User', 20, 'API Token', 'c13b4899c935d3dac463ede0197be2ae41ce1f42cba6d366e56ca5577e5ef511', '[\"*\"]', NULL, '2025-04-08 21:30:49', '2025-03-25 21:30:49', '2025-03-25 21:30:49'),
(41, 'App\\Models\\User', 23, 'API Token', 'c26c07e5cedb29bac4dcc193ce81f9f3d46bb1c5cb5e32a46b82d46e3a962022', '[\"*\"]', NULL, '2025-04-08 21:32:28', '2025-03-25 21:32:28', '2025-03-25 21:32:28'),
(42, 'App\\Models\\User', 24, 'API Token', 'a6c23da44e456304492c165a8190511a52793b316a4b6d9d2f189e1ffb4aa2ef', '[\"*\"]', NULL, '2025-04-08 21:36:00', '2025-03-25 21:36:00', '2025-03-25 21:36:00'),
(43, 'App\\Models\\User', 24, 'API Token', '1e992d02de1f0f72cacf45cc77b79f6485708f2ec1c138f324d8e7d9e523008a', '[\"*\"]', NULL, '2025-04-08 21:42:39', '2025-03-25 21:42:39', '2025-03-25 21:42:39'),
(44, 'App\\Models\\User', 23, 'API Token', 'b681fff5c2bdc55cefe6a10a9b3a22c0b2635e56430e71469171dcb8fc008e6a', '[\"*\"]', NULL, '2025-04-08 21:45:29', '2025-03-25 21:45:29', '2025-03-25 21:45:29'),
(45, 'App\\Models\\User', 25, 'API Token', '596428d3ba40e08256982750f7afd7f8567433aa918aad09e5257b94a6848431', '[\"*\"]', NULL, '2025-04-08 21:47:10', '2025-03-25 21:47:10', '2025-03-25 21:47:10'),
(46, 'App\\Models\\User', 26, 'API Token', '6b9eae498c081072a10cb38c2c26d50f6b738f01b4f76bf000e22da17920c28a', '[\"*\"]', NULL, '2025-04-08 21:47:48', '2025-03-25 21:47:48', '2025-03-25 21:47:48'),
(47, 'App\\Models\\User', 26, 'API Token', '7e96abc95a9d718aaef7596847b4fe633c3c71b9ce05e128a5281a83f595ebda', '[\"*\"]', NULL, '2025-04-08 21:48:03', '2025-03-25 21:48:03', '2025-03-25 21:48:03'),
(48, 'App\\Models\\User', 27, 'API Token', 'f1eb7b956d6599831159c9a407027b11de565c4b3397d89844e420613dcbf268', '[\"*\"]', NULL, '2025-04-08 21:50:45', '2025-03-25 21:50:45', '2025-03-25 21:50:45'),
(49, 'App\\Models\\User', 27, 'API Token', 'ad8f7b2e9b25d20ed948347bf68a7c6fbd3b94c740c35c42663b0d198c961bba', '[\"*\"]', NULL, '2025-04-08 21:50:54', '2025-03-25 21:50:54', '2025-03-25 21:50:54'),
(50, 'App\\Models\\User', 27, 'API Token', 'ff8aa121223aec57048e196fe2f2af495745e564bc6eda25e71b19afbf92bc96', '[\"*\"]', NULL, '2025-04-08 23:21:25', '2025-03-25 23:21:25', '2025-03-25 23:21:25'),
(51, 'App\\Models\\User', 26, 'API Token', '83381353ffa0e27ad4131c53325db79695448b0e6e85e27b950cd3f1885a5453', '[\"*\"]', NULL, '2025-04-08 23:26:54', '2025-03-25 23:26:54', '2025-03-25 23:26:54'),
(52, 'App\\Models\\User', 28, 'API Token', 'f1617e8ce90978d72d10af566b7fa9a7c5376b2c3ceaf222515d19d07baeab42', '[\"*\"]', NULL, '2025-04-08 23:50:31', '2025-03-25 23:50:31', '2025-03-25 23:50:31'),
(53, 'App\\Models\\User', 29, 'API Token', 'f93a45b5b268bc4a6c5a4f0f232ad1d2eba6c8ca314bffad5f353d4d0713c9cf', '[\"*\"]', NULL, '2025-04-08 23:52:39', '2025-03-25 23:52:39', '2025-03-25 23:52:39'),
(54, 'App\\Models\\User', 29, 'API Token', '975d5f4294582e5eee4f8a2f5dd443625a6c6beecf596e5916ae447b08732a52', '[\"*\"]', NULL, '2025-04-08 23:53:15', '2025-03-25 23:53:15', '2025-03-25 23:53:15'),
(55, 'App\\Models\\User', 30, 'API Token', '837b383aab1a771e4ec67d0c81f91afdf69203da2f931cc4c8d91386de4f8aff', '[\"*\"]', NULL, '2025-04-09 14:35:39', '2025-03-26 14:35:39', '2025-03-26 14:35:39'),
(56, 'App\\Models\\User', 32, 'API Token', 'fc0f9e32e92ac1550f4c5d1ed07d12cbcff1128868c3c70f4a9298a94ef8cc19', '[\"*\"]', NULL, '2025-04-10 02:07:40', '2025-03-27 02:07:40', '2025-03-27 02:07:40'),
(57, 'App\\Models\\User', 33, 'API Token', '268df65e25067b376cdf0989283b8cbdef78ec719887c61e5a4afba9965e921e', '[\"*\"]', NULL, '2025-04-10 02:15:34', '2025-03-27 02:15:34', '2025-03-27 02:15:34'),
(58, 'App\\Models\\User', 34, 'API Token', '58c908adaf87c8e59572e73f702ceb14fb922b86568c03b8c0ad63d344e33f59', '[\"*\"]', NULL, '2025-04-10 02:39:59', '2025-03-27 02:39:59', '2025-03-27 02:39:59'),
(59, 'App\\Models\\User', 34, 'API Token', '7a7c2ad480ad1c8dae3e0e03b42d55a67f5774ca3614913c7d2a573453e58138', '[\"*\"]', NULL, '2025-04-10 02:44:33', '2025-03-27 02:44:33', '2025-03-27 02:44:33'),
(60, 'App\\Models\\User', 36, 'API Token', '59f891352de6ea8ecdf9198adab1f1683928a1e5a4ace055db13154424c44a70', '[\"*\"]', NULL, '2025-04-10 02:45:20', '2025-03-27 02:45:20', '2025-03-27 02:45:20'),
(61, 'App\\Models\\User', 35, 'API Token', '23b0adf7e952192ada72d14eff24e86a40f95d0d0ae94e12529e3cd9788fe108', '[\"*\"]', NULL, '2025-04-10 02:45:34', '2025-03-27 02:45:34', '2025-03-27 02:45:34'),
(62, 'App\\Models\\User', 35, 'API Token', 'fb34918a5c9f0dedb4def14b15682e58c5ecfb600260c9d18369d06df5ea7e04', '[\"*\"]', NULL, '2025-04-10 02:48:43', '2025-03-27 02:48:43', '2025-03-27 02:48:43'),
(64, 'App\\Models\\User', 38, 'API Token', 'beddd8733d2d21175d9dbe0f9e7ff55d1231fe202552b99a0da7909701b74b4e', '[\"*\"]', NULL, '2025-04-10 02:58:46', '2025-03-27 02:58:46', '2025-03-27 02:58:46'),
(65, 'App\\Models\\User', 39, 'API Token', '16df941ca519810b37bfe868aad0296fc5c3a01b54d14c178b30994ac8a8dc6d', '[\"*\"]', NULL, '2025-04-10 03:03:47', '2025-03-27 03:03:47', '2025-03-27 03:03:47'),
(66, 'App\\Models\\User', 40, 'API Token', 'cb4fe9d0a4c43f1897b5e61ec6c9ab141ef6d5d40ab7e38f8ea4595cdb451611', '[\"*\"]', NULL, '2025-04-10 03:09:28', '2025-03-27 03:09:28', '2025-03-27 03:09:28'),
(67, 'App\\Models\\User', 41, 'API Token', 'c180ed1ec44b21e08d0ad648ae690c4088859b025c1b7a95fb861dc056170de3', '[\"*\"]', NULL, '2025-04-10 03:13:22', '2025-03-27 03:13:22', '2025-03-27 03:13:22'),
(68, 'App\\Models\\User', 42, 'API Token', '7d64b7b39598f88aab5c69dce2125d87779d20fa65325bf134c792543bdce332', '[\"*\"]', NULL, '2025-04-10 03:14:46', '2025-03-27 03:14:46', '2025-03-27 03:14:46'),
(69, 'App\\Models\\User', 42, 'API Token', 'fd96b4fd233dd60fa0412627bb7aae5fb22b9d01be42da67dce85d4cb926f667', '[\"*\"]', NULL, '2025-04-10 03:16:00', '2025-03-27 03:16:00', '2025-03-27 03:16:00'),
(70, 'App\\Models\\User', 41, 'API Token', '5021c8cb721f3e4be44bcbd28bea1c6d48fbef191626bb179b1350d7b22799ef', '[\"*\"]', NULL, '2025-04-10 03:16:10', '2025-03-27 03:16:10', '2025-03-27 03:16:10'),
(71, 'App\\Models\\User', 41, 'API Token', 'cced51dbc451a329f6ca20b6d440653770bfa93a88df12e6fb8c56d9ee492e2a', '[\"*\"]', NULL, '2025-04-10 04:04:12', '2025-03-27 04:04:12', '2025-03-27 04:04:12'),
(72, 'App\\Models\\User', 41, 'API Token', 'd2eb0dcf24da1cdfbb5c1276a418de63441f897b3a355e621137c7ce21bdb1eb', '[\"*\"]', NULL, '2025-04-10 04:05:04', '2025-03-27 04:05:04', '2025-03-27 04:05:04'),
(73, 'App\\Models\\User', 41, 'API Token', 'e83076e8e8448c7e7d1bc41e0c0ce30b25934a02d6893152faa6b8692dfe924b', '[\"*\"]', NULL, '2025-04-10 04:07:51', '2025-03-27 04:07:51', '2025-03-27 04:07:51'),
(74, 'App\\Models\\User', 41, 'API Token', '4376aaad53280c759d8767833c24f21f4b45df1eb1f03a8bbe87fe9d3e46fca4', '[\"*\"]', NULL, '2025-04-10 04:09:30', '2025-03-27 04:09:30', '2025-03-27 04:09:30'),
(75, 'App\\Models\\User', 41, 'API Token', '1b4eccbc5c117ac3231cffc30d9c988e235486ec44af903cc13f02f92d9cb4e3', '[\"*\"]', NULL, '2025-04-10 04:11:05', '2025-03-27 04:11:05', '2025-03-27 04:11:05'),
(76, 'App\\Models\\User', 41, 'API Token', '62698c14b42844bd87f0361050fe1e8d4d560a53cb3ffc12d9001f92acd44abb', '[\"*\"]', '2025-03-27 04:14:26', '2025-04-10 04:11:30', '2025-03-27 04:11:30', '2025-03-27 04:14:26'),
(77, 'App\\Models\\User', 41, 'API Token', '521cc6caf8874ab1d95cb28584161d7ef6faca3e77c4857ed7331b58d6c84ac7', '[\"*\"]', '2025-04-05 17:12:21', '2025-04-10 04:14:32', '2025-03-27 04:14:32', '2025-04-05 17:12:21'),
(78, 'App\\Models\\User', 41, 'API Token', '491be8abfc8f2bb9b8700b223777199ea5e4de581e666332e9caeb5c3c6ca4dc', '[\"*\"]', NULL, '2025-04-10 04:24:21', '2025-03-27 04:24:21', '2025-03-27 04:24:21'),
(79, 'App\\Models\\User', 41, 'API Token', 'be3b3e36d1f3a94babda3bc63904c7c2d3979ca591e3f426391179b8a4b0be76', '[\"*\"]', NULL, '2025-04-10 04:25:02', '2025-03-27 04:25:02', '2025-03-27 04:25:02'),
(80, 'App\\Models\\User', 41, 'API Token', '6deaa262d6deabe7a30dab9c6c471885867a294f7deb1d207e7a264e6b2322a6', '[\"*\"]', NULL, '2025-04-10 04:25:38', '2025-03-27 04:25:38', '2025-03-27 04:25:38'),
(81, 'App\\Models\\User', 41, 'API Token', '144a718ec86f82535bf9cb05b1f650731c6a1cd7aec583d8883c399103604089', '[\"*\"]', NULL, '2025-04-10 04:29:36', '2025-03-27 04:29:36', '2025-03-27 04:29:36'),
(82, 'App\\Models\\User', 41, 'API Token', 'bd441fb6e1b049a7f0b4312e77f2d2380a6af1f3e2e511eeabd250e8bbd7ca16', '[\"*\"]', NULL, '2025-04-10 04:30:43', '2025-03-27 04:30:43', '2025-03-27 04:30:43'),
(83, 'App\\Models\\User', 41, 'API Token', '39f6ce0574f3dab3922ad8d92125ee76c176d28ad743babf9dd1b3a31b6c1970', '[\"*\"]', NULL, '2025-04-10 04:31:19', '2025-03-27 04:31:19', '2025-03-27 04:31:19'),
(84, 'App\\Models\\User', 41, 'API Token', 'a536e7c028547b70b8585d7a99eba534d5492af5a45d3d93419c72c7f91578f6', '[\"*\"]', NULL, '2025-04-10 04:31:50', '2025-03-27 04:31:50', '2025-03-27 04:31:50'),
(85, 'App\\Models\\User', 41, 'API Token', 'd36dcbbbb1dcf8a2219c6e7c653c7a92d1a6af9ce6c08cebfbb63d61fcb8b4c2', '[\"*\"]', NULL, '2025-04-10 04:31:53', '2025-03-27 04:31:53', '2025-03-27 04:31:53'),
(86, 'App\\Models\\User', 41, 'API Token', '27ac6ac48038d27c503e1f38911b8d8e7e3734e002e4134fc7bf17617148f4b7', '[\"*\"]', NULL, '2025-04-10 04:32:52', '2025-03-27 04:32:52', '2025-03-27 04:32:52'),
(87, 'App\\Models\\User', 41, 'API Token', '068785afcf682ad35c21465e17c80bb0896ffb0e1c38d30f029776d09595c2ca', '[\"*\"]', NULL, '2025-04-10 04:32:53', '2025-03-27 04:32:53', '2025-03-27 04:32:53'),
(88, 'App\\Models\\User', 41, 'API Token', 'd7462f2051d945da8db36af4ae68741bba1f82b30f8ed9ebcf5f055e23c602ae', '[\"*\"]', NULL, '2025-04-10 04:33:52', '2025-03-27 04:33:52', '2025-03-27 04:33:52'),
(89, 'App\\Models\\User', 41, 'API Token', '6b860032d28f28ed1995502ce2965d075c1ca8ef5f84e35594c42adf0b146001', '[\"*\"]', NULL, '2025-04-10 04:34:22', '2025-03-27 04:34:22', '2025-03-27 04:34:22'),
(90, 'App\\Models\\User', 41, 'API Token', '1bec5d4ea51d5423c6dac0896f1c70f147a74eb4c3b0b6b9027ddd6342d19f82', '[\"*\"]', NULL, '2025-04-10 04:34:34', '2025-03-27 04:34:34', '2025-03-27 04:34:34'),
(91, 'App\\Models\\User', 41, 'API Token', 'cd2b5c0146b9f61dff1dfadd0161e20977e7b0811ddd9c9df7e1dcbb290cff05', '[\"*\"]', NULL, '2025-04-10 04:39:18', '2025-03-27 04:39:18', '2025-03-27 04:39:18'),
(92, 'App\\Models\\User', 41, 'API Token', '4300faf9856ec0f040c6f6225b6ecda31a033661665a512f82352cf099146239', '[\"*\"]', NULL, '2025-04-10 04:39:57', '2025-03-27 04:39:57', '2025-03-27 04:39:57'),
(93, 'App\\Models\\User', 41, 'API Token', 'f9f70fe2d0def971ef42f6401c3eaf2c45e7d35bf5425dbbbc3c51aba012bfbc', '[\"*\"]', NULL, '2025-04-10 04:40:05', '2025-03-27 04:40:05', '2025-03-27 04:40:05'),
(94, 'App\\Models\\User', 41, 'API Token', 'fd2753f6d8a926b0fd2bf478d891e2865047716834e7a55b971afecb51a72cb3', '[\"*\"]', NULL, '2025-04-10 04:40:18', '2025-03-27 04:40:18', '2025-03-27 04:40:18'),
(95, 'App\\Models\\User', 41, 'API Token', 'dbd7e81f26a19bcd43fdfe220d7d52c3a62118bd7b2baeec79a4f9704bdbf7f9', '[\"*\"]', NULL, '2025-04-10 04:41:21', '2025-03-27 04:41:21', '2025-03-27 04:41:21'),
(97, 'App\\Models\\User', 41, 'API Token', '33e775ea63321712d91e24f6c64b674f0a8c2e851b58a2eadd3a6ec9b5da2796', '[\"*\"]', NULL, '2025-04-10 04:42:06', '2025-03-27 04:42:06', '2025-03-27 04:42:06'),
(98, 'App\\Models\\User', 41, 'API Token', '2b75806cc1c103de60fe461c9f59cfc5a9b45e8d66cf3ed9d728cf5597acb58f', '[\"*\"]', NULL, '2025-04-10 04:50:06', '2025-03-27 04:50:06', '2025-03-27 04:50:06'),
(99, 'App\\Models\\User', 41, 'API Token', '78bd091972ec3864dc19de58b0e48c5bc28bfdeb4aca2c676cde6c42eeb37aca', '[\"*\"]', NULL, '2025-04-10 04:57:54', '2025-03-27 04:57:54', '2025-03-27 04:57:54'),
(100, 'App\\Models\\User', 41, 'API Token', '31792d20b19dcccbd9dda78f5f17a7ba9517d64029f80008b799cc2877985360', '[\"*\"]', NULL, '2025-04-10 05:06:58', '2025-03-27 05:06:58', '2025-03-27 05:06:58'),
(101, 'App\\Models\\User', 41, 'API Token', 'd4f8cba0fe9565c0e117d70e95bf1192310c180d4a6f0073d9719ece550c05ba', '[\"*\"]', NULL, '2025-04-10 05:56:39', '2025-03-27 05:56:39', '2025-03-27 05:56:39'),
(102, 'App\\Models\\User', 41, 'API Token', '9f7f54dd12d51b69cfd1990d35d541e2ffeb43a066921ecf39da62051cceff25', '[\"*\"]', NULL, '2025-04-10 06:17:16', '2025-03-27 06:17:16', '2025-03-27 06:17:16'),
(103, 'App\\Models\\User', 43, 'API Token', '9308323d3cb8337d989455b887215b04b32a517863b7548f3e602d0d8e10cefb', '[\"*\"]', NULL, '2025-04-10 06:18:02', '2025-03-27 06:18:02', '2025-03-27 06:18:02'),
(104, 'App\\Models\\User', 41, 'API Token', 'a4019422031410eb90576ad2a40818d879d663cd25ba1fd378b40267f829e7e2', '[\"*\"]', NULL, '2025-04-10 06:21:04', '2025-03-27 06:21:04', '2025-03-27 06:21:04'),
(105, 'App\\Models\\User', 41, 'API Token', 'a81725a603e9dec094584094a789666f8f9d5d27a439cc87d1f6ad55cfd5e78f', '[\"*\"]', NULL, '2025-04-10 07:16:09', '2025-03-27 07:16:09', '2025-03-27 07:16:09'),
(106, 'App\\Models\\User', 41, 'API Token', '8a97baf890c2b580c9acdd9a3bbaf9113425b5a325982ece19ef06dc389b5827', '[\"*\"]', NULL, '2025-04-10 07:23:25', '2025-03-27 07:23:25', '2025-03-27 07:23:25'),
(107, 'App\\Models\\User', 41, 'API Token', 'ea86d4a4c098da20655bae646bfb95753ed45a269ee7ee90b50268b94b420a64', '[\"*\"]', NULL, '2025-04-10 07:32:35', '2025-03-27 07:32:35', '2025-03-27 07:32:35'),
(108, 'App\\Models\\User', 41, 'API Token', '3fd5bc84aa2704193036d469302aaf37ce9406e7499be29132d9289db3f093a7', '[\"*\"]', NULL, '2025-04-10 08:03:45', '2025-03-27 08:03:45', '2025-03-27 08:03:45'),
(109, 'App\\Models\\User', 44, 'API Token', 'a31d25fd83370ff0e8b2fb9f13b0ffe6c4284c9ed65cd4eda19a3211dd07a0a8', '[\"*\"]', NULL, '2025-04-10 13:21:06', '2025-03-27 13:21:06', '2025-03-27 13:21:06'),
(110, 'App\\Models\\User', 41, 'API Token', '84ec33ede2ffb2e0b994dbe70a847c9fad85b1f80c1ed9f0996a2dd61ec768b9', '[\"*\"]', NULL, '2025-04-10 13:22:15', '2025-03-27 13:22:15', '2025-03-27 13:22:15'),
(111, 'App\\Models\\User', 41, 'API Token', 'eeac3e7c27e118f07d9a86381776ddb02906b4788976f340c2f9fdd88be5bfa5', '[\"*\"]', NULL, '2025-04-10 13:42:12', '2025-03-27 13:42:12', '2025-03-27 13:42:12'),
(112, 'App\\Models\\User', 41, 'API Token', '8fc1126abdeee447afa66e900566ea3e9e02a17c85863711c92e8ecd71cce118', '[\"*\"]', NULL, '2025-04-10 13:47:18', '2025-03-27 13:47:18', '2025-03-27 13:47:18'),
(113, 'App\\Models\\User', 41, 'API Token', '82db8ea58b21e3c2f2bfff9d5fe4fa6fbd61ef9054bd30d0f9ca2c662405cbef', '[\"*\"]', NULL, '2025-04-10 13:47:47', '2025-03-27 13:47:47', '2025-03-27 13:47:47'),
(114, 'App\\Models\\User', 41, 'API Token', '64be263b2159f0b77ee40afc11a16a2c8c19e2a82f9e0f83ff5cded613fced1b', '[\"*\"]', NULL, '2025-04-10 13:48:37', '2025-03-27 13:48:37', '2025-03-27 13:48:37'),
(115, 'App\\Models\\User', 41, 'API Token', 'e5c6d900df35e03620e8581c42213ad2bffde43728abf5745087947d91946f77', '[\"*\"]', NULL, '2025-04-10 14:01:11', '2025-03-27 14:01:11', '2025-03-27 14:01:11'),
(116, 'App\\Models\\User', 41, 'API Token', '6efa13515d9167120a95af4a219584427d73edbf3b9b2a14b99f095775a011c5', '[\"*\"]', NULL, '2025-04-10 14:03:16', '2025-03-27 14:03:16', '2025-03-27 14:03:16'),
(117, 'App\\Models\\User', 41, 'API Token', 'b0c1a5485ba7ac8e0b7441ed9635a425190992244b8c8fbeb761e10a50998d1d', '[\"*\"]', NULL, '2025-04-10 14:04:19', '2025-03-27 14:04:19', '2025-03-27 14:04:19'),
(118, 'App\\Models\\User', 41, 'API Token', 'a591a5641f41969eaede22684a04798effd3090106693d0ac979b755681d4463', '[\"*\"]', NULL, '2025-04-10 14:05:28', '2025-03-27 14:05:28', '2025-03-27 14:05:28'),
(119, 'App\\Models\\User', 41, 'API Token', '7134ea6898e2de243cec11391860d251f4f6218d9e62d06cd2c6595f94649934', '[\"*\"]', NULL, '2025-04-10 14:06:49', '2025-03-27 14:06:49', '2025-03-27 14:06:49'),
(120, 'App\\Models\\User', 41, 'API Token', '77ad67e663be7943e5981cff2989c4d7324b33703545571508e50945baf065a8', '[\"*\"]', NULL, '2025-04-10 14:09:44', '2025-03-27 14:09:44', '2025-03-27 14:09:44'),
(121, 'App\\Models\\User', 41, 'API Token', 'f2641593b93f0f7b4ad2f4d94f1227213f9faf50297fd376baf5474c6746e12d', '[\"*\"]', NULL, '2025-04-10 14:10:29', '2025-03-27 14:10:29', '2025-03-27 14:10:29'),
(122, 'App\\Models\\User', 41, 'API Token', 'e0b5752106ad8d3bd1a9a5d381f4172f4fa6894e4b695fff90b811cca2850f56', '[\"*\"]', NULL, '2025-04-10 14:12:21', '2025-03-27 14:12:21', '2025-03-27 14:12:21'),
(123, 'App\\Models\\User', 41, 'API Token', '0af7f8dd0ce535e4a62f0904dd2a1a1de132c7be3a1bc271f3b2b32a0e345811', '[\"*\"]', NULL, '2025-04-10 14:17:26', '2025-03-27 14:17:26', '2025-03-27 14:17:26'),
(124, 'App\\Models\\User', 41, 'API Token', '65fe0dd9287f97bf206ff9455adaeb509a5abd493151bbe442b4391ad9938c2e', '[\"*\"]', NULL, '2025-04-10 14:18:33', '2025-03-27 14:18:33', '2025-03-27 14:18:33'),
(125, 'App\\Models\\User', 41, 'API Token', '856be376ec48a8afba8ffeb64bdaf54ba8491b1584d8aa902418c0732ad94282', '[\"*\"]', NULL, '2025-04-10 14:22:19', '2025-03-27 14:22:19', '2025-03-27 14:22:19'),
(126, 'App\\Models\\User', 41, 'API Token', '13c5b2ee7bcb7906efa99253f04133e7a8b5865a3ac05c39dbfae540e343d72c', '[\"*\"]', NULL, '2025-04-10 14:23:49', '2025-03-27 14:23:49', '2025-03-27 14:23:49'),
(127, 'App\\Models\\User', 41, 'API Token', '1326fe872c7fdb9a17a197331436dbc7f1413d142216a724171fddadcd9a146e', '[\"*\"]', NULL, '2025-04-10 14:25:20', '2025-03-27 14:25:20', '2025-03-27 14:25:20'),
(128, 'App\\Models\\User', 41, 'API Token', '18a1cf48b9b9bb4b2f581b0bd67740591c59ecf57779d51b0897941d53859369', '[\"*\"]', NULL, '2025-04-10 14:28:07', '2025-03-27 14:28:07', '2025-03-27 14:28:07'),
(129, 'App\\Models\\User', 41, 'API Token', 'cf295754e02f1e485ab4a3986571d886cb9645a30ee6be28e469813b54f25585', '[\"*\"]', NULL, '2025-04-10 14:30:09', '2025-03-27 14:30:09', '2025-03-27 14:30:09'),
(130, 'App\\Models\\User', 41, 'API Token', '14b126bf00d2086ffb0b2c73da114c995a7f09a7e383d50b4d18b6964b6214b1', '[\"*\"]', NULL, '2025-04-10 14:35:32', '2025-03-27 14:35:32', '2025-03-27 14:35:32'),
(131, 'App\\Models\\User', 41, 'API Token', '49b2c1bccf874169674366a9ad622fac621324da36400a7f8670f9ac02e5e1ff', '[\"*\"]', NULL, '2025-04-10 14:44:07', '2025-03-27 14:44:07', '2025-03-27 14:44:07'),
(132, 'App\\Models\\User', 41, 'API Token', '47bfa49b3bd18e21408a54c37972b3e7a776d3ac95cf825055d6a8aeef8c51d5', '[\"*\"]', NULL, '2025-04-10 14:46:18', '2025-03-27 14:46:18', '2025-03-27 14:46:18'),
(133, 'App\\Models\\User', 41, 'API Token', '51158e87555e02429e68928404363142b550aa635b05436f9c89cbfe9b907a8e', '[\"*\"]', NULL, '2025-04-10 14:46:32', '2025-03-27 14:46:32', '2025-03-27 14:46:32'),
(134, 'App\\Models\\User', 41, 'API Token', '5ed84fc36e7dc8c12a3d0f1ccf8846c87a366c4b31dda4264ca753b50ac44b2c', '[\"*\"]', NULL, '2025-04-10 14:46:41', '2025-03-27 14:46:41', '2025-03-27 14:46:41'),
(135, 'App\\Models\\User', 41, 'API Token', '986fa0110ad9d0655c69a784bd56511f7760049cdde4349fc436915174f94b60', '[\"*\"]', NULL, '2025-04-10 14:49:27', '2025-03-27 14:49:27', '2025-03-27 14:49:27'),
(136, 'App\\Models\\User', 41, 'API Token', '1db79edae6c0bb51dd9d0bfbd37f99db1f06fe534e647cb22134611a887bbb38', '[\"*\"]', NULL, '2025-04-10 14:49:51', '2025-03-27 14:49:51', '2025-03-27 14:49:51'),
(137, 'App\\Models\\User', 41, 'API Token', 'c6ef2519bc870e85f38b79ad2cca5fbeec14779b05a6b4dab36fcb3662fca2ee', '[\"*\"]', NULL, '2025-04-10 14:50:13', '2025-03-27 14:50:13', '2025-03-27 14:50:13'),
(138, 'App\\Models\\User', 41, 'API Token', '8bfa55620524dde674a3f1e954b6c4a5c35dbbc990c41449428f95f50957b23c', '[\"*\"]', NULL, '2025-04-10 14:55:49', '2025-03-27 14:55:49', '2025-03-27 14:55:49'),
(139, 'App\\Models\\User', 41, 'API Token', '6f6025c811c23cbfe44866c871a21c5c71421be9dc8915b447fde77face713bb', '[\"*\"]', NULL, '2025-04-10 14:56:48', '2025-03-27 14:56:48', '2025-03-27 14:56:48'),
(140, 'App\\Models\\User', 41, 'API Token', '6098561a642af79ffdedf84ea6c7cf9c9569f82db7748ebdbdfb98b0ad45bb5b', '[\"*\"]', NULL, '2025-04-10 14:59:02', '2025-03-27 14:59:02', '2025-03-27 14:59:02'),
(141, 'App\\Models\\User', 41, 'API Token', '5b5737fefbbdd27d3714a43be4eef48a5572187e487496bcc884e51527fcde1f', '[\"*\"]', NULL, '2025-04-10 15:28:12', '2025-03-27 15:28:12', '2025-03-27 15:28:12'),
(142, 'App\\Models\\User', 41, 'API Token', '4e0e4cf7189c7f780ce2cf63bb4cd450e4aa3bdf032bf4d719e276590cbc5cdc', '[\"*\"]', NULL, '2025-04-10 15:30:07', '2025-03-27 15:30:07', '2025-03-27 15:30:07'),
(143, 'App\\Models\\User', 41, 'API Token', 'e64508f19098e29b490b6112b4507c6e287331fbb808eb9619d51bbf0f0701c5', '[\"*\"]', NULL, '2025-04-10 15:33:20', '2025-03-27 15:33:20', '2025-03-27 15:33:20'),
(144, 'App\\Models\\User', 41, 'API Token', 'b23e3ab0a36ceeea95570362c168dccd9ef28020210826558f8af47d48608dda', '[\"*\"]', NULL, '2025-04-10 15:33:45', '2025-03-27 15:33:45', '2025-03-27 15:33:45'),
(145, 'App\\Models\\User', 41, 'API Token', 'abf7f78f50af0c0f184859a17efdeacf0cc2526651a3e7dd1e44cbd5ae6a9391', '[\"*\"]', NULL, '2025-04-10 15:36:04', '2025-03-27 15:36:04', '2025-03-27 15:36:04'),
(146, 'App\\Models\\User', 41, 'API Token', '1628ec3123c3afdfe19659e68b6ad08e3fd46454a601d1c4248ac5a491cd4873', '[\"*\"]', NULL, '2025-04-10 15:36:15', '2025-03-27 15:36:15', '2025-03-27 15:36:15'),
(147, 'App\\Models\\User', 41, 'API Token', '04f2a449644b75eac4dacb97b32428262f7a82887f87493871f2551a690efa41', '[\"*\"]', NULL, '2025-04-10 15:38:14', '2025-03-27 15:38:14', '2025-03-27 15:38:15'),
(148, 'App\\Models\\User', 41, 'API Token', '20b17f76c004aacad88ea195eca18891a581ad3e64bc46209f1925646b123d62', '[\"*\"]', NULL, '2025-04-10 15:39:42', '2025-03-27 15:39:42', '2025-03-27 15:39:42'),
(149, 'App\\Models\\User', 41, 'API Token', '764167c1d9122827898e80a67ae3cc6495150fba23e6d1a62ec052f102a944d4', '[\"*\"]', NULL, '2025-04-10 15:59:28', '2025-03-27 15:59:28', '2025-03-27 15:59:28'),
(150, 'App\\Models\\User', 41, 'API Token', '27deac6c1b3870dd35882ad1defd2b6a16bebc979195d0d6f08d08e229f23d85', '[\"*\"]', NULL, '2025-04-10 15:59:46', '2025-03-27 15:59:46', '2025-03-27 15:59:46'),
(151, 'App\\Models\\User', 41, 'API Token', 'ee78a86e2aeb7e87c0d96a0b7f629aed783b4ba6e937addbe957771674be4211', '[\"*\"]', NULL, '2025-04-10 16:00:56', '2025-03-27 16:00:56', '2025-03-27 16:00:56'),
(152, 'App\\Models\\User', 41, 'API Token', 'e54935ec7aa4b782a1fddbec6b34c852a9452a03b2a278ef093708ee392fd2ad', '[\"*\"]', NULL, '2025-04-10 16:13:01', '2025-03-27 16:13:01', '2025-03-27 16:13:01'),
(153, 'App\\Models\\User', 41, 'API Token', '7db5e2ab4bf93547057b7e59f8f211aeb630d24f4d051be736528ea2d8976937', '[\"*\"]', NULL, '2025-04-10 16:28:04', '2025-03-27 16:28:04', '2025-03-27 16:28:04'),
(154, 'App\\Models\\User', 41, 'API Token', '3af756e14385610dd43986aa7b00fa9ceea5466e83a7766aa952a45c790e2e44', '[\"*\"]', NULL, '2025-04-10 16:40:17', '2025-03-27 16:40:17', '2025-03-27 16:40:17'),
(155, 'App\\Models\\User', 41, 'API Token', 'c7754abb7e0ddb6e1c10ff1d4c40e92303fe71f5bbc704d358da4735ea5ed05c', '[\"*\"]', NULL, '2025-04-10 16:57:21', '2025-03-27 16:57:21', '2025-03-27 16:57:21'),
(156, 'App\\Models\\User', 41, 'API Token', '64f5994439a9c7e547c313272868b120c2f0b7631dbd2ab78b26d989e84e70df', '[\"*\"]', NULL, '2025-04-10 16:59:06', '2025-03-27 16:59:06', '2025-03-27 16:59:06'),
(157, 'App\\Models\\User', 41, 'API Token', 'a1bc145a03e29ee284c9c1f301fbfe99f2b49147fa6ffda99015d76f1a95d289', '[\"*\"]', NULL, '2025-04-10 17:14:37', '2025-03-27 17:14:38', '2025-03-27 17:14:38'),
(158, 'App\\Models\\User', 41, 'API Token', 'aeb8de0ca1bc051cf6ca54ef6a467a82bc0e559f4da41b561c1e96f5a002c1a5', '[\"*\"]', NULL, '2025-04-11 01:51:28', '2025-03-28 01:51:28', '2025-03-28 01:51:28'),
(159, 'App\\Models\\User', 41, 'API Token', '2532d1163709323dbc2ef323c666dd9c69c2a10b92ec3fe0c37676a8e6cdc4ed', '[\"*\"]', NULL, '2025-04-11 06:26:25', '2025-03-28 06:26:25', '2025-03-28 06:26:25'),
(160, 'App\\Models\\User', 41, 'API Token', '465e11ddde92d27a7f0ede9f261015b015083c43135addf47713a4fd548683fd', '[\"*\"]', NULL, '2025-04-11 06:34:53', '2025-03-28 06:34:53', '2025-03-28 06:34:53'),
(161, 'App\\Models\\User', 41, 'API Token', '8cc7ec65073aa83f11dd7cac572befaadb2e9f945fb6a17319f8873e30d69c8d', '[\"*\"]', NULL, '2025-04-11 06:35:01', '2025-03-28 06:35:01', '2025-03-28 06:35:01'),
(162, 'App\\Models\\User', 41, 'API Token', 'b5f6bf628673d443c4125cb30c7e7522459da597beabf4c6699c275252aa76cb', '[\"*\"]', NULL, '2025-04-11 06:35:42', '2025-03-28 06:35:42', '2025-03-28 06:35:42'),
(163, 'App\\Models\\User', 41, 'API Token', 'da95d8017c44a0f7e0edc8b4ca1f1193d57351b9bc8406bb5567989af584224c', '[\"*\"]', NULL, '2025-04-11 06:37:00', '2025-03-28 06:37:00', '2025-03-28 06:37:00'),
(164, 'App\\Models\\User', 41, 'API Token', 'eb055521f262a801487931363e96d8fc812496c6b37a8bed2a787e174bb5b61d', '[\"*\"]', NULL, '2025-04-11 06:37:25', '2025-03-28 06:37:25', '2025-03-28 06:37:25'),
(165, 'App\\Models\\User', 41, 'API Token', '7137f70b287cca491ae342f90f4b65d2c1688bcc9cd25196226e5363152c6555', '[\"*\"]', NULL, '2025-04-11 06:37:44', '2025-03-28 06:37:44', '2025-03-28 06:37:44'),
(166, 'App\\Models\\User', 41, 'API Token', '91dcf7a62dc5dee00a9f40014815dd9cce4508ba26936682250a7e0d8886d5cb', '[\"*\"]', NULL, '2025-04-11 06:39:43', '2025-03-28 06:39:43', '2025-03-28 06:39:43'),
(167, 'App\\Models\\User', 41, 'API Token', 'd2ff016d53314d146be162893453553ad52e802de3148feca8b33a669706ccaf', '[\"*\"]', NULL, '2025-04-11 06:40:26', '2025-03-28 06:40:26', '2025-03-28 06:40:26'),
(168, 'App\\Models\\User', 41, 'API Token', '40e12a9b2f75e71b31be5e04c079cf5491a126e74f5b737b9fd3b5d75f350ec7', '[\"*\"]', NULL, '2025-04-11 06:42:00', '2025-03-28 06:42:00', '2025-03-28 06:42:00'),
(169, 'App\\Models\\User', 41, 'API Token', '6a31087b6418ad796db729e5163497c1cba1e96b2a79360b57ae97f9b7ba45a4', '[\"*\"]', NULL, '2025-04-11 06:47:12', '2025-03-28 06:47:12', '2025-03-28 06:47:12'),
(170, 'App\\Models\\User', 41, 'API Token', '4908bac4893ed677c89a59741a0c6fbcf76eb2f44defcd2b56010d75a1071903', '[\"*\"]', NULL, '2025-04-11 07:09:53', '2025-03-28 07:09:53', '2025-03-28 07:09:53'),
(171, 'App\\Models\\User', 41, 'API Token', 'f2fca501c8b6562e222178af568dd8056cdf8f45a397836e0f6530d4ee8aa89a', '[\"*\"]', NULL, '2025-04-12 03:34:01', '2025-03-29 03:34:01', '2025-03-29 03:34:01'),
(172, 'App\\Models\\User', 41, 'API Token', 'a5f5db20279ab166983022f93242c80c0972fa58275027131891d75d63475cd1', '[\"*\"]', NULL, '2025-04-12 03:38:09', '2025-03-29 03:38:09', '2025-03-29 03:38:09'),
(173, 'App\\Models\\User', 41, 'API Token', '03e65e18e4a5620ebca440013d50071d8f8eaecc25db4194b5943287ff99ee2f', '[\"*\"]', NULL, '2025-04-12 03:39:12', '2025-03-29 03:39:12', '2025-03-29 03:39:12'),
(174, 'App\\Models\\User', 41, 'API Token', '3775281ac02f310212d128567f17dcd3e3863a61b1a4bcab508450d9b2fd7dd3', '[\"*\"]', '2025-04-06 10:34:54', '2025-04-12 03:52:52', '2025-03-29 03:52:52', '2025-04-06 10:34:54'),
(175, 'App\\Models\\User', 41, 'API Token', '4172908aee0559e72a8897c526debf6573359d3a9bfa0414678ac27e1aaf338e', '[\"*\"]', NULL, '2025-04-12 03:54:03', '2025-03-29 03:54:03', '2025-03-29 03:54:03'),
(176, 'App\\Models\\User', 41, 'API Token', '56696b1f1ac4db4fbddd873d6dd791c7464bdf66b1c4a53c09946d83bfcb6b9e', '[\"*\"]', NULL, '2025-04-12 04:14:31', '2025-03-29 04:14:31', '2025-03-29 04:14:31'),
(177, 'App\\Models\\User', 41, 'API Token', '5b090904c0aefc466a472e0ae55d9d2ee21c86936c91f85af69e5c8e1261587c', '[\"*\"]', NULL, '2025-04-12 04:33:48', '2025-03-29 04:33:48', '2025-03-29 04:33:48'),
(178, 'App\\Models\\User', 41, 'API Token', '7b8e779bd15dfac437266ade7e2fdc5398cb602e03e1bcd174de6739d7bf581d', '[\"*\"]', '2025-03-31 09:14:50', '2025-04-12 04:36:06', '2025-03-29 04:36:06', '2025-03-31 09:14:50'),
(179, 'App\\Models\\User', 41, 'API Token', '2203bbb8196260c2249e66be602f77cf5e475f9da1ed1a1233a46d65f48f0492', '[\"*\"]', '2025-04-01 03:26:26', '2025-04-12 05:01:25', '2025-03-29 05:01:25', '2025-04-01 03:26:26'),
(180, 'App\\Models\\User', 41, 'API Token', '3faecf1f1b2928b1bd0b76347d3c7cb7f2e1ca422084e38d139eaa8347a857fb', '[\"*\"]', NULL, '2025-04-12 05:37:05', '2025-03-29 05:37:05', '2025-03-29 05:37:05'),
(181, 'App\\Models\\User', 41, 'API Token', '815dfef1bc7a5465d4bb08a97b2d7fa9859b755832c359515a313305809f73f2', '[\"*\"]', NULL, '2025-04-12 05:37:15', '2025-03-29 05:37:15', '2025-03-29 05:37:15'),
(182, 'App\\Models\\User', 41, 'API Token', '32fc94b8c37adf884ab3d7411094210b023ce958455a2e8ef38a20e52ac813fb', '[\"*\"]', NULL, '2025-04-12 05:53:35', '2025-03-29 05:53:35', '2025-03-29 05:53:35'),
(183, 'App\\Models\\User', 41, 'API Token', 'fc3f9428c0815ba83fc66d300f9acd11887d7764e0344ede36f713052e86ceda', '[\"*\"]', NULL, '2025-04-12 07:54:15', '2025-03-29 07:54:15', '2025-03-29 07:54:15'),
(184, 'App\\Models\\User', 41, 'API Token', 'd425660a857d4c6dd0027ebf9432b457bacd50348f1a721fa7957f91989c6be6', '[\"*\"]', NULL, '2025-04-14 03:54:16', '2025-03-31 03:54:16', '2025-03-31 03:54:16'),
(185, 'App\\Models\\User', 41, 'API Token', 'cd4ef6fb96f2c11ec8b8a587462a785dc39d7813b550cdea104336652829c873', '[\"*\"]', NULL, '2025-04-14 10:11:06', '2025-03-31 10:11:06', '2025-03-31 10:11:06'),
(186, 'App\\Models\\User', 41, 'API Token', 'edc0e50c4b6237dd6ee720a875c990f5be7e9b97e72a241ca2019f94a4ba1095', '[\"*\"]', '2025-04-01 04:02:25', '2025-04-14 11:12:36', '2025-03-31 11:12:36', '2025-04-01 04:02:25'),
(187, 'App\\Models\\User', 41, 'API Token', '90a5e34e6b298ba66368bc9eb1095ce092ddf117226893b51b460231966f075a', '[\"*\"]', NULL, '2025-04-14 11:36:32', '2025-03-31 11:36:32', '2025-03-31 11:36:32'),
(188, 'App\\Models\\User', 41, 'API Token', '0e834b3dbcebf4d4306627af1bd69b34640a78818ec8e8067d3f21cd8589fdf0', '[\"*\"]', NULL, '2025-04-14 15:13:46', '2025-03-31 15:13:46', '2025-03-31 15:13:46'),
(189, 'App\\Models\\User', 41, 'API Token', 'd271820afba683190d4722d8be0e3f4d21be974573141ca74415553b70b6e114', '[\"*\"]', NULL, '2025-04-15 03:17:11', '2025-04-01 03:17:11', '2025-04-01 03:17:11'),
(190, 'App\\Models\\User', 41, 'API Token', '7cd7eb281700b3901f55421c9203e5c5609a1159b0c0a8e683a70ef0f3403c26', '[\"*\"]', NULL, '2025-04-15 03:17:43', '2025-04-01 03:17:43', '2025-04-01 03:17:43'),
(191, 'App\\Models\\User', 41, 'API Token', 'b80accdf23531a2f250807cf05a64d062def6e5577fb63363a04897b3da87c45', '[\"*\"]', NULL, '2025-04-15 03:18:29', '2025-04-01 03:18:29', '2025-04-01 03:18:29'),
(192, 'App\\Models\\User', 45, 'API Token', 'f4a59751ec670902f302c8aecce4f7b1e21699430700841c03fb6701143aa87f', '[\"*\"]', NULL, '2025-04-15 03:18:38', '2025-04-01 03:18:38', '2025-04-01 03:18:38'),
(193, 'App\\Models\\User', 46, 'API Token', '562fe8d6fa5841c55b5d1d95bbee3b7fd73f90e1b172957c33aa62e9338816b2', '[\"*\"]', NULL, '2025-04-15 03:19:04', '2025-04-01 03:19:04', '2025-04-01 03:19:04'),
(194, 'App\\Models\\User', 47, 'API Token', '7656d74db05a551345534addba0fa18f322be1fdd745aef36d6587987dbe4c18', '[\"*\"]', NULL, '2025-04-15 03:19:10', '2025-04-01 03:19:10', '2025-04-01 03:19:10'),
(195, 'App\\Models\\User', 46, 'API Token', '2c74b7ccc73f7c2ec20b833b936b2e9eefa18133ba5a122be1b3b89fec3a08f5', '[\"*\"]', NULL, '2025-04-15 03:19:35', '2025-04-01 03:19:35', '2025-04-01 03:19:35'),
(196, 'App\\Models\\User', 41, 'API Token', 'f0061991995fcb2ba792f517b1873e5b757552b320ce05fd3660bcccf26edc5c', '[\"*\"]', NULL, '2025-04-15 04:40:18', '2025-04-01 04:40:18', '2025-04-01 04:40:18'),
(197, 'App\\Models\\User', 41, 'API Token', '1b48799b10c7a499b6dea185b06a9d5ec921376b161106df79a678ecd71cd370', '[\"*\"]', NULL, '2025-04-15 04:40:54', '2025-04-01 04:40:54', '2025-04-01 04:40:54'),
(198, 'App\\Models\\User', 41, 'API Token', 'd040e93cac57f242a576165c735cd1c2f35128346bab8a5a91eeb5b18184ea33', '[\"*\"]', NULL, '2025-04-15 04:44:22', '2025-04-01 04:44:22', '2025-04-01 04:44:22'),
(199, 'App\\Models\\User', 41, 'API Token', 'c85b70ecd87b125f54d5d467b3d91f82c60ce8d61357a55cb50ae5d2afbc891c', '[\"*\"]', NULL, '2025-04-15 04:59:09', '2025-04-01 04:59:09', '2025-04-01 04:59:09'),
(200, 'App\\Models\\User', 41, 'API Token', '45ba2d05c0641620080425d1ffabc8d9532d1239bea13a22ffbb775295202e85', '[\"*\"]', NULL, '2025-04-15 04:59:33', '2025-04-01 04:59:33', '2025-04-01 04:59:33'),
(201, 'App\\Models\\User', 41, 'API Token', '734a6e880e796cceda28c5cc61c356cdf23846f81502976aa4ef1a700ea11f4a', '[\"*\"]', '2025-04-03 02:25:41', '2025-04-15 06:51:55', '2025-04-01 06:51:55', '2025-04-03 02:25:41'),
(202, 'App\\Models\\User', 48, 'API Token', 'cb530f23e2f801588629f79fb1ced1d7847a4b17be7a8f9d09c03e79f69ec06b', '[\"*\"]', NULL, '2025-04-15 06:52:04', '2025-04-01 06:52:04', '2025-04-01 06:52:04'),
(203, 'App\\Models\\User', 49, 'API Token', '53e0b12896c152b4a76ae589b18d118ff7b0df60216c6222b5c11b82620b79bf', '[\"*\"]', '2025-04-01 08:42:14', '2025-04-15 06:55:42', '2025-04-01 06:55:42', '2025-04-01 08:42:14'),
(204, 'App\\Models\\User', 50, 'API Token', '6addd1988e92eaede7bb769bb1cfb5c7cdf2bc737a31c7dac8981336ea0683e5', '[\"*\"]', NULL, '2025-05-01 08:46:59', '2025-04-01 08:46:59', '2025-04-01 08:46:59'),
(205, 'App\\Models\\User', 51, 'API Token', '82519f8a37e73514731fc13843a979174182aa10f8ad97a13c954f4a93067f9f', '[\"*\"]', NULL, '2025-05-01 15:04:33', '2025-04-01 15:04:33', '2025-04-01 15:04:33'),
(206, 'App\\Models\\User', 51, 'API Token', '6911346b40952ca60d38ed28e3da55299384681be2efba6058bedb04408afca2', '[\"*\"]', NULL, '2025-05-03 04:34:55', '2025-04-03 04:34:55', '2025-04-03 04:34:55'),
(207, 'App\\Models\\User', 41, 'API Token', 'f11c3e9969e993a111113d04f650cc4ebeda9d9c503b51a1bb253720569b9921', '[\"*\"]', NULL, '2025-05-03 04:36:33', '2025-04-03 04:36:33', '2025-04-03 04:36:33'),
(208, 'App\\Models\\User', 41, 'API Token', 'd445e54fe6722a3e02d27f732ee00ac3d609c316e6222e012276caeaf4e8c262', '[\"*\"]', NULL, '2025-05-03 04:36:59', '2025-04-03 04:36:59', '2025-04-03 04:36:59'),
(209, 'App\\Models\\User', 41, 'API Token', '02001800c6483c80ea01b1ebc76448b836850028335b20cd1b56f96e0c055fdf', '[\"*\"]', NULL, '2025-05-03 04:37:02', '2025-04-03 04:37:02', '2025-04-03 04:37:02'),
(210, 'App\\Models\\User', 41, 'API Token', 'e65b26c7f52e76dfdecc23dba82fc4ff62ee453d01b2cd45d375894e95035115', '[\"*\"]', NULL, '2025-05-03 04:37:32', '2025-04-03 04:37:32', '2025-04-03 04:37:32'),
(211, 'App\\Models\\User', 41, 'API Token', 'eac38547f1f1c2e8ea319b59f2429969fa1bcea2a8d8e10fdec8799c43421803', '[\"*\"]', NULL, '2025-05-03 04:38:22', '2025-04-03 04:38:22', '2025-04-03 04:38:22'),
(212, 'App\\Models\\User', 41, 'API Token', '8bba5ae6ca86eceb4f7e39485eea76333f64dcb48818616da3ad70e7e9c77d69', '[\"*\"]', '2025-04-05 09:13:05', '2025-05-03 04:40:34', '2025-04-03 04:40:34', '2025-04-05 09:13:05'),
(213, 'App\\Models\\User', 41, 'API Token', '93144d2d9f439c27f8ac405d1c99882e243c2e6c947a1f1c4d3cc96d7b46bbac', '[\"*\"]', NULL, '2025-05-03 04:40:34', '2025-04-03 04:40:34', '2025-04-03 04:40:34'),
(214, 'App\\Models\\User', 41, 'API Token', '020838af31cf95728d60d795b307d7207091c2d1996712cd9995e2af01ca8963', '[\"*\"]', NULL, '2025-05-04 13:23:29', '2025-04-04 13:23:29', '2025-04-04 13:23:29'),
(215, 'App\\Models\\User', 41, 'API Token', '82ec4a0bf58d134b3cc595aca806c48be4cf181948f8d8a6ffb4a3593f74d94e', '[\"*\"]', '2025-04-05 09:50:02', '2025-05-04 13:32:53', '2025-04-04 13:32:53', '2025-04-05 09:50:02'),
(216, 'App\\Models\\User', 41, 'API Token', '52199dfbf0894d5feaee2a9b3c8d09be3d0dbd6ca157779ff7bc286b7f28e8ee', '[\"*\"]', NULL, '2025-05-04 17:27:32', '2025-04-04 17:27:32', '2025-04-04 17:27:32'),
(217, 'App\\Models\\User', 41, 'API Token', 'e039c89fc23b5d21fc696db1a68d7cdb58dce55d694baa3df7b7c6d5c01594fd', '[\"*\"]', '2025-04-05 11:55:12', '2025-05-05 10:06:37', '2025-04-05 10:06:37', '2025-04-05 11:55:12'),
(218, 'App\\Models\\User', 41, 'API Token', 'cb43270b67c7c74fab9654dbe90bbb2125c1715ebc8f582e88537819aaf84fd6', '[\"*\"]', '2025-04-05 14:32:18', '2025-05-05 11:56:09', '2025-04-05 11:56:09', '2025-04-05 14:32:18'),
(219, 'App\\Models\\User', 41, 'API Token', '2c44e4198a48ac21dab243cdade5f990130284c4a4f92b7d56f952e0a62c326c', '[\"*\"]', NULL, '2025-05-05 14:34:39', '2025-04-05 14:34:39', '2025-04-05 14:34:39'),
(220, 'App\\Models\\User', 41, 'API Token', '6222b7f34727838e0e9faf5640a4c7731f0d9d2e59889e0e4b5a174183fc82c7', '[\"*\"]', NULL, '2025-05-05 14:34:40', '2025-04-05 14:34:40', '2025-04-05 14:34:40'),
(221, 'App\\Models\\User', 41, 'API Token', '601edb2eda6980a4675bd5b6ee9513eaa0eba6469a2705f24d55ae3bf144a42e', '[\"*\"]', NULL, '2025-05-05 14:35:40', '2025-04-05 14:35:40', '2025-04-05 14:35:40'),
(222, 'App\\Models\\User', 41, 'API Token', 'cf35b3cb2294a20c7b0341005926f6d1a67a035334cc0ef37d238c41730c1d23', '[\"*\"]', NULL, '2025-05-05 14:36:25', '2025-04-05 14:36:25', '2025-04-05 14:36:25'),
(223, 'App\\Models\\User', 41, 'API Token', 'cabf7b22c6414bfb8cde254fb7325e2d13c0d0521e7480d4f9bbfdc6b7bce337', '[\"*\"]', '2025-04-05 14:45:11', '2025-05-05 14:44:59', '2025-04-05 14:44:59', '2025-04-05 14:45:11'),
(224, 'App\\Models\\User', 41, 'API Token', 'a822e434ed64163e28ede4267b2934a9e7ee398ddd943f3e0e03f7a05d75255c', '[\"*\"]', NULL, '2025-05-05 14:49:34', '2025-04-05 14:49:34', '2025-04-05 14:49:34'),
(225, 'App\\Models\\User', 41, 'API Token', '722087895fa594bf31946db987b3d1b603d002a9f110d7ab211c8c8d37f68246', '[\"*\"]', '2025-04-05 15:23:15', '2025-05-05 14:57:16', '2025-04-05 14:57:16', '2025-04-05 15:23:15'),
(226, 'App\\Models\\User', 41, 'API Token', 'f2107cf375ab35b70b487a3b44f8c61351ea1883e399642ce68ecb0a16a0f7a5', '[\"*\"]', '2025-04-10 09:43:07', '2025-05-05 14:58:26', '2025-04-05 14:58:26', '2025-04-10 09:43:07'),
(227, 'App\\Models\\User', 52, 'API Token', '902ad8b120c3761b712b40ae5e37620059d8404c37a402f6c0624430bdb5cd30', '[\"*\"]', NULL, '2025-05-05 15:14:28', '2025-04-05 15:14:28', '2025-04-05 15:14:28'),
(228, 'App\\Models\\User', 52, 'API Token', '36bb9d320c64b5e31cc202be323ed964926d4adc8988e4125dc3fad50931db53', '[\"*\"]', '2025-04-05 17:13:46', '2025-05-05 15:17:27', '2025-04-05 15:17:27', '2025-04-05 17:13:46'),
(229, 'App\\Models\\User', 41, 'API Token', 'f7f306cf3b608c40f4217cc3957a1800e01bd6a8e2e1de0114a6a77f9712384e', '[\"*\"]', '2025-04-05 16:50:41', '2025-05-05 15:24:26', '2025-04-05 15:24:26', '2025-04-05 16:50:41'),
(230, 'App\\Models\\User', 46, 'API Token', 'b168eb35fcc1c8b7061b7fd8bcad3fa51b6f85e8da7c56f26282075ee2b00e50', '[\"*\"]', '2025-04-30 03:58:31', '2025-05-05 16:36:57', '2025-04-05 16:36:57', '2025-04-30 03:58:31'),
(231, 'App\\Models\\User', 41, 'API Token', 'afecfb5724da16c41ff6960c33cdec3406b24360bef19747c000c64899b06da3', '[\"*\"]', '2025-04-07 08:33:39', '2025-05-05 16:53:31', '2025-04-05 16:53:31', '2025-04-07 08:33:39'),
(232, 'App\\Models\\User', 43, 'API Token', 'e255263f1cd0e4796c9d011a64d7e18e60f48af2b13814d7c4789a050a9e1ca4', '[\"*\"]', '2025-04-06 10:36:02', '2025-05-06 10:35:35', '2025-04-06 10:35:35', '2025-04-06 10:36:02'),
(233, 'App\\Models\\User', 43, 'API Token', 'c26edde8c8498c858eee21e51e6befd334a705a5f45254928c5278f355ef930a', '[\"*\"]', NULL, '2025-05-07 07:15:31', '2025-04-07 07:15:31', '2025-04-07 07:15:31'),
(234, 'App\\Models\\User', 43, 'API Token', '4379392e84980d2349c0639d2c3348b8fa00ecfae95515c3d54be5e9427a9880', '[\"*\"]', NULL, '2025-05-07 07:15:44', '2025-04-07 07:15:44', '2025-04-07 07:15:44'),
(235, 'App\\Models\\User', 43, 'API Token', '9bf8134f4b0e4ae006bf3b1120342ad0ed74ce12eb233e3bf4573a2d1478146c', '[\"*\"]', '2025-04-07 07:17:58', '2025-05-07 07:15:57', '2025-04-07 07:15:57', '2025-04-07 07:17:58'),
(236, 'App\\Models\\User', 41, 'API Token', '3d456266cd313e33e728db418be53c797323158980da370114819648679bcdcf', '[\"*\"]', '2025-04-10 09:57:58', '2025-05-10 08:07:13', '2025-04-10 08:07:13', '2025-04-10 09:57:58'),
(237, 'App\\Models\\User', 41, 'API Token', 'c0f1f7d1e17401c1cff464af6041aacf1ee9efbef93bd5fd8f61dc00e20a8bea', '[\"*\"]', '2025-04-10 10:04:17', '2025-05-10 09:59:50', '2025-04-10 09:59:50', '2025-04-10 10:04:17'),
(238, 'App\\Models\\User', 41, 'API Token', 'b19c437b2dc85817a424f0b48324099b56172c0ffed57d412aff1285873185d9', '[\"*\"]', NULL, '2025-05-12 15:11:05', '2025-04-12 15:11:05', '2025-04-12 15:11:05'),
(239, 'App\\Models\\User', 41, 'API Token', 'fc279e728ac08e50399686618cd0a120d98f7a30142e4060364266ba53b75b0d', '[\"*\"]', NULL, '2025-05-16 14:43:50', '2025-04-16 14:43:50', '2025-04-16 14:43:50'),
(240, 'App\\Models\\User', 41, 'API Token', 'd7d3fc69819f1d2fea084fb045521c3d89bcfd7f575218930662bd11ec2afadf', '[\"*\"]', NULL, '2025-05-18 10:02:03', '2025-04-18 10:02:03', '2025-04-18 10:02:03'),
(241, 'App\\Models\\User', 41, 'API Token', '27107d86d74a5a4e9e07a5b1f815306e831e3794db02f3e86163862b1ca4767d', '[\"*\"]', '2025-04-19 10:45:41', '2025-05-19 10:19:02', '2025-04-19 10:19:02', '2025-04-19 10:45:41'),
(242, 'App\\Models\\User', 41, 'API Token', '51180a262f7d057f2dd28b9e1a55dfecc4e7c03a456cc0caa76cba516247f425', '[\"*\"]', NULL, '2025-05-20 06:45:19', '2025-04-20 06:45:19', '2025-04-20 06:45:19'),
(243, 'App\\Models\\User', 41, 'API Token', '26b14651e631d444662b0223c390bd74363ed9fb1460a07c039898d67142293f', '[\"*\"]', NULL, '2025-05-20 06:48:49', '2025-04-20 06:48:49', '2025-04-20 06:48:49'),
(244, 'App\\Models\\User', 50, 'API Token', '52da3203ab558e1f636c39d72ed8336844d48bf5b21bfad4a8a152b168b50475', '[\"*\"]', NULL, '2025-05-20 06:55:58', '2025-04-20 06:55:58', '2025-04-20 06:55:58'),
(245, 'App\\Models\\User', 50, 'API Token', 'e1f0e1ef62dbbaa2aad0c7670ed7b9512003384ff42af3c9c82d70fcd193f338', '[\"*\"]', NULL, '2025-05-20 06:56:47', '2025-04-20 06:56:47', '2025-04-20 06:56:47'),
(246, 'App\\Models\\User', 50, 'API Token', 'c918c20114d9dafca01125a10ba54c7729c476596a280a546a9db37a570f098a', '[\"*\"]', '2025-05-20 05:15:51', '2025-05-20 06:56:51', '2025-04-20 06:56:51', '2025-05-20 05:15:51'),
(247, 'App\\Models\\User', 41, 'API Token', 'a29a7a22b4d69a295eac2c671ba3542c01d4d5e348a8197a6bcc25a2498b7d6f', '[\"*\"]', '2025-04-23 15:07:24', '2025-05-21 03:21:57', '2025-04-21 03:21:57', '2025-04-23 15:07:24'),
(248, 'App\\Models\\User', 41, 'API Token', '62ef604ed02028ecc88bccebd7ab520c5f810a7f920b9a926591caa0491e7828', '[\"*\"]', NULL, '2025-05-21 07:37:52', '2025-04-21 07:37:52', '2025-04-21 07:37:52'),
(249, 'App\\Models\\User', 43, 'API Token', 'ae6181c7ea1a69a929425c1c5f4fd635fad5a189a6c9a00404b2506a8711f435', '[\"*\"]', '2025-04-26 14:08:15', '2025-05-22 08:15:39', '2025-04-22 08:15:39', '2025-04-26 14:08:15'),
(250, 'App\\Models\\User', 41, 'API Token', '232a3683b6cc27820a7ed09c8fc952b898b424774c3da42072151683a3faebf9', '[\"*\"]', NULL, '2025-05-23 03:01:22', '2025-04-23 03:01:22', '2025-04-23 03:01:22'),
(251, 'App\\Models\\User', 53, 'API Token', '7760aa6955ba4fe30b75a3f2a12d560f3dcf671f733f7e66e0eaa22175443c63', '[\"*\"]', '2025-04-23 03:27:24', '2025-05-23 03:25:18', '2025-04-23 03:25:18', '2025-04-23 03:27:24'),
(252, 'App\\Models\\User', 43, 'API Token', '6fedfd1eb3f2a35392772b460de5959699794dcdcc915ef0a15c9c62758693a3', '[\"*\"]', NULL, '2025-05-23 15:34:53', '2025-04-23 15:34:53', '2025-04-23 15:34:53'),
(253, 'App\\Models\\User', 41, 'API Token', '6bccf01e1afc399ce0934305bf3fa0d740e16427eee3dd1a0542c86dc3fa718a', '[\"*\"]', NULL, '2025-05-24 06:57:57', '2025-04-24 06:57:57', '2025-04-24 06:57:57'),
(254, 'App\\Models\\User', 41, 'API Token', '71060f5b0148ebd85e71bf40de23dcd2c346448bca08279f2d284e13ae3a9aa5', '[\"*\"]', '2025-04-24 17:17:51', '2025-05-24 17:16:40', '2025-04-24 17:16:40', '2025-04-24 17:17:51'),
(255, 'App\\Models\\User', 41, 'API Token', '2b5b156b0532550b0d5ca4509752e7c18a498dfdbb666d2267695a209b46855e', '[\"*\"]', '2025-04-26 16:24:16', '2025-05-26 07:06:05', '2025-04-26 07:06:05', '2025-04-26 16:24:16'),
(257, 'App\\Models\\Admin', 2, 'API Token', '982d5947b731a4e8c2cb3e4f73fef4c39d44e7a1b093f9e28dcbe17d7ff02929', '[\"*\"]', '2025-05-08 07:18:20', '2025-05-10 08:01:09', '2025-04-26 08:01:09', '2025-05-08 07:18:20'),
(258, 'App\\Models\\Admin', 4, 'API Token', 'd4b8cac7726d253c96a61211f10189504a906d53d9c89401f593df573969a869', '[\"*\"]', '2025-04-26 08:04:53', '2025-05-10 08:02:00', '2025-04-26 08:02:00', '2025-04-26 08:04:53'),
(259, 'App\\Models\\Admin', 4, 'API Token', 'cc72f52d5f31516acc0b18741df454489d9af1d548fa52b0cd2e0120426a0ec2', '[\"*\"]', NULL, '2025-05-10 08:05:07', '2025-04-26 08:05:07', '2025-04-26 08:05:07'),
(260, 'App\\Models\\User', 41, 'API Token', 'fa23d5b55428779c8c8638344554ebc29e3593ff1fcd5121d5469a33284b26d6', '[\"*\"]', '2025-05-07 13:50:17', '2025-05-26 14:57:06', '2025-04-26 14:57:06', '2025-05-07 13:50:17'),
(261, 'App\\Models\\Admin', 4, 'API Token', '65d580df44acf33b3a57c6330a3958176a0c99716a2739ed911f43e845e2be78', '[\"*\"]', '2025-04-26 16:14:48', '2025-05-10 15:00:19', '2025-04-26 15:00:19', '2025-04-26 16:14:48'),
(262, 'App\\Models\\User', 41, 'API Token', '0ea1517e0dddc29559210b8833b0ed4a610fafdaca746760c072793e45d6112b', '[\"*\"]', NULL, '2025-05-27 06:38:47', '2025-04-27 06:38:47', '2025-04-27 06:38:47'),
(263, 'App\\Models\\User', 41, 'API Token', '904d7e0e993d56964b33e63a8294276479a76c6a1fd7bf2e5189790729783ad1', '[\"*\"]', NULL, '2025-05-27 06:39:44', '2025-04-27 06:39:44', '2025-04-27 06:39:44'),
(264, 'App\\Models\\User', 41, 'API Token', '0b328c29991d1f5907f841f2ad2011c474fe13c11636d1ef255306dd1e85cca9', '[\"*\"]', NULL, '2025-05-27 06:45:08', '2025-04-27 06:45:08', '2025-04-27 06:45:08'),
(265, 'App\\Models\\User', 41, 'API Token', '587a72d4c70986644169d04579946bfdcb1d2bf55823dd0b30b96769a6b00106', '[\"*\"]', NULL, '2025-05-27 06:45:17', '2025-04-27 06:45:17', '2025-04-27 06:45:17'),
(266, 'App\\Models\\User', 41, 'API Token', '2eb4f24899c245f5178840440c3facb18814d6ebfcaeb6f8f7317de8ae1ddf71', '[\"*\"]', NULL, '2025-05-27 06:46:36', '2025-04-27 06:46:36', '2025-04-27 06:46:36'),
(267, 'App\\Models\\User', 41, 'API Token', '69063ec443ad5790eecee75b316de51562fac8ae5302126f3c00aebd03643a73', '[\"*\"]', '2025-04-27 15:15:01', '2025-05-27 06:50:36', '2025-04-27 06:50:36', '2025-04-27 15:15:01'),
(268, 'App\\Models\\User', 41, 'API Token', 'fbc9c883809b7123aae40676a0490f94e25f119db3d4158a0b7168cd2de8f9dc', '[\"*\"]', NULL, '2025-05-27 07:16:06', '2025-04-27 07:16:06', '2025-04-27 07:16:06'),
(269, 'App\\Models\\User', 41, 'API Token', 'c376080ff11b2273b097e49f52d9bc536639fba91a8072ec364de60088482e01', '[\"*\"]', NULL, '2025-05-27 13:54:06', '2025-04-27 13:54:06', '2025-04-27 13:54:06'),
(270, 'App\\Models\\User', 41, 'API Token', '27217d0e1b5e96d20cca6a539ebbfa03083849e43521f58ecc977b43b91de5db', '[\"*\"]', '2025-05-06 15:35:21', '2025-05-28 08:47:39', '2025-04-28 08:47:39', '2025-05-06 15:35:21'),
(271, 'App\\Models\\User', 49, 'API Token', 'ae5e9ab90bb247f3fe0b6a710195b242b398248c43662b263390ceb151e6060e', '[\"*\"]', NULL, '2025-05-29 14:21:42', '2025-04-29 14:21:42', '2025-04-29 14:21:42'),
(272, 'App\\Models\\User', 41, 'API Token', '507772faac7511aaaee55c7047f648360993c0123dff212bf8822996fe8556fc', '[\"*\"]', NULL, '2025-05-29 14:31:26', '2025-04-29 14:31:26', '2025-04-29 14:31:26'),
(273, 'App\\Models\\User', 41, 'API Token', '211289a4cb2d4227ec71ea3970f16e9bde051e60e02abc6dffbad0b49cb7413f', '[\"*\"]', NULL, '2025-05-29 14:32:16', '2025-04-29 14:32:16', '2025-04-29 14:32:16'),
(274, 'App\\Models\\User', 49, 'API Token', 'fe34d7a5dba31c2c2e50393dc932b987d6815e3623a597c7d89ab6ba1ef5787e', '[\"*\"]', NULL, '2025-05-29 14:41:12', '2025-04-29 14:41:12', '2025-04-29 14:41:12'),
(275, 'App\\Models\\User', 49, 'API Token', 'fb825838b3dd0498b93d430a8df1289bba60019fc07111792de610e6f599605d', '[\"*\"]', NULL, '2025-05-29 14:42:00', '2025-04-29 14:42:00', '2025-04-29 14:42:00'),
(276, 'App\\Models\\User', 49, 'API Token', '4726cad09e3594f8011276ff9c7fb640d8c9872a7ec152f214be0bcd0b5aa241', '[\"*\"]', NULL, '2025-05-29 14:43:09', '2025-04-29 14:43:09', '2025-04-29 14:43:09'),
(277, 'App\\Models\\User', 41, 'API Token', '0cb61967172f8e1a9fdd6a4ae5be74daed27de5caaea9c6c62692f0a69b1b91a', '[\"*\"]', NULL, '2025-05-29 14:44:59', '2025-04-29 14:44:59', '2025-04-29 14:44:59'),
(278, 'App\\Models\\User', 49, 'API Token', 'c27c48f6b5f9b0c19420a7482408d65ede761dd2b63f3606b2976b7f39f5e15b', '[\"*\"]', NULL, '2025-05-29 14:45:17', '2025-04-29 14:45:17', '2025-04-29 14:45:17');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(279, 'App\\Models\\User', 49, 'API Token', '7434923f8e94f5aa953f1b79fb034af86b036172175105f80514106156404a55', '[\"*\"]', NULL, '2025-05-29 14:46:19', '2025-04-29 14:46:19', '2025-04-29 14:46:19'),
(280, 'App\\Models\\User', 49, 'API Token', '24df94440b594e4c4bdeb687a4e952ad0232541e256c696b49880030533ba9a6', '[\"*\"]', NULL, '2025-05-29 14:47:50', '2025-04-29 14:47:50', '2025-04-29 14:47:50'),
(281, 'App\\Models\\User', 49, 'API Token', '7a9b949c9c560ab665bf38e2492d628f97e61a45ed344ae8ada0e19edc1bc734', '[\"*\"]', NULL, '2025-05-29 14:49:01', '2025-04-29 14:49:01', '2025-04-29 14:49:01'),
(282, 'App\\Models\\User', 41, 'API Token', 'b55a0956d97952c31af41281b32d9c1b160a30c43b10b3a878db3713f72f8227', '[\"*\"]', NULL, '2025-05-29 14:52:03', '2025-04-29 14:52:03', '2025-04-29 14:52:03'),
(283, 'App\\Models\\User', 41, 'API Token', '11f9086ff22d04356bd600e8ccee09444ca29729aac8ae502ab2502fe9370fa7', '[\"*\"]', NULL, '2025-05-29 14:53:15', '2025-04-29 14:53:15', '2025-04-29 14:53:15'),
(284, 'App\\Models\\User', 41, 'API Token', 'ebc70e6b0799fe0947d10258868b0176aa34328f29a897e68f281235ee4802d9', '[\"*\"]', NULL, '2025-05-29 14:54:29', '2025-04-29 14:54:29', '2025-04-29 14:54:29'),
(285, 'App\\Models\\User', 41, 'API Token', '35fcd23a81a5e832f79b0d4e9a32597deb2cac7a24acab56bec1692daa71e779', '[\"*\"]', NULL, '2025-05-29 14:57:06', '2025-04-29 14:57:06', '2025-04-29 14:57:06'),
(286, 'App\\Models\\User', 49, 'API Token', '62ba6f36d11d81aa392aa169b078247332a1d2ec16148cee69abaf6653d68a3b', '[\"*\"]', NULL, '2025-05-29 15:49:18', '2025-04-29 15:49:18', '2025-04-29 15:49:18'),
(287, 'App\\Models\\User', 41, 'API Token', 'dfdf30060e5ce004240db28e2022f89ca4572a28427daace90b11376d74821c1', '[\"*\"]', '2025-04-30 09:46:19', '2025-05-29 16:09:44', '2025-04-29 16:09:44', '2025-04-30 09:46:19'),
(288, 'App\\Models\\User', 49, 'API Token', '2114d99f39c47b1dbe5a3adc775bfefb3d04852d88e2484857db8eaedee1ba3d', '[\"*\"]', '2025-04-29 16:14:09', '2025-05-29 16:10:16', '2025-04-29 16:10:16', '2025-04-29 16:14:09'),
(289, 'App\\Models\\User', 54, 'API Token', '11c198b1f4759f05b07d85d5f4dabe7ff2d37ff1bb17629464914bec39b8d52e', '[\"*\"]', '2025-04-30 04:00:18', '2025-05-30 03:55:42', '2025-04-30 03:55:42', '2025-04-30 04:00:18'),
(290, 'App\\Models\\User', 54, 'API Token', '2aa2dbe288864c0c22420ac1f3625d38ba6d49d79316a6cd90b0a04b34c5daad', '[\"*\"]', '2025-04-30 04:02:08', '2025-05-30 03:58:55', '2025-04-30 03:58:55', '2025-04-30 04:02:08'),
(291, 'App\\Models\\User', 55, 'API Token', 'c40b8f9d8fdcec9274c42869d25c8cb02088fcfdb1c784bb4d3b3fe59a10b0f5', '[\"*\"]', '2025-04-30 16:20:26', '2025-05-30 04:02:48', '2025-04-30 04:02:48', '2025-04-30 16:20:26'),
(292, 'App\\Models\\User', 53, 'API Token', '9818c879ecb3e9d538c07e4c1e327c90ec90811409ed20530671ee1863b86070', '[\"*\"]', NULL, '2025-05-30 04:06:46', '2025-04-30 04:06:46', '2025-04-30 04:06:46'),
(293, 'App\\Models\\User', 50, 'API Token', '8f698f5490bd2783504360adefabbe653c0b604cba7d38e643d7b5a7e15dfaec', '[\"*\"]', '2025-04-30 04:09:52', '2025-05-30 04:09:01', '2025-04-30 04:09:01', '2025-04-30 04:09:52'),
(294, 'App\\Models\\User', 55, 'API Token', '6eb62dbbb9076ece09a7260da5a3c0cca8ee5ae2c6e4466b1e23f18581abcefc', '[\"*\"]', '2025-04-30 16:03:28', '2025-05-30 16:01:40', '2025-04-30 16:01:40', '2025-04-30 16:03:28'),
(295, 'App\\Models\\User', 41, 'API Token', 'e5902cfca9fe63d91ffa122156573c45f134c4fae4a89ca9a27ece1316b56f94', '[\"*\"]', NULL, '2025-06-01 10:44:36', '2025-05-01 10:44:36', '2025-05-01 10:44:36'),
(296, 'App\\Models\\Admin', 4, 'API Token', '3dd18ee1ea1a146b2e9fbded16e9dea7719e7ae1e1c363d98fff2fdcabc40ba0', '[\"*\"]', NULL, '2025-05-15 14:10:08', '2025-05-01 14:10:08', '2025-05-01 14:10:08'),
(297, 'App\\Models\\User', 41, 'API Token', '7471d5203b8b0e48e729d694e627bd992d89e100b3a8081ea1ec08cd6ec2790a', '[\"*\"]', '2025-05-25 16:18:00', '2025-06-01 14:26:51', '2025-05-01 14:26:51', '2025-05-25 16:18:00'),
(298, 'App\\Models\\Admin', 2, 'API Token', '9ad2c5a71051585aec941f446557466a41d6ba407c0448056da0dd6dfa41a8d6', '[\"*\"]', NULL, '2025-05-16 03:07:29', '2025-05-02 03:07:29', '2025-05-02 03:07:29'),
(299, 'App\\Models\\Admin', 2, 'API Token', 'b544a915874b45b0c8cd1e28ee63ab5b978e71ece47184d542e9c8f3a05ff804', '[\"*\"]', NULL, '2025-05-16 03:27:54', '2025-05-02 03:27:54', '2025-05-02 03:27:54'),
(300, 'App\\Models\\Admin', 2, 'API Token', 'ceba82a6c28a0b6d869bcbc9ca0cd69aeab4d3d4f280449a011d53cd851b2418', '[\"*\"]', NULL, '2025-05-16 04:02:21', '2025-05-02 04:02:21', '2025-05-02 04:02:21'),
(301, 'App\\Models\\Admin', 2, 'API Token', '3e420f5345e8efc45210adb57433bde1a9779fc239fcf4bddb86507df8f1ba37', '[\"*\"]', NULL, '2025-05-16 04:14:34', '2025-05-02 04:14:34', '2025-05-02 04:14:34'),
(302, 'App\\Models\\Admin', 2, 'API Token', 'b9349430e15047b48a5b29fdfcaee98e3bc3fa37fc6e8c26f5d569be7285b210', '[\"*\"]', '2025-05-02 04:39:53', '2025-05-16 04:25:51', '2025-05-02 04:25:51', '2025-05-02 04:39:53'),
(303, 'App\\Models\\Admin', 2, 'API Token', '03b2c60ffaeb5861c1be9ea29c4290f1c05b4633e53bf36debfee1e25bc4dd65', '[\"*\"]', NULL, '2025-05-16 05:07:18', '2025-05-02 05:07:18', '2025-05-02 05:07:18'),
(304, 'App\\Models\\Admin', 2, 'API Token', '858a97819b67e6d7e7b0d04b2eaa627e448a402cb1d4b8d3d34ea665da1cc224', '[\"*\"]', NULL, '2025-05-16 05:07:50', '2025-05-02 05:07:50', '2025-05-02 05:07:50'),
(305, 'App\\Models\\Admin', 2, 'API Token', '8e10264c2e730408a59dbacab591e8611f365aac0583339bbba6b3ab7cab88d0', '[\"*\"]', NULL, '2025-05-16 05:10:07', '2025-05-02 05:10:07', '2025-05-02 05:10:07'),
(306, 'App\\Models\\Admin', 2, 'API Token', 'e0d7fcc9cfb7ea324d8958f211311757e1fbb561a5bdf478cd67c9e4dbb4ff68', '[\"*\"]', NULL, '2025-05-16 05:36:18', '2025-05-02 05:36:18', '2025-05-02 05:36:18'),
(307, 'App\\Models\\Admin', 2, 'API Token', '1b5f82f9379f96d338464d84db50275098254faa3362a2c23e99ce1e6f43a604', '[\"*\"]', NULL, '2025-05-16 05:37:00', '2025-05-02 05:37:00', '2025-05-02 05:37:00'),
(308, 'App\\Models\\Admin', 2, 'API Token', '3a592e8a55d95bc6e679243817a8966509cc11af03805504f1cbc73c67be7bc2', '[\"*\"]', NULL, '2025-05-16 05:38:06', '2025-05-02 05:38:06', '2025-05-02 05:38:06'),
(309, 'App\\Models\\Admin', 2, 'API Token', '622cb60629b36130f736b81ee7adfb9d7edb933122726a24977bf652f51333b3', '[\"*\"]', NULL, '2025-05-16 05:38:56', '2025-05-02 05:38:56', '2025-05-02 05:38:56'),
(310, 'App\\Models\\Admin', 2, 'API Token', 'fcd948377349253a8109be6a786bd9f4afb3598c785836bbe7aba93b966a6854', '[\"*\"]', NULL, '2025-05-16 05:41:14', '2025-05-02 05:41:14', '2025-05-02 05:41:14'),
(311, 'App\\Models\\Admin', 2, 'API Token', '9415c17a2bd3e7ce07e471b8f514abe35214cd99a8f9924a527b0aafdcd807d2', '[\"*\"]', NULL, '2025-05-16 05:53:39', '2025-05-02 05:53:39', '2025-05-02 05:53:39'),
(312, 'App\\Models\\Admin', 2, 'API Token', '8542021df046a21db9df57c85e875103309fff8fbf4c0f3bc073c66d492d0491', '[\"*\"]', NULL, '2025-05-16 05:58:33', '2025-05-02 05:58:33', '2025-05-02 05:58:33'),
(313, 'App\\Models\\Admin', 2, 'API Token', '0e2d0652a8f9c6a85a381186f7d90eee67fdac068f273b09c814034d3287ea84', '[\"*\"]', NULL, '2025-05-16 05:59:32', '2025-05-02 05:59:32', '2025-05-02 05:59:32'),
(314, 'App\\Models\\Admin', 2, 'API Token', '6fd60b54e82f3e093c92cdbc1e36e2118d1df073b6a138071a1c9ac5468be9d1', '[\"*\"]', NULL, '2025-05-16 06:05:18', '2025-05-02 06:05:18', '2025-05-02 06:05:18'),
(315, 'App\\Models\\Admin', 2, 'API Token', '12c041cd2a96ff062f9c65d88d37b81fb6ea11f6678dba9ed4a3e0ba1176cecc', '[\"*\"]', NULL, '2025-05-16 06:07:04', '2025-05-02 06:07:04', '2025-05-02 06:07:04'),
(316, 'App\\Models\\Admin', 2, 'API Token', 'c6925b333c68119d802d5e477bd4c90d04ba2ffb142d45e915b829d6fe4fc3e6', '[\"*\"]', NULL, '2025-05-16 06:11:16', '2025-05-02 06:11:16', '2025-05-02 06:11:16'),
(317, 'App\\Models\\Admin', 2, 'API Token', '292180e1a07a65f8068146d73ac97a50cc95ba08dce1a9e0c8373ade8c061f25', '[\"*\"]', NULL, '2025-05-16 06:12:00', '2025-05-02 06:12:00', '2025-05-02 06:12:00'),
(318, 'App\\Models\\Admin', 2, 'API Token', 'b0418c69adb84571571e1fa49e7437989ac74902e1c7e770af6f7f9853397cbe', '[\"*\"]', NULL, '2025-05-16 06:25:33', '2025-05-02 06:25:33', '2025-05-02 06:25:33'),
(319, 'App\\Models\\Admin', 2, 'API Token', 'f433f01cf72b2c3cc42f5664434a88af38135b6dad0800c5f474ce7cb2ea06c7', '[\"*\"]', NULL, '2025-05-16 06:25:58', '2025-05-02 06:25:58', '2025-05-02 06:25:58'),
(320, 'App\\Models\\Admin', 2, 'API Token', '1fe24a7a20a04e7d6d9919e1d14491f6d0a57835babd57ab6099564053b150de', '[\"*\"]', NULL, '2025-05-16 06:34:33', '2025-05-02 06:34:33', '2025-05-02 06:34:33'),
(321, 'App\\Models\\Admin', 2, 'API Token', '2c8e37a5372691d3ced0af8961a81dddcce82e754fd7d86777bfbdf8b752a4c2', '[\"*\"]', NULL, '2025-05-16 06:37:00', '2025-05-02 06:37:00', '2025-05-02 06:37:00'),
(322, 'App\\Models\\Admin', 2, 'API Token', '8f51cf5248e8550f795438ab8771284614f4a2b263a444e73445455f6bfa0915', '[\"*\"]', NULL, '2025-05-16 06:38:24', '2025-05-02 06:38:24', '2025-05-02 06:38:24'),
(323, 'App\\Models\\Admin', 2, 'API Token', '0a0fecc90d20f29353416f9ea8535083add004648950df0fe6f3509e5b12c71b', '[\"*\"]', NULL, '2025-05-16 06:40:04', '2025-05-02 06:40:04', '2025-05-02 06:40:04'),
(324, 'App\\Models\\Admin', 2, 'API Token', 'ecde3dfd90563b05541177e3d1eaeec2fbdd53ea80fb70fe4e7a6f624f9fea5d', '[\"*\"]', NULL, '2025-05-16 06:40:44', '2025-05-02 06:40:44', '2025-05-02 06:40:44'),
(325, 'App\\Models\\Admin', 2, 'API Token', '98d9d2e8a0f86340aa50a5e61bbac57bc8889b153bbb24f663cc3a01b7e662e3', '[\"*\"]', NULL, '2025-05-16 06:51:32', '2025-05-02 06:51:32', '2025-05-02 06:51:32'),
(326, 'App\\Models\\Admin', 2, 'API Token', 'eba151cf176aa2fb47ec26b5ba6d596eb7febe9d8b691ad40981239a56b8571c', '[\"*\"]', NULL, '2025-05-16 06:52:21', '2025-05-02 06:52:21', '2025-05-02 06:52:21'),
(327, 'App\\Models\\Admin', 2, 'API Token', 'f49677da96b5c2d0a6f1b718f515302209097f20057fe65f140db86fb0e2ceed', '[\"*\"]', NULL, '2025-05-16 06:53:03', '2025-05-02 06:53:03', '2025-05-02 06:53:03'),
(328, 'App\\Models\\Admin', 2, 'API Token', '2e92e68dc2646783f16bdd6a10855e0d86a09c4b9e0350e677c89325ba743161', '[\"*\"]', NULL, '2025-05-16 06:53:47', '2025-05-02 06:53:47', '2025-05-02 06:53:47'),
(329, 'App\\Models\\Admin', 2, 'API Token', '784fc1126395c722892f29dd4b35dbf2db3554317986276f7f82a1ef6ae541b6', '[\"*\"]', NULL, '2025-05-16 06:56:48', '2025-05-02 06:56:48', '2025-05-02 06:56:48'),
(330, 'App\\Models\\Admin', 2, 'API Token', '3e249cbca6f88887b1f4eee400343299edb43c6e67f71010be8325e99d376cc7', '[\"*\"]', NULL, '2025-05-16 07:01:51', '2025-05-02 07:01:51', '2025-05-02 07:01:51'),
(331, 'App\\Models\\Admin', 2, 'API Token', '9319dc31cf12ce0eee38f7d57dae1c864f4b1d8c4a42b537d9deaa0633bfdba9', '[\"*\"]', NULL, '2025-05-16 07:02:56', '2025-05-02 07:02:56', '2025-05-02 07:02:56'),
(332, 'App\\Models\\Admin', 2, 'API Token', 'e603ff351fc44a02d26f718f5e84d614555bcf24087ae5f6eb32a2b8a486bc9e', '[\"*\"]', NULL, '2025-05-16 07:03:21', '2025-05-02 07:03:21', '2025-05-02 07:03:21'),
(333, 'App\\Models\\Admin', 2, 'API Token', '441999178a625fadd7450a8617c8b4f2bf0c1fd9855ead5a40f3432dd86eb6d2', '[\"*\"]', NULL, '2025-05-16 07:06:14', '2025-05-02 07:06:14', '2025-05-02 07:06:14'),
(334, 'App\\Models\\Admin', 2, 'API Token', '2418b2a2af39fe1333f60cd386016e6c1a0c9ddc8ba64f92494361cd017b4329', '[\"*\"]', NULL, '2025-05-16 07:07:10', '2025-05-02 07:07:10', '2025-05-02 07:07:10'),
(335, 'App\\Models\\Admin', 2, 'API Token', 'a21862ebc2c98d669a4eaa6974df0678235f2fd1f9d65975425ed2eef0e30bbe', '[\"*\"]', NULL, '2025-05-16 07:08:21', '2025-05-02 07:08:21', '2025-05-02 07:08:21'),
(336, 'App\\Models\\Admin', 2, 'API Token', 'bd06bf402a825d307eb599fc7eb01bb43e05d8dc030794049f1a364148259cd7', '[\"*\"]', NULL, '2025-05-16 07:16:01', '2025-05-02 07:16:01', '2025-05-02 07:16:01'),
(337, 'App\\Models\\Admin', 2, 'API Token', 'b5f3320b8e75893109530e826aa757ab8f8c3263b5d8226bfe7ef43454a8593d', '[\"*\"]', NULL, '2025-05-16 07:16:39', '2025-05-02 07:16:39', '2025-05-02 07:16:39'),
(338, 'App\\Models\\Admin', 2, 'API Token', '02cd0f62cfbabc94e66223191fc41cfdd4d8a937d510ab45b1d71b07f033aa1c', '[\"*\"]', NULL, '2025-05-16 07:17:26', '2025-05-02 07:17:26', '2025-05-02 07:17:26'),
(339, 'App\\Models\\Admin', 2, 'API Token', 'afd89d184d6251ed5cf078a0273df70b2c1813fcd29ed00b1227beb3437dbcc0', '[\"*\"]', NULL, '2025-05-16 07:17:44', '2025-05-02 07:17:44', '2025-05-02 07:17:44'),
(340, 'App\\Models\\Admin', 2, 'API Token', 'cc58391e169493bbb16b0ee53cfaefd1622182173a21e1fe320593ca3c68407c', '[\"*\"]', NULL, '2025-05-16 07:20:00', '2025-05-02 07:20:00', '2025-05-02 07:20:00'),
(341, 'App\\Models\\Admin', 2, 'API Token', '62a531325727cb2b88f4c73eea56f0206f9a4bf490e6ada032154870a92f129a', '[\"*\"]', NULL, '2025-05-16 07:20:22', '2025-05-02 07:20:22', '2025-05-02 07:20:22'),
(342, 'App\\Models\\Admin', 2, 'API Token', '48204405ad93b1b94cab74d481bf6af7407d266ac420a8ec2011dbc128913191', '[\"*\"]', NULL, '2025-05-16 07:24:55', '2025-05-02 07:24:55', '2025-05-02 07:24:55'),
(343, 'App\\Models\\Admin', 2, 'API Token', 'b236a73ebf877ebb4a917893bdf2553e3aaf4e7c3b17ab99e7ddeb9c02e0058e', '[\"*\"]', NULL, '2025-05-16 07:32:50', '2025-05-02 07:32:50', '2025-05-02 07:32:50'),
(344, 'App\\Models\\Admin', 2, 'API Token', 'b46908c03c441cac5ca723df921cd75460555e95428927d7589468d3316acc1a', '[\"*\"]', NULL, '2025-05-16 07:36:35', '2025-05-02 07:36:35', '2025-05-02 07:36:35'),
(345, 'App\\Models\\Admin', 4, 'API Token', '8a7684734f032020623a6b9cfa39f30c1ecfadbf2d76a055b55ad85984255379', '[\"*\"]', '2025-05-08 07:18:54', '2025-05-16 07:38:31', '2025-05-02 07:38:31', '2025-05-08 07:18:54'),
(346, 'App\\Models\\Admin', 2, 'API Token', 'ee1ec5435fcba7963e9f934ba3e393a96c31f6e62986ac5b51cde7d31ba04bcb', '[\"*\"]', NULL, '2025-05-16 07:38:32', '2025-05-02 07:38:32', '2025-05-02 07:38:32'),
(347, 'App\\Models\\Admin', 2, 'API Token', '7b23c8740b3ef37609a97e53051f94e76794a45557aa05bf43b04a1d6ea60c70', '[\"*\"]', NULL, '2025-05-16 07:38:53', '2025-05-02 07:38:53', '2025-05-02 07:38:53'),
(348, 'App\\Models\\Admin', 2, 'API Token', 'b6db8302e9eba626c596f8a7ad795477e2d997e04484eb5f81977f7e299eb754', '[\"*\"]', NULL, '2025-05-16 07:41:15', '2025-05-02 07:41:15', '2025-05-02 07:41:15'),
(349, 'App\\Models\\Admin', 2, 'API Token', 'f5fe52967ab6a2835073733f24a5ec91b52fcdccf3801f1ba985126441368bc4', '[\"*\"]', NULL, '2025-05-16 07:41:59', '2025-05-02 07:41:59', '2025-05-02 07:41:59'),
(350, 'App\\Models\\Admin', 2, 'API Token', 'fcc8f3e74526cb427e7df5a092189e5197e870f7fc4825090f0c534fb1c18cf7', '[\"*\"]', NULL, '2025-05-16 07:47:06', '2025-05-02 07:47:06', '2025-05-02 07:47:06'),
(351, 'App\\Models\\Admin', 2, 'API Token', 'fe4a84776619b3c505af5276693a8eae724ca8d43ae0265c4f2c41061b3a4f66', '[\"*\"]', NULL, '2025-05-16 07:48:53', '2025-05-02 07:48:53', '2025-05-02 07:48:53'),
(352, 'App\\Models\\Admin', 2, 'API Token', '927ae019bb0c34eb5c86f5feb2c1f18826817a62b1439bb2069a014bcfcd4911', '[\"*\"]', '2025-05-02 08:23:22', '2025-05-16 07:52:18', '2025-05-02 07:52:18', '2025-05-02 08:23:22'),
(353, 'App\\Models\\Admin', 2, 'API Token', '5a115bc5dc303e7491627f78283ac789547a2b850221236c42c6f5586a15000b', '[\"*\"]', '2025-05-02 11:24:39', '2025-05-16 08:21:02', '2025-05-02 08:21:02', '2025-05-02 11:24:39'),
(354, 'App\\Models\\Admin', 2, 'API Token', '537e8e557f3399fb25e9e4ccc4629ba86ed509529d83b8a9a31753200e02970e', '[\"*\"]', NULL, '2025-05-16 10:19:34', '2025-05-02 10:19:34', '2025-05-02 10:19:34'),
(355, 'App\\Models\\Admin', 2, 'API Token', 'a69038b66dbe799606f23d5ae203bd81f1765117d70a9efe7e4106cec2594e46', '[\"*\"]', NULL, '2025-05-16 10:20:09', '2025-05-02 10:20:09', '2025-05-02 10:20:09'),
(356, 'App\\Models\\Admin', 2, 'API Token', 'fd9ea5e7159c7a8b42d7f6db4bdeb4b768955deecc092642bd2ffb22b7898fbf', '[\"*\"]', NULL, '2025-05-16 10:20:27', '2025-05-02 10:20:27', '2025-05-02 10:20:27'),
(357, 'App\\Models\\Admin', 2, 'API Token', '871e90bd3e223f7331242ebe63f330f4437df1141c7a50b40977a7a29ccac664', '[\"*\"]', NULL, '2025-05-16 10:25:54', '2025-05-02 10:25:54', '2025-05-02 10:25:54'),
(358, 'App\\Models\\Admin', 2, 'API Token', '56945b38efc871ac17ca7f4b55ec7669b0c9a837d34549a376b7f0254ca112a5', '[\"*\"]', NULL, '2025-05-16 10:27:40', '2025-05-02 10:27:40', '2025-05-02 10:27:40'),
(359, 'App\\Models\\Admin', 2, 'API Token', 'a1c1977d7f1a71edc922902dee4f3c53aabd047c1ba77da048512e9bd30d5566', '[\"*\"]', NULL, '2025-05-16 10:28:08', '2025-05-02 10:28:08', '2025-05-02 10:28:08'),
(360, 'App\\Models\\Admin', 2, 'API Token', '896ef9a4e79aa674932f58ab7a8f2e32f73d08b0124928e9d8e75f8f8dcdb0b1', '[\"*\"]', NULL, '2025-05-16 10:29:11', '2025-05-02 10:29:11', '2025-05-02 10:29:11'),
(361, 'App\\Models\\Admin', 2, 'API Token', '80244b3d01312093d871cfafb821cdb2dd2aff06afc33ee2a46bbacbed33e78b', '[\"*\"]', NULL, '2025-05-16 10:30:11', '2025-05-02 10:30:11', '2025-05-02 10:30:11'),
(362, 'App\\Models\\Admin', 2, 'API Token', '66026be274b3832673c03e68081262be3e18a0503681a68469f706ee96a00c92', '[\"*\"]', NULL, '2025-05-16 10:33:35', '2025-05-02 10:33:35', '2025-05-02 10:33:35'),
(363, 'App\\Models\\Admin', 2, 'API Token', '794f09e985ed6bcb9d952218f645758002585bd70ec236645840eb1773686c2e', '[\"*\"]', NULL, '2025-05-16 10:34:39', '2025-05-02 10:34:39', '2025-05-02 10:34:39'),
(364, 'App\\Models\\Admin', 2, 'API Token', '0cac52f0abdcf1b4313cf3b83a3787fb3c620064c4ac4ee51b788d89c8d268f1', '[\"*\"]', NULL, '2025-05-16 10:36:44', '2025-05-02 10:36:44', '2025-05-02 10:36:44'),
(366, 'App\\Models\\User', 56, 'API Token', 'acfd846d27697a0c7a8b05cf9e166a0309f5192c5391efa49b9a089273a8e664', '[\"*\"]', NULL, '2025-06-02 11:18:30', '2025-05-02 11:18:30', '2025-05-02 11:18:30'),
(367, 'App\\Models\\User', 57, 'API Token', '5a05bec051b31893892564897093507d65f20ee8d2cf2b34334c40967c01a96e', '[\"*\"]', NULL, '2025-06-02 11:19:05', '2025-05-02 11:19:05', '2025-05-02 11:19:05'),
(379, 'App\\Models\\Admin', 2, 'API Token', '9849f77c4437344ae96b2711291b727a5c6ca53a62a87bb730f9bde83a45e303', '[\"*\"]', '2025-05-02 11:54:25', '2025-05-16 11:53:50', '2025-05-02 11:53:50', '2025-05-02 11:54:25'),
(380, 'App\\Models\\Admin', 2, 'API Token', '56dca12b5fd5a53fa38257a42bd7347f44c4a41a8dc122d742585afd0b0dd6d1', '[\"*\"]', '2025-05-02 11:57:21', '2025-05-16 11:57:07', '2025-05-02 11:57:07', '2025-05-02 11:57:21'),
(381, 'App\\Models\\Admin', 2, 'API Token', '3f5b720738a677cfab12e86ce360d024a1b09268cdd358c19daff7d7e1f81107', '[\"*\"]', '2025-05-02 11:58:41', '2025-05-16 11:58:14', '2025-05-02 11:58:14', '2025-05-02 11:58:41'),
(382, 'App\\Models\\User', 55, 'API Token', 'b9552f8d566ca8186371a3c98e4ad0c8f87e904413a82fa4472836738ca88357', '[\"*\"]', '2025-05-02 16:08:01', '2025-06-02 13:56:46', '2025-05-02 13:56:46', '2025-05-02 16:08:01'),
(383, 'App\\Models\\User', 41, 'API Token', '6f8f706226c5197a0feb0801824f795981c992001f2e60443a31e54ea41da25a', '[\"*\"]', '2025-05-02 17:19:55', '2025-06-02 14:54:33', '2025-05-02 14:54:33', '2025-05-02 17:19:55'),
(384, 'App\\Models\\Admin', 2, 'API Token', '7a39920953f45ce99aea3cb6257fe140317128a7fb9edfe7343ff9741766c5f4', '[\"*\"]', '2025-05-02 16:09:33', '2025-05-16 16:09:07', '2025-05-02 16:09:07', '2025-05-02 16:09:33'),
(385, 'App\\Models\\User', 55, 'API Token', 'f546a6c0511bf791df40e079dcc041ee71f1964a7d98a228f332c62d41508ac0', '[\"*\"]', '2025-05-02 17:20:32', '2025-06-02 17:17:59', '2025-05-02 17:17:59', '2025-05-02 17:20:32'),
(386, 'App\\Models\\User', 55, 'API Token', '03c336aa24f157bb6dd1a70b35593e6fe716bb30eb843f23ce9e81b3e96ab18a', '[\"*\"]', '2025-05-03 09:34:32', '2025-06-03 09:30:08', '2025-05-03 09:30:08', '2025-05-03 09:34:32'),
(387, 'App\\Models\\User', 41, 'API Token', '724f0f97e9c922ec5258a92a2a8bc8bb133718ba774b1c02f7bae35de0c2987d', '[\"*\"]', '2025-05-05 07:06:10', '2025-06-03 09:36:59', '2025-05-03 09:36:59', '2025-05-05 07:06:10'),
(388, 'App\\Models\\User', 41, 'API Token', 'e81a041ec2371579e531e934fe271d5b0e4f38ff861fc27f0a27e0f8c1e0c5e7', '[\"*\"]', '2025-05-05 07:38:45', '2025-06-04 05:38:03', '2025-05-04 05:38:03', '2025-05-05 07:38:45'),
(389, 'App\\Models\\User', 46, 'API Token', '18658fee44240711d747ae23a4be2354422b9187f9793397ac0dc03b9cf7541b', '[\"*\"]', '2025-05-04 10:15:05', '2025-06-04 10:06:06', '2025-05-04 10:06:06', '2025-05-04 10:15:05'),
(390, 'App\\Models\\User', 41, 'API Token', 'cb9ee94f26b82471b1018251c7561672c052bda34bdf1a323415ea98e2e17a6a', '[\"*\"]', '2025-05-04 10:13:39', '2025-06-04 10:11:20', '2025-05-04 10:11:20', '2025-05-04 10:13:39'),
(391, 'App\\Models\\User', 41, 'API Token', '1af079dec2726d2f58113bf71ea585ad02e90254ae85655a6ceac94c0b64faae', '[\"*\"]', '2025-05-13 07:47:04', '2025-06-04 14:44:46', '2025-05-04 14:44:46', '2025-05-13 07:47:04'),
(392, 'App\\Models\\User', 41, 'API Token', 'c9f5b3987a6731dc4524e46158c33c76867dcfd2ae298b66946dd030087ac3c1', '[\"*\"]', '2025-05-05 08:38:53', '2025-06-05 07:39:29', '2025-05-05 07:39:29', '2025-05-05 08:38:53'),
(393, 'App\\Models\\User', 41, 'API Token', '943ddefde7e3a03a020626fae16b912ce13c4eebcaf1e0d46efbde11440a84b3', '[\"*\"]', '2025-05-05 08:36:25', '2025-06-05 08:19:42', '2025-05-05 08:19:42', '2025-05-05 08:36:25'),
(394, 'App\\Models\\User', 55, 'API Token', 'ff46cb37618d4fb5504da5cec4d11285854b3d5651fdcbe33af271cb4b97219d', '[\"*\"]', '2025-05-06 07:39:55', '2025-06-05 08:37:36', '2025-05-05 08:37:36', '2025-05-06 07:39:55'),
(395, 'App\\Models\\User', 41, 'API Token', '2d7694bdb6b3301eea4ae40195d6dcf0e2f8505aaabf85f6fda2a861d3886145', '[\"*\"]', NULL, '2025-06-05 08:38:43', '2025-05-05 08:38:43', '2025-05-05 08:38:43'),
(396, 'App\\Models\\User', 41, 'API Token', 'd2d3344674facf9328d837fd3e22935e7edb373bd7ed8c7d38713c9d306c1f54', '[\"*\"]', '2025-05-26 06:08:13', '2025-06-05 08:38:59', '2025-05-05 08:38:59', '2025-05-26 06:08:13'),
(397, 'App\\Models\\Admin', 2, 'API Token', '001fe929c931f02a4c4498317253651588c73955cde357d82ee1fbf438035d40', '[\"*\"]', '2025-05-05 12:27:40', '2025-05-19 12:27:39', '2025-05-05 12:27:39', '2025-05-05 12:27:40'),
(398, 'App\\Models\\Admin', 2, 'API Token', '62566c1e9f57694d05bbec594ab871498c3c6746fec7d1201ed658d06d2b3fb9', '[\"*\"]', '2025-05-05 12:27:49', '2025-05-19 12:27:40', '2025-05-05 12:27:40', '2025-05-05 12:27:49'),
(399, 'App\\Models\\Admin', 2, 'API Token', '5d252b614a37cc3ff4ec3fc76da072ca843e59c44173e55e6257c00abf70923f', '[\"*\"]', '2025-05-05 13:35:55', '2025-05-19 12:28:02', '2025-05-05 12:28:02', '2025-05-05 13:35:55'),
(400, 'App\\Models\\User', 41, 'API Token', '1a21f3fb8ac3af3019f9df6c1a5eac291db369eb0502279d49c1330c4f6ac0e2', '[\"*\"]', '2025-05-06 06:21:49', '2025-06-06 02:52:50', '2025-05-06 02:52:50', '2025-05-06 06:21:49'),
(401, 'App\\Models\\User', 55, 'API Token', 'cd6fcbe97728ba3ff52ea51b9755401b3573b09db57e61db3d41c356de02b4c3', '[\"*\"]', '2025-05-07 13:20:27', '2025-06-06 07:40:14', '2025-05-06 07:40:14', '2025-05-07 13:20:27'),
(402, 'App\\Models\\User', 55, 'API Token', 'fde8e4f2f6d0fd3978a0800262fd1021f70f3c1b6e7cb6ec75742c794338de6a', '[\"*\"]', '2025-05-07 14:39:38', '2025-06-07 13:20:36', '2025-05-07 13:20:36', '2025-05-07 14:39:38'),
(403, 'App\\Models\\User', 55, 'API Token', '3d8e49b6033c6673b513a6eb85029a12c51ecd6db8220f9923f6f0c285cb3dda', '[\"*\"]', '2025-05-07 15:49:00', '2025-06-07 14:40:02', '2025-05-07 14:40:02', '2025-05-07 15:49:00'),
(404, 'App\\Models\\User', 47, 'API Token', '879b397046633d33e4793170ed06c8248d37a5f7d066f6123f37c77062b4ef2e', '[\"*\"]', NULL, '2025-06-07 14:42:42', '2025-05-07 14:42:42', '2025-05-07 14:42:42'),
(405, 'App\\Models\\User', 55, 'API Token', '035f4e08d4754ad90311882227759eaa18338e4345d06f65be0f8cc25be9bab5', '[\"*\"]', NULL, '2025-06-07 14:44:31', '2025-05-07 14:44:31', '2025-05-07 14:44:31'),
(406, 'App\\Models\\User', 58, 'API Token', 'cbabf787c6c27a23c4bc46bb12897127fab72eceb0fc304f378bf70c5a67a8b4', '[\"*\"]', '2025-05-07 15:30:33', '2025-06-07 15:30:15', '2025-05-07 15:30:15', '2025-05-07 15:30:33'),
(407, 'App\\Models\\User', 59, 'API Token', '65da818f44011d3bb72b09e2ddc6794c87dbbdd6833df76d4af11f1da256b8bc', '[\"*\"]', '2025-05-07 15:31:29', '2025-06-07 15:31:26', '2025-05-07 15:31:26', '2025-05-07 15:31:29'),
(408, 'App\\Models\\User', 41, 'API Token', 'a73264ad38e955d0d9713b58457e883ae5935fbdb3b4db7e850322bbd3ddacab', '[\"*\"]', '2025-05-08 15:29:50', '2025-06-08 07:01:41', '2025-05-08 07:01:41', '2025-05-08 15:29:50'),
(409, 'App\\Models\\User', 55, 'API Token', 'bff32a41a3bca8c313b9b98d8da8f8108366189d53587cc343dfa16f07a9551d', '[\"*\"]', '2025-05-11 04:36:17', '2025-06-08 07:03:35', '2025-05-08 07:03:35', '2025-05-11 04:36:17'),
(410, 'App\\Models\\User', 55, 'API Token', 'f63dc86dfb922953dce9c795f461f6fe7ae6c8422bd6d72395eefc3dce9f3dc7', '[\"*\"]', '2025-05-08 07:06:23', '2025-06-08 07:05:18', '2025-05-08 07:05:18', '2025-05-08 07:06:23'),
(411, 'App\\Models\\User', 55, 'API Token', 'd057d4f73de4377c2a64759058353509ad9603b5e98a03ef41363d0bc2478c46', '[\"*\"]', '2025-05-09 17:59:42', '2025-06-08 07:18:33', '2025-05-08 07:18:33', '2025-05-09 17:59:42'),
(412, 'App\\Models\\Admin', 4, 'API Token', '2af97f5b2aecf35e319a7a38552998416906cce9824b11143c15e20419b922ec', '[\"*\"]', '2025-05-22 10:24:53', '2025-05-22 14:58:47', '2025-05-08 14:58:47', '2025-05-22 10:24:53'),
(413, 'App\\Models\\User', 41, 'API Token', 'c45784e65dad9e37928b8b4bed37dd9a169d24f0e80c74339e77143e4cd23952', '[\"*\"]', '2025-05-10 13:54:57', '2025-06-09 18:06:59', '2025-05-09 18:06:59', '2025-05-10 13:54:57'),
(414, 'App\\Models\\User', 41, 'API Token', 'f81a514688c87fae9b0adbdced97763702db9bc092bc1cda2331c823cbb72d96', '[\"*\"]', '2025-05-10 14:43:54', '2025-06-10 13:57:44', '2025-05-10 13:57:44', '2025-05-10 14:43:54'),
(415, 'App\\Models\\User', 55, 'API Token', '4fb51884b73d1852186ef026a798999b571132348d1a668af53ca8bbbc3f92df', '[\"*\"]', '2025-05-10 14:41:28', '2025-06-10 14:21:16', '2025-05-10 14:21:16', '2025-05-10 14:41:28'),
(416, 'App\\Models\\User', 55, 'API Token', '130153079bcfac3e41517adb64498ce5efad1c7f711c682f8d87c87ec5e71e62', '[\"*\"]', '2025-05-11 04:38:19', '2025-06-10 14:45:51', '2025-05-10 14:45:51', '2025-05-11 04:38:19'),
(417, 'App\\Models\\User', 55, 'API Token', 'fb25530a66bc57e93a5b08a206bc7062e8004246a758079fffc9b2b10dc357b4', '[\"*\"]', '2025-05-11 04:38:40', '2025-06-11 04:36:59', '2025-05-11 04:36:59', '2025-05-11 04:38:40'),
(418, 'App\\Models\\User', 55, 'API Token', '7540707a587205e9cfc455a1df4d6695fe9550967370d5565c5460b1de0c60e6', '[\"*\"]', '2025-05-12 06:12:12', '2025-06-11 04:42:01', '2025-05-11 04:42:01', '2025-05-12 06:12:12'),
(419, 'App\\Models\\User', 41, 'API Token', 'fe3c95da8be1b7831d59a0bc93186ca090ff5a4a29713f858a43fcc0b7e08547', '[\"*\"]', '2025-05-11 07:49:26', '2025-06-11 06:38:04', '2025-05-11 06:38:04', '2025-05-11 07:49:26'),
(420, 'App\\Models\\User', 49, 'API Token', '7a86df9c02067a6b8fdfb6e49b1e24376ee4e2093ffb44476b3cd9e9406c6f1c', '[\"*\"]', '2025-05-12 04:23:33', '2025-06-11 07:14:22', '2025-05-11 07:14:22', '2025-05-12 04:23:33'),
(421, 'App\\Models\\User', 55, 'API Token', 'a38fffb60d6c9b24b3c2287abe678d26cce37cea139855d8ae70638b84af53ed', '[\"*\"]', '2025-05-13 14:23:57', '2025-06-11 07:58:31', '2025-05-11 07:58:31', '2025-05-13 14:23:57'),
(422, 'App\\Models\\User', 49, 'API Token', '24d7db5249bd6a43653d8f67d623e2440e7fa038f21a2a7fcc1fc772d2a9cda2', '[\"*\"]', '2025-05-25 07:48:19', '2025-06-11 08:14:29', '2025-05-11 08:14:29', '2025-05-25 07:48:19'),
(423, 'App\\Models\\Admin', 2, 'API Token', '6b13e3fa6fc03d43474713dd886432cb3e6dfdf10f9fc81ceabaca0c7147c103', '[\"*\"]', '2025-05-11 14:08:26', '2025-05-25 14:08:24', '2025-05-11 14:08:24', '2025-05-11 14:08:26'),
(424, 'App\\Models\\Admin', 2, 'API Token', '8baab61de9a1b1b569039fd4f2db49ae4e4a644e32b225a1dc10743e9415ad12', '[\"*\"]', '2025-05-11 16:02:28', '2025-05-25 14:13:33', '2025-05-11 14:13:33', '2025-05-11 16:02:28'),
(425, 'App\\Models\\Admin', 4, 'API Token', 'a1b9a1e3c8268e834a5cb242d4b15ab9218745ec58247b6104ff697eccc5a1c9', '[\"*\"]', '2025-05-25 07:06:58', '2025-05-25 14:16:04', '2025-05-11 14:16:04', '2025-05-25 07:06:58'),
(426, 'App\\Models\\User', 41, 'API Token', '8febc7d11463cf3277f5fe4d973693aba6bf1307cb2fdad000f17d026a4e9c47', '[\"*\"]', '2025-05-11 16:04:07', '2025-06-11 16:04:06', '2025-05-11 16:04:06', '2025-05-11 16:04:07'),
(427, 'App\\Models\\Admin', 2, 'API Token', '7d7b8dff91451111e84c26f3885d175476961fd4c684d97d5fcb365b92c33e26', '[\"*\"]', '2025-05-11 16:05:41', '2025-05-25 16:05:33', '2025-05-11 16:05:33', '2025-05-11 16:05:41'),
(428, 'App\\Models\\Admin', 2, 'API Token', '204b61d0291bf8d7a466ce11acb40e6aca7fddc65a90348d6b859b8c34127c0d', '[\"*\"]', '2025-05-11 16:09:44', '2025-05-25 16:07:34', '2025-05-11 16:07:34', '2025-05-11 16:09:44'),
(429, 'App\\Models\\Admin', 2, 'API Token', '174bc9d7ec3a92dc40ff3833e2d43015f4b699d2bf2bd92ffc4f017d277726df', '[\"*\"]', '2025-05-11 16:24:01', '2025-05-25 16:21:36', '2025-05-11 16:21:36', '2025-05-11 16:24:01'),
(430, 'App\\Models\\User', 41, 'API Token', '5ea7456160941e1a4114121ed183f465a1b8dedf9c8fa9b4e5e167c9e91e0145', '[\"*\"]', '2025-05-11 16:49:10', '2025-06-11 16:32:35', '2025-05-11 16:32:35', '2025-05-11 16:49:10'),
(431, 'App\\Models\\Admin', 2, 'API Token', '0c1a45e3fef64f9de847a47d7d702902f136264cd66c62aef99f79ec21281422', '[\"*\"]', '2025-05-11 16:49:58', '2025-05-25 16:49:53', '2025-05-11 16:49:53', '2025-05-11 16:49:58'),
(432, 'App\\Models\\User', 41, 'API Token', '40e389c2fd013131aa267d7e795f86e6996542ccfda3b389700c50073670b3aa', '[\"*\"]', '2025-05-11 16:55:41', '2025-06-11 16:51:30', '2025-05-11 16:51:30', '2025-05-11 16:55:41'),
(433, 'App\\Models\\User', 41, 'API Token', '86031318c09291d82a5e4f6e2922e6ff91de0fc5d634ff84263f90e045f0e11e', '[\"*\"]', '2025-05-12 06:10:22', '2025-06-11 16:56:57', '2025-05-11 16:56:57', '2025-05-12 06:10:22'),
(434, 'App\\Models\\Admin', 2, 'API Token', '1dcc0f42d9aa571207bc1c4af9c68f757edb9592fba9a6385653010f0fa6e4bd', '[\"*\"]', '2025-05-12 06:14:43', '2025-05-26 06:12:17', '2025-05-12 06:12:17', '2025-05-12 06:14:43'),
(435, 'App\\Models\\User', 41, 'API Token', '5dca9ef05d1e5590c0d62f36ecd80d40782707947cb7f226f02ba217186e2ae7', '[\"*\"]', NULL, '2025-06-12 06:18:56', '2025-05-12 06:18:56', '2025-05-12 06:18:56'),
(436, 'App\\Models\\User', 60, 'API Token', '8081631a0d4a6e8e4c740903e0bc637e588a4b2983e51c1a26134def4bc4a72d', '[\"*\"]', '2025-05-12 07:05:12', '2025-06-12 06:43:23', '2025-05-12 06:43:23', '2025-05-12 07:05:12'),
(437, 'App\\Models\\User', 41, 'API Token', 'ef35bee1a38205e6458dba19eb80ae04b426815d44422d331a731cafb45d1a1b', '[\"*\"]', '2025-05-20 13:43:50', '2025-06-12 06:55:54', '2025-05-12 06:55:54', '2025-05-20 13:43:50'),
(438, 'App\\Models\\User', 55, 'API Token', '8d97c99090b88ad489dbd2bc12b1f6b249d5d7b70ebe82f750171ebc476db3af', '[\"*\"]', '2025-05-12 07:24:01', '2025-06-12 07:05:56', '2025-05-12 07:05:56', '2025-05-12 07:24:01'),
(439, 'App\\Models\\Admin', 2, 'API Token', '403ead5159750ee298bd34cf2501105c2509d345e6fd8b542075d6abd4d55744', '[\"*\"]', '2025-05-12 07:33:25', '2025-05-26 07:28:47', '2025-05-12 07:28:47', '2025-05-12 07:33:25'),
(440, 'App\\Models\\User', 55, 'API Token', 'e2e41ad3573ea74a9c20afb86da4d3e1cdad45b7e954dd5cbcb3d2afcedcbcb5', '[\"*\"]', '2025-05-12 13:45:30', '2025-06-12 13:45:29', '2025-05-12 13:45:29', '2025-05-12 13:45:30'),
(441, 'App\\Models\\User', 55, 'API Token', '13e5d80b930a74e5c4afb623e63e6de73502f541e8ed8d337197caff77a6f5ad', '[\"*\"]', '2025-05-12 13:54:11', '2025-06-12 13:45:38', '2025-05-12 13:45:38', '2025-05-12 13:54:11'),
(442, 'App\\Models\\User', 55, 'API Token', '9e5584d5d49e4698d11b4f7c7b1eabc5b16845726825b715ca85ebe687d1e69d', '[\"*\"]', '2025-05-21 04:26:52', '2025-06-13 14:24:02', '2025-05-13 14:24:02', '2025-05-21 04:26:52'),
(443, 'App\\Models\\User', 41, 'API Token', '572cd36543d23481473b01c824ab6b5e8c259113b56cc6a6ac01c36686640688', '[\"*\"]', NULL, '2025-06-13 15:05:45', '2025-05-13 15:05:45', '2025-05-13 15:05:45'),
(444, 'App\\Models\\User', 41, 'API Token', 'adc8eb8342e0c3f2815627c2b279f313641b2e1fb0f5f69a2b3ffe4e6a3a6fe5', '[\"*\"]', NULL, '2025-06-13 15:59:58', '2025-05-13 15:59:58', '2025-05-13 15:59:58'),
(445, 'App\\Models\\User', 41, 'API Token', 'd56d0db6b34eff6e6b0fc9e8880759674b228b7809afc1302843f01acd6442cf', '[\"*\"]', NULL, '2025-06-13 16:00:07', '2025-05-13 16:00:07', '2025-05-13 16:00:07'),
(446, 'App\\Models\\User', 41, 'API Token', 'aff1b72d7eecef639daed996997bf4f4d31c79fb96dc13a06887dd476d5e89a1', '[\"*\"]', NULL, '2025-06-13 16:00:18', '2025-05-13 16:00:18', '2025-05-13 16:00:18'),
(447, 'App\\Models\\User', 41, 'API Token', 'dbd04a39c850cd60e2802b29691833422433a47719e66e58307cd6c0289e190f', '[\"*\"]', NULL, '2025-06-13 16:00:30', '2025-05-13 16:00:30', '2025-05-13 16:00:30'),
(448, 'App\\Models\\User', 41, 'API Token', '2a0855b30bd3653c4e93aecdf418120d8f09b9a38f947d85596f4e78059bb2b3', '[\"*\"]', NULL, '2025-06-13 16:00:48', '2025-05-13 16:00:48', '2025-05-13 16:00:48'),
(449, 'App\\Models\\User', 41, 'API Token', 'e4cef14ccdfbe9ad76b4faa45746e9b28cc2c65bf19af0f1ffb7472559f89529', '[\"*\"]', NULL, '2025-06-13 16:02:03', '2025-05-13 16:02:03', '2025-05-13 16:02:03'),
(450, 'App\\Models\\User', 46, 'API Token', '506639edb86bfeaf4e89d5a2d9c97626597ec089f6b6ebece66c1f1950d8eaf2', '[\"*\"]', NULL, '2025-06-13 16:09:30', '2025-05-13 16:09:30', '2025-05-13 16:09:30'),
(451, 'App\\Models\\User', 46, 'API Token', '111dbd5ae9251cc1f694ff9f94ad64e7d472773c07209cdc14a24fcbb7607224', '[\"*\"]', NULL, '2025-06-13 16:11:00', '2025-05-13 16:11:00', '2025-05-13 16:11:00'),
(452, 'App\\Models\\User', 41, 'API Token', '0fac7774a79942f336f0c721a20633e55a24f2e1bcf0de1a6313dfb2654e2254', '[\"*\"]', '2025-05-20 04:15:23', '2025-06-14 08:11:02', '2025-05-14 08:11:02', '2025-05-20 04:15:23'),
(453, 'App\\Models\\Admin', 2, 'API Token', 'df84ba00d394daf27dc36a33fa7e8077692c4983cd5786001936226a8d38013c', '[\"*\"]', '2025-05-15 05:52:08', '2025-05-29 05:51:41', '2025-05-15 05:51:41', '2025-05-15 05:52:08'),
(454, 'App\\Models\\Admin', 2, 'API Token', '8aaaa512c2ca90a38c1b56e5c9466ac5df6565b455a0127f889c62341263027d', '[\"*\"]', '2025-05-15 07:29:14', '2025-05-29 05:55:06', '2025-05-15 05:55:06', '2025-05-15 07:29:14'),
(455, 'App\\Models\\User', 41, 'API Token', '10113bfc4ccb7412365b73a90832e91df4c29559ebbcf3b6a4f2c96864239d55', '[\"*\"]', '2025-05-31 09:47:16', '2025-06-16 05:09:31', '2025-05-16 05:09:31', '2025-05-31 09:47:16'),
(456, 'App\\Models\\Admin', 2, 'API Token', 'bcff86b3dc8d150fb0de7572510cbbdbf536eeeeab89aea5867795400380f38d', '[\"*\"]', '2025-05-17 08:26:09', '2025-05-31 08:26:07', '2025-05-17 08:26:07', '2025-05-17 08:26:09'),
(457, 'App\\Models\\Admin', 2, 'API Token', 'b4026a1f501987387b87b3d62074fab07862631cc7d53050108b4cd6525b15e0', '[\"*\"]', '2025-05-20 02:27:13', '2025-06-03 02:27:11', '2025-05-20 02:27:11', '2025-05-20 02:27:13'),
(458, 'App\\Models\\Admin', 2, 'API Token', '8770925bd33062bead172b2f4c3bd78b19885dbe83710659c5059e346c73209c', '[\"*\"]', '2025-05-20 02:33:06', '2025-06-03 02:27:59', '2025-05-20 02:27:59', '2025-05-20 02:33:06'),
(459, 'App\\Models\\Admin', 2, 'API Token', '4417631a28766b7a00d1274727dbbe5140552d9c1959099d104f815b4fb02411', '[\"*\"]', '2025-05-20 04:03:13', '2025-06-03 02:45:48', '2025-05-20 02:45:48', '2025-05-20 04:03:13'),
(460, 'App\\Models\\User', 46, 'API Token', '07b041c04f9835aa55aaaf1bd44d35f1f107f103267234cd49965b8029c08777', '[\"*\"]', '2025-05-20 04:05:50', '2025-06-20 04:05:46', '2025-05-20 04:05:46', '2025-05-20 04:05:50'),
(461, 'App\\Models\\User', 46, 'API Token', '4eefdc75f7df2c31f6bfeef4124b0ee8206acdaafc7c92ebeef5eb2ae9b1b280', '[\"*\"]', '2025-05-27 07:29:26', '2025-06-20 04:06:35', '2025-05-20 04:06:35', '2025-05-27 07:29:26'),
(462, 'App\\Models\\User', 55, 'API Token', 'da5c87ac1217d5510472121af4bbe93e4c946c0df5834d0816ee6147b7ea5452', '[\"*\"]', '2025-05-20 04:13:39', '2025-06-20 04:07:10', '2025-05-20 04:07:10', '2025-05-20 04:13:39'),
(463, 'App\\Models\\User', 55, 'API Token', '4ef55be6505612fa63cc12a98c336aba9078a295ea669c3288ab5f24f259d499', '[\"*\"]', '2025-05-20 04:53:42', '2025-06-20 04:13:49', '2025-05-20 04:13:49', '2025-05-20 04:53:42'),
(465, 'App\\Models\\Admin', 6, 'API Token', '0f4e754aed15fb74ddd6e738ae3a9a15fd6ed99a6832583ca127f4fd66097bb0', '[\"*\"]', '2025-05-20 04:15:01', '2025-06-03 04:14:25', '2025-05-20 04:14:25', '2025-05-20 04:15:01'),
(466, 'App\\Models\\User', 41, 'API Token', '5a548ac5407cdf75b319cfc8c69ba2c78e2230caf50805bcd5bb3172feffcfbb', '[\"*\"]', '2025-05-25 07:27:18', '2025-06-20 04:15:32', '2025-05-20 04:15:32', '2025-05-25 07:27:18'),
(467, 'App\\Models\\User', 61, 'API Token', 'acf54cc39df90949cf3cba6175814fafffcef4e172fe847c8a647b19ff1577a3', '[\"*\"]', '2025-05-20 04:43:15', '2025-06-20 04:16:41', '2025-05-20 04:16:41', '2025-05-20 04:43:15'),
(468, 'App\\Models\\User', 46, 'API Token', 'cd0534ab59d25c1494c074e4a0f9881f9157dfa839683f0d31a29f57acd0a197', '[\"*\"]', NULL, '2025-06-20 04:22:27', '2025-05-20 04:22:27', '2025-05-20 04:22:27'),
(469, 'App\\Models\\User', 62, 'API Token', '698e78c1c0ce407a1e5d348fd05e3b814720aafe04a102286076591a430d9e6e', '[\"*\"]', NULL, '2025-06-20 04:29:23', '2025-05-20 04:29:23', '2025-05-20 04:29:23'),
(470, 'App\\Models\\User', 63, 'API Token', 'e59e997bc1c831b046e92d78deefc836569cae4812bb26292f754aab77116c58', '[\"*\"]', NULL, '2025-06-20 04:30:42', '2025-05-20 04:30:42', '2025-05-20 04:30:42'),
(471, 'App\\Models\\User', 64, 'API Token', 'e48761d1cd50b7fcaf5538bfb140f3460821f2bedff17545c5b702739db9e3ea', '[\"*\"]', NULL, '2025-06-20 04:44:07', '2025-05-20 04:44:07', '2025-05-20 04:44:07'),
(472, 'App\\Models\\User', 65, 'API Token', '2afe232430bafdb229f602e7065b3b0521024b929136b6cf6737febf707859fa', '[\"*\"]', NULL, '2025-06-20 04:48:13', '2025-05-20 04:48:13', '2025-05-20 04:48:13'),
(473, 'App\\Models\\User', 66, 'API Token', '382085d77813b1d893616c714690f9fe5068366c0db9f62862422586c78d537b', '[\"*\"]', NULL, '2025-06-20 04:48:44', '2025-05-20 04:48:44', '2025-05-20 04:48:44'),
(474, 'App\\Models\\User', 55, 'API Token', '7a6a9c63f41f4da52e64f59285cbe8824a0266cbcfabefb6363e64e50391f5be', '[\"*\"]', '2025-05-20 04:56:43', '2025-06-20 04:56:42', '2025-05-20 04:56:42', '2025-05-20 04:56:43'),
(475, 'App\\Models\\User', 55, 'API Token', 'b9e3768bce5b556fdc56d237d7095528653721f780ba6c1949e7d8b6c664b20d', '[\"*\"]', '2025-05-20 14:06:48', '2025-06-20 04:56:48', '2025-05-20 04:56:48', '2025-05-20 14:06:48'),
(476, 'App\\Models\\User', 58, 'API Token', 'a17baaafee019cdf0b9e40722abbeb26d0e535d4cb11a36dff1ab0d45e06d819', '[\"*\"]', '2025-05-20 05:22:25', '2025-06-20 05:22:22', '2025-05-20 05:22:22', '2025-05-20 05:22:25'),
(477, 'App\\Models\\User', 41, 'API Token', '38f8e9d4082c2cd97c3f18066abe2648657a5b3bb815a7687974e327963ee2c9', '[\"*\"]', '2025-05-20 15:34:58', '2025-06-20 13:43:59', '2025-05-20 13:43:59', '2025-05-20 15:34:58'),
(478, 'App\\Models\\Admin', 2, 'API Token', 'c7737a6162f18620dec5d63cca979b79fb93a9cfcf0a1f91576021ac684800a5', '[\"*\"]', '2025-05-20 17:09:26', '2025-06-03 14:06:56', '2025-05-20 14:06:56', '2025-05-20 17:09:26'),
(479, 'App\\Models\\Admin', 2, 'API Token', 'd3d011adbf3b8cd8020c8dd79fb629913db66e7a80b7f9487fb450882f5f355e', '[\"*\"]', '2025-05-21 03:36:43', '2025-06-04 03:10:25', '2025-05-21 03:10:25', '2025-05-21 03:36:43'),
(480, 'App\\Models\\Admin', 6, 'API Token', 'acad76b102fcb602508f69bb5979df90f4e9633847dda560d213b25d6acec4a7', '[\"*\"]', '2025-05-21 03:11:17', '2025-06-04 03:11:00', '2025-05-21 03:11:00', '2025-05-21 03:11:17'),
(481, 'App\\Models\\Admin', 2, 'API Token', 'd25f0d3f485711cb4e40cd43693be32f46ad52c5390a7109f2f1d49207197b82', '[\"*\"]', '2025-05-21 03:40:10', '2025-06-04 03:29:38', '2025-05-21 03:29:38', '2025-05-21 03:40:10'),
(482, 'App\\Models\\Admin', 2, 'API Token', '5d01a0e06d9cf9cf257b74cd0649815fa7607b32a60a1c2ef90c693e0e100b2b', '[\"*\"]', '2025-05-21 03:59:39', '2025-06-04 03:40:22', '2025-05-21 03:40:22', '2025-05-21 03:59:39'),
(483, 'App\\Models\\Admin', 2, 'API Token', '50a8dd946177ae1057ca9e40a54343d3ac75db57d76c51b17f251118ee97cb4f', '[\"*\"]', '2025-05-21 04:12:10', '2025-06-04 04:00:36', '2025-05-21 04:00:36', '2025-05-21 04:12:10'),
(484, 'App\\Models\\Admin', 2, 'API Token', '23b6ee6e0b6c7a40ef28fb26c2f399153e93fa9a83eb6126d294e3e7e541271d', '[\"*\"]', '2025-05-21 04:17:44', '2025-06-04 04:13:35', '2025-05-21 04:13:35', '2025-05-21 04:17:44'),
(485, 'App\\Models\\Admin', 2, 'API Token', 'e5f2303bb6c5e06613ba31ab9d5a6bfa283c0f0059546e93c886d25b2e16c960', '[\"*\"]', '2025-05-21 04:31:32', '2025-06-04 04:29:15', '2025-05-21 04:29:15', '2025-05-21 04:31:32'),
(486, 'App\\Models\\Admin', 2, 'API Token', 'f50147450cbba51786a0cb74d369956c09a6515bef562d8ef0f110468893b53a', '[\"*\"]', '2025-05-21 06:39:42', '2025-06-04 06:23:39', '2025-05-21 06:23:39', '2025-05-21 06:39:42'),
(487, 'App\\Models\\Admin', 2, 'API Token', '2c6c8b9b61325ee9f71042a3b047fdc2e760319b73845d24f712117ef2412874', '[\"*\"]', '2025-05-21 06:39:14', '2025-06-04 06:35:55', '2025-05-21 06:35:55', '2025-05-21 06:39:14'),
(488, 'App\\Models\\Admin', 2, 'API Token', '857a21ff6d7d1b7526001902ad02ebc90f4ed21897c77f8422811c1d255ec1c2', '[\"*\"]', '2025-05-21 06:43:19', '2025-06-04 06:42:47', '2025-05-21 06:42:47', '2025-05-21 06:43:19'),
(489, 'App\\Models\\Admin', 2, 'API Token', 'e1977d7752aad28afdd174b36bc3c7c0f92d6e99b9a5e86a7ac798a254a8043f', '[\"*\"]', '2025-05-21 07:03:22', '2025-06-04 06:45:07', '2025-05-21 06:45:07', '2025-05-21 07:03:22'),
(490, 'App\\Models\\Admin', 2, 'API Token', 'cb0bb7ef80bf4dfa7831dd8d1fe35cde54185d242ff4d2286daf8c7f724bdb4e', '[\"*\"]', '2025-05-21 07:06:03', '2025-06-04 07:04:10', '2025-05-21 07:04:10', '2025-05-21 07:06:03'),
(491, 'App\\Models\\Admin', 2, 'API Token', '05fd31da73f5c6446e759571b0c59c0c92780d473783913ee2f0f482af639aa5', '[\"*\"]', '2025-05-21 07:52:17', '2025-06-04 07:07:54', '2025-05-21 07:07:54', '2025-05-21 07:52:17'),
(492, 'App\\Models\\Admin', 2, 'API Token', '3815260198fde8a8a5cd8ba7f60b836b6d5d185a2fa8c351013a44303d209e13', '[\"*\"]', '2025-05-21 08:01:26', '2025-06-04 07:09:44', '2025-05-21 07:09:44', '2025-05-21 08:01:26'),
(493, 'App\\Models\\Admin', 2, 'API Token', '2791437d5dcd63451c86cc9fed90d2ea0d9859ca318f6f56ab715dfd63e325ce', '[\"*\"]', '2025-05-21 07:14:21', '2025-06-04 07:12:50', '2025-05-21 07:12:50', '2025-05-21 07:14:21'),
(494, 'App\\Models\\Admin', 2, 'API Token', '7abb439a632afc5b1aa1a454b5771eaf6e53498d81d04b8542b65b5d55129ef1', '[\"*\"]', '2025-05-21 07:20:59', '2025-06-04 07:20:55', '2025-05-21 07:20:55', '2025-05-21 07:20:59'),
(495, 'App\\Models\\Admin', 2, 'API Token', '07b9114a6f45cd8c4b8fc01eba1cda1ee792ea86028ec0758388d6b2990c5cc9', '[\"*\"]', NULL, '2025-06-04 08:05:01', '2025-05-21 08:05:01', '2025-05-21 08:05:01'),
(496, 'App\\Models\\Admin', 2, 'API Token', '534ac6a0900dae29d9679d2a41ddfc194ae6f94c22786f7ba44eebbef3d58317', '[\"*\"]', '2025-05-21 08:20:25', '2025-06-04 08:19:14', '2025-05-21 08:19:14', '2025-05-21 08:20:25'),
(497, 'App\\Models\\Admin', 2, 'API Token', '4f0f86f932c79dc57099adc4cd69079a858eb808d22ae2c1cd4a352a621a873f', '[\"*\"]', '2025-05-21 08:50:31', '2025-06-04 08:23:08', '2025-05-21 08:23:08', '2025-05-21 08:50:31'),
(498, 'App\\Models\\Admin', 2, 'API Token', '414ee1eb37bcf3def75715a1c2364fa478e81a3ae0e2ee1486d3d72bd4841c89', '[\"*\"]', '2025-05-21 08:43:38', '2025-06-04 08:36:40', '2025-05-21 08:36:40', '2025-05-21 08:43:38'),
(499, 'App\\Models\\Admin', 2, 'API Token', '5cd1220c921eafd9a801a1a92c6e50d09c00daece5503a6540cba75a39972820', '[\"*\"]', '2025-05-21 09:31:11', '2025-06-04 09:01:54', '2025-05-21 09:01:54', '2025-05-21 09:31:11'),
(500, 'App\\Models\\Admin', 2, 'API Token', '972dda6355efdd3f6f0c48e81d6a38247fefc9c52ef80a12f73bbaf6cceb0422', '[\"*\"]', '2025-05-21 15:31:12', '2025-06-04 13:43:20', '2025-05-21 13:43:20', '2025-05-21 15:31:12'),
(501, 'App\\Models\\User', 46, 'API Token', 'c6a98fdcec5cb5b4ac4e80182e39d06f7ac3d28cb1010610de703a8fe63c747d', '[\"*\"]', '2025-05-21 14:42:15', '2025-06-21 14:42:04', '2025-05-21 14:42:04', '2025-05-21 14:42:15'),
(502, 'App\\Models\\Admin', 2, 'API Token', '81802ab611f02aa2ef5383c66b45acdc84eec8e14810ae46af432e9ca4d33cf4', '[\"*\"]', '2025-05-22 06:58:17', '2025-06-04 15:50:17', '2025-05-21 15:50:17', '2025-05-22 06:58:17'),
(503, 'App\\Models\\Admin', 6, 'API Token', '1d75b5fc7bd21b675a759cf3e77c7344ce75cfb99ca3cf124fcf604e414fb10d', '[\"*\"]', '2025-05-22 07:47:35', '2025-06-05 06:54:48', '2025-05-22 06:54:48', '2025-05-22 07:47:35'),
(504, 'App\\Models\\User', 55, 'API Token', 'f3e000f1d160a3db2ce7e5ea8b92b6c54de682b27e5450af7863e66d4a4c7926', '[\"*\"]', '2025-05-22 15:39:16', '2025-06-22 08:01:21', '2025-05-22 08:01:21', '2025-05-22 15:39:16'),
(505, 'App\\Models\\Admin', 2, 'API Token', 'c51e51b6134d54e7bc71a541338b58abd52568f7a04b3fb1e5b3a0ad17d6582c', '[\"*\"]', '2025-05-22 08:03:11', '2025-06-05 08:03:08', '2025-05-22 08:03:08', '2025-05-22 08:03:11'),
(506, 'App\\Models\\Admin', 2, 'API Token', 'c5b17256ebbedbeac0e1f69c4eb0fc58da1d35864ca130c3aeee5e523d38814c', '[\"*\"]', '2025-05-22 08:03:29', '2025-06-05 08:03:13', '2025-05-22 08:03:13', '2025-05-22 08:03:29'),
(507, 'App\\Models\\User', 50, 'API Token', '0a4e1784163b88c1bf2b87afc8716a794224e24a966782dbf11c62d159a181ad', '[\"*\"]', '2025-05-28 08:54:00', '2025-06-22 08:05:36', '2025-05-22 08:05:36', '2025-05-28 08:54:00'),
(508, 'App\\Models\\User', 55, 'API Token', '1647d2557245d0a9a040dd2b279863bde6cd534bfb49a903bd3d78d4ede0e671', '[\"*\"]', '2025-05-22 08:13:01', '2025-06-22 08:13:00', '2025-05-22 08:13:00', '2025-05-22 08:13:01'),
(509, 'App\\Models\\User', 41, 'API Token', '655714a0e6980912b3ceb6b7523c308ea5f31190c2346b3aceb14668cfc4085d', '[\"*\"]', '2025-05-22 08:16:09', '2025-06-22 08:13:28', '2025-05-22 08:13:28', '2025-05-22 08:16:09'),
(510, 'App\\Models\\Admin', 2, 'API Token', '8737ad3127231f864b3cc0ae9f4dd99825f596a6fc7cb154867cb7f57fb9d126', '[\"*\"]', '2025-05-22 09:58:54', '2025-06-05 09:45:00', '2025-05-22 09:45:00', '2025-05-22 09:58:54'),
(511, 'App\\Models\\Admin', 2, 'API Token', '9d4bd975c02db9f56a7a295b8d8a02a701f33650217fdb8babdf59b38887f611', '[\"*\"]', '2025-05-22 09:45:59', '2025-06-05 09:45:44', '2025-05-22 09:45:44', '2025-05-22 09:45:59'),
(512, 'App\\Models\\Admin', 2, 'API Token', '8b82ccba93227ef07a0ef405ce6fd1afd6244482bba84cd5f294429801dc9afc', '[\"*\"]', '2025-05-22 10:33:06', '2025-06-05 10:00:08', '2025-05-22 10:00:08', '2025-05-22 10:33:06'),
(513, 'App\\Models\\Admin', 2, 'API Token', 'a7295c6cda8439b1b329f085f59d4c8ed6eaab8fbd731f5098658f70be762ed2', '[\"*\"]', '2025-05-22 10:04:18', '2025-06-05 10:00:28', '2025-05-22 10:00:28', '2025-05-22 10:04:18'),
(514, 'App\\Models\\Admin', 2, 'API Token', '46dba9002bde722742dffec0ab499b23278494a76f6fad5613c81a2aed0fec2a', '[\"*\"]', '2025-05-22 10:02:13', '2025-06-05 10:01:05', '2025-05-22 10:01:05', '2025-05-22 10:02:13'),
(515, 'App\\Models\\Admin', 2, 'API Token', '78f1f65c021900ae025d27698c240e4a73892d4ed5f2e9e3234b907600d195d7', '[\"*\"]', '2025-05-22 10:24:20', '2025-06-05 10:05:15', '2025-05-22 10:05:15', '2025-05-22 10:24:20'),
(516, 'App\\Models\\Admin', 2, 'API Token', '1109b5ad4a55fc8659ee644206195444b5e7d1ad26badc699217656e7f740f3b', '[\"*\"]', '2025-05-22 10:41:45', '2025-06-05 10:33:16', '2025-05-22 10:33:16', '2025-05-22 10:41:45'),
(517, 'App\\Models\\Admin', 2, 'API Token', '076de8447584cb551a97c5c12e1478e0976220319b10de06a550e780a2f20b34', '[\"*\"]', '2025-05-22 10:49:00', '2025-06-05 10:42:23', '2025-05-22 10:42:23', '2025-05-22 10:49:00'),
(518, 'App\\Models\\User', 55, 'API Token', '2eacde865e66993e975c2bc4c94dce7f29c8dac0f5f288a7455411bbc6308503', '[\"*\"]', '2025-05-23 15:56:45', '2025-06-23 04:38:43', '2025-05-23 04:38:43', '2025-05-23 15:56:45'),
(519, 'App\\Models\\Admin', 2, 'API Token', 'ffa583ad4f4ade98978df8c81c04f1c0b3182aea4e052507f7ebcb51d294a044', '[\"*\"]', '2025-05-23 05:02:33', '2025-06-06 05:02:11', '2025-05-23 05:02:11', '2025-05-23 05:02:33'),
(520, 'App\\Models\\User', 41, 'API Token', 'b12e65e0c59d0aa4809a5673372d6a0ef5a0b6df685c27e70549d0bea026dc37', '[\"*\"]', '2025-05-23 15:23:50', '2025-06-23 15:22:26', '2025-05-23 15:22:26', '2025-05-23 15:23:50'),
(521, 'App\\Models\\User', 41, 'API Token', '20377db2595e2df96321358392b5546f8b8c56f712a979fb2c240f141c99d1df', '[\"*\"]', '2025-05-23 15:23:58', '2025-06-23 15:23:57', '2025-05-23 15:23:57', '2025-05-23 15:23:58'),
(522, 'App\\Models\\User', 41, 'API Token', 'af089697b685479c4e9581c8d7b3c142381527fdb4b5dded29498846a8c50487', '[\"*\"]', '2025-05-23 15:25:39', '2025-06-23 15:25:37', '2025-05-23 15:25:37', '2025-05-23 15:25:39'),
(523, 'App\\Models\\User', 41, 'API Token', 'cd6cb2c17078e9408947c663a3125a09f7bea7573215217d5d4096d79947c9d5', '[\"*\"]', '2025-05-23 15:25:59', '2025-06-23 15:25:58', '2025-05-23 15:25:58', '2025-05-23 15:25:59'),
(524, 'App\\Models\\User', 41, 'API Token', 'f58a86d431f9b60ac9f5a1dfb3f2650e4312aec32f4eaeb045f6240eb1b2b439', '[\"*\"]', '2025-05-23 15:26:38', '2025-06-23 15:26:36', '2025-05-23 15:26:37', '2025-05-23 15:26:38'),
(525, 'App\\Models\\User', 41, 'API Token', 'fde12ec7c4bcba5850198e740e5efad8097306b37b98d2bde8ace8af057cca70', '[\"*\"]', '2025-05-23 15:28:14', '2025-06-23 15:26:51', '2025-05-23 15:26:51', '2025-05-23 15:28:14'),
(526, 'App\\Models\\User', 41, 'API Token', '0a6bd6b5513ce12a1dc3c51cd3e91425b515e27db5c24cd423d6069b189b31a0', '[\"*\"]', '2025-05-23 15:29:16', '2025-06-23 15:29:01', '2025-05-23 15:29:01', '2025-05-23 15:29:16'),
(527, 'App\\Models\\User', 41, 'API Token', '40df75defc46198831f30b6acdaa5f7cc1f2210ed7188bf9ec5f56d9001ca5c7', '[\"*\"]', '2025-05-23 15:31:37', '2025-06-23 15:31:36', '2025-05-23 15:31:36', '2025-05-23 15:31:37'),
(528, 'App\\Models\\User', 41, 'API Token', '3868d80c24c39eaf74960f708bc78a21f5db9da444f60aecec30b66b61ba51f0', '[\"*\"]', '2025-05-23 15:32:29', '2025-06-23 15:31:47', '2025-05-23 15:31:47', '2025-05-23 15:32:29'),
(529, 'App\\Models\\User', 41, 'API Token', '8548788c6fa3495d026c7b0b94d1bddcf44fd26539e0e89ab6702bf7e1a03531', '[\"*\"]', '2025-05-23 15:32:37', '2025-06-23 15:32:36', '2025-05-23 15:32:36', '2025-05-23 15:32:37'),
(530, 'App\\Models\\User', 41, 'API Token', 'bbb831ad9c1eb122552c0993c577c864277d9d35b1e22e0681d4d5958dbe5352', '[\"*\"]', '2025-05-23 15:33:22', '2025-06-23 15:32:49', '2025-05-23 15:32:49', '2025-05-23 15:33:22'),
(531, 'App\\Models\\User', 41, 'API Token', '13f500cc81c1aa110ec9a4d830a815d99776f33537c30daf3fdecf102b5218d4', '[\"*\"]', '2025-05-23 15:34:45', '2025-06-23 15:33:32', '2025-05-23 15:33:32', '2025-05-23 15:34:45');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(532, 'App\\Models\\User', 41, 'API Token', '889cd61ced377c0272e8a182a287196e7b5f9c7c9775e0380512801bdc9396f4', '[\"*\"]', '2025-05-23 15:37:35', '2025-06-23 15:36:10', '2025-05-23 15:36:10', '2025-05-23 15:37:35'),
(533, 'App\\Models\\User', 41, 'API Token', 'fad554426076c890a87da268c916e503e3e8f5f5e4072d2b0fd0f0ad2d94aa67', '[\"*\"]', '2025-05-23 15:37:42', '2025-06-23 15:37:40', '2025-05-23 15:37:40', '2025-05-23 15:37:42'),
(534, 'App\\Models\\User', 41, 'API Token', 'd8fc39bd672660e8ad64bcf9aae2e6d4bc795c04589a118dd30ffdd9178f5f6f', '[\"*\"]', '2025-05-23 15:38:55', '2025-06-23 15:37:53', '2025-05-23 15:37:53', '2025-05-23 15:38:55'),
(535, 'App\\Models\\Admin', 6, 'API Token', '57abeedec794d7b6d9ac21fa9eccc648e8969218edc0e5b1b5454825438db7e1', '[\"*\"]', '2025-05-24 07:56:22', '2025-06-06 15:38:45', '2025-05-23 15:38:45', '2025-05-24 07:56:22'),
(536, 'App\\Models\\User', 41, 'API Token', '149e78231aedf066e010e640eaef8654868582bbb4b114032fb91d16fc38f583', '[\"*\"]', '2025-05-23 15:41:23', '2025-06-23 15:39:12', '2025-05-23 15:39:12', '2025-05-23 15:41:23'),
(537, 'App\\Models\\User', 41, 'API Token', 'c42318f748ed08628363135bdde1d3f3e2fc0bd557d7273fba777b4de139f984', '[\"*\"]', '2025-05-23 15:44:35', '2025-06-23 15:41:41', '2025-05-23 15:41:41', '2025-05-23 15:44:35'),
(538, 'App\\Models\\User', 55, 'API Token', 'b93bf9f1467ea7435517455d9e4d71980e3827266b1136e0daf703cfed7cf3a7', '[\"*\"]', '2025-05-23 15:49:54', '2025-06-23 15:49:37', '2025-05-23 15:49:37', '2025-05-23 15:49:54'),
(539, 'App\\Models\\User', 55, 'API Token', 'c73810c309293f39b602c2c1612e426572c2e60ef1a51fafb007be2ba86f5602', '[\"*\"]', '2025-05-24 09:08:53', '2025-06-23 15:58:16', '2025-05-23 15:58:16', '2025-05-24 09:08:53'),
(540, 'App\\Models\\Admin', 2, 'API Token', 'dc385f9ff77562a5a5b0b5602b39612b9a4365278ac4e8da60411e161e26d057', '[\"*\"]', '2025-05-23 16:09:20', '2025-06-06 16:09:14', '2025-05-23 16:09:14', '2025-05-23 16:09:20'),
(541, 'App\\Models\\User', 41, 'API Token', '0ad43dbc3374df61a4128eff6de1aa2bc92e995b4a453fcc3dd414886958f3cd', '[\"*\"]', '2025-05-24 06:33:19', '2025-06-24 06:19:05', '2025-05-24 06:19:05', '2025-05-24 06:33:19'),
(542, 'App\\Models\\User', 55, 'API Token', 'b14344a13dae4e5fecb943e48ef24f2b1e5dc9c165de5da9ecbb575224cc2937', '[\"*\"]', '2025-05-24 07:53:15', '2025-06-24 06:30:17', '2025-05-24 06:30:17', '2025-05-24 07:53:15'),
(543, 'App\\Models\\Admin', 2, 'API Token', '1e10e55ab8a156928d00664f8644a17cc3885c9584001b6fbd191e5fcefd3412', '[\"*\"]', '2025-05-24 06:42:21', '2025-06-07 06:35:46', '2025-05-24 06:35:46', '2025-05-24 06:42:21'),
(544, 'App\\Models\\Admin', 2, 'API Token', '567d115f69d91a0654def4a9245c79220e32b4391ecbc87473a4d529d5451ee9', '[\"*\"]', '2025-05-24 07:52:53', '2025-06-07 07:04:02', '2025-05-24 07:04:02', '2025-05-24 07:52:53'),
(545, 'App\\Models\\User', 55, 'API Token', '26c43f7d6e6b619e7bc4cde8be0e5a54d74b34559778ab33773b7d6471def7e3', '[\"*\"]', '2025-05-26 03:19:59', '2025-06-24 09:51:31', '2025-05-24 09:51:31', '2025-05-26 03:19:59'),
(546, 'App\\Models\\Admin', 2, 'API Token', 'aab18cc0d6bdb62c0ed267d79e04f96b5da1353c7ea600fc436ba8e0df8d6709', '[\"*\"]', '2025-05-25 08:07:29', '2025-06-08 07:06:53', '2025-05-25 07:06:53', '2025-05-25 08:07:29'),
(547, 'App\\Models\\Admin', 6, 'API Token', '92b1ba70b47b98dc722dfafd388bf7d64d5a471b22fcd1bf13203ac0babf91b5', '[\"*\"]', '2025-05-25 07:13:19', '2025-06-08 07:12:58', '2025-05-25 07:12:58', '2025-05-25 07:13:19'),
(548, 'App\\Models\\User', 41, 'API Token', 'f8559c27eb3879ad8dcb769800cf170e4b4c30c2eee4ff4b7474b643e95db472', '[\"*\"]', '2025-05-25 09:15:12', '2025-06-25 07:38:23', '2025-05-25 07:38:23', '2025-05-25 09:15:12'),
(549, 'App\\Models\\User', 67, 'API Token', 'd718589219ca9aa3ac858ee6141159c2b6359543ec9b23ca023464584c685760', '[\"*\"]', '2025-05-25 07:49:49', '2025-06-25 07:49:04', '2025-05-25 07:49:04', '2025-05-25 07:49:49'),
(550, 'App\\Models\\User', 67, 'API Token', 'fe330d22fec6e5be9b7c74c08155895a2746535963f1abdeba28da2019639940', '[\"*\"]', NULL, '2025-06-25 07:52:39', '2025-05-25 07:52:39', '2025-05-25 07:52:39'),
(551, 'App\\Models\\User', 67, 'API Token', '3da8b68afd71ebcedd6d00d7a1b9b04c61612d4ca7d617a796400ff7b134afa5', '[\"*\"]', NULL, '2025-06-25 07:52:55', '2025-05-25 07:52:55', '2025-05-25 07:52:55'),
(552, 'App\\Models\\User', 68, 'API Token', '6ad8cb223390c732d1b7abdb52f8b9563bca0e9056f448af47c8ce98a5cb6267', '[\"*\"]', '2025-05-25 12:57:35', '2025-06-25 07:55:12', '2025-05-25 07:55:12', '2025-05-25 12:57:35'),
(553, 'App\\Models\\User', 55, 'API Token', '7148d7be253dcbeca2b8020a3662e8c0c2f50cf05e3603c7902b7e61dc96abd4', '[\"*\"]', '2025-05-26 03:05:12', '2025-06-25 08:08:15', '2025-05-25 08:08:15', '2025-05-26 03:05:12'),
(554, 'App\\Models\\Admin', 2, 'API Token', '5e26450dec52a424e4c00f6db1fc16d0bbdee4a2458695c5c4f0a5d439f04999', '[\"*\"]', '2025-05-25 09:16:00', '2025-06-08 09:14:37', '2025-05-25 09:14:37', '2025-05-25 09:16:00'),
(555, 'App\\Models\\User', 41, 'API Token', '57148da41e9aac5afd8336e4cda30cae7a78483d33ee73a7784b02c14754a90c', '[\"*\"]', '2025-05-26 03:29:38', '2025-06-25 09:15:26', '2025-05-25 09:15:26', '2025-05-26 03:29:38'),
(556, 'App\\Models\\Admin', 2, 'API Token', '7f0e3170a7520d409188830b319308ca6579abf74cb866bb560287ef2137679b', '[\"*\"]', '2025-05-25 09:50:01', '2025-06-08 09:41:20', '2025-05-25 09:41:20', '2025-05-25 09:50:01'),
(557, 'App\\Models\\User', 41, 'API Token', '6f5674b3abf1ebcac448826b94848e1a94481252080dde696e6c2d333f6b5581', '[\"*\"]', '2025-05-25 15:22:16', '2025-06-25 15:22:14', '2025-05-25 15:22:14', '2025-05-25 15:22:16'),
(558, 'App\\Models\\User', 41, 'API Token', '3d5746e152b45c4e54faec1674ee4c40c2e8d7813b64c0be20ed846ed0d70e41', '[\"*\"]', '2025-05-26 03:53:40', '2025-06-25 15:48:27', '2025-05-25 15:48:27', '2025-05-26 03:53:40'),
(559, 'App\\Models\\User', 68, 'API Token', 'ff490b3c196b5b69af7047ac4240a23fc712c76bb3e1bd5a3f9878aa37d4b68b', '[\"*\"]', '2025-05-26 14:35:28', '2025-06-25 16:18:41', '2025-05-25 16:18:41', '2025-05-26 14:35:28'),
(560, 'App\\Models\\Admin', 2, 'API Token', 'bd9228377413bdb913d6108ef8368419c9d61baceb9f5fce66ea4e20676a23cd', '[\"*\"]', '2025-05-26 03:35:11', '2025-06-09 03:13:02', '2025-05-26 03:13:02', '2025-05-26 03:35:11'),
(561, 'App\\Models\\User', 55, 'API Token', '4cc26886e5fdf01292a57835b86fa970b02d22e9c7cfa503b4dfdb0d59685384', '[\"*\"]', '2025-05-28 06:12:56', '2025-06-26 03:25:17', '2025-05-26 03:25:17', '2025-05-28 06:12:56'),
(562, 'App\\Models\\User', 55, 'API Token', '70796828055eb5a83e0e7fa830ae9f655d26e8c007fc13c630508be8dbb8b6cc', '[\"*\"]', '2025-05-26 04:08:26', '2025-06-26 03:36:11', '2025-05-26 03:36:11', '2025-05-26 04:08:26'),
(563, 'App\\Models\\User', 41, 'API Token', '792dc6a7ef284c235aaed8ae923509df74dc100545a0896aec5db3a0a5a73fde', '[\"*\"]', '2025-05-31 05:52:52', '2025-06-26 03:38:07', '2025-05-26 03:38:07', '2025-05-31 05:52:52'),
(564, 'App\\Models\\User', 41, 'API Token', '288dd63de0925c564583fa3598a33ad091620628b7027e071182cd16bf362ad9', '[\"*\"]', '2025-05-26 04:41:47', '2025-06-26 03:54:09', '2025-05-26 03:54:09', '2025-05-26 04:41:47'),
(565, 'App\\Models\\User', 55, 'API Token', 'de1ccacda18bb389ae2882b5908fa35172bc93014d0e60a0f19a07ad5a71a787', '[\"*\"]', '2025-05-26 04:09:40', '2025-06-26 04:09:39', '2025-05-26 04:09:39', '2025-05-26 04:09:40'),
(566, 'App\\Models\\User', 55, 'API Token', 'ef11980b966614c48acfb58f70c44d2df155d08b76fbc6cb4096fbbab76f8469', '[\"*\"]', '2025-05-26 04:17:59', '2025-06-26 04:17:58', '2025-05-26 04:17:58', '2025-05-26 04:17:59'),
(567, 'App\\Models\\User', 55, 'API Token', 'e64e5f174750461c25d98cb62c2cc5d180bb21e8c93c79c720d6c04fd672b3aa', '[\"*\"]', '2025-06-10 01:48:25', '2025-06-26 04:18:47', '2025-05-26 04:18:47', '2025-06-10 01:48:25'),
(568, 'App\\Models\\User', 41, 'API Token', '3c2e476d0abaeefafabeffa090d40ac276f4e9efa3dbe3e5690c38e5f3ffbb34', '[\"*\"]', '2025-05-26 06:33:35', '2025-06-26 06:23:14', '2025-05-26 06:23:14', '2025-05-26 06:33:35'),
(569, 'App\\Models\\User', 41, 'API Token', '058666c271a17d5861d185f54daf2edae322c7715fb362cf317a68f55ab184d6', '[\"*\"]', '2025-05-26 06:33:43', '2025-06-26 06:33:42', '2025-05-26 06:33:42', '2025-05-26 06:33:43'),
(570, 'App\\Models\\User', 41, 'API Token', 'ca687cf7995fdcc2e4545bea8eaa78146874240e30a7e701c5a043145a93640c', '[\"*\"]', '2025-05-26 14:51:20', '2025-06-26 06:53:28', '2025-05-26 06:53:28', '2025-05-26 14:51:20'),
(571, 'App\\Models\\User', 46, 'API Token', '6dc7c9ba1e7482f626c53b0b2c4f61a266578afddf979c316f50626235114bc0', '[\"*\"]', '2025-05-26 14:47:51', '2025-06-26 14:43:20', '2025-05-26 14:43:20', '2025-05-26 14:47:51'),
(572, 'App\\Models\\User', 46, 'API Token', '1e17f05ce61ac968011cf8c3e409200586cc496753e56f23c5eadb9fcb54df92', '[\"*\"]', '2025-05-27 15:42:04', '2025-06-27 07:29:42', '2025-05-27 07:29:42', '2025-05-27 15:42:04'),
(573, 'App\\Models\\User', 61, 'API Token', 'f7d419fefb4c12bf3a6d90138ff2e0e095a332d3ba1e52d2b32a0141fcc0e58b', '[\"*\"]', '2025-05-27 16:06:59', '2025-06-27 15:40:04', '2025-05-27 15:40:04', '2025-05-27 16:06:59'),
(574, 'App\\Models\\User', 57, 'API Token', 'f60cc28af10c1cc442b15c9d7ad84a0cce8afe2d6f93cd6e7aaa05db8b38bffb', '[\"*\"]', NULL, '2025-06-28 03:46:56', '2025-05-28 03:46:56', '2025-05-28 03:46:56'),
(575, 'App\\Models\\User', 57, 'API Token', '36bb857bebc9d7f768c02b57935d3fd18b869f0c58b1847c1453cc9fab94268a', '[\"*\"]', '2025-05-28 03:47:11', '2025-06-28 03:47:10', '2025-05-28 03:47:10', '2025-05-28 03:47:11'),
(576, 'App\\Models\\Admin', 2, 'API Token', 'f0ad190f71e99e4f9f13555977241d1ce621c49f17102c6616fb87ca3eda04b5', '[\"*\"]', '2025-05-28 06:27:50', '2025-06-11 06:27:43', '2025-05-28 06:27:43', '2025-05-28 06:27:50'),
(577, 'App\\Models\\User', 55, 'API Token', '48f150459e89aac272f77662fd10348e42ee2cd17761c2822d12642d2b6eda8c', '[\"*\"]', '2025-05-28 12:37:38', '2025-06-28 06:47:30', '2025-05-28 06:47:30', '2025-05-28 12:37:38'),
(578, 'App\\Models\\User', 69, 'API Token', 'ca79527a1e10c242ff66c6cc2963343d5e027a75cf2a2bc004125f2699504393', '[\"*\"]', '2025-05-29 03:11:14', '2025-06-28 08:23:36', '2025-05-28 08:23:36', '2025-05-29 03:11:14'),
(579, 'App\\Models\\User', 41, 'API Token', 'd003c3ac5192a60c303c5136f7c5e0f4f015f632b9b2425f7176db25995f1c25', '[\"*\"]', '2025-05-28 08:44:38', '2025-06-28 08:40:18', '2025-05-28 08:40:18', '2025-05-28 08:44:38'),
(580, 'App\\Models\\User', 70, 'API Token', '3fc6f1b1732401ea8307e1018dbfe07de1568846889b849227e5e76f233c31f1', '[\"*\"]', '2025-05-28 10:39:54', '2025-06-28 10:34:24', '2025-05-28 10:34:24', '2025-05-28 10:39:54'),
(581, 'App\\Models\\Admin', 6, 'API Token', 'bd68cee550c978500fc7ca6781fb116b4519fb562e0c31ab45d0b96a88dc05c0', '[\"*\"]', '2025-05-28 12:27:26', '2025-06-11 12:26:45', '2025-05-28 12:26:45', '2025-05-28 12:27:26'),
(582, 'App\\Models\\User', 71, 'API Token', '924697f8ac34ad9ff2fc81e01959eed0d44f56e1fe287b5299cc5cec78a51c85', '[\"*\"]', '2025-05-28 13:10:50', '2025-06-28 12:51:43', '2025-05-28 12:51:43', '2025-05-28 13:10:50'),
(583, 'App\\Models\\User', 72, 'API Token', 'e26887b0d3e3cbb86120026a25f77b442cbbb9873a07f5cacc860d3dfa4e0a42', '[\"*\"]', '2025-05-28 13:35:48', '2025-06-28 13:16:19', '2025-05-28 13:16:19', '2025-05-28 13:35:48'),
(584, 'App\\Models\\User', 73, 'API Token', 'd689db3b3b0d32083c860961891ec9306c96defce3a8a98f2f7b0ffde83b9e43', '[\"*\"]', '2025-05-28 14:01:26', '2025-06-28 13:47:14', '2025-05-28 13:47:14', '2025-05-28 14:01:26'),
(585, 'App\\Models\\User', 57, 'API Token', '9314f4540d935501d920609f9b7052a0a5861ff36b624e280a2664476cde5e92', '[\"*\"]', '2025-05-28 14:19:17', '2025-06-28 13:59:21', '2025-05-28 13:59:21', '2025-05-28 14:19:17'),
(586, 'App\\Models\\User', 73, 'API Token', '3b681bf87ba62f60a11628cc67d8922b8655bdca616355480f3c2c20c3e5797b', '[\"*\"]', '2025-05-28 14:01:55', '2025-06-28 14:01:51', '2025-05-28 14:01:51', '2025-05-28 14:01:55'),
(587, 'App\\Models\\User', 73, 'API Token', '568189310ff0ddc57c9737f8c2ea043d05b9a3dd0424fbd62f7e3f09516d4102', '[\"*\"]', '2025-05-28 14:02:27', '2025-06-28 14:02:25', '2025-05-28 14:02:25', '2025-05-28 14:02:27'),
(588, 'App\\Models\\User', 73, 'API Token', '070b3433990da105414d99f7fc96e53e30cc8ac90b15f7009cbf2a7b74f0734e', '[\"*\"]', '2025-05-28 14:03:35', '2025-06-28 14:03:33', '2025-05-28 14:03:33', '2025-05-28 14:03:35'),
(589, 'App\\Models\\User', 57, 'API Token', '35501515c9fd3f11936192b84be1bdbb31fab7212878c92fa40cc3d00253592d', '[\"*\"]', '2025-05-28 15:36:52', '2025-06-28 14:03:57', '2025-05-28 14:03:57', '2025-05-28 15:36:52'),
(590, 'App\\Models\\User', 50, 'API Token', 'd60e473eebee95ad39d1c61329d1e24375ff82dd3e0aedd1406ae36c3a8af353', '[\"*\"]', '2025-06-01 05:03:11', '2025-06-28 14:05:09', '2025-05-28 14:05:09', '2025-06-01 05:03:11'),
(591, 'App\\Models\\User', 57, 'API Token', '69466493a9d10d8f4ecfbc54c49cef06b1fae56bf79f1f29c2776b29b5d504d3', '[\"*\"]', '2025-05-28 14:42:45', '2025-06-28 14:25:23', '2025-05-28 14:25:23', '2025-05-28 14:42:45'),
(592, 'App\\Models\\User', 74, 'API Token', '417229166525f489997e9bc8d3709e41b6a8e6493323882adff06a84f2263dd6', '[\"*\"]', '2025-05-28 15:28:54', '2025-06-28 15:28:14', '2025-05-28 15:28:14', '2025-05-28 15:28:54'),
(593, 'App\\Models\\User', 75, 'API Token', 'a6b6192a89b1bc17df1de858eac2ffb7deefb0bbecd24f3ae337403969629b88', '[\"*\"]', '2025-05-28 15:53:57', '2025-06-28 15:30:28', '2025-05-28 15:30:28', '2025-05-28 15:53:57'),
(594, 'App\\Models\\User', 76, 'API Token', 'af3b475ad8b72f8d76b23711997365273150b66942e5ce474021ca4042a5df9f', '[\"*\"]', '2025-05-28 16:03:42', '2025-06-28 15:59:19', '2025-05-28 15:59:19', '2025-05-28 16:03:42'),
(595, 'App\\Models\\User', 77, 'API Token', 'c02fea65729be98b64fdf8fb576c2f90dc21df95bce967c0ef622755f3cb361a', '[\"*\"]', '2025-05-29 03:30:59', '2025-06-29 03:17:30', '2025-05-29 03:17:30', '2025-05-29 03:30:59'),
(596, 'App\\Models\\User', 78, 'API Token', 'a7d5d8af28f3aebe9de90e5ee26d958279196ca655c3842dd66caf3137c4369d', '[\"*\"]', '2025-06-02 08:30:20', '2025-06-29 03:22:33', '2025-05-29 03:22:33', '2025-06-02 08:30:20'),
(597, 'App\\Models\\User', 79, 'API Token', '2089caa85fa8d0aaa1dddf789aeacc675ac16f278e2f8cd82f301235dd51c343', '[\"*\"]', '2025-05-31 07:29:34', '2025-06-29 06:06:38', '2025-05-29 06:06:38', '2025-05-31 07:29:34'),
(598, 'App\\Models\\User', 80, 'API Token', '8e07384dfb9a8deb754f97cc66f04d8e570b06fef795345c644973e26c1d549c', '[\"*\"]', '2025-05-29 06:42:28', '2025-06-29 06:31:06', '2025-05-29 06:31:06', '2025-05-29 06:42:28'),
(599, 'App\\Models\\User', 81, 'API Token', '18439ae4a57af985ac007ba72b21bae1ced9945756b832d68330513fb4e3a5c2', '[\"*\"]', '2025-05-29 07:12:02', '2025-06-29 06:34:38', '2025-05-29 06:34:38', '2025-05-29 07:12:02'),
(600, 'App\\Models\\Admin', 2, 'API Token', '3cf5ae22c62d88385650101f72a2e49e1b994d142d9449e5b51bc6e00374d898', '[\"*\"]', '2025-05-29 06:47:19', '2025-06-12 06:45:34', '2025-05-29 06:45:34', '2025-05-29 06:47:19'),
(601, 'App\\Models\\Admin', 6, 'API Token', 'e89fe588b1ef3a5b2f5a42ffca08659c0da78b7a095105d95a07417df5fba6a1', '[\"*\"]', '2025-05-29 07:17:23', '2025-06-12 06:47:12', '2025-05-29 06:47:12', '2025-05-29 07:17:23'),
(602, 'App\\Models\\User', 55, 'API Token', '35f10d7064ee93d2af9322d7cadd2b26a5e8e07fcd281fa28ae9f1720cbedb5a', '[\"*\"]', '2025-05-30 03:55:35', '2025-06-29 07:01:12', '2025-05-29 07:01:12', '2025-05-30 03:55:35'),
(603, 'App\\Models\\Admin', 2, 'API Token', '936cae61010782446eef7c797f3dfe22c50d1e57c6df06e999a6695f9423c929', '[\"*\"]', '2025-05-29 07:20:35', '2025-06-12 07:02:08', '2025-05-29 07:02:08', '2025-05-29 07:20:35'),
(604, 'App\\Models\\User', 82, 'API Token', 'd098e3032ed186e62513a7959bcaa17e678ac35284751e0b420e3544ff4320ec', '[\"*\"]', '2025-05-29 14:51:02', '2025-06-29 13:16:26', '2025-05-29 13:16:26', '2025-05-29 14:51:02'),
(605, 'App\\Models\\User', 83, 'API Token', 'bad6143efadd624c8671b6c38b1eb8d502b7556745f7ff35a4ea56c87f90a784', '[\"*\"]', '2025-05-29 13:54:21', '2025-06-29 13:54:19', '2025-05-29 13:54:19', '2025-05-29 13:54:21'),
(606, 'App\\Models\\User', 83, 'API Token', '47d037fcea49a7a32316bc9e991a99fb96393bd32f089b407028bee3ee57e741', '[\"*\"]', '2025-05-29 14:37:52', '2025-06-29 14:35:00', '2025-05-29 14:35:00', '2025-05-29 14:37:52'),
(607, 'App\\Models\\User', 84, 'API Token', 'ee3f11abf45021ca16d3144c8acfb6cd0610dd3f772bb16d570b40a1e0995a05', '[\"*\"]', '2025-05-29 15:12:41', '2025-06-29 15:08:27', '2025-05-29 15:08:27', '2025-05-29 15:12:41'),
(608, 'App\\Models\\User', 85, 'API Token', 'e4a8e2306da7e3a0a9ae4428fc183550f002465c32dfa92871cd70621259883d', '[\"*\"]', '2025-05-30 03:26:48', '2025-06-29 15:17:06', '2025-05-29 15:17:06', '2025-05-30 03:26:48'),
(609, 'App\\Models\\User', 86, 'API Token', 'f48d7940fddedba249c5c8bed27c1c0ae93924db78430c8d8a8d933811fae7c0', '[\"*\"]', '2025-06-02 11:58:02', '2025-06-29 19:21:35', '2025-05-29 19:21:35', '2025-06-02 11:58:02'),
(610, 'App\\Models\\Admin', 2, 'API Token', '16dd9c22015669601de78f7835b47f86095eaa7d4004441338fac7270e0cfbf6', '[\"*\"]', '2025-05-31 05:57:07', '2025-06-13 03:55:02', '2025-05-30 03:55:02', '2025-05-31 05:57:07'),
(611, 'App\\Models\\User', 55, 'API Token', '25486109370d3817c7791a30de10ad029ef0fc475bb50c62b062b39fd13310e4', '[\"*\"]', '2025-05-30 08:03:18', '2025-06-30 03:55:43', '2025-05-30 03:55:43', '2025-05-30 08:03:18'),
(612, 'App\\Models\\User', 87, 'API Token', '1b519356171cd5ae099b5d8a5f8ac4cbc03d330b7066f7a89dfe1fc555d1844d', '[\"*\"]', '2025-05-30 06:50:56', '2025-06-30 04:03:05', '2025-05-30 04:03:05', '2025-05-30 06:50:56'),
(613, 'App\\Models\\User', 88, 'API Token', '1e48b7f944358613e946c6b7449d3b5aea2b21a6a66f7f961fc6fe833d48ae08', '[\"*\"]', '2025-05-30 04:10:28', '2025-06-30 04:10:27', '2025-05-30 04:10:27', '2025-05-30 04:10:28'),
(614, 'App\\Models\\User', 88, 'API Token', '94acdfc88659eb554cae815c2976f1c88cce37c5ff54a8915342b9be5e7f8e88', '[\"*\"]', '2025-05-30 04:14:02', '2025-06-30 04:10:55', '2025-05-30 04:10:55', '2025-05-30 04:14:02'),
(615, 'App\\Models\\User', 88, 'API Token', '167f6bbb68abeb321f343e3c377d390ce4cb02f23616d7e95cc20e4c8cda3e59', '[\"*\"]', '2025-05-30 05:04:31', '2025-06-30 04:15:11', '2025-05-30 04:15:11', '2025-05-30 05:04:31'),
(616, 'App\\Models\\User', 89, 'API Token', '5878332c907b4670a1fd510827fe8b7d711c983524e923e2824578d718a6859c', '[\"*\"]', '2025-05-30 04:23:45', '2025-06-30 04:17:04', '2025-05-30 04:17:04', '2025-05-30 04:23:45'),
(617, 'App\\Models\\User', 90, 'API Token', '9299dfb26695b9fb7f615ccef99309a35cb03e0ceff3d1a3b1e4b49088f4794a', '[\"*\"]', '2025-05-30 06:33:07', '2025-06-30 06:33:04', '2025-05-30 06:33:04', '2025-05-30 06:33:07'),
(618, 'App\\Models\\User', 90, 'API Token', '7f0eab74e323110c1fb0e7f77b3533770eee16daaefce55d8f66e992058af81d', '[\"*\"]', '2025-05-30 07:03:42', '2025-06-30 06:33:57', '2025-05-30 06:33:57', '2025-05-30 07:03:42'),
(619, 'App\\Models\\User', 91, 'API Token', 'b87c06d19f728dcbf93a4e3be14d67b3c1251246ad26dda8ab23b9fa594cec50', '[\"*\"]', '2025-05-30 11:57:53', '2025-06-30 08:01:52', '2025-05-30 08:01:52', '2025-05-30 11:57:53'),
(620, 'App\\Models\\User', 92, 'API Token', '9aa3b37ee68b7eb2e601f8e02a4c20018a17a9792d93430aa5c89d4807b4fd14', '[\"*\"]', '2025-05-30 08:39:15', '2025-06-30 08:04:12', '2025-05-30 08:04:12', '2025-05-30 08:39:15'),
(621, 'App\\Models\\User', 55, 'API Token', '26a991351aa7e87fe872e3b7a940f34de2272e09ccf0e5b8eba9360fd2c97eba', '[\"*\"]', '2025-05-31 15:57:38', '2025-06-30 08:06:19', '2025-05-30 08:06:19', '2025-05-31 15:57:38'),
(622, 'App\\Models\\User', 93, 'API Token', 'a1d43406ac769a700853a103047e3aae4602b47ad272b75bacb8a10adfddb215', '[\"*\"]', '2025-05-30 15:32:15', '2025-06-30 15:31:24', '2025-05-30 15:31:24', '2025-05-30 15:32:15'),
(623, 'App\\Models\\User', 93, 'API Token', 'd0a61f6b478a957d552523f19627105f1c713e54405c91c29e45137be2b15b62', '[\"*\"]', '2025-05-31 16:40:45', '2025-06-30 15:32:27', '2025-05-30 15:32:27', '2025-05-31 16:40:45'),
(624, 'App\\Models\\User', 94, 'API Token', 'ad02cfa9c7817482aab7367371e2a3ad62f4051e9476b1c3cab168900fb2baec', '[\"*\"]', '2025-05-31 03:59:14', '2025-07-01 03:42:39', '2025-05-31 03:42:39', '2025-05-31 03:59:14'),
(625, 'App\\Models\\User', 68, 'API Token', 'bdbbfb1abfd9efe4e9e12ac0b1084a26983387c482eaa4f6d1a730e1f9ee8a44', '[\"*\"]', '2025-05-31 04:44:48', '2025-07-01 04:44:47', '2025-05-31 04:44:47', '2025-05-31 04:44:48'),
(626, 'App\\Models\\User', 95, 'API Token', '7fda52fb627dabe9f11da0adff140f7f862576a96df36fcb110301f882d6e51a', '[\"*\"]', '2025-05-31 06:29:36', '2025-07-01 05:51:24', '2025-05-31 05:51:24', '2025-05-31 06:29:36'),
(627, 'App\\Models\\User', 41, 'API Token', '47e53a7400001c82dc2050aeb5acaac6a205833f7879824289d610f2e8d05149', '[\"*\"]', '2025-05-31 16:41:22', '2025-07-01 05:54:29', '2025-05-31 05:54:29', '2025-05-31 16:41:22'),
(628, 'App\\Models\\User', 96, 'API Token', '06052c38f048c2c5013c27956d28d67f76ff35e5b4ba78eabf6128b698956ca3', '[\"*\"]', '2025-05-31 05:57:20', '2025-07-01 05:56:47', '2025-05-31 05:56:47', '2025-05-31 05:57:20'),
(629, 'App\\Models\\User', 96, 'API Token', 'c8ae44de9b8e8dcaf9f0ce7d77f248ded6eb880c55fec4b5410dfd2ea85ae5ba', '[\"*\"]', '2025-05-31 05:57:41', '2025-07-01 05:57:40', '2025-05-31 05:57:40', '2025-05-31 05:57:41'),
(630, 'App\\Models\\User', 96, 'API Token', '5785e3ef7260d2751246f9b15e9d7a0c1fa22955dd3c8e8e0953db63d4d845f3', '[\"*\"]', '2025-05-31 07:43:12', '2025-07-01 05:57:58', '2025-05-31 05:57:58', '2025-05-31 07:43:12'),
(631, 'App\\Models\\User', 96, 'API Token', '4c2d39c3a9d09dccff77a8874341e930914191070c2cbe188d86aa4f4c29e635', '[\"*\"]', '2025-05-31 06:03:42', '2025-07-01 06:01:33', '2025-05-31 06:01:33', '2025-05-31 06:03:42'),
(632, 'App\\Models\\User', 97, 'API Token', '251e334b068ce919dba91b54c1a9d2de92d302cce6e874982aa3f2bc1fe06521', '[\"*\"]', '2025-05-31 06:58:11', '2025-07-01 06:47:35', '2025-05-31 06:47:35', '2025-05-31 06:58:11'),
(633, 'App\\Models\\User', 98, 'API Token', '5af623424e381ff09b8d83c41fa416b9ddf717ff7c14a09c4db10ef183b81740', '[\"*\"]', '2025-05-31 07:30:27', '2025-07-01 07:30:25', '2025-05-31 07:30:25', '2025-05-31 07:30:27'),
(634, 'App\\Models\\User', 79, 'API Token', '63cfaab1bb3e2b935e8a6b6c3ccc6bb1b700200125e29a3a8e256891d9658fa1', '[\"*\"]', '2025-05-31 09:00:32', '2025-07-01 07:30:48', '2025-05-31 07:30:48', '2025-05-31 09:00:32'),
(635, 'App\\Models\\User', 98, 'API Token', '6d6bd93664e69b2f41a903bed2a9ae8314b49244bdf095ae0ed86521873f1906', '[\"*\"]', '2025-06-02 02:07:38', '2025-07-01 09:01:52', '2025-05-31 09:01:52', '2025-06-02 02:07:38'),
(636, 'App\\Models\\User', 99, 'API Token', 'efb6dd6163e9876451aab8a5411c7f17ab9ca0c0aadf0031a012c803ff35eea6', '[\"*\"]', '2025-06-12 06:35:54', '2025-07-01 09:38:58', '2025-05-31 09:38:58', '2025-06-12 06:35:54'),
(637, 'App\\Models\\User', 55, 'API Token', 'd258af14d978cce45e7cf88990714aceefcd41b22f72225a54072ff6bc858e2b', '[\"*\"]', '2025-06-13 06:37:58', '2025-07-01 09:47:25', '2025-05-31 09:47:25', '2025-06-13 06:37:58'),
(638, 'App\\Models\\Admin', 2, 'API Token', '8cc1c2d98b570ba2994ba8c7c0fad4d1cb64aabcd60011061f61f2db0621e2d2', '[\"*\"]', '2025-05-31 12:03:43', '2025-06-14 12:03:06', '2025-05-31 12:03:06', '2025-05-31 12:03:43'),
(639, 'App\\Models\\User', 100, 'API Token', 'bf5215d1c54bfc763312ac75b7ebabb80e0d40f03889efc9b5f489291616fc16', '[\"*\"]', '2025-05-31 12:04:08', '2025-07-01 12:03:28', '2025-05-31 12:03:28', '2025-05-31 12:04:08'),
(640, 'App\\Models\\User', 100, 'API Token', '2232585c2de7bfadcd5717ce93334259e66e94934a7bc25c8e2efbd3081d0602', '[\"*\"]', '2025-05-31 12:32:43', '2025-07-01 12:04:22', '2025-05-31 12:04:22', '2025-05-31 12:32:43'),
(641, 'App\\Models\\User', 101, 'API Token', '5ddeebd362d20bd1c29499e5d37ae3ec84ddc04a5d5f88ee00f3fb0f7879a392', '[\"*\"]', '2025-05-31 15:09:22', '2025-07-01 14:54:21', '2025-05-31 14:54:21', '2025-05-31 15:09:22'),
(642, 'App\\Models\\User', 93, 'API Token', '3d850c3f42adeb305e45bc25c44bb04558d38f957d702a61725a8a0e3368a77e', '[\"*\"]', '2025-05-31 16:43:12', '2025-07-01 16:42:31', '2025-05-31 16:42:31', '2025-05-31 16:43:12'),
(643, 'App\\Models\\User', 102, 'API Token', '5cbb2ab470e8c8deb3c8403e0d0ec61fea8a565003e8e4acfac3de51d6258994', '[\"*\"]', '2025-06-01 03:17:01', '2025-07-01 02:59:56', '2025-06-01 02:59:56', '2025-06-01 03:17:01'),
(644, 'App\\Models\\User', 55, 'API Token', 'fa6c8b547e8b59af9838e9743405475dbf7cb14741fc7c94e5420e70aa98a658', '[\"*\"]', '2025-06-02 07:00:53', '2025-07-01 05:03:14', '2025-06-01 05:03:14', '2025-06-02 07:00:53'),
(645, 'App\\Models\\User', 103, 'API Token', 'a5ff0e80e3de04f6f450988152d2a5a33ed13a8cdee19b26a5efb7c1ce9cdd1f', '[\"*\"]', '2025-06-01 06:52:12', '2025-07-01 06:50:42', '2025-06-01 06:50:42', '2025-06-01 06:52:12'),
(646, 'App\\Models\\User', 41, 'API Token', '3a48b41609f5ab9c5f463b5b00c60e379e3df5ddc5469fec018c4046230457b4', '[\"*\"]', '2025-06-02 02:05:00', '2025-07-01 06:53:36', '2025-06-01 06:53:36', '2025-06-02 02:05:00'),
(647, 'App\\Models\\User', 104, 'API Token', '2604af07e4b44929f6d0af7bbc2d5a68737cecb99c9d72128123791e8ec9e312', '[\"*\"]', '2025-06-06 06:53:52', '2025-07-01 06:54:15', '2025-06-01 06:54:15', '2025-06-06 06:53:52'),
(648, 'App\\Models\\Admin', 2, 'API Token', '006cf08cacb8de308cde91eb4d3774f1fc23d5d85efdec40796ec542bb51229e', '[\"*\"]', '2025-06-01 07:21:10', '2025-06-15 06:57:41', '2025-06-01 06:57:41', '2025-06-01 07:21:10'),
(649, 'App\\Models\\User', 105, 'API Token', '80624d9539fadcdbd32d2374131112809a70ef7314c5f704d8998141ce61d2f1', '[\"*\"]', '2025-06-01 07:35:42', '2025-07-01 06:58:37', '2025-06-01 06:58:37', '2025-06-01 07:35:42'),
(650, 'App\\Models\\User', 106, 'API Token', 'e7041df6ed19cdbe4a04ef4abf2ce312b4182e38f7a0d316c370d46f1ad9d4bb', '[\"*\"]', '2025-06-01 07:28:09', '2025-07-01 07:26:46', '2025-06-01 07:26:46', '2025-06-01 07:28:09'),
(651, 'App\\Models\\User', 107, 'API Token', '5255f3a82c09b1d5bfd2456308f905fca134dd944ac152c66b4d4fa0126467f2', '[\"*\"]', '2025-06-02 07:56:49', '2025-07-01 07:27:04', '2025-06-01 07:27:04', '2025-06-02 07:56:49'),
(652, 'App\\Models\\User', 108, 'API Token', '3423a4b157f2fa0f73ac07d040d509a8b45282d711b38aed56200d4839631133', '[\"*\"]', '2025-06-01 08:16:01', '2025-07-01 08:10:37', '2025-06-01 08:10:37', '2025-06-01 08:16:01'),
(653, 'App\\Models\\User', 109, 'API Token', 'eaf93c8d27e27f55ac37f1deaa0f86efb992756e03b87a8b7d4d1e3a2835c2e2', '[\"*\"]', '2025-06-01 09:49:00', '2025-07-01 09:46:36', '2025-06-01 09:46:36', '2025-06-01 09:49:00'),
(654, 'App\\Models\\User', 110, 'API Token', '2319f06f05a9e964962208e0429fc5ff7ba4e34e05ca4d1073bd0a74c73600e7', '[\"*\"]', '2025-06-01 12:25:07', '2025-07-01 12:24:49', '2025-06-01 12:24:49', '2025-06-01 12:25:07'),
(655, 'App\\Models\\User', 50, 'API Token', '919e074d619d2e172e598f88b07c7f49d3f8d554bc27ca36934855b8f413ad32', '[\"*\"]', '2025-06-01 16:14:05', '2025-07-01 13:24:17', '2025-06-01 13:24:17', '2025-06-01 16:14:05'),
(656, 'App\\Models\\User', 111, 'API Token', '141967a8db848f279a59abcec5e4c2cc63c0f326c9c9492ffdd9e130b475fd9e', '[\"*\"]', NULL, '2025-07-01 14:18:19', '2025-06-01 14:18:19', '2025-06-01 14:18:19'),
(657, 'App\\Models\\User', 112, 'API Token', '9f85c9d3072992720cc59c1a8d530293b021a37c7168d0eb2e8fc504af153fc1', '[\"*\"]', '2025-06-01 15:06:05', '2025-07-01 14:59:38', '2025-06-01 14:59:38', '2025-06-01 15:06:05'),
(658, 'App\\Models\\User', 113, 'API Token', 'a89d215dbb1f3972afd6c86cc28b49159fcaf2f43aebbe6ab5c16d53e67a2276', '[\"*\"]', '2025-06-01 16:15:42', '2025-07-01 16:07:13', '2025-06-01 16:07:13', '2025-06-01 16:15:42'),
(659, 'App\\Models\\User', 50, 'API Token', 'd85b3b8b0b8306a7ce31a0e2a84657ff0f0dd2e3c976aaf198738ce2f1f5328f', '[\"*\"]', '2025-06-17 15:10:51', '2025-07-01 16:18:38', '2025-06-01 16:18:38', '2025-06-17 15:10:51'),
(660, 'App\\Models\\User', 114, 'API Token', '0d2c82cd04bf441f1b74e37cce2cdd5ad04f4f10ae38947eabbf1988aefef2eb', '[\"*\"]', '2025-06-02 01:22:01', '2025-07-02 01:20:39', '2025-06-02 01:20:39', '2025-06-02 01:22:01'),
(661, 'App\\Models\\User', 41, 'API Token', '20f2603a1d6eec6a6f5c65e64c4d663aace68285cc1b5c7ae9741e9970dc51c9', '[\"*\"]', '2025-06-06 10:33:32', '2025-07-02 02:06:17', '2025-06-02 02:06:17', '2025-06-06 10:33:32'),
(662, 'App\\Models\\User', 79, 'API Token', '33f32852c443a850ccdee3b40db93ca32e81c30d9bd27104519ffd9d01b46403', '[\"*\"]', '2025-06-23 06:26:50', '2025-07-02 02:08:47', '2025-06-02 02:08:47', '2025-06-23 06:26:50'),
(663, 'App\\Models\\User', 115, 'API Token', '15ea539cfdbb7aebd2642ca102a5fddb9d9314b696f9ad7de4f0e8a1b3445d23', '[\"*\"]', '2025-06-02 08:12:39', '2025-07-02 07:59:33', '2025-06-02 07:59:33', '2025-06-02 08:12:39'),
(664, 'App\\Models\\User', 116, 'API Token', '724e28517e2865fa535fe991310f264cd967d5a26238211517bc46fc7a56791d', '[\"*\"]', '2025-06-02 08:13:31', '2025-07-02 08:10:51', '2025-06-02 08:10:51', '2025-06-02 08:13:31'),
(665, 'App\\Models\\User', 117, 'API Token', '3226be23b6426a73ac42475d814f40bd0dd4ce1ce94a7b1eb6e8d4f5f2c9ff0b', '[\"*\"]', '2025-06-02 11:48:10', '2025-07-02 11:43:13', '2025-06-02 11:43:13', '2025-06-02 11:48:10'),
(666, 'App\\Models\\User', 117, 'API Token', '0d6631aff990839ffc62eed50c6d0cf35c81eb7b164427958b3adf06324f5be3', '[\"*\"]', '2025-06-02 11:52:40', '2025-07-02 11:52:11', '2025-06-02 11:52:11', '2025-06-02 11:52:40'),
(667, 'App\\Models\\User', 118, 'API Token', '33f8d82907dee2e3fcdb0ad2c8a7c3e5a9d9f55ed78ec289f12d7b8a9b5e828b', '[\"*\"]', '2025-06-02 14:35:48', '2025-07-02 14:34:19', '2025-06-02 14:34:19', '2025-06-02 14:35:48'),
(668, 'App\\Models\\User', 119, 'API Token', '1b0f9bb112ee7d7a4ddaa332cc054f87cf2c2687fb176631a24409ab59242913', '[\"*\"]', '2025-06-02 15:17:43', '2025-07-02 15:17:42', '2025-06-02 15:17:42', '2025-06-02 15:17:43'),
(669, 'App\\Models\\User', 120, 'API Token', '3a6f1015b5475f26dd0654dda9dd9d987bd561f302834b80b684b6a77ed4c66b', '[\"*\"]', '2025-06-03 06:29:13', '2025-07-03 06:23:46', '2025-06-03 06:23:46', '2025-06-03 06:29:13'),
(670, 'App\\Models\\User', 121, 'API Token', '221c5e66a5f2c3ea8346d7b7112786cff03b2ffe2df71aada1153db37678582c', '[\"*\"]', '2025-06-03 06:41:25', '2025-07-03 06:41:22', '2025-06-03 06:41:22', '2025-06-03 06:41:25'),
(671, 'App\\Models\\User', 41, 'API Token', '69d79521cbaee68e2a9f08ab4540d17a423be459d37000faa339ec2cb28d54ac', '[\"*\"]', '2025-06-04 08:23:17', '2025-07-04 08:03:47', '2025-06-04 08:03:47', '2025-06-04 08:23:17'),
(672, 'App\\Models\\User', 41, 'API Token', 'c16c66e11468442456c7e1158c8380937744904228d5e3d6bcf1a92fb98d0f94', '[\"*\"]', '2025-06-04 08:30:03', '2025-07-04 08:23:22', '2025-06-04 08:23:22', '2025-06-04 08:30:03'),
(673, 'App\\Models\\User', 41, 'API Token', 'bb5b4e4c11b32bbcfe6df13661edffe226e12929d3d739cb694538d419d74a4a', '[\"*\"]', '2025-06-09 08:02:43', '2025-07-04 08:31:37', '2025-06-04 08:31:37', '2025-06-09 08:02:43'),
(674, 'App\\Models\\User', 57, 'API Token', '8e57c74a58083e396eb0b0a3cc29429371070460d51cf6dc313f41a73135b1a9', '[\"*\"]', '2025-06-06 10:38:01', '2025-07-06 10:37:54', '2025-06-06 10:37:54', '2025-06-06 10:38:01'),
(675, 'App\\Models\\User', 56, 'API Token', '3131deac53be34800e5f29b8fbf2bc7bace02f2412223c6893d5f6cd0ebf4bd9', '[\"*\"]', '2025-06-06 11:32:59', '2025-07-06 11:32:57', '2025-06-06 11:32:57', '2025-06-06 11:32:59'),
(676, 'App\\Models\\User', 56, 'API Token', 'dec97f4314ae974ef9a2117cc4c3b4b8214cbe328bb24ed95f58f18812657200', '[\"*\"]', '2025-06-06 14:51:26', '2025-07-06 11:33:17', '2025-06-06 11:33:17', '2025-06-06 14:51:26'),
(677, 'App\\Models\\User', 41, 'API Token', 'a7486085bd14184dd7c10f28af60307af90a07284b59fa7592b8a46a3f043c56', '[\"*\"]', '2025-06-10 03:14:40', '2025-07-09 09:03:48', '2025-06-09 09:03:48', '2025-06-10 03:14:40'),
(678, 'App\\Models\\User', 55, 'API Token', '3ce478187f4b47f1d34f8966b6bf3cab68f5cd4bd355781bceabc2a2576639e1', '[\"*\"]', '2025-06-11 07:17:39', '2025-07-09 09:06:53', '2025-06-09 09:06:53', '2025-06-11 07:17:39'),
(679, 'App\\Models\\Admin', 6, 'API Token', 'aca58486a66c5e400115df4593c281867a93046d5639208a318d4db4b5949ae7', '[\"*\"]', '2025-06-10 03:44:51', '2025-06-24 03:43:29', '2025-06-10 03:43:29', '2025-06-10 03:44:51'),
(680, 'App\\Models\\User', 55, 'API Token', 'cf675d1c2c7078445927384015f49372e8debb6d7a1093f27162fb6db98c517a', '[\"*\"]', '2025-06-10 04:49:36', '2025-07-10 04:49:11', '2025-06-10 04:49:11', '2025-06-10 04:49:36'),
(681, 'App\\Models\\User', 55, 'API Token', 'b205407aea062abe51af7262bc1559934f85e8ec6029280936e274a7c46b33c4', '[\"*\"]', '2025-06-10 08:35:17', '2025-07-10 08:35:11', '2025-06-10 08:35:11', '2025-06-10 08:35:17'),
(682, 'App\\Models\\User', 41, 'API Token', '312e26e7215433e20e1e8f8fae3c3b369359dc377d9170afa80fe8cee6e812d8', '[\"*\"]', '2025-06-10 08:43:48', '2025-07-10 08:43:08', '2025-06-10 08:43:08', '2025-06-10 08:43:48'),
(683, 'App\\Models\\User', 41, 'API Token', '48edf5ce4a76b30bd2f071dcf03e6efda44ce32026c571a1c636cb4d407d0056', '[\"*\"]', '2025-06-10 08:45:48', '2025-07-10 08:44:01', '2025-06-10 08:44:01', '2025-06-10 08:45:48'),
(684, 'App\\Models\\User', 41, 'API Token', 'f7a4a7d4e36b9d1e518f7c0ee775ac487a9611ee45a12bf057c307dc82348bc1', '[\"*\"]', NULL, '2025-07-10 08:45:56', '2025-06-10 08:45:56', '2025-06-10 08:45:56'),
(685, 'App\\Models\\User', 41, 'API Token', '97b7749da87e12de0009f0472596bab2691e1f108d6b65e3830b9cc30218aa07', '[\"*\"]', NULL, '2025-07-10 08:50:35', '2025-06-10 08:50:35', '2025-06-10 08:50:35'),
(686, 'App\\Models\\User', 41, 'API Token', '005ce3fd5b616626db17899c4ee031697d6092759766d897bf4d89e507fdc4c9', '[\"*\"]', '2025-06-10 10:04:41', '2025-07-10 10:02:28', '2025-06-10 10:02:28', '2025-06-10 10:04:41'),
(687, 'App\\Models\\User', 41, 'API Token', 'a7aa816e7844ddcb183eae99e66395e77ff148260dcfdd123e1b68e25a74e9b2', '[\"*\"]', '2025-06-10 10:15:30', '2025-07-10 10:05:51', '2025-06-10 10:05:51', '2025-06-10 10:15:30'),
(688, 'App\\Models\\User', 41, 'API Token', '9ddfbd7ac3d556cc9d21a3b3bd025d955337c35cec4b681d12c384443e2ee787', '[\"*\"]', '2025-06-10 10:23:35', '2025-07-10 10:15:55', '2025-06-10 10:15:55', '2025-06-10 10:23:35'),
(689, 'App\\Models\\User', 41, 'API Token', 'bae4f05f1aa4f96d1990b8abeea5b85dc760e0812cb503a2215d4f3ceb7dd9a4', '[\"*\"]', '2025-06-10 13:38:35', '2025-07-10 11:19:01', '2025-06-10 11:19:01', '2025-06-10 13:38:35'),
(690, 'App\\Models\\User', 41, 'API Token', 'ed54fe45478b879d6b6cdfe17f6adb2839e789736a28dcd8687d99a3f581bba9', '[\"*\"]', '2025-06-12 03:06:51', '2025-07-10 13:38:41', '2025-06-10 13:38:41', '2025-06-12 03:06:51'),
(691, 'App\\Models\\User', 122, 'API Token', 'b8c501fd04499123182015f18974cc8b492989e1153e40fab9c5461312724065', '[\"*\"]', '2025-06-11 00:08:27', '2025-07-10 23:35:53', '2025-06-10 23:35:53', '2025-06-11 00:08:27'),
(692, 'App\\Models\\User', 55, 'API Token', '0f0f8f3cfb89f33cba953a876261eec95be27a6eeb78921566fda8247a5be71e', '[\"*\"]', '2025-06-11 03:15:54', '2025-07-11 03:15:10', '2025-06-11 03:15:10', '2025-06-11 03:15:54'),
(693, 'App\\Models\\User', 55, 'API Token', '5714fdfa2f85b31a3f2c10a462b8ea59622d7246312b0306860c23783434692f', '[\"*\"]', '2025-06-12 12:41:03', '2025-07-11 03:48:40', '2025-06-11 03:48:40', '2025-06-12 12:41:03'),
(694, 'App\\Models\\User', 50, 'API Token', 'bd783bb87dcdbd4b9ea564021882af2876fb67ee4a4aaed2bdc964b85ca0fd9f', '[\"*\"]', '2025-06-11 04:04:11', '2025-07-11 04:03:29', '2025-06-11 04:03:29', '2025-06-11 04:04:11'),
(695, 'App\\Models\\User', 41, 'API Token', 'f6e0da8235aeb4f3eb10a23fa36eb674ffffa9f39d0863616e83b7eb94eb522f', '[\"*\"]', '2025-06-12 03:08:37', '2025-07-12 03:08:36', '2025-06-12 03:08:36', '2025-06-12 03:08:37'),
(696, 'App\\Models\\User', 41, 'API Token', 'ab728efe9feda889d7ece90685f9d0c8dfc762861901a4591754c89c54495622', '[\"*\"]', '2025-06-12 03:14:43', '2025-07-12 03:11:03', '2025-06-12 03:11:03', '2025-06-12 03:14:43'),
(697, 'App\\Models\\User', 41, 'API Token', 'bd9168d920f5104c6f4be4ce601e817c90d35780f8e3538b6c8ea346f67ffbd8', '[\"*\"]', '2025-06-13 06:49:37', '2025-07-12 03:14:57', '2025-06-12 03:14:57', '2025-06-13 06:49:37'),
(698, 'App\\Models\\User', 55, 'API Token', '3a63663d166137c9f4b13b2780272c0d61f7664b28ce037e864a0e642c34fc75', '[\"*\"]', '2025-06-12 12:46:04', '2025-07-12 12:46:03', '2025-06-12 12:46:03', '2025-06-12 12:46:04'),
(699, 'App\\Models\\User', 55, 'API Token', '0b27811f30eac65b2198795e7de8c24e3389ce2b240707a17a2e5f47996e0caa', '[\"*\"]', '2025-06-12 12:54:02', '2025-07-12 12:54:01', '2025-06-12 12:54:01', '2025-06-12 12:54:02'),
(700, 'App\\Models\\User', 50, 'API Token', '6e1edfd5e8e3b24416c4eedae880aea848f43937031b9ad24bd062761ac93cce', '[\"*\"]', '2025-06-17 15:28:25', '2025-07-12 15:53:54', '2025-06-12 15:53:54', '2025-06-17 15:28:25'),
(701, 'App\\Models\\User', 50, 'API Token', '60676830545f83806b49f857e4babb9d6ff00a97ffb872d141f733e131f38b8a', '[\"*\"]', NULL, '2025-07-12 16:18:12', '2025-06-12 16:18:12', '2025-06-12 16:18:12'),
(702, 'App\\Models\\User', 50, 'API Token', '7a78078aa45d699dcf78af1f4832ce729494022c0a60932ca2be9c1762619ed0', '[\"*\"]', '2025-06-14 12:33:07', '2025-07-12 16:20:47', '2025-06-12 16:20:47', '2025-06-14 12:33:07'),
(703, 'App\\Models\\User', 55, 'API Token', '2d13b02b9e3ad8e5fa39d5e3e59348c62992b6248a375242310825308757991d', '[\"*\"]', '2025-06-13 07:56:29', '2025-07-13 03:49:23', '2025-06-13 03:49:23', '2025-06-13 07:56:29'),
(704, 'App\\Models\\User', 41, 'API Token', '8197ec6e72adef61b04cea59097b44bbfe551f5d4fcd74eb6fe6e29a258181f9', '[\"*\"]', '2025-06-13 06:40:51', '2025-07-13 06:40:14', '2025-06-13 06:40:14', '2025-06-13 06:40:51'),
(705, 'App\\Models\\User', 41, 'API Token', '19fe8ea6aacca0680be8d5e021c7fd4b30438458bddfdbcde269677ca42a1075', '[\"*\"]', '2025-06-13 07:09:06', '2025-07-13 07:09:05', '2025-06-13 07:09:05', '2025-06-13 07:09:06'),
(706, 'App\\Models\\User', 41, 'API Token', '77e7d7e9f16080e4e8c6d4a1a57b32cf985056197963958e00cb26f2ae9f81bb', '[\"*\"]', '2025-06-13 10:40:43', '2025-07-13 07:13:14', '2025-06-13 07:13:14', '2025-06-13 10:40:43'),
(707, 'App\\Models\\Admin', 6, 'API Token', '3086ef28afec78b927282d6fb9432ff7ad55c00a625b1933fa9fec0b0ba2bd2a', '[\"*\"]', '2025-06-20 08:09:18', '2025-06-28 15:47:21', '2025-06-14 15:47:21', '2025-06-20 08:09:18'),
(708, 'App\\Models\\User', 41, 'API Token', 'f0b7869e6d00d07c46624a8c3a7b2cceb79e9991777dd44657f5195c661e50d0', '[\"*\"]', '2025-06-14 16:51:54', '2025-07-14 16:39:39', '2025-06-14 16:39:39', '2025-06-14 16:51:54'),
(709, 'App\\Models\\Admin', 2, 'API Token', '549bc199301f0be16b7af405baa6f3741cb459ef48dcc49cb7a500c2956a1c99', '[\"*\"]', '2025-06-14 17:31:32', '2025-06-28 16:59:36', '2025-06-14 16:59:36', '2025-06-14 17:31:32'),
(710, 'App\\Models\\Admin', 2, 'API Token', 'c1bb285e72ce3c7a4c568a5efdc87dae3bf0da0db1939fc5b07be205be03b083', '[\"*\"]', '2025-06-15 15:13:35', '2025-06-28 17:31:44', '2025-06-14 17:31:44', '2025-06-15 15:13:35'),
(711, 'App\\Models\\User', 93, 'API Token', 'd81b413d537ff64e7977d0e8ffd4bc77f5356f7c4385bf174453d60697aa7c01', '[\"*\"]', '2025-06-15 10:05:25', '2025-07-15 10:05:23', '2025-06-15 10:05:23', '2025-06-15 10:05:25'),
(712, 'App\\Models\\User', 41, 'API Token', '68ffd78552c40eb4623f67ce07eed892e31428a3b8d72784cfdc10733dff1f69', '[\"*\"]', '2025-06-16 02:28:05', '2025-07-16 02:22:12', '2025-06-16 02:22:12', '2025-06-16 02:28:05'),
(713, 'App\\Models\\User', 55, 'API Token', '2c325035b01c5005ab7428b1b0c8a6ad2d5f834b3fa8e0de4232f231a2a38290', '[\"*\"]', '2025-06-16 15:41:43', '2025-07-16 02:22:40', '2025-06-16 02:22:40', '2025-06-16 15:41:43'),
(714, 'App\\Models\\User', 41, 'API Token', '856c65082c9f41ce490c6c871bddc011b9a12d35ab8ee4c5874fd205130c2961', '[\"*\"]', '2025-06-16 16:44:23', '2025-07-16 02:28:29', '2025-06-16 02:28:29', '2025-06-16 16:44:23'),
(715, 'App\\Models\\User', 93, 'API Token', 'ccbb2979b6dcad25d49c5b1554fe652aed4d996f653583d69e6a9e5549845bf4', '[\"*\"]', '2025-06-16 07:40:15', '2025-07-16 07:30:19', '2025-06-16 07:30:19', '2025-06-16 07:40:15'),
(716, 'App\\Models\\User', 57, 'API Token', 'e8490007b24b3898d09aca4700a5f72e24f729a424dc8a6a1b948544685c4786', '[\"*\"]', '2025-06-16 08:05:44', '2025-07-16 07:57:08', '2025-06-16 07:57:08', '2025-06-16 08:05:44'),
(717, 'App\\Models\\Admin', 2, 'API Token', '841443a5729c024ab4c94f7a47bcbf5e88ebac68dea8e3209a29efffc681ab2f', '[\"*\"]', '2025-06-16 11:30:56', '2025-06-30 08:09:22', '2025-06-16 08:09:22', '2025-06-16 11:30:56'),
(718, 'App\\Models\\User', 55, 'API Token', '161483d2defe477f7cc4f83a7d70f6fd7c6683907113337dda9766af2da48848', '[\"*\"]', '2025-06-16 16:41:58', '2025-07-16 08:36:22', '2025-06-16 08:36:22', '2025-06-16 16:41:58'),
(719, 'App\\Models\\Admin', 2, 'API Token', '16ca2f778ed5f43fe59b6479d4f03efa6bf3ef756f7398187a70bcd124dc4dc1', '[\"*\"]', '2025-06-16 11:40:55', '2025-06-30 11:31:29', '2025-06-16 11:31:29', '2025-06-16 11:40:55'),
(720, 'App\\Models\\Admin', 2, 'API Token', '3469ec78ee48b281691e8ff3265d10e4c4b43afe5f994b4020b2e5e98a61669a', '[\"*\"]', '2025-06-16 14:53:40', '2025-06-30 11:58:14', '2025-06-16 11:58:14', '2025-06-16 14:53:40'),
(721, 'App\\Models\\User', 57, 'API Token', 'a164b5c435d52ecd0c43c8dcdae5f27a85956f59ffb0996fbb0939ad44e610e4', '[\"*\"]', '2025-06-16 16:39:24', '2025-07-16 14:53:54', '2025-06-16 14:53:54', '2025-06-16 16:39:24'),
(722, 'App\\Models\\Admin', 2, 'API Token', '8144e18f8e22f204f775d4bffc4e439a371dc9d14003ce3778fd2557791ff3cb', '[\"*\"]', '2025-06-16 16:50:18', '2025-06-30 15:41:55', '2025-06-16 15:41:55', '2025-06-16 16:50:18'),
(723, 'App\\Models\\Admin', 6, 'API Token', '0cf0d0a267d522e1cd3f4b48aca09c47f558aceac3a71976cafc3682c8a9a614', '[\"*\"]', '2025-06-18 14:57:55', '2025-06-30 15:58:54', '2025-06-16 15:58:54', '2025-06-18 14:57:55'),
(724, 'App\\Models\\User', 55, 'API Token', '3c05786de05e40de300151576cf03f762cf64d7cc017fcbe2a0184da250dd138', '[\"*\"]', '2025-06-17 04:27:34', '2025-07-17 03:43:42', '2025-06-17 03:43:42', '2025-06-17 04:27:34'),
(725, 'App\\Models\\User', 93, 'API Token', '617a8689461d503c4fbd1e1ee9ee57d251cf3d1cc554c402687205f6ac79f2a4', '[\"*\"]', '2025-06-17 04:15:14', '2025-07-17 04:14:47', '2025-06-17 04:14:47', '2025-06-17 04:15:14'),
(726, 'App\\Models\\User', 41, 'API Token', 'c748bf83fd89d8cdb03bfe234f2feb6e44527eb50845a2a20cb78e31e435ea9c', '[\"*\"]', '2025-06-17 04:57:59', '2025-07-17 04:23:57', '2025-06-17 04:23:57', '2025-06-17 04:57:59'),
(727, 'App\\Models\\Admin', 2, 'API Token', 'd4e380ddacaf9948d7501543a6a2a5c52819855fec8749953fca973423a57477', '[\"*\"]', '2025-06-17 05:01:31', '2025-07-01 04:26:05', '2025-06-17 04:26:05', '2025-06-17 05:01:31'),
(728, 'App\\Models\\Admin', 2, 'API Token', '93449dbabd6968826999239749dea83c00f708cb545ddafab87ba96eeb995c8f', '[\"*\"]', '2025-06-17 11:13:16', '2025-07-01 05:02:01', '2025-06-17 05:02:01', '2025-06-17 11:13:16'),
(729, 'App\\Models\\Admin', 2, 'API Token', '75b6283108616b228c29420b59dfd5137f3a55b0f0d5eb7a944a868c0aa7d020', '[\"*\"]', '2025-06-17 11:27:50', '2025-07-01 11:10:34', '2025-06-17 11:10:34', '2025-06-17 11:27:50'),
(730, 'App\\Models\\User', 93, 'API Token', '42ec6708beed8e5bce6fe5a47aac9fa49a0e4d3988d918c8ee1f450f9f41ae9e', '[\"*\"]', '2025-06-17 15:34:44', '2025-07-17 14:45:34', '2025-06-17 14:45:34', '2025-06-17 15:34:44'),
(731, 'App\\Models\\User', 41, 'API Token', '37cb7f9361730c851bea872b6dfdaa78513499ffe87808f8a8a7aefbc87e7dd8', '[\"*\"]', '2025-06-17 15:22:04', '2025-07-17 14:46:17', '2025-06-17 14:46:17', '2025-06-17 15:22:04'),
(732, 'App\\Models\\User', 55, 'API Token', '179b64cb485950ac0a74b8366879fd926148815984ada40e0d628b8fd53bd636', '[\"*\"]', '2025-06-17 14:59:09', '2025-07-17 14:51:26', '2025-06-17 14:51:26', '2025-06-17 14:59:09'),
(733, 'App\\Models\\User', 50, 'API Token', '9644184aab0709895cb4f505c5ec7391642eac51845faf242ad160e7cb941e34', '[\"*\"]', '2025-06-18 16:26:10', '2025-07-17 15:11:38', '2025-06-17 15:11:38', '2025-06-18 16:26:10'),
(734, 'App\\Models\\Admin', 2, 'API Token', 'ee8a09036853c260db1eb66af8589ce2d65d8aa40d5c7517b2c40d918f7c0f15', '[\"*\"]', '2025-06-17 16:38:34', '2025-07-01 15:17:50', '2025-06-17 15:17:50', '2025-06-17 16:38:34'),
(735, 'App\\Models\\Admin', 2, 'API Token', '02f08c82ff3f1998bb0c3d1127f25f9bdac0116e031ccbb33ac71cd99f8276bb', '[\"*\"]', '2025-06-17 15:28:18', '2025-07-01 15:22:11', '2025-06-17 15:22:11', '2025-06-17 15:28:18'),
(736, 'App\\Models\\User', 50, 'API Token', 'bdefd9dd657a3580f776e16f1e46f616321af972a60e01679574e51c7673d126', '[\"*\"]', '2025-06-17 15:51:24', '2025-07-17 15:29:15', '2025-06-17 15:29:15', '2025-06-17 15:51:24'),
(737, 'App\\Models\\Admin', 2, 'API Token', '142793a9bd0f1d0922d4de91469d3f5a8f870cec2a4f267ed0994542fb9887f9', '[\"*\"]', '2025-06-17 15:55:34', '2025-07-01 15:40:10', '2025-06-17 15:40:10', '2025-06-17 15:55:34'),
(738, 'App\\Models\\User', 41, 'API Token', 'a36725a52ba297ffd31472d0130a37d0949568c2fba86c6ea1529236ac242880', '[\"*\"]', '2025-06-17 15:55:43', '2025-07-17 15:48:09', '2025-06-17 15:48:09', '2025-06-17 15:55:43'),
(739, 'App\\Models\\User', 41, 'API Token', 'eca05f7db531acec0e49fd49b17e7cfb4c0835f2ea259aa9c39d055c7b728a01', '[\"*\"]', '2025-06-17 16:04:37', '2025-07-17 15:57:36', '2025-06-17 15:57:36', '2025-06-17 16:04:37'),
(740, 'App\\Models\\Admin', 6, 'API Token', '71ac27642acb3576a1f92523fac0865aed5ca8b59361c1bf8b77a4caadb859cf', '[\"*\"]', '2025-06-17 16:36:00', '2025-07-01 16:02:05', '2025-06-17 16:02:05', '2025-06-17 16:36:00'),
(741, 'App\\Models\\Admin', 2, 'API Token', 'fcfdad15c8b223c2b1d3296d731032470ee897061357f5150f94c722e3f2a568', '[\"*\"]', '2025-06-17 16:18:34', '2025-07-01 16:05:27', '2025-06-17 16:05:27', '2025-06-17 16:18:34'),
(742, 'App\\Models\\User', 41, 'API Token', '170c0fabaf9cae29cc39308a743f84e96b64b74491d27596633afde8bfd94c9e', '[\"*\"]', '2025-06-17 16:18:32', '2025-07-17 16:09:40', '2025-06-17 16:09:40', '2025-06-17 16:18:32'),
(743, 'App\\Models\\Admin', 2, 'API Token', '1e9eca5ad2119f4e77efb357b8ad505dc483fdcaead12a8286cdd3fd67a24dc2', '[\"*\"]', '2025-06-17 16:38:53', '2025-07-01 16:18:42', '2025-06-17 16:18:42', '2025-06-17 16:38:53'),
(744, 'App\\Models\\Admin', 2, 'API Token', 'ed1f95bf42fbf69602aee638bdee5024b7e977a2bc26efa5602c14190ee2bbbe', '[\"*\"]', '2025-06-18 14:21:08', '2025-07-02 08:44:58', '2025-06-18 08:44:58', '2025-06-18 14:21:08'),
(745, 'App\\Models\\Admin', 2, 'API Token', '8df039a3611e66ff0b9b65458b0067694ea54603de4039475aedbd457e79a560', '[\"*\"]', '2025-06-18 14:41:15', '2025-07-02 14:21:21', '2025-06-18 14:21:21', '2025-06-18 14:41:15'),
(746, 'App\\Models\\Admin', 7, 'API Token', 'f6c037601121449fbd3e3535b1131a34ff1993afb366e6212a2be30cf7d50a3e', '[\"*\"]', '2025-06-18 15:11:14', '2025-07-02 14:41:25', '2025-06-18 14:41:25', '2025-06-18 15:11:14'),
(747, 'App\\Models\\User', 55, 'API Token', 'f3583d3e07847c1387b4d84e3d1546d1d45e5805ec9a8771e531a55b49ee03fd', '[\"*\"]', '2025-06-18 14:44:09', '2025-07-18 14:44:08', '2025-06-18 14:44:08', '2025-06-18 14:44:09'),
(748, 'App\\Models\\Admin', 6, 'API Token', 'b071b684bd7bc00914e9e06c261ab12824193f1eccb55506791e4bed8df87aaa', '[\"*\"]', '2025-06-18 15:05:21', '2025-07-02 14:53:08', '2025-06-18 14:53:08', '2025-06-18 15:05:21'),
(749, 'App\\Models\\User', 55, 'API Token', 'e905cc60507e3e87abb4ad714e33ba8cb314da807fcbf1c6c42ce0cb4777f9e9', '[\"*\"]', '2025-06-18 15:11:24', '2025-07-18 15:11:23', '2025-06-18 15:11:23', '2025-06-18 15:11:24'),
(750, 'App\\Models\\User', 55, 'API Token', '3257e7f32ee47659d1444b9214e2d0fc09c37bd38c720773d5cb4da507d6cc20', '[\"*\"]', '2025-06-18 15:11:37', '2025-07-18 15:11:36', '2025-06-18 15:11:36', '2025-06-18 15:11:37'),
(751, 'App\\Models\\User', 55, 'API Token', 'fb2300e255f7c02b75408d0b65ad3e76a1cd6357f2cdf47a46a637461288471a', '[\"*\"]', '2025-06-18 15:11:51', '2025-07-18 15:11:50', '2025-06-18 15:11:50', '2025-06-18 15:11:51'),
(752, 'App\\Models\\User', 55, 'API Token', 'd9d525c165bda291130546189e3d89af2ad8d325eabe7c69e738a66299c88a84', '[\"*\"]', '2025-06-18 15:23:22', '2025-07-18 15:13:18', '2025-06-18 15:13:18', '2025-06-18 15:23:22'),
(753, 'App\\Models\\User', 113, 'API Token', '8cf57855b9d9fe2e88c662a4e5bf17a7341ed03e960840cd0806b4c475dcd7de', '[\"*\"]', NULL, '2025-07-18 15:15:37', '2025-06-18 15:15:37', '2025-06-18 15:15:37'),
(754, 'App\\Models\\User', 113, 'API Token', '72f340dffb7f53e45db3d8430a350ca71ce4bbaa877aefd893fbd90e433080a3', '[\"*\"]', NULL, '2025-07-18 15:17:42', '2025-06-18 15:17:42', '2025-06-18 15:17:42'),
(755, 'App\\Models\\User', 133, 'API Token', '273efe82e3b3bc0970cfc5d797de8aac77bfb55aca79ec7e9e8138df672fe431', '[\"*\"]', NULL, '2025-07-18 15:18:08', '2025-06-18 15:18:08', '2025-06-18 15:18:08'),
(756, 'App\\Models\\User', 41, 'API Token', 'cdec6ff7f486d67a76638fdeae1e4e00b2508de4fe1fb69a71ed8f10f613d96e', '[\"*\"]', '2025-06-18 15:20:38', '2025-07-18 15:19:40', '2025-06-18 15:19:40', '2025-06-18 15:20:38'),
(757, 'App\\Models\\User', 132, 'API Token', '6df9cd203750ded36d5c214e01f62aa88fdc2b23c04ec9cdcbd826b390380017', '[\"*\"]', NULL, '2025-07-18 15:20:36', '2025-06-18 15:20:36', '2025-06-18 15:20:36'),
(758, 'App\\Models\\User', 93, 'API Token', 'c0a4d7fbc9fda305bb91cd0dbe9af58af98523f9cdeef1d3db80eb8d7ea1667d', '[\"*\"]', '2025-06-18 16:19:46', '2025-07-18 15:22:22', '2025-06-18 15:22:22', '2025-06-18 16:19:46'),
(759, 'App\\Models\\User', 55, 'API Token', '24634d0f09088c25b632aa97dc2a8a9f559fa52534a92d7e6ac001b72c8adcfa', '[\"*\"]', '2025-06-18 16:05:26', '2025-07-18 15:26:42', '2025-06-18 15:26:42', '2025-06-18 16:05:26'),
(760, 'App\\Models\\User', 41, 'API Token', 'a583fdacc09cae3c6eb4ee1fa6bbe8e7f54090dc844220b14c79675174c364be', '[\"*\"]', '2025-06-18 15:52:01', '2025-07-18 15:26:43', '2025-06-18 15:26:43', '2025-06-18 15:52:01'),
(761, 'App\\Models\\Admin', 2, 'API Token', '1b2e20de9609849d10ad4518290f0f141e56e0e8036f37b097d1447bbc999c1b', '[\"*\"]', '2025-06-18 16:09:16', '2025-07-02 15:57:12', '2025-06-18 15:57:12', '2025-06-18 16:09:16'),
(762, 'App\\Models\\User', 134, 'API Token', 'ef7645cd486e96f0255f9f0bcc51a330e4c135f9cd63a45c99210c4362ef991f', '[\"*\"]', NULL, '2025-07-18 15:57:38', '2025-06-18 15:57:38', '2025-06-18 15:57:38'),
(763, 'App\\Models\\User', 135, 'API Token', 'fcf8fee6ce8be38f8736b25021d598f2172e1890c99e95ea2b87c7a1ccac6627', '[\"*\"]', NULL, '2025-07-18 15:58:26', '2025-06-18 15:58:26', '2025-06-18 15:58:26'),
(764, 'App\\Models\\User', 55, 'API Token', '22a3c50fc3c5730fd65aaf2a17520a24961cc4e7e421d9c7c650e820682f1dad', '[\"*\"]', '2025-06-18 16:02:59', '2025-07-18 16:02:43', '2025-06-18 16:02:43', '2025-06-18 16:02:59');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(765, 'App\\Models\\User', 55, 'API Token', 'ef6f40cf5ee47e6299d7699464d4f4c378bad9314538ac21688b4abfb654259d', '[\"*\"]', '2025-06-18 16:13:47', '2025-07-18 16:05:27', '2025-06-18 16:05:27', '2025-06-18 16:13:47'),
(766, 'App\\Models\\Admin', 7, 'API Token', 'bd7d7c4816cc933dc3fcbface7c3bc343a537016e07f5180760744d87ea0cb93', '[\"*\"]', '2025-06-18 16:09:29', '2025-07-02 16:09:26', '2025-06-18 16:09:26', '2025-06-18 16:09:29'),
(767, 'App\\Models\\Admin', 7, 'API Token', '64467de28ac01a28b9f78c6ff30adfcc062e3d227417d9ce4e732f89bd9c73b0', '[\"*\"]', '2025-06-18 16:09:31', '2025-07-02 16:09:30', '2025-06-18 16:09:30', '2025-06-18 16:09:31'),
(768, 'App\\Models\\Admin', 7, 'API Token', '1609b8265acbfb695573332b9882284748ec2bc6d19b81f2e5aee7151a6113f9', '[\"*\"]', '2025-06-19 02:06:14', '2025-07-02 16:09:48', '2025-06-18 16:09:48', '2025-06-19 02:06:14'),
(769, 'App\\Models\\User', 55, 'API Token', 'fca7379141c9460af27e5adca3fdffc7fdff62a65a2c7ea876e78ad589cc9dc0', '[\"*\"]', '2025-06-23 06:17:26', '2025-07-18 16:13:49', '2025-06-18 16:13:49', '2025-06-23 06:17:26'),
(770, 'App\\Models\\Admin', 7, 'API Token', '82ef85dfc1132dac450566cba64acba72e10ed8a967e5e0705b42e39ea6dc23d', '[\"*\"]', '2025-06-19 06:42:37', '2025-07-03 02:39:10', '2025-06-19 02:39:10', '2025-06-19 06:42:37'),
(771, 'App\\Models\\Admin', 6, 'API Token', '9f0b87ee1663b2c26576a53ca10317180e8ae7cc58b12c11972a1ab60e37fa3a', '[\"*\"]', '2025-06-19 02:52:29', '2025-07-03 02:39:58', '2025-06-19 02:39:58', '2025-06-19 02:52:29'),
(772, 'App\\Models\\User', 41, 'API Token', 'b14c93d8a103036e1943c9e6fa84eb0e5d35464c93e9af012db47dbf14820c5a', '[\"*\"]', '2025-06-23 06:20:38', '2025-07-19 08:11:46', '2025-06-19 08:11:46', '2025-06-23 06:20:38'),
(773, 'App\\Models\\User', 41, 'API Token', 'ff8685630172f3fcc5a4a00e0a8c2c01cf6fe1d4bea09f23823d768df18f1d3f', '[\"*\"]', '2025-06-19 17:09:32', '2025-07-19 16:38:37', '2025-06-19 16:38:37', '2025-06-19 17:09:32'),
(774, 'App\\Models\\Admin', 2, 'API Token', 'd335d7dbd815916c2b7cd694e3bd6b680d671897d30dcdd5d95d099d5b8ef5a6', '[\"*\"]', '2025-06-20 06:33:13', '2025-07-04 06:04:12', '2025-06-20 06:04:12', '2025-06-20 06:33:13'),
(775, 'App\\Models\\User', 41, 'API Token', '4a3fd9e9ac39cce6760f5a7c4d89c5827b10a0bb34ff6ab45119b8be2ed53dd4', '[\"*\"]', '2025-06-20 06:54:26', '2025-07-20 06:53:09', '2025-06-20 06:53:09', '2025-06-20 06:54:26'),
(776, 'App\\Models\\User', 41, 'API Token', '5c0d841dc78e3e57544778d2c6537b8e6fb329c8c0ae0c92b7eaf00fcb2f5866', '[\"*\"]', '2025-06-23 06:37:01', '2025-07-20 06:55:20', '2025-06-20 06:55:20', '2025-06-23 06:37:01'),
(777, 'App\\Models\\Admin', 6, 'API Token', '30b275d5872ed8fa9b8c9a924310b922fa44187c6b2a6fcad1148783224fd9a3', '[\"*\"]', '2025-06-20 08:17:29', '2025-07-04 07:40:14', '2025-06-20 07:40:14', '2025-06-20 08:17:29'),
(778, 'App\\Models\\Admin', 6, 'API Token', 'b4def40b3fe899485d3fd1020ae081818894e5d73de0c7fb490851601b178335', '[\"*\"]', '2025-06-20 07:42:57', '2025-07-04 07:42:22', '2025-06-20 07:42:22', '2025-06-20 07:42:57'),
(779, 'App\\Models\\Admin', 6, 'API Token', '56619a062fb4d0e6b04f700e045ac3da9f4cc8fd85bcc8b1cf7365c58f89b83b', '[\"*\"]', '2025-06-20 08:16:47', '2025-07-04 08:04:12', '2025-06-20 08:04:12', '2025-06-20 08:16:47'),
(780, 'App\\Models\\Admin', 6, 'API Token', '2f50068751b28b4ff6ffd5036cdad03ffc2bcfbc82c6db5018f8ea3f78d626b8', '[\"*\"]', NULL, '2025-07-04 08:07:21', '2025-06-20 08:07:21', '2025-06-20 08:07:21'),
(781, 'App\\Models\\Admin', 7, 'API Token', 'c1d16e26ec8eb1e578e2bc6285973003145f559a4e8ac628216097a7cfe4b5e4', '[\"*\"]', '2025-06-20 14:02:38', '2025-07-04 14:02:28', '2025-06-20 14:02:28', '2025-06-20 14:02:38'),
(782, 'App\\Models\\Admin', 6, 'API Token', '8935da9defae15abd86fbbb4f59a5ae5997b52ad74aae7d07ad532ed939b9325', '[\"*\"]', '2025-06-20 14:31:55', '2025-07-04 14:06:00', '2025-06-20 14:06:00', '2025-06-20 14:31:55'),
(783, 'App\\Models\\User', 55, 'API Token', '2afdac1f3fc927d58e48f53bc439dd5691c751637e5aabfe55a97a3f13f4e731', '[\"*\"]', '2025-06-23 06:17:20', '2025-07-23 06:10:33', '2025-06-23 06:10:33', '2025-06-23 06:17:20'),
(784, 'App\\Models\\User', 55, 'API Token', 'ba78ce69e360db740c6c1268ea29a91a12c556d338050691e5747bbdf2d59ee8', '[\"*\"]', '2025-06-23 07:43:24', '2025-07-23 06:17:27', '2025-06-23 06:17:27', '2025-06-23 07:43:24');

-- --------------------------------------------------------

--
-- Table structure for table `portfolios`
--

CREATE TABLE `portfolios` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `major_id` int(11) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `about` text DEFAULT NULL,
  `working_status` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `portfolios`
--

INSERT INTO `portfolios` (`id`, `user_id`, `major_id`, `phone_number`, `about`, `working_status`, `created_at`, `updated_at`) VALUES
(45, '116476710830297179900', NULL, '012345678', 'theasd best person', NULL, '2025-04-01 03:19:04', '2025-05-20 04:08:21'),
(46, '109256411017728322719', NULL, '', '', NULL, '2025-04-01 03:19:10', '2025-04-01 03:19:10'),
(49, '105664580476841290147', 1, '016805280', 'My name is Cheam Chanphearun. Currently, I am a Computer Science and English Major.', 1, '2025-04-01 08:46:59', '2025-05-12 04:41:45'),
(54, '105112392647691820585', NULL, '098614694', 'This is Visal', NULL, '2025-04-30 04:02:48', '2025-06-23 06:21:22'),
(57, '111037384532008328218', NULL, '', '', 2, '2025-05-07 15:30:15', '2025-05-07 15:30:15'),
(58, '103496679620329732532', NULL, '', '', 2, '2025-05-07 15:31:26', '2025-05-07 15:31:26'),
(59, '112579669774957438364', 1, '0124234123', 'sdfasfasfadf', 2, '2025-05-12 06:43:23', '2025-05-12 06:48:50'),
(60, '109689464774317234827', 1, '092 521 603', 'I am a fourth year CS major in paragon international university.', 2, '2025-05-20 04:16:41', '2025-05-27 15:41:30'),
(64, '115609318949887683531', 1, '017614694', 'A computer science major, studying and depressing.', 2, '2025-05-20 13:43:59', '2025-06-19 17:12:02'),
(66, '100632280883951344419', NULL, '', '', 2, '2025-05-25 07:55:12', '2025-05-25 07:55:12'),
(67, '117923283157965530322', NULL, '', '', 2, '2025-05-28 08:23:36', '2025-05-28 08:23:36'),
(68, '113481086482515968867', 1, NULL, 'Paragon International University Computer Science Student', 2, '2025-05-28 10:34:24', '2025-05-28 10:35:19'),
(69, '108876146476379244781', 2, '017777888', 'I am a student at Paragon International University, majoring in Management of Information Systems.', 1, '2025-05-28 12:51:43', '2025-05-28 12:58:36'),
(70, '108167943679095175390', 1, NULL, 'CS', 2, '2025-05-28 13:16:19', '2025-05-28 13:19:19'),
(71, '100606516072338303383', NULL, '', '', 2, '2025-05-28 13:47:14', '2025-05-28 13:47:14'),
(72, '102455700561975003395', NULL, '', '', 2, '2025-05-28 15:28:14', '2025-05-28 15:28:14'),
(73, '116982373330549749328', 1, NULL, 'lol', 2, '2025-05-28 15:30:28', '2025-05-28 15:40:22'),
(74, '105800202714559282436', NULL, '', '', 2, '2025-05-28 15:59:19', '2025-05-28 15:59:19'),
(75, '108507708017297844247', 1, '016 126 629', 'កំពុងអង្គុយផឹកកាហ្វេសុខៗ​ សិស្សច្បងហៅធ្វើsurvey', 2, '2025-05-29 03:17:30', '2025-05-29 03:21:38'),
(76, '104431353302662109466', 2, '010948123', 'កំពុងអង្គុយផឹកកាហ្វេសុខៗ​ សិស្សច្បងហៅធ្វើsurvey (2)', 2, '2025-05-29 03:22:33', '2025-05-29 03:24:28'),
(77, '117105768751399130157', 3, '086 506 584', 'I\'m a Digital Artist and Designer who creates impactful, visually engaging designs that blend creativity, strategy, and clear communication to elevate brands and ideas.', 2, '2025-05-29 06:06:38', '2025-05-29 06:15:16'),
(78, '102710524414998808816', NULL, '', '', 2, '2025-05-29 06:31:06', '2025-05-29 06:31:06'),
(79, '113626584035690878089', NULL, '', '', 2, '2025-05-29 06:34:38', '2025-05-29 06:34:38'),
(80, '104616858926155738941', 1, NULL, 'Hobbies include: reading books, listening to music', 2, '2025-05-29 13:16:26', '2025-05-29 13:21:20'),
(81, '102216063992337294863', 1, '0972410355', 'I am a student at Paragon International University', 2, '2025-05-29 13:54:19', '2025-05-29 14:36:04'),
(82, '114272842745434634976', NULL, '', '', 2, '2025-05-29 15:08:27', '2025-05-29 15:08:27'),
(83, '118016059024304193772', 1, NULL, 'Hello', 1, '2025-05-29 15:17:06', '2025-05-29 15:22:07'),
(84, '108502640408441251364', 1, '-111111111', 'B sl soy', 2, '2025-05-29 19:21:35', '2025-05-29 19:22:41'),
(85, '106315963701207381127', 1, '012345678', 'Senior at ParagonIU', 1, '2025-05-30 04:03:05', '2025-05-30 04:04:16'),
(86, '116973618827169503318', NULL, '', '', 2, '2025-05-30 04:10:27', '2025-05-30 04:10:27'),
(87, '112392944656503209536', NULL, '', '', 2, '2025-05-30 04:17:04', '2025-05-30 04:17:04'),
(88, '110615078229468432506', NULL, '010818316', 'Hello, world!', 2, '2025-05-30 06:33:04', '2025-05-30 07:03:41'),
(89, '108410952512424132644', NULL, '', '', 2, '2025-05-30 08:01:52', '2025-05-30 08:01:52'),
(90, '112856655077603959648', 1, '123456789', 'Junior at Paragon International University with experience in full-stack web development, covering both Front-end and Back-end. Experienced in all stages of web development, from concept to deployment, with background in programming languages such as C++ and Python. I am a determined problem solver, passionate about taking on new challenges and expanding my expertise in Web Development, ICT Solutions, and Multimedia.\r\n\r\nAside from development projects, I’m also a freelance digital artist. I create character illustrations and custom artwork for small businesses, and fellow art enthusiasts. I am deeply interested in applying creative and artistic ideas into my development work; blending both technical skills and artistic vision.', 2, '2025-05-30 08:04:12', '2025-05-30 08:33:49'),
(91, '118098064367283271535', NULL, '016805280', 'I am CS major and I like AI', 2, '2025-05-30 15:31:24', '2025-05-31 16:43:10'),
(92, '103796364275165575202', NULL, '', '', 2, '2025-05-31 03:42:39', '2025-05-31 03:42:39'),
(93, '103436675094644153654', NULL, '', '', 2, '2025-05-31 05:51:24', '2025-05-31 05:51:24'),
(94, '118402940873463506267', NULL, '093792693', 'I am awesome and I knew it.', 2, '2025-05-31 05:56:47', '2025-05-31 06:03:12'),
(95, '111975347209826473061', 1, '077225811', 'I am student at paragon major in computer science.', 2, '2025-05-31 06:47:35', '2025-05-31 06:49:57'),
(96, '112540488722621950947', NULL, '', '', 2, '2025-05-31 07:30:25', '2025-05-31 07:30:25'),
(97, '102071898084888450385', 1, '095926526', 'retest', 1, '2025-05-31 09:38:58', '2025-05-31 09:40:22'),
(98, '104528518324137756996', NULL, '', '', 2, '2025-05-31 12:03:28', '2025-05-31 12:03:28'),
(99, '109929528358657444072', NULL, '', '', 2, '2025-05-31 14:54:21', '2025-05-31 14:54:21'),
(100, '113456994043230592967', 1, '015548340', '🏳️‍⚧️🏳️‍⚧️🏳️‍⚧️', 1, '2025-06-01 02:59:56', '2025-06-01 03:02:59'),
(101, '105749826662890121756', 1, '0123456789', 'I\'m a god', 2, '2025-06-01 06:50:42', '2025-06-01 06:52:10'),
(102, '111097408531013640252', 1, '081558479', 'Year 4 Comp-Sci Student at Paragon International University', 1, '2025-06-01 06:54:15', '2025-06-01 06:55:21'),
(103, '105361487265780981862', 1, '', '', 2, '2025-06-01 06:58:37', '2025-06-01 06:58:37'),
(104, '101463281501466010459', 1, '', '', 2, '2025-06-01 07:26:46', '2025-06-01 07:26:46'),
(105, '110318519372219231972', 1, NULL, '\\', 2, '2025-06-01 07:27:04', '2025-06-01 07:32:12'),
(106, '114031057129221542789', 1, '095656234', 'John Doe', 1, '2025-06-01 08:10:37', '2025-06-01 08:14:48'),
(107, '100600337465530178542', 1, NULL, 'Junior Computer Science student at Paragon International University with over one year of hands-on experience as a WordPress developer. Passionate about building clean, functional websites, editing creative videos, and working effectively in team environments.', 2, '2025-06-01 09:46:36', '2025-06-01 09:48:59'),
(108, '113201655955790775496', 1, '', '', 2, '2025-06-01 12:24:49', '2025-06-01 12:24:49'),
(109, '107213801914141063838', 1, '', '', 2, '2025-06-01 14:18:19', '2025-06-01 14:18:19'),
(110, '116784175348453711353', 2, NULL, 'Hii.', 1, '2025-06-01 14:59:38', '2025-06-01 15:00:09'),
(111, '105512814150697617580', NULL, '', '', 2, '2025-06-01 16:07:13', '2025-06-01 16:07:13'),
(112, '107298935129324919069', 1, '089874400', 'I am a senior majoring in Computer Science', 1, '2025-06-02 01:20:39', '2025-06-02 01:21:59'),
(113, '107115742061888715994', 1, NULL, 'I am heree', 1, '2025-06-02 07:59:33', '2025-06-02 08:02:48'),
(114, '111680111370746628196', 1, NULL, 'hello', 2, '2025-06-02 08:10:51', '2025-06-02 08:11:55'),
(115, '102941384540875068611', 1, '111111111', 'test', 1, '2025-06-02 11:43:13', '2025-06-02 11:52:28'),
(116, '117392974911690747338', 2, '011660884', 'MIS', 1, '2025-06-02 14:34:19', '2025-06-02 14:35:47'),
(117, '102448098227121592728', 1, '', '', 2, '2025-06-02 15:17:42', '2025-06-02 15:17:42'),
(118, '113556364386504517312', 1, '', '', 2, '2025-06-03 06:23:46', '2025-06-03 06:23:46'),
(119, '107330600687878643134', NULL, '', '', 2, '2025-06-03 06:41:22', '2025-06-03 06:41:22'),
(120, '106199674194179636945', 1, NULL, 'I love working', 1, '2025-06-10 23:35:53', '2025-06-10 23:39:21');

-- --------------------------------------------------------

--
-- Table structure for table `programming_languages`
--

CREATE TABLE `programming_languages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `programming_language` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `programming_languages`
--

INSERT INTO `programming_languages` (`id`, `programming_language`, `created_at`, `updated_at`) VALUES
(1, 'Python', '2025-04-22 15:11:45', '2025-04-22 15:11:45'),
(2, 'Java', '2025-04-22 15:24:17', '2025-04-22 15:24:17'),
(3, 'PHP', '2025-04-22 15:52:35', '2025-04-22 15:52:35'),
(4, 'C++', '2025-04-24 06:53:20', '2025-04-24 06:53:20'),
(5, 'Laravel', '2025-04-24 06:53:20', '2025-04-24 06:53:20'),
(6, 'JavaScript', '2025-04-26 06:33:24', '2025-04-26 06:33:24'),
(7, 'TypeScript', '2025-04-27 14:55:32', '2025-04-27 14:55:32'),
(8, 'Assembly', '2025-05-12 07:03:26', '2025-05-12 07:03:26'),
(9, 'Next.js', '2025-05-26 14:47:51', '2025-05-26 14:47:51'),
(10, 'LMDB (Lightning Memory-Mapped Database)', '2025-05-28 07:15:41', '2025-05-28 07:15:41'),
(11, 'Svelte', '2025-05-28 15:35:06', '2025-05-28 15:35:06'),
(12, 'CorelDRAW', '2025-05-29 06:58:24', '2025-05-29 06:58:24'),
(13, 'Adobe Photoshop', '2025-05-29 06:58:24', '2025-05-29 06:58:24'),
(14, 'Adobe Illustrator', '2025-05-29 06:58:24', '2025-05-29 06:58:24'),
(15, 'Pen and Pencil', '2025-06-02 08:51:45', '2025-06-02 08:51:45'),
(16, 'Hand Drawing', '2025-06-02 08:51:45', '2025-06-02 08:51:45'),
(17, 'Canva', '2025-06-02 08:51:45', '2025-06-02 08:51:45'),
(18, 'Whitespace', '2025-06-02 11:46:39', '2025-06-02 11:46:39'),
(19, 'UserTesting', '2025-06-02 11:46:39', '2025-06-02 11:46:39');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `portfolio_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `instruction` longtext DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `programming_language_id` int(11) DEFAULT NULL,
  `project_visibility_status` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `portfolio_id`, `title`, `description`, `instruction`, `link`, `file`, `programming_language_id`, `project_visibility_status`, `created_at`, `updated_at`) VALUES
(20, 42, 'POS System', 'test', 'Project instruction here', 'http://example.com', 'projects/PuTzlK7Fnu8aMPlkKBv7JJnQkTG23gPoQj6PEy8E.zip', 2, 0, '2025-04-22 08:33:29', '2025-04-22 08:33:29'),
(21, 42, 'Updated Project Title', 'Updated Description', 'Updated Instruction', 'https://example.com/demo', NULL, 1, 0, '2025-04-22 08:46:58', '2025-04-23 09:10:08'),
(27, 42, 'lol', 'Project description here', 'Project instruction here', 'http://example.com', 'projects/sPhxRGHHgfRUuIK54MTGNRXCXdGm01gFRHmn2uiu.zip', 2, 0, '2025-04-23 15:42:23', '2025-04-23 15:42:23'),
(29, 42, 'Updated Project Title', 'Updated project description.', 'Follow these updated instructions.', 'https://example.com/project', 'projects/1745676495_test.zip', 3, 1, '2025-04-26 14:02:01', '2025-04-26 14:08:15'),
(41, 48, 'ly', 'ly', '<p><strong>ly</strong></p>', 'http://localhost:3000/yourportfolio', 'projects/ASBLAL2u54H0Lzp2rT3De8MAcW7LN6B2Ujh1olBk.html', 1, 0, '2025-04-29 16:14:09', '2025-04-29 16:14:09'),
(51, 59, 'Signicate', 'asdfasdfasf', '<p>asdfsdfsdfsdfs</p>', 'sfadsfsad/asfsafasd', 'projects/Ufs7EkrLRfUirBesx5wgkbC4hgGnhsS8q9oAazrw.pdf', 4, 0, '2025-05-12 06:53:39', '2025-05-12 06:53:39'),
(61, 49, 'Khmer ChatGPT', 'Khmer Chatgpt', '<ol><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>Log in with ur email and password.</strong></li><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span>go to talenthub.com</li></ol>', 'talenthub.com', NULL, 1, 0, '2025-05-16 06:45:16', '2025-06-18 15:23:53'),
(62, 66, 'TalentHub Project', 'TalentHub is A Web Platform for ParagonIU ICT Students to Create and Explore Academic and Career Portfolios.', 'Login to talenthub', 'https://example.com/project', NULL, NULL, 0, '2025-05-25 16:19:21', '2025-05-26 14:35:28'),
(63, 64, 'TalentHub', 'A Web Platform for ParagonIU ICT Students to Create and Explore Peers’ Academic and Career Portfolios', '<ol><li data-list=\"ordered\"><span class=\"ql-ui\" contenteditable=\"false\"></span>Login with your PIU email.</li><li data-list=\"ordered\"><span class=\"ql-ui\" contenteditable=\"false\"></span>Go to your portfolio page to make your portfolio.</li><li data-list=\"ordered\"><span class=\"ql-ui\" contenteditable=\"false\"></span>Share your portfolio to gain more attraction.</li><li data-list=\"ordered\"><span class=\"ql-ui\" contenteditable=\"false\"></span>Enjoy!!!!</li></ol>', 'https://talenthub-liart.vercel.app/', NULL, 6, 0, '2025-05-26 04:35:13', '2025-06-13 06:24:45'),
(64, 45, 'Game Man ta', 'Jumping Game', '<p>Jumping jump jump</p>', 'ot prab', 'projects/nENOBUw0paD7j5VtHZ6vWIXtEiA7vENmnfHsLRU9.png', NULL, 0, '2025-05-27 07:33:42', '2025-05-27 07:33:42'),
(65, 54, 'https://localhost:3000', 'mmm', '<p>lkkljklj</p>', NULL, 'projects/1748416574_FYP-Drawing.zip', 1, 0, '2025-05-28 07:15:41', '2025-05-28 07:16:14'),
(66, 73, 'AStar Pathfinding Algorithm Visualizer', 'A Visualizer for the algorithm', '<p># Project URL</p><p>https://eavlongsok-a-star.netlify.app</p><p># create-svelte</p><p><br></p><p>Everything you need to build a Svelte project, powered by [`create-svelte`](https://github.com/sveltejs/kit/tree/master/packages/create-svelte).</p><p><br></p><p>## Creating a project</p><p><br></p><p>If you\'re seeing this, you\'ve probably already done this step. Congrats!</p><p><br></p><p>```bash</p><p># create a new project in the current directory</p><p>npm create svelte@latest</p><p><br></p><p># create a new project in my-app</p><p>npm create svelte@latest my-app</p><p>```</p><p><br></p><p>## Developing</p><p><br></p><p>Once you\'ve created a project and installed dependencies with `npm install` (or `pnpm install` or `yarn`), start a development server:</p><p><br></p><p>```bash</p><p>npm run dev</p><p><br></p><p># or start the server and open the app in a new browser tab</p><p>npm run dev -- --open</p><p>```</p><p><br></p><p>## Building</p><p><br></p><p>To create a production version of your app:</p><p><br></p><p>```bash</p><p>npm run build</p><p>```</p><p><br></p><p>You can preview the production build with `npm run preview`.</p><p><br></p><p>&gt; To deploy your app, you may need to install an [adapter](https://kit.svelte.dev/docs/adapters) for your target environment.</p>', 'https://github.com/eavlongs/AStar-Algorithm-Visualizer', NULL, 11, 0, '2025-05-28 15:35:06', '2025-05-28 15:39:03'),
(67, 77, 'My Portfolio.', 'My portfolio showcases my experiences and case studies.', '<p>This portfolio, based in Cambodia, is a comprehensive showcase of my <u>experiences</u> and <u>detailed case studies </u>involving real-time clients. It highlights the skills and expertise I have developed through hands-on projects and collaborations within the industry. Each case study provides insights into the challenges faced, strategies implemented, and results achieved, demonstrating my ability to deliver effective solutions in real-world scenarios. This portfolio reflects my dedication and growth as a Graphic Designer. Click <strong>🔗</strong> <strong>Visit Project</strong> to see more of my works in detail.</p>', 'https://t.me/Blue_design_base_in_cambo', 'projects/OWc2W3kl7GsVi32nXxpKHpPE3empKqldOElXm8oI.pdf', 12, 0, '2025-05-29 06:34:54', '2025-05-29 14:37:08'),
(68, 88, 'International Student Management System', 'International Student Management System', NULL, NULL, NULL, 2, 0, '2025-05-30 06:49:33', '2025-05-30 06:50:52'),
(70, 77, 'Tenzero Mild Feminine Wash (Product poster)', 'These are the posters that represent the product call Tenzero Mild Feminine Wash.', '<p>Posters are a powerful tool on social media—they grab attention, quickly deliver your message, boost brand recognition, and make your business look professional and share-worthy.</p><p><br></p><p><strong style=\"background-color: rgb(255, 255, 255); color: oklch(0.373 0.034 259.733);\">Click: 🔗Visit Project</strong><span style=\"background-color: rgb(255, 255, 255); color: oklch(0.373 0.034 259.733);\"> to see more of my works in detail.</span></p><p><strong style=\"color: oklch(0.373 0.034 259.733); background-color: rgb(255, 255, 255);\">Click: ⬇️ Download </strong><span style=\"color: oklch(0.373 0.034 259.733); background-color: rgb(255, 255, 255);\">to view the </span><em style=\"color: oklch(0.373 0.034 259.733); background-color: rgb(255, 255, 255);\"><u>Tenzero Mild Feminine Wash.</u></em></p>', 'https://t.me/Blue_design_base_in_cambo', 'projects/0H35ZKxEl51GN5hc5EhpC8avGC6JB35TdGkWUa5z.pdf', 12, 0, '2025-05-31 07:46:50', '2025-05-31 09:00:30'),
(71, 100, 'LiftNote', 'hzzzzz', '<p>read the readme in the repo</p>', 'https://github.com/Sivtheng/LiftNote', NULL, NULL, 0, '2025-06-01 03:06:25', '2025-06-01 03:06:25'),
(72, 77, 'Byzantine Empire (World Building Project)', 'This is a World building project from Digital Art and Design Department during Midterm Exam.', '<p>🔷<em> Click</em> 🔗 <strong>Visit Project</strong> <em>to view my World Building project.</em></p><p>________________________________________________________________</p><p><br></p><p>My world building project is base on my Imagination inspire from The <strong>great Roman Empire. </strong>especially, during the Byzantine empire (The west roman). But the story isn\'t following real life history of the roman empire. I only borrow some name from the great king and commander at that time.</p><p><br></p><p>It\'s appear to my interest to put different historical figures in the same time line.</p><p><br></p><p><strong>The UNITUS Tree</strong>, name comes from Unity. And using Vis fruit is the source of electricity for military purpose, I got this idea from referencing The giant tree from the movie <em>Avatar </em>and <em>Iron man</em>.</p><p><br></p><p>Everything is hand-drawn using pencil and paper.</p><p>By: ChanPanha Serey.</p>', 'https://www.canva.com/design/DAGgEMinswc/0I_IfmJbJxEr2DSFIjvFRQ/view?utm_content=DAGgEMinswc&utm_campaign=designshare&utm_medium=link2&utm_source=uniquelinks&utlId=h7ef16e5629', NULL, 15, 0, '2025-06-02 08:51:45', '2025-06-02 09:06:02'),
(76, 64, 'FYP', 'hello world', '<ol><li data-list=\"bullet\"><span class=\"ql-ui\" contenteditable=\"false\"></span><strong>zzzz <em>xcxdcc sdsds<u>csdfsf</u></em></strong></li></ol>', NULL, 'projects/GDfOZ8SK6y1zYEwpKk0whGvtrDGRan25FIqwMxpz.pdf', 9, 0, '2025-06-23 06:15:31', '2025-06-23 06:15:31');

-- --------------------------------------------------------

--
-- Table structure for table `project_collaboration_statuses`
--

CREATE TABLE `project_collaboration_statuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_collaboration_statuses`
--

INSERT INTO `project_collaboration_statuses` (`id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Pending', '2025-03-31 03:10:33', '2025-03-31 03:10:33'),
(2, 'Approved', '2025-03-31 03:10:33', '2025-03-31 03:10:33'),
(3, 'Declined', '2025-03-31 03:10:33', '2025-03-31 03:10:33'),
(4, 'Banned', '2025-03-31 03:10:33', '2025-03-31 03:10:33');

-- --------------------------------------------------------

--
-- Table structure for table `project_collaborators`
--

CREATE TABLE `project_collaborators` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` int(11) NOT NULL,
  `user_id` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_collaborators`
--

INSERT INTO `project_collaborators` (`id`, `project_id`, `user_id`, `created_at`, `updated_at`) VALUES
(5, 12, '109256411017728322719', '2025-05-01 11:21:22', '2025-05-01 11:21:22'),
(6, 12, '116476710830297179900', '2025-05-01 11:21:22', '2025-05-01 11:21:22'),
(9, 48, '116476710830297179900', '2025-05-05 06:58:42', '2025-05-05 06:58:42'),
(21, 12, '105112392647691820585', '2025-05-12 04:22:52', '2025-05-12 04:22:52'),
(24, 12, '115609318949887683531', '2025-05-26 03:16:50', '2025-05-26 03:16:50'),
(26, 49, '115609318949887683531', '2025-05-26 04:03:49', '2025-05-26 04:03:49'),
(27, 47, '115609318949887683531', '2025-05-26 04:27:10', '2025-05-26 04:27:10'),
(28, 61, '115609318949887683531', '2025-05-26 14:25:47', '2025-05-26 14:25:47'),
(29, 63, '105664580476841290147', '2025-05-26 14:48:04', '2025-05-26 14:48:04'),
(30, 64, '105664580476841290147', '2025-05-27 07:35:09', '2025-05-27 07:35:09');

-- --------------------------------------------------------

--
-- Table structure for table `project_collaborator_invitation_statuses`
--

CREATE TABLE `project_collaborator_invitation_statuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` int(11) NOT NULL,
  `collaborator_id` varchar(100) NOT NULL,
  `project_collab_status_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_collaborator_invitation_statuses`
--

INSERT INTO `project_collaborator_invitation_statuses` (`id`, `project_id`, `collaborator_id`, `project_collab_status_id`, `created_at`, `updated_at`) VALUES
(5, 12, '109256411017728322719', 1, '2025-05-01 11:21:22', '2025-05-01 11:21:22'),
(6, 12, '116476710830297179900', 1, '2025-05-01 11:21:22', '2025-05-01 11:21:22'),
(9, 48, '116476710830297179900', 2, '2025-05-05 06:58:42', '2025-05-05 06:58:42'),
(24, 12, '115609318949887683531', 2, '2025-05-26 03:16:50', '2025-05-26 03:16:59'),
(26, 49, '115609318949887683531', 2, '2025-05-26 04:03:49', '2025-05-26 04:03:53'),
(27, 47, '115609318949887683531', 2, '2025-05-26 04:27:10', '2025-05-26 08:15:39'),
(28, 61, '115609318949887683531', 2, '2025-05-26 14:25:47', '2025-05-26 14:26:08'),
(29, 63, '105664580476841290147', 2, '2025-05-26 14:48:04', '2025-05-26 14:48:10'),
(30, 64, '105664580476841290147', 2, '2025-05-27 07:35:09', '2025-05-27 07:35:24');

-- --------------------------------------------------------

--
-- Table structure for table `project_endorsement_statuses`
--

CREATE TABLE `project_endorsement_statuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` int(11) NOT NULL,
  `endorsement_status_id` int(11) NOT NULL,
  `endorser_id` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_endorsement_statuses`
--

INSERT INTO `project_endorsement_statuses` (`id`, `project_id`, `endorsement_status_id`, `endorser_id`, `created_at`, `updated_at`) VALUES
(4, 12, 1, '109256411017728322719', '2025-04-30 08:41:50', '2025-04-30 08:41:50'),
(5, 12, 1, '1156', '2025-04-30 08:49:33', '2025-04-30 08:49:33'),
(7, 12, 1, '116476710830297179900', '2025-04-30 09:46:00', '2025-04-30 09:46:00'),
(9, 48, 1, '116476710830297179900', '2025-05-05 07:00:05', '2025-05-05 07:00:05'),
(10, 47, 1, '116476710830297179900', '2025-05-08 15:21:51', '2025-05-08 15:21:51'),
(16, 61, 2, '116476710830297179900', '2025-05-27 07:30:56', '2025-05-27 07:31:55'),
(19, 63, 2, '118098064367283271535', '2025-06-18 15:48:44', '2025-06-18 15:48:58'),
(20, 61, 2, '118098064367283271535', '2025-06-18 15:53:36', '2025-06-18 15:53:41');

-- --------------------------------------------------------

--
-- Table structure for table `project_endorsers`
--

CREATE TABLE `project_endorsers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` int(11) NOT NULL,
  `user_id` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_endorsers`
--

INSERT INTO `project_endorsers` (`id`, `project_id`, `user_id`, `created_at`, `updated_at`) VALUES
(4, 12, '109256411017728322719', '2025-04-30 08:41:50', '2025-04-30 08:41:50'),
(5, 12, '1156', '2025-04-30 08:49:33', '2025-04-30 08:49:33'),
(7, 12, '116476710830297179900', '2025-04-30 09:46:00', '2025-04-30 09:46:00'),
(9, 48, '116476710830297179900', '2025-05-05 07:00:05', '2025-05-05 07:00:05'),
(10, 47, '116476710830297179900', '2025-05-08 15:21:51', '2025-05-08 15:21:51'),
(16, 61, '116476710830297179900', '2025-05-27 07:30:56', '2025-05-27 07:30:56'),
(19, 63, '118098064367283271535', '2025-06-18 15:48:44', '2025-06-18 15:48:44'),
(20, 61, '118098064367283271535', '2025-06-18 15:53:36', '2025-06-18 15:53:36');

-- --------------------------------------------------------

--
-- Table structure for table `project_images`
--

CREATE TABLE `project_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_images`
--

INSERT INTO `project_images` (`id`, `project_id`, `image`, `created_at`, `updated_at`) VALUES
(5, 18, 'project_images/5xjlCWRGcVDyu1kmc0D2msRuinUqSMJISKT6Jkm6.jpg', '2025-04-22 08:18:00', '2025-04-22 08:18:00'),
(6, 19, 'project_images/3cd8FNqxUFiNvRg0U47UWav8UGX90kQEDIEH0lfn.jpg', '2025-04-22 08:33:21', '2025-04-22 08:33:21'),
(7, 20, 'project_images/jgaajv13LezA5IzwxRPtohAhucsLAFpg1jFiaEWE.jpg', '2025-04-22 08:33:29', '2025-04-22 08:33:29'),
(8, 20, 'project_images/zhnZ8V1c6S2yCEeQk5WXxGBzuDx4OV7SI80nOpIf.jpg', '2025-04-22 08:33:29', '2025-04-22 08:33:29'),
(14, 22, 'project_images/nPm54O82iasDU8IX0UBTal3F05Xj4ELhjB6QquXP.jpg', '2025-04-22 15:11:45', '2025-04-22 15:11:45'),
(15, 22, 'project_images/oojBL58Ntbynz7hfg2WAbrwnAwrGYRH3Q6vQ0rlI.jpg', '2025-04-22 15:11:45', '2025-04-22 15:11:45'),
(16, 23, 'project_images/djns5xcYhwKEE3pi3DZbtvF4adLqNjksQeVmMfRO.jpg', '2025-04-22 15:12:57', '2025-04-22 15:12:57'),
(17, 23, 'project_images/lyv4ZFoj7PquU6MgbQl4HgbWS4Aeow5tQeIXExx7.jpg', '2025-04-22 15:12:57', '2025-04-22 15:12:57'),
(18, 24, 'project_images/caljkJC73qh1nbYS2Wg6LXKiG6mksHlCjJLx0d3l.jpg', '2025-04-22 15:24:17', '2025-04-22 15:24:17'),
(19, 24, 'project_images/JZ4AOridnfVItS7M6J0gLrMh7qyH3wlxmAWN3hL0.jpg', '2025-04-22 15:24:17', '2025-04-22 15:24:17'),
(21, 25, 'project_images/h6dmNoWqUBv1YJXys2X2j6liG0uswmdU3Snlgfrb.jpg', '2025-04-22 15:47:42', '2025-04-22 15:47:42'),
(22, 25, 'project_images/5UsqaIsQSN9nv9Kcvl4KdMT4Il3D1YsaFwTC1jWw.jpg', '2025-04-22 15:47:42', '2025-04-22 15:47:42'),
(25, 26, 'project_images/PeKDBNinYQeBzmCSeLMINrPtVcVfpdQPIUQmvnzF.jpg', '2025-04-23 09:10:24', '2025-04-23 09:10:24'),
(26, 26, 'project_images/s678HLZkOmiJ9FBwa2VtetFzq1P2CqseqrU4hOlw.jpg', '2025-04-23 09:10:24', '2025-04-23 09:10:24'),
(27, 27, 'project_images/GmCkqiMoHizYDQC9PF6hWANtNaf2W8LB0GRSkYMv.jpg', '2025-04-23 15:42:23', '2025-04-23 15:42:23'),
(28, 27, 'project_images/izE0eoHcJbWao6ThCh2fCrmzTSyybhct7ujVVrn5.jpg', '2025-04-23 15:42:23', '2025-04-23 15:42:23'),
(34, 29, 'project_images/TbXDwH1BvN6lyOuUfYXx3AY6bS8OFNSGNoc0Y7M7.jpg', '2025-04-26 14:02:01', '2025-04-26 14:02:01'),
(35, 29, 'project_images/u2HTSrwmJYQdD3uR74MDxQubpRZorJjFVuocOxqm.jpg', '2025-04-26 14:02:01', '2025-04-26 14:02:01'),
(36, 29, 'project_images/rpTpU0khER2XQcIK10Ywznm0huijhNlzr2tmAOx0.jpg', '2025-04-26 14:02:49', '2025-04-26 14:02:49'),
(69, 41, 'project_images/oGbRg7XoALqlygkMIFEf1nrSMHTakfsFkzKxYKCB.png', '2025-04-29 16:14:09', '2025-04-29 16:14:09'),
(70, 41, 'project_images/LTekFB6xd0Cpflk3LhT7Z529242usW0vg6Ef1m0E.png', '2025-04-29 16:14:09', '2025-04-29 16:14:09'),
(126, 61, 'project_images/J1UTEi2HBt2ScqV6bOs52pK1N6ogZpqmaB5NaQUW.jpg', '2025-05-26 14:45:44', '2025-05-26 14:45:44'),
(127, 64, 'project_images/4RQd0U0ZWbK8CrteI9WqUdbOIfipaW20kMmA0V0U.png', '2025-05-27 07:33:42', '2025-05-27 07:33:42'),
(128, 65, 'project_images/UHDGgb7H9j7CfcnFDSEW7u6BBeRfHVQvzxUFxPDJ.png', '2025-05-28 07:16:04', '2025-05-28 07:16:04'),
(129, 65, 'project_images/EMioP7nk5DSdHGsdxisqwmLPXtfE10TJhf5kdD1B.png', '2025-05-28 07:16:04', '2025-05-28 07:16:04'),
(130, 65, 'project_images/iILTHlTxLateql659BLo5VRGjyHpArYl6qIEU5LG.png', '2025-05-28 07:16:04', '2025-05-28 07:16:04'),
(133, 66, 'project_images/e25YcoY0MnnMh6D4YzXGT7TfVCqhhwC7tcOuB6bu.png', '2025-05-28 15:39:03', '2025-05-28 15:39:03'),
(140, 67, 'project_images/vACx6NzYO02BEK20AHM9yTT1F6mWO3UxEIQDl27f.png', '2025-05-29 14:37:08', '2025-05-29 14:37:08'),
(142, 70, 'project_images/DiJ3zK2zr97AYICa1islZSdSQ0aIndKMJMUahq2i.png', '2025-05-31 08:58:51', '2025-05-31 08:58:51'),
(143, 72, 'project_images/BiPVT1QVzvieDQjFsy5EqlI5GgUjy3Froz7Pb1QL.png', '2025-06-02 08:51:45', '2025-06-02 08:51:45');

-- --------------------------------------------------------

--
-- Table structure for table `project_languages`
--

CREATE TABLE `project_languages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` int(11) NOT NULL,
  `programming_language_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `project_languages`
--

INSERT INTO `project_languages` (`id`, `project_id`, `programming_language_id`, `created_at`, `updated_at`) VALUES
(1, 24, 2, '2025-04-22 15:24:17', '2025-04-22 15:24:17'),
(2, 25, 2, '2025-04-22 15:47:42', '2025-04-22 15:47:42'),
(22, 21, 1, '2025-04-23 09:10:08', '2025-04-23 09:10:08'),
(30, 26, 1, '2025-04-23 09:33:30', '2025-04-23 09:33:30'),
(31, 27, 2, '2025-04-23 15:42:23', '2025-04-23 15:42:23'),
(56, 28, 3, '2025-04-26 06:48:24', '2025-04-26 06:48:24'),
(57, 28, 6, '2025-04-26 06:48:24', '2025-04-26 06:48:24'),
(70, 29, 3, '2025-04-26 14:08:15', '2025-04-26 14:08:15'),
(71, 29, 6, '2025-04-26 14:08:15', '2025-04-26 14:08:15'),
(72, 30, 5, '2025-04-26 15:51:49', '2025-04-26 15:51:49'),
(73, 31, 1, '2025-04-26 15:56:20', '2025-04-26 15:56:20'),
(74, 32, 2, '2025-04-26 16:02:26', '2025-04-26 16:02:26'),
(75, 33, 6, '2025-04-26 16:04:15', '2025-04-26 16:04:15'),
(76, 34, 6, '2025-04-26 16:06:57', '2025-04-26 16:06:57'),
(77, 35, 6, '2025-04-26 16:08:16', '2025-04-26 16:08:16'),
(78, 36, 1, '2025-04-26 16:08:57', '2025-04-26 16:08:57'),
(79, 37, 1, '2025-04-27 14:47:21', '2025-04-27 14:47:21'),
(80, 38, 1, '2025-04-27 14:54:02', '2025-04-27 14:54:02'),
(81, 39, 7, '2025-04-27 14:55:32', '2025-04-27 14:55:32'),
(82, 40, 6, '2025-04-27 15:00:03', '2025-04-27 15:00:03'),
(83, 40, 2, '2025-04-27 15:00:03', '2025-04-27 15:00:03'),
(84, 41, 1, '2025-04-29 16:14:09', '2025-04-29 16:14:09'),
(85, 42, 1, '2025-04-29 16:24:28', '2025-04-29 16:24:28'),
(86, 43, 1, '2025-04-29 16:31:41', '2025-04-29 16:31:41'),
(87, 44, 7, '2025-04-29 16:32:32', '2025-04-29 16:32:32'),
(88, 45, 1, '2025-04-29 16:33:46', '2025-04-29 16:33:46'),
(89, 46, 1, '2025-04-29 16:39:57', '2025-04-29 16:39:57'),
(144, 48, 3, '2025-05-09 17:45:41', '2025-05-09 17:45:41'),
(145, 48, 6, '2025-05-09 17:45:41', '2025-05-09 17:45:41'),
(155, 50, 1, '2025-05-12 04:05:40', '2025-05-12 04:05:40'),
(156, 51, 4, '2025-05-12 06:53:39', '2025-05-12 06:53:39'),
(157, 52, 5, '2025-05-12 06:55:56', '2025-05-12 06:55:56'),
(158, 53, 4, '2025-05-12 06:57:38', '2025-05-12 06:57:38'),
(159, 54, 1, '2025-05-12 06:59:49', '2025-05-12 06:59:49'),
(160, 55, 1, '2025-05-12 07:01:00', '2025-05-12 07:01:00'),
(161, 56, 1, '2025-05-12 07:01:10', '2025-05-12 07:01:10'),
(162, 57, 1, '2025-05-12 07:01:23', '2025-05-12 07:01:23'),
(163, 58, 1, '2025-05-12 07:01:45', '2025-05-12 07:01:45'),
(164, 59, 1, '2025-05-12 07:02:41', '2025-05-12 07:02:41'),
(165, 60, 8, '2025-05-12 07:03:26', '2025-05-12 07:03:26'),
(209, 47, 4, '2025-05-26 14:34:10', '2025-05-26 14:34:10'),
(239, 61, 1, '2025-05-26 14:45:44', '2025-05-26 14:45:44'),
(240, 61, 6, '2025-05-26 14:45:44', '2025-05-26 14:45:44'),
(253, 65, 1, '2025-05-28 07:16:14', '2025-05-28 07:16:14'),
(254, 65, 10, '2025-05-28 07:16:14', '2025-05-28 07:16:14'),
(255, 65, 6, '2025-05-28 07:16:14', '2025-05-28 07:16:14'),
(256, 65, 4, '2025-05-28 07:16:14', '2025-05-28 07:16:14'),
(259, 66, 11, '2025-05-28 15:39:03', '2025-05-28 15:39:03'),
(287, 67, 12, '2025-05-29 14:37:08', '2025-05-29 14:37:08'),
(288, 67, 13, '2025-05-29 14:37:08', '2025-05-29 14:37:08'),
(289, 67, 14, '2025-05-29 14:37:08', '2025-05-29 14:37:08'),
(290, 68, 2, '2025-05-30 06:49:33', '2025-05-30 06:49:33'),
(293, 69, 12, '2025-05-31 07:39:58', '2025-05-31 07:39:58'),
(294, 69, 13, '2025-05-31 07:39:58', '2025-05-31 07:39:58'),
(299, 70, 12, '2025-05-31 09:00:30', '2025-05-31 09:00:30'),
(300, 70, 13, '2025-05-31 09:00:30', '2025-05-31 09:00:30'),
(322, 72, 15, '2025-06-02 09:06:02', '2025-06-02 09:06:02'),
(323, 72, 16, '2025-06-02 09:06:02', '2025-06-02 09:06:02'),
(324, 72, 17, '2025-06-02 09:06:02', '2025-06-02 09:06:02'),
(325, 73, 18, '2025-06-02 11:46:39', '2025-06-02 11:46:39'),
(326, 73, 19, '2025-06-02 11:46:39', '2025-06-02 11:46:39'),
(331, 63, 6, '2025-06-13 06:24:45', '2025-06-13 06:24:45'),
(332, 63, 9, '2025-06-13 06:24:45', '2025-06-13 06:24:45'),
(333, 63, 3, '2025-06-13 06:24:45', '2025-06-13 06:24:45'),
(334, 63, 5, '2025-06-13 06:24:45', '2025-06-13 06:24:45'),
(335, 75, 6, '2025-06-16 16:01:43', '2025-06-16 16:01:43'),
(336, 76, 9, '2025-06-23 06:15:31', '2025-06-23 06:15:31');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role`, `created_at`, `updated_at`) VALUES
(1, 'Student', '2025-03-24 23:30:56', '2025-03-24 23:30:56'),
(2, 'Endorser', '2025-03-24 23:30:56', '2025-03-24 23:30:56'),
(3, 'Administrator', '2025-03-24 23:30:56', '2025-03-24 23:30:56');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(191) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('02mqZbAbaNc91YqqxrFUur20A6Q7JfxGNM0OWBkq', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ1R4TWJ5Ykk1d3U1Y2FvUkNHa2p4WVA5Z3hPVlZncmFIYjZRMkNrZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660371),
('0IGDENl1WDJ6Fm5sxr03a0TJIN9lbuIhnMnI0qTT', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVkhGT1dvaGpzM25Cbm51SmhudEhMd2FHVERZbzFjamJBRWtoOWZkOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660365),
('0oHfbr9uFAxLxCLQc9juySmqEOfLjrHuvg8qpwe8', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWTR4Y1hBanVHWG5TeFkxMGc2T09ROHFwN3V2SmVoS2N0bXFMdzBkNCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750662026),
('0Uypn7XjoEVAv5yytiMtgn6He415XZJrITSim1bn', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaHZSVEIyODNjRFg4ZXVsSHZXOWpMOGxzTnNJRnlLVjdWMzRSQjdtYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660408),
('0xji8fH0urTJdl7no3m1kjY2MDXMMlWKQcHVMSaR', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQUtwb1pxUEl2RHJIWDhXQjhTRVdrZHZka1BKZlZYVm1MNWRERVg5VyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660271),
('17qzyVl8USMXLU5NIZ03giYAaFL3iGtTlrN6Fzc4', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTTdFUUxQMUo0U3BIdWthMHh1MENBMVh2NU9qd2VlTG82VGNMdkxjMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660126),
('1GSgRn9qobEP4Rn1cOZi0Q3fsy6ygcUQxt4WLb9e', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidGptcGZLMkNkQnBNaHRUTlFjMjAyRERQdTlXZzlLS0R6S3lneDUzSCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659516),
('1xuKp9r9l0FvcIdjo9Mtl47roCC8nZwJVNLcppij', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ1R0eldCSFdCbzBBZk9VVGVvTGlxdG9WcThlSkhnWGRqVlBzU2pXZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660122),
('25z5v0hsFswESRe0UNGSGh5sI8nZQckTrRDugC39', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMmJDSW1ycEh5TmN0RDNhdW5QMEx1Y1dWV0IzbDg4VHBwbTRPQ3E1YSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660222),
('2Brd1OdW8COKgZesWXrGb9fEuiynA17aRytDqmej', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicFBBUGQxMzUzVVBzbk05NDIwNUdHMlRZSlZKQzdtZlRsM3BYZEdBUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659853),
('2jBKryQa0mrufbNs76Dyjvz4ocSTYBvirQBYIEoL', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid1JvTmxXRFlyREpBNnExNzlTcnRuaWJ0MXFJaWZ2ak5Rb2FLa1c1aiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659540),
('2K4uOxMLHJxB0zTigcapwHSzQrjQpxnBkkYorEDJ', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR09iVXIyTGJ4NEZzektkWXZQUWpRNU9RZTliYm9KZVFtN0lvazVwNCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660165),
('2RLKIQNxwzuDya4sEoBlpaQSS7UsicqxzeojD5EW', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSndGM0NVUjRSblZZV2RlM3pqNjNvdzk2WXJuVzFiQjVMNnFnSnF1WCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660404),
('2sFipH2CfYcRabc4j2PwyXY8sXKqiSddHU4ZS5EU', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibEd6Z2sxWGMwVDZSRHNFNGxPNWNuVXp2aW9iOXlzQVBpOTgxamJMZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660347),
('2TArensE5gCHZAkeMrk55UFpr297XTl305trTwQZ', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidUx6V3JsZHFzcXJLMnhVUWtPUW1tZW90dWRzWTVmeU02cFphUnl6OCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660379),
('2yMzCySTcOY6o7m25swt8aIkkjcdDVLoRZHC51aU', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibllLZXQ0bldPb1NZdWxuSW5LbDVRTk5Uc2FHWVlnWFhGOElEYjJFQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660287),
('3sRw3OxZkbwvBEYqNFGRNEhWqsOO2MJLTFrHY3UP', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMDdJT1Njd1VQZk1JWUhlMnBjcldka2ZBODlYd01EYzFMNVc1aEFoTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660275),
('3Z2DUBOgdCa8eh7o1uILrbPw7p1Ck087xsBozO1D', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZWh0bUthYm5Sb2hpYjNLR25TSGlGUHhkNzBlRWNLell5YUpVc1BuQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660405),
('4bZ2rpdVd5iRZedCmw0RwD8cLrZOJ7z5IVqikuZZ', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieDdQekpuMmo2TzZhR1J6Y3J0RVZzdUxOR2RCWXZjZ0c5RmJWVGx1cSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660232),
('4om8bi818RzRhKvPNBuRviXeMLIFhtfhUVhSTyDE', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib2lyMTBlUlRQUDRZWUxJZVM0eXZLeXJYM0gwVWVVbmVDUWxIbFZkcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659936),
('4v6M6gp6jl9DA3jXINvWbeC3uJoAGiFExMTrwJpW', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUGd6TXg2UlJ3TzNVN1pXenNEOG81cExEMkpWcW5hbjE3R2cyUVBNRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659516),
('50QLBpMQeL4UoeUN3alBg4tUUy042Z05GCSgM0SM', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNlpHRmhTSWFhWWRMN1NWTXYxUzA4ZmF0SFNOT1JrN0d0ZUxFUWs2QiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660236),
('5IMfSZBI4OI7KrpsPySC7eka6TEGRZV6PcD3QXkg', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUFAxbWgyZGxQTG1Lc3pHRjRmbm5oSVU4VzAxWkxHV0hKamQ0ODJ5aCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660271),
('5ISDY9TQCTEly2xHq3JmTIQygmlctTlkeazUSBNQ', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR1VZSU5Ycm83NThiWnByNmVacVp1T0pGS2xNZnM2R2VjdWhtVExuaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660236),
('5iZJO4U61kGR8gWbYQu1ylXTEO5RpZaKf0YGorEw', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUEtLVXZwOXhZWUVZNWFZc3RhcEFoNGdoT2NDeXNUOW04NVJzVDZnUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660356),
('6Mx9cvXZHsfilEQVrzmqeHeMh5MSv2sfVaXryzDe', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicjd5SUNVWDBFTUh6TUFFUzZIcWsycWVjWEhNc3NCYkY0RmNrbHlWcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659682),
('6qsnrEv7ujWTp9yr0XVhhFMQBpEZtNQQrjl6q1YW', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV0gwdnE1SWprbjFhTFFwZ2M3MGV4SkJDRFNXMmEybjd0bjdjZjdjQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660221),
('7VAe7qeSfSs4DJOMywCRibALEKl7KVpwH5eIGY87', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS0h5VktYd0lpOG9YSHZhOHNTU0hJZUJXbGtINHRaYWlONkszYkNFNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660236),
('8Ep1pxVoSqD89EIPwsOkpP9MN5gtrgKJeUivqey7', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN1NXUm1ORmRTTVlHd1RlMjF5bWVMQXpabmJxWEhMeFBYZnhXaTlPdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660408),
('8f0dLYHZZevQV3c4DNsNJPlMDJfsso3muzgoIxg9', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid1hZTXBLZFJPS29MZzVqRkNHREtvTld1WDFqUm1ib3I0RzF2RGc5MyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659499),
('8F6md76hPWhTQAF54T0gDwndI8XUUszMV1yk5Y5k', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZjdaUkprYkZFRFRNbmNXTkZYU1hOOTAyemhpQ2pmWHJ5SHVLS0w0MCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660408),
('8ltKyeowjfp9kbJkLTdXWvNCbg6Sw1OAyEeJeowb', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUVZnNjRCTHFWd2MyRWVIaDdNU3NiQVpReGFiZ3FvMnBUeEVaUDl0cSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660383),
('8LyaNV5rc5rKGNDVq0crXyw4cAqvLXFaWe3mCyq9', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT2E3MVU0V2M3YkNiUzVCSnRFQ01KZTBYdzNBTU5OWWFub2lwTUZ3bCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660317),
('8O9hccxxSFXIpTYUwK1NLhkBBRCkcBq4ZslbVtOG', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidjVXeTl1amZmWnBvWEhvR25Xb0dvS0hWbzlrTE5XbzQ2MHAwYVlZbiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660231),
('93qLmGKpBYZOsx5jvhfgU8jcPMZTKYOV2H587QYO', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYno4bGxHWFdkcmNqdDJoZmxDQ1NpQ1N5UGswWUR2Z0lZVnBqOTFFVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660155),
('9arvLhk0LrSdg402TXAInW2kOPkwCJm2APt8LDc0', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYWRhM1VyelFLUlh0ZWNIYzUwQ3JESUlZWGJRSk02aE5YQTJhRFVuRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660231),
('9Hg2NPAzkpsvs9cX5snNrxoMNVfbB9flp8a5mEiT', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTkNpenlDNFRXRzFXS2Z0bzVoTGk0M09QOHN4Q3FXZTRwYVRsNDRNNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660236),
('9uGhVHGW2v54G8L1GNxlXo6KAZX5jyYx6ZoiYIjx', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR3JsTkQzUEpQek9pWXgyaE5yRUJNcTlrZDlKS0l1UXFTVmxBVU41aSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660130),
('A6moCQdC0zVpezw4SuvuA2eFwP17ubJF9jhGPtGl', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRmRZdU1aNHZ3Z0dCYkx5cjNIYUF2QUhCNlo1REw3eHBqVmxjaTVkZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660335),
('aCq0qGAabyI8kIXnAiPWQOg8xvffYQrzs1AwrxNk', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTFZndDFOaFN5cE1SQ0RjNTgzVjg4bGVkQndtVFJXeGY0WXhiemQ1RCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660292),
('aH84G1BqBVK9P574m9FSzqACDgQ0Hc4FiJkQgqgk', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUkZTSjkyOVUxdmJYRlNqRU1SaVpPeUtDSXpTWkhQRXhRZjBxSXoycyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659448),
('Ajprq3YQ0P649WlUKK3OQvUYnXHUAVuQgVdaCzHu', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQmRIWWZpaXluVXRqTFpmODFjdTJNc3I4MEZRcjZiYTM0bVhIejZhQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660232),
('ajwQZGotBU3f4jXzuyZ4hmqi2nFu5HnChWk3D5FL', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibzhMRURSS0MwSXp1VG40VVFCSTFqczlKb3daQWlWYTI2UThBQXdnNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660287),
('aWJPjyx7fJ9u8jpcEZLD9M1tT3K8xc23pFouDnk4', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaWdjRmNrM2tuM00zTkFQTnBacXg1UVNqa3Vuc2JmTUZ4OTVvZXA2YSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660348),
('B2CU7R2W5kocXHWRaOePTM0bDmGN7Ro5BVuloxBu', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTGtTeUFpeUFrRTN3U09Od1l1RzdUbE9YZFNIcHdORkdHak5rclVNQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660356),
('b53pOSOjVcrVqugp1UbXNE62iykeVRCIlwI2wZE2', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWWJ3cmtrQ0FYdW9UZ21GYUNXcG5LRnNOWTQzajN0OGhpSkZHaFJKMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660223),
('BdTxxccC8KBOelYjx6I5Gr4glnp5zAY5ke3jJsGJ', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoidnM0U05wTFRyNTZCSWg3bjB1c2xiWkJMTnhrdlBsdURQczJUYnBHbCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750659527),
('beVxDnMje50Xxv4qOUCZkAtywjj8IPNZLDAj4yqK', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZmJ0V3gybXV5UExHUU4xanVnYkwxVlFDaXVZZElNNlJPSUpnRk1wTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS92aWV3X2luY29taW5nX2NvbnRhY3QiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750659647),
('Bj02PHgTh8JhBYghm4FJunheGIirSq6LYfzd0Rua', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaWdNRXdrSld4ZnprT2Y1MTFDczBOWEtVc1FOOFZwS0xkNXU3dTF2cCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660406),
('bLMnENLX5NBapqg2xva9btPIODLj9y0cTx80jpcC', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibEJ2bFZTSklvYVFNVUZJYVVYUTJYNThtZ2g3c2hIdWx5RlpqWkVxRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659446),
('BoNmqmi5Ay7D5S4E7O3aseUtvnvueTFHbeQUchGk', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSWpmbmRvNUwyOGlWV01DSGFiNHhWVFRQMlU1V2VpOHBhaVY1Nlc2VSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660401),
('BQ5I8FlOqQ1Axbhf1p7AbUad3q3BJjIhGAfjGwdw', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMWd2WkFtRHlieDZPOHBkdVFvUHdJVllYUUxiQzY1dzQ2RUFCZVo4TyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660212),
('BWO9iheJv87ejAKDtcT4CoPQvzvoa8G9AqBe1lED', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibFhzVlBoM3FaZU9obERoUThVYmNFVDgzdDVKNFY2TnA3dzE3cndIcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659643),
('C0hTtZNJ5DQZcW3enPAYZ6jcJ8IAZ0yuKdHbFSnC', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTEpMMnVobUlTa3pjVDIzZFJZa3ZWWUNtQnRmbUVPbjNKaWNTSUV0UiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660317),
('C0qwABWSoMFswjKdQzVZTiftW3GgLeGr7P6ZvsGS', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYUM1Qm9USUNBUGcwOFI1aVhjakgxSjBDeXFUTTRVRGpzbG1vQURLRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750662033),
('C7l9HvekjApEmfUiLuAk9aQVwipHGJExCVnUGpNl', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoienFLSkVzOFdpVU1EZEs0YlRPVFZ6a01PQnI3d0UyZUF6NW4wbGpjRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660404),
('CAWvEQvXWx5EC1ekd6PYDE6Ii364FRF28tKh0Kun', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib1B2dUJ6S2tlVmJ1bmhuVmhjcWRSajZkOUR6a2FXTUlVWUdielBENyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660400),
('CfPkNgXuBBaCu8PZhaH9gp48cjsPFRliTfxD7SQq', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiemFiaVFJTUlrc1pZMkJMdkxwZG9MY1pZMHRQazJqZUUxczhsM0FCeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660621),
('cIeINLAlmkpM3M1e1wrOu2kKJsSolfKwM2yn8PWl', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSkNtQ1VpdzhWQWlSMlp5TVlKQ2p6STJhMlRzT3E2TjFLVGkyYmU0ZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659527),
('cmi3VHP1k0P87ycNwCMX8NyUpueNe0676RGN0i5X', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieWNSSFFUOFRDVEV0c1hxaVlOQnlIN2hCVmVia1N5anR6RXY1ZURFbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660244),
('cwK1M6z2KDFLlpgQMUv2L10rqMD47RmQrBssrKJG', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR3AzbE5vcUEyOXFVTkNodXMzazd0dVZIdVp4aWYxTUhQd0VBcEE5eSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660231),
('DA6kP1IX3Hrr37QYXm26Sf048iawerxX4ALi5IsQ', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY3ZqMUhoVUZWYzhTNlR6b09TZ3lROGhzUU1NVUFlaHZhTmZyS1FMMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660405),
('dcD5txGlePRpNNHGB1kQ3w8pNvRmXHDVdPs6Ko6s', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUGZjYXlzZFVnSjZwWE9STFc3RGhWYzNYQW9Rb21DbDVSYk9NTG9iaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660378),
('DhoZSCXc3iKQoXFRAfecnWlM5au1EsttBHh2tCUM', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU0o1b3Y1OXVVY05OblFUbk0wMzcxQlhBTXQyUUp4aHZIZWI3SXpXOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660380),
('doSfXEkCpwRlCSHHZqSBGU5F5N7VaAQMxVFR1M8O', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWkx2TWZNQ0NhR0JsTVp4TDhSWjh3MTFOMXMzMmpNNlUzTm5KeWV4SCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660401),
('dQGJWwbbmujbwzp2O8r9dXIc9QY10EjGq0XClo2p', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWmlVODhwWFA2MTQ2NHZNdlh2OVpFaGF3TTN3eVp5TmRaVjdFSkRVeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660338),
('DXqonKogUAVmWyxbGox22SKAfL6B87yYg2jEFr2R', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZEYwTzFmY0cwYkNSQklYb0FEZTVvYnlMZElNZ3VXbWVBYnl3S2VqQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660285),
('DXsChT9kbcDwKITlRKozKGLTRkSxTPfPOyfjWNNq', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOVdzYW9TTW5Sb2pLRmRsR1pSYnVRZ2xTYVNycjVTbzVQb0E2Qjl3YiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660356),
('eboxAIyXOcsUFew6bZgBwlZqhU0w9JxzZOjHFs08', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZVhZOUtHTG9FUzh6TjZFTFJTalBVZXdhV3pZcmt4elNaUXFTbDQ1biI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659490),
('ecTgsP4d7P1nkr7kSkbNrXHAp27NNbc5XKUkDvSm', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN285bmxNVEgyUzlCa01Db29mZUJWbG9xcFZKTjZVRW1KQ2pxU1VldCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660404),
('eDQgCVq5lhwLEWz9363y26nH1tMvc6FP76d2nCUR', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia1FHdVFJZm5yUzRhTXM4anZ4eXRYelo5WWx6NXJwd0NSNXdKVDVOMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750661554),
('EKxZJXnal22wVkJuyzGh8FwBxXIUsDiRAlVdlrWs', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWWFydmo0cGVBSTZucElqTnZvRFRFamdBekZ2Unk0OWt0c1lmVHdmdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660335),
('er7P2MubZLoL70CoVMccYL6qpkayiSnbFmTSR1ae', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWDdYZ2ZpdjBRdWhVUzF5WDFCaDVkTkhzTzhrU09Bc053elVjNDlPWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660356),
('eRDcNZvPJSP8cmLgzVdZJl0XbVcRTyHlcnvIqiUH', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaGJCQXpMdnV5NnhSRVhtZ0EyNmhnVVk5TjRMTkozZ0E5SndhTWl6NiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660364),
('ErYGHIsV6ns76XHi2qJ1P2hrto66vmE4H8IQxEmz', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYVYwWkpBOWlNQzZOVGxxWlllRmtWOTZhU2xmZ3JqRlY4Skk5NVdjaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659682),
('ETcb2iVEsthhF8P8f4PmBba4Azk13HowDl597oY7', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMU9jQk01eFdXdHdCeXI3REFRVzM4V1pjaU1JcVVab1Fwd3lWVWVoaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660271),
('eugpSNMnidSwKKL0wiCzK8rqgm3y8lsioxuNXNWy', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV0lyWEx5RUNZMHpRS2YydGZDM0I0OEp1SWhjWUZudTJzY1VzTU1ueCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660401),
('f6l8vIPn3wOIPK7PxBbr0QffIbskFMwBdXtU02AA', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT0w3eHJUQlNYNWcxME1zck9jWEo0M2JWeXIxaHdyb3B5Q2xJNUFXbCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660126),
('FgKAM7ZfOvps406kUAjZCJVnfqFBmpVyl6pJKjUu', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid2ExTnZuWkNiTE1EQ0Y5czRpM000Q2J0V0MzMDBGdzJWSEdGTHdGTyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660235),
('fGNAC9EN8SROiS5FVE58Xo4Qh0AMb0kC6G7PQMjv', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ1JPeTMxZzBQeFltWWY2SkozZHZlWW05bk95dTBLNkFQakFQQksyViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660235),
('FgwNoGYpa2rsenSGPxqWG2NrOvGB4XFEWJvhbBn5', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieUs1UnZDdzhibFdjeW9vTzdHRUdkaHBkamJyYUZoaHNBNHVjOG5nZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660406),
('fi7uIChEiTPsWmgNwGXAvLKFnQhziN8u7Rs1rhap', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibmxIdEJkbHFxamNvSm5TbzF3MzlDUk85SEY1Qkw1Q3FZaGN1ekdMTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750662158),
('Fkfold7D8SbB5Ghv3uQPGDz2ijOKzD3lgttfDg9S', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWHBCUHlXUlFYaXMya0pWZFRoUVQ3dkRYYkYyN0NFcXZFWk5lcHNudCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660379),
('fKo4KehD5OJK5wnmC2xehTWXuiW8Ycmb82ZgqSLR', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSEQ1TFFIV21EQUw0YWZLaXVrNmdUQXdEMXE5NHRDcjl0V29BRWhsbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660175),
('FO2DGRWLt1mnI0cZgOV5bj5tasoK4TQZnDfFXaXz', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQmpXcDF5NXJPTUNIMTdwZHc5VWhLbzNvaXRtY0lJeHgzSE9Qb0VOYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660222),
('FrNrzHbN3SPsmiLMx0SsvmdMecgMChbZXR5itIhS', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWm92dFF0TGRZZDFpWmtMR3A3czBJNUs1MWRwaFl3c1VtNVVSNkdDMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660357),
('FvGB1HwjOmmAfH5cqmAD2iN0EMQIsyrngoZwg5XB', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQU5xMFo3U1NDZUpvUVFsRXNOT051dDFyWkxwYmJibDVxNFVLNlZIeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660369),
('FvZ66ihpW6kdK5xHBBUVrtEFWyuG0KcDlG6REViw', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNjNXN1ljTEJLMTdjNlBFTjcyZEJLY0pMQlZlY3lXOTV3SnpYQWFMWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660231),
('g2CiDiBrPOUNBMSUP6A58ivsz3FZ4tyPWa47mt2j', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid0lyUERudWpkYm9WWUR6YjNPMFo5SHMzeFhXOEZsZ2FkV3J5QUo2WSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659646),
('GCAxq27DVjcmjKNQPBM4wMULKst25r6PZjwjo7Ql', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid05STXppWmxBdWtPNTUydzBaTlpzZkFLTnFXNGZVTWRlSDVrQmRqdSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660130),
('gi3O8J2nopNWKwf5T9mXlyhFHqVudvYSQpwARNTU', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWEl0MXVMNjA4MmZiUkJDODdoTkFhYmZRUGxYSGRWdWVNbklLZzVJcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750662035),
('HcjdW3lDrOwsx65xoVzsR7nSWqK8H2TLrPTByT2z', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTVlXcVRxMUl0ZTVyWVI3Rzh5dXNoanBkQXI0NFJma2FRRE1zYnZNZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660365);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('hCRcYsFrZueX4tsh57oEXXqH4s3o9DF64LGA69wO', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSjZjbTY4R1dHR3pyYUgzOWxMb09ZQUc0RGc2VjJzd3lrTmFMN0RsaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750662035),
('hF8IclZqugGQIOHUmwLw1pnWj9ZAdg0WeOFO4ebQ', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSkhNREdTQ0ZVUnVndHRzR0FPc0JmT2RLMHd4MFVncWNqbnM5QkZmWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660334),
('Hh2q5JIWQ8OclDiDIzo3G9jW0rbwphy5WjTbSXxo', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieHZYVWhrZFQ3VkdXOVlTb29GTXpIVXZNTkpkcWN1d0t1cUpaV3J5TSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660406),
('Hh5O7JgDvXxqBsN5ar4pCMG4CYzmuPbO3114Dpvi', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoid21JdzNzb3Q3b2hDY1BONUNFaVRJeUhEVUp2VTIwQmozRlFBWUU3WiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659853),
('hxmebwALZNnOysyMDk0mREeqjHTbJSinimGTzUsZ', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibEtLVnBMZnZhWkxPQXVkbkRiU2V1bTdndGM4U3NnR1VHZ0lCQm42UyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660380),
('i5BMqk47cw9AoNtRRhBNpIPYzdE0Bz5hzR7rhG9d', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT3ZXeVQ5Q0l0d2MyYklFRWp5SUpSWXdVbXNRSXc5dUJ3ckpPNDlsZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660317),
('iak8reeuRT9pcv4k1deNZfrHHRGw5Fg3SDjzeI5L', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOXY3Tkt5Q21NMU1TTUZuWEVTWjd4TWFwZ3poVmhuaW42YlNVVmV3VCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS92aWV3X2luY29taW5nX2NvbnRhY3QiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750659647),
('IjJWRYeE5fuS6OPuoLl6ZA6QqOJcWDPMnjYfFqa7', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOWllYnk3M1lkQkN1VlAweU5NWTIyR05HWFBmd2t3bjJHMFFVRGEzayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660371),
('iKUz3CNa7KYf2xPw8JP6hBUuJRCYkaWUlr3ex2fP', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTWpMWVFudGpHT1ZvcEFzRE91QzJ3NWpqcFc5NWNEMExKWGNuUnRhTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660370),
('IMzR54jqr7qKqhWEfpqZepNQdAM09BHyElb9kKwA', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicXZmYTJoZUlPNVhNRFJqYjh0YzZ1Zkw4Wm9LSFlLNEZvODdIWVdaMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660408),
('Ir7DHupoaoPgE78QokcU0weHNmpH5BMRYQsf4RkZ', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidnltMTlrVXdka1pnRDE2YXBwdFNUZjBjUUE5Z21aUG10ZjIyUUx3dCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660366),
('irUn1fwB254vcNAPq2ZAQLOTnk8xnflnkayhT47Y', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTXRLaDBBbzVPWTRscDJ6azJqZzhJUHUyMHdqZExCZHkwTXljNnh6VSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660287),
('ITZISNEUSX2kl1nz6RSpCHD7pjW2QNFi4IgPri4w', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaHZGRm5RNWFHNzRZa2c5VWJ2QVVqc0JzbG9zdzRMN3QxQTRHNHFzTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660348),
('J3AbChke4SFckPESXg30qLKYxzXZ2Azh8ny61OJc', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ2h1ZU9acjB3SnlTaTdTdGRNd3gxWk5YR2Q4VEhqN2hpa3Fnd01RWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659540),
('J7tA6BYHrXauGH6in6PUwa6q8i7UVgOYIEhgPbGZ', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibElRcG9Qc2I5ckE3TEdzc28xa3BzVlpFTWI4QlF5amg1WXBpMFFnMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660337),
('jCvvZ5ssTqOfzboD6B0x4dGBXyuFk6TEBza0PmRE', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQnFyWDQzYzcyRnI5aHdVYVE2T2pScUtFNERWTUo0MmNRT1ZJd3dYQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659853),
('JIdymSBKkkDm9R2WJmfrF0hHESa0gJQFbI08nHoJ', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaXpGTUx2N055NXdnc0FqaXVuQ0l1Z1ZsYUtoZnRhdjB0TncwUmRLWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660408),
('JJmZLPPk5ZB0aEC9Qa3UcB2OLAM7ShLzKMz8fEAQ', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYkpjSlEzWFRmYW12MkdvODhjS0RhYzFoZzdJUzhYTWlCdFFmMmo2QiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660615),
('JQO5BtIepF4VBFuLPbRMWUMuIaqA1RcLJbt6crEs', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOWd1ZnI3MGIwRFB1U0U4dFlzeXFqSERGMEJMeTJxRXVGUVk0dVU5ViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660356),
('JRhF2kxS5S8lNEMRmvwsADrDGrkBWxuPTqgCvu7g', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiekVNeXJXeFhaYlUySEcwU0hJYWVsdDJja3UzTWJBczRPSlNKMEoxOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659500),
('JrOWXUYe4P8gFuSfz5mMtr8Ik2cy9wkWVnf8a5Hq', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiclZxWDlZb2ZHUDFmZEY4QVBuZElPa09PUHYwbFBKYXRtVmU0UWtQciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660272),
('jxiwlmQ7RQSDDmmOx3wfOWkET99J81oAOVq7plJh', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUWttNHJWYjJKTDlkQjEwcXNza0d5NzZ3WWF1SW80N2NiMnBzSURyUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660457),
('K0YQhyIbSQSVw5cecO4UtHXiQwPCkk8Znt9zAGY6', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoibFFwa0dRZW5YNVhqSENWUEVwZ0E1T1hwS0tWRnpMZlR6UVd2UWhrUyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750659539),
('KDuXf0HcVTZW2g44kWww6mhBND5TZ5jjO9FB9GOl', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOFppUnpNVlY1SnZ1VmFsMHR0dFdaak9uejFzTUpjdkFrMDJZeVVXUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660269),
('kjjBocrtTRVJkCwdfcvy5fwSLBbGr9mNRpJ8mqGA', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibDBobTlUcnFMd0pLc0I1OGNhZHU0eWdPVjdYbTFOOWozc1FremlLQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660335),
('KpulNAzxsB6Z8HnfPq7dPw9Jsw43qhr5W1DqL8MV', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUUo1Q0Fib2hUQmJIRWx5ZmdBc2szTFpOa1dVNUdBdDVTV1pVaHlJdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659491),
('KqTY66w9Qi9sKlAxu2WmU0CvoghQ1yCG2fnPDuxi', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTFN5SXFXempUOGxZRHQ2QlhlWFhjRElRNGdmaFVlT2xKU3c3UGNyYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660338),
('KxonXiMaxvJeUBA3iRkSRw9BrR3GbiwXk7PrfClL', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRVVYZEY2eVF3SUhOdHRWNURCa3lqODF3V1BNdElYRzJ1dlRlTWRSYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660356),
('lemFZkVCqTRaVLsTx8jsYeF64fRIVY7dwt6VW770', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMk5kWVZnRG1tazJRb0hOOEp1eHJhUUwxYlNmUjRaQmMycVJqUkphZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659854),
('lkFowP48QLFnuy4CRfzwLH5Jyc4OopJENBmHeiZU', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRjJiVnNCNjY4bDhHbTFqSkJhaXRHeVdWSXM0RFhwZ1BaN2FYQUphMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660338),
('MEhfbBm2q1vAU3nx4TiIIvZfcdoWKIYhuMUlRbwS', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZnhSVzVnczVOZEd1Z0tVbTZ6Y1hjcVl4ajFYbzRwN0JyUW5JaTNGciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660348),
('MhSECC2OxczlQB4FrN8aZ1IMT3kdngjI7404lKE9', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibzNVaTN0QVZVZWFvQ3YxQVJpRmFwaUpIeHRnM1gxMFNqNFFQUkQ2biI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660364),
('MpeQ6gi60zDnwDa0gs4PjyoaEAX036THlc0Bmv7T', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTEJ2cUZrbVdORms0VlBsYXh6SXhOc2xGelhkVVNEMmdnZUJMYTU2VCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659446),
('mvSsc5QM1PFyOed3qFp5zZt99IkJpiEnLVwZauwf', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoialZqb0dPcHB0QzBqbjNTRUtrT1NIZXJhemppenMycVB4OHd5eTlHciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660401),
('myD0aGsT2JCHMaADyGYn136ioyMQcwXppq3fI72Y', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidkNab2FJaUJidEROY2VTdERwOEdEOWF6bmNTRmRkQXJxSm53blNEMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660337),
('n1sV59ZQch8pvQdLCMd5lT0ClD92yqMPwx11yZiu', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieHR5TmNscElqd1JkQjJPMkRJSFFreUk0UTdSNmg1MFAzQ3pLT2NzdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750662156),
('naxZFd6iFajEpkas5XQgRrIezya8yI2Krsx2i5wx', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiS1FjVHNpaGlRam5GQ25CcVpUQVdDYUNDZ3dPOXJSQjZOU05kMzhGSyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750659651),
('NEyC0czVOLpIejiPP6QymBRqv1T2bt8o74scV2yz', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoickNJRWFVWlV1N2NHUUZXMGVRVWRybUFWMHNXRWFqdUExRnVTMjd4WSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750662036),
('nlJIpyUaItUyqoVEX69fa9s3VINNyPly71hG7OgF', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU3VpMU0yZmlBRmtLcjVTS2FhV21LY1I0OWtNdzV2bkJXaUl2MkJNaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660126),
('nZAE27gROwL5UueDJDNTPGb19dg2Im0QmpiBCMqc', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWmtuSnJId3c1QVZDTWFJcG80Nm0yczNKNHFraVo0MDNiZWVwUlB3SiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660220),
('NZQmxf09shy0AiFjhPUC3DhDSr6d3nEFAeOkNzDu', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRzRBVnNxclpoSTc4Z2ZDZTA0ZVRwVk1sUHhWcU8xRDdOSVZVV3NldCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660174),
('O4ccj0ayVAx8oR4Rfy9d2uHnyrRPyW5PuJXYWggb', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOVZuM0d5djJiV2JzdzVjYzkyazhoNzRwMnlmOXJoTzFCQjJ4TmxwMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660317),
('O6uR3pg2JY6DLDcAaCNpMmpQmpCMN3iimBMos9mO', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVE9oRGlYaU9COWkzSkdCeUVUWVFQeGdTSlFibnFUeXdOVnVYdzZHcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659854),
('oEZT9YvdPjFCGLbeoNtHnNWbrbhdZgqCo314ac9A', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMTJWVUtSSmJOYThHRnlGdlN4Um9jMGp0Sk83Y1ltTlRaUWVsY3l2VSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660231),
('p2xiEoCDzHfKviTwjttAQYeeVeBeod9DmHlATEtB', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ3dqZWZWODRuamZ0bWg0a280a25zalJGVWlYZnp5RTZGNkxma3hMNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750662065),
('PA9j2tET1ozJ3FLjIVhOgVO6ewa6K8qKa2SXTzk7', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMk9JcnF6SGh6RlA5ZnIzeU5VMlYwdVNVdkFYQnpiUHFCeHV4cTF2TyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660159),
('PbWWETUB2mJlkboFmQVBOx5lcWh2fCcawrMevWeE', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZVRjNnN5UXRUNzNheGpCbG4zTlRVcUJWckVJOGdYb3F1WmF6b2x1UyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659446),
('pEHn7kUy1ZzWrbKLdXl43tniMFyxfMeaisSBdNVO', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMmRvdzVNMDFEaXRqWE16SHVpa3kxMDhXUVliS1pHTDZOT1M0c01zUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660404),
('PHAQ8Y0SXWX5zXtz7bUd7JzY0AMx5LNtNMljyIWN', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR05XUXBiNmFXdHJOWDhyNk5nTXJwWW94T1A2d3FSSk9WaDI0VVpJMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660404),
('pWipkIx0IBzxkyjNmRRfZtqxqe4tpHjVfLZFhrD7', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWFNzcFdyVmtpMkFKcDdGdFF0bGZna2Z3MlZOUWFUcEljRUNsdXo3NiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660338),
('Q2UwuZVTXsAHUs0KKX17PoN2lDyeP0sMPNXQGhjq', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSUtjMjBlOG5WY0N1SWlBWU13SnJSbGxtdnhnQktPM2xTQ2lzdm1rWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660287),
('q6x5l0tSJ63lGvNeTn7cIiQ03eRDpk5jGe358Eoc', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSWVoS21ZYlB4c2lnZk81a3BoWnE4blduWm8yVFFhbHVza2hqVXRpNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750664602),
('QjMoNBseGea1xzIRw3duXjgARhoSSNiQ8F0n22v9', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRHpiNHdrSzE2bXQwektzbWlybmpDWkg5bllRbEJ3bk1WeXdvemFnNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750662068),
('qmvtu76pvIlJaxBnWpFbivg802DYNgWIZSvifeS5', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidDNERE02WXJYalZaSG50MU5qMERSMklKaVN2YzZlVUJXZEhRQ3FpOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660126),
('qWrej4Tm8vY6rtYytgGNEwLNzDdkESNG0IQR2bWP', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYjRDaUxqYVNGT3NKOG5ycFRxdERsQ3pCOThQc1RiekswNENMMnk1TSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660339),
('qZ6yMgx2SzIe5T9Vhwc7MGx05UIcFAgQaDwVcCT3', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSTFXb0hibTdkQU5oWjgwSmNlczN5VUJzb2xNc0NsSVFZQzR1cVZOVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659516),
('R70hML5JZsC9sj5lVUFQeDUwtuBhSHLwy0kPBKGa', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidlBTSkdiaExkakxyakhMSk9tTDJBd1ZTdWU2Mk1KVTkwcFRSZGVqeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659657),
('RSXfe8IygLBBuvak6UaM26J8utg0UGjRCbCV4Dwm', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOWFtYklSa2twUnc4T1cwTHJvSDNqQllZWGRNYk9rZVlzM0sxNHhtRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660130),
('rXpRL8jg2kBfiWOWdOGjjGmBVqOsisiUpDv91hL4', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoickdwd1V5WjFxcHlCOVFWYUpPZHRINVVvM2pzZFU1eUJYeno1VXJJTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660271),
('RXSaytu3gWX1QJ7LOcmOSanPCRdLPOhjp3b9lo5Y', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTTIxTE45ODBzYnR6TU1LV1h4NzI4SENKNG5zcEM3cTZWaWozSU02bSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659480),
('RZ3dV9CZiHXMqIZkEK4AkM0cSOwbmQGqZOSO04Gf', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWEFveWZMOGVxQVNkc2IzeExsR2hGSHFvQ3pzemVJczExd0FRNG92MyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660292),
('s1tfbuPkVA1Vet41tq2cg9gCcYFN7DpYcApWetk5', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU0ltdU1lY25PZTJhc2hOTmlLUlJwUWd0S3dZWFlXbmtGT0dwMWtmWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660405),
('sDBu3mpC8qKYwSdKNY47Rz379DB51ujhNBRF6RNX', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYWhEUUY3UVllbDBHcjFJT3dCc3dkSXN1RDlZcEFqQU1QMkMwUzRkOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660335),
('SMSjUcPC9h3L00pDVcJ76exrIlphvkVSXUqFQKIg', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidDNZMVZnVWVhSGZqV24xVXJEcnc0ejdHd1dIeUl6Z0hodFgwUThVZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660371),
('sSy5NNvKc0vhL23GX50QBtmsWz395FlLwR4W9OBV', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRzU1TzBUSmRkeTN3S3hCaHVLWGJlazRYRUZWNjZrcjBhU2J0SzR6UCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660379),
('svzddyoA518mcSiWKiPB639aqTwydeYKGekATIU4', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOXQ3SHhPWXBleVV0WHJZbms3SGpwNFpmTWw4eVpDNnQ0MFVPcmQ1YiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660379),
('sW3hb9E6RDdy1o2pC0A7CmuBusFkXsKhsDkw200R', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ1ZUTU91RzM4QXpKMmxENFVtRjdSNThScnhMa2ptZW9VOWVDY1RqVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750662068),
('sXGMbXL0KGcdPZDac6FdFfnpXEEY6CvjBO3asSFO', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibW1aS29SYm9xeXN2SVZOdWNBcjR6REE3a05XTHJyTkJCUGNIM0FyaCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660292),
('t1KuvFaomSRbg7tpOd8sDLbAQxyL2HMFtRp2utA4', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiandoNUw2d1lmM2xOSXM2WmlHNWV6TndZbDc5ZW5DTTVBeXRyMDZ5WiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660348),
('t1OKh7wkxbXNmKUujtFDvwBQvdRerwdPX4uhezEL', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQVJzajVyYlpnNzd4ajU5WEhGT1JRdEJVZjB3Q1NJWWx6QVBmN1NrVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660357),
('TASfo4yTVPyGYrMB5Byjh4FJyT6Wzgv41BZXuTPY', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibnFqZkhwNmxCb2NWVHdqRWRVbjNTVGFlWHhxSGdiMVJ2VENZVXVqMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750662073),
('tn2Kqxgn4gvQLi9gdIaemC983K1XAaD0fpD68gfW', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSVFDRnF1a1NndXJQNjIyTExka2Z6Q2lwNVYzUjFERjg4OHc1VXN4ciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660317),
('tt7qP9rwxcr0PGnlLryi3UMs2nLTDFzJwMS311ju', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNWxlM1BnY1ZpZlprSXBVMDhKSGQ0aERVUG83c0tscTVweG1qM29MNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660222),
('tYXURkIcx6jWpjQGtPFHQkKuO6zPKquwsUvy63V6', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYzlqeVk5NFpxcjVBczBoZFdpeDloQzRsYjl1TTM1emVTd2xGZDRUNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660348),
('tz3Wdt9YDBAlPcHlWWeBm3u9gNd3VEThQaoGdPoF', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQTFzMEx4Y3NDRWdYZFNydHJybHV6R21CNFZKNW5FUFFndWZHVzA4SCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660150),
('U3AZDqRbgNZenByS3PiRLqZtzlfVCB5GSSUKphIu', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVmhPOWJQNjViamxqQVJaTE1wVWRuRVJDalg2Q3Z6ck53ZGlZZkU5aiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750662036),
('U3jSjag9eFRIVwedjlqbwjepFN6LJXbIfamh4Mdf', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR1ltUFhNRnphY01ycEc0UWJQeUlDbzg5c2JWNk5aWVNFRDJwTXhzNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660130),
('u7I88dTCDLzrQEhPfuRkQ5XhXKzk7dztlcDHt16e', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiekR5d0xLYWVLdFQ3MEVrMnRxWXBvNEh5Z1BOTUxwNUxUak5DdjNDQiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660428),
('UcWL3L4m4RzwutmLAB8X8OWpzFSlpNsypBp1Hf3Q', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSjhzRmRUMWtuSUJTSlNJWWpLOHFadkFsRjNocXRKS05PdjRnWHZoRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njk6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmF0YSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660309),
('UGDu5rP2YPMGRdfvx6Z3J4an71smTTz1cH5l4zSo', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV1BTS2htZklJdjZnQjRKeHpjVkpuTTdvemZPUlhIdTNrdTVTOVhESyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660338),
('ULx63PDv6y9ryfIFhyAPEvMQc4BuPkDBYpEFNmQk', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYjFDYTNUZkUzWHMySlJMQXNmQ2x4T2t2MVJ5RkhxWnJ1WFFJOGJ1eCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660408),
('uuNzW14IVEQyuy3x79LHzsMxr8qEfPJrl0HirYyU', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibExLMUxHQWhXRzhrRUowUGtjQ0tCQ2lTb043bEhVMktJeFh6OVhYcSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660371),
('VBckQulwUNWjHwVNlJGr6RzNvqZ9l944J6X8T1hB', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSllRZEIwOVdPTW1jenR6TzE5MlZJaHlnQnRMNG1CM0RlMlVOOWQyRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660364),
('vPE9fJsC91rSt9dx7SecTKGzUA50fNvliw61Ts9t', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWkNPRFpRdUpFeGQwTW84bTc4SFpiUnFqN0l5SVdkRElaeG90Vk5XVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660235),
('vrovp7w6jqyU30VQ38Z8fKj83QaqmETtwplqFg5v', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVEhWc2t3b05WTVBLZFh5OTZ4YWJ6QW5UUXVlOE4wTVUwaDhEWGRLWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659500),
('VsQXUN7D9uyUWpX9A0kDIbWOwBHR7jEmZ4eAaYqd', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic2lDeUVnYlVWR09RaUN0VkZvSFdZdEwwZUFwOTlyT2JMN0JMc3ZRViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660271),
('vuqoDuEkEEKmZz3GH1RZns6ZPHMotd2UwFLHYUeK', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZmJzQ05Da05zWDBPSVJQd1VaYUdXYW5QZWZKREhuWGUzdVU3cm9qOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750662065),
('VWndBn557gdBUX6h8lUUzlLujmfKkZr3IfK0BgwJ', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVVZLNjh4bkJSZGluMmRPQnNqUUh5Rmlwd2I0YnQ2S29qdXJCYnBXciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660405),
('vYx2Nmehh6QAHjgecxUIdeQkdZtil08LBpabGOzh', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVVVkTkNwcG9rQ004NGtzbW9kZGxOb3g1QkUzSnBmT1huMEhhZ1dTWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660365),
('WBmYrL69A5EJpjlm9EmBlIvZrP3xlW1aQKFtPr2m', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQU9XS2tweGtiVGY0Ykk5Q2wycVlmNWVITVdLNENjSXE2aVUzRzZ5TSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660623),
('WiUNkKxIlgJCKPjSrl3yalFOlvIssnmnmkeHElG4', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic2d0eGJZZkVwVWFuc0VSN2h6eVE5MEt1OGVPUUN1MHljdWRhMjRrYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750662156),
('WIzq5QksWH5OaRuwtfcPMXdeXwYf8BIQQANJGRo2', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSndCcndBTVgwNU1BMVdrdDd5OEJSOXV0WWEyYlg2WExleGFoT3ZadSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660317),
('WNcIcnnLoS0SvotqFZC9D49w3uibmdkwDsyUPiX0', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTFBuUXlwd2xNQWI4NUdibUpoUlBia0plTDVvdkZYMXJlTXBvU3o2SCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660306);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('wpBaQLszsmEjpLAubQfXdqRNOOlTePwXzKDhh0M1', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQThZVzlYNDExalRMSmliRGZyNUlOdUJ1Sm5RcFpFRVFRYVJtRUpEMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660272),
('wW9yEBC9omsieSfjQvV1c2xID0dV3LUNbMIoQHHo', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTjlpVHNkaDduVnZnQkV1UHFwYjZZR2JsYjBZNk5RN2RKaktBTnk2SiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750662034),
('x24VN1iZwXmsDBQcUHQ4RG3xU75MiYyH8s9eO2Vy', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibEZYdjJOWjVPTVpZUzVqRG9zSzVOOEhhR0drRzlIcFhNWGpKWDRjaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750661555),
('XbWhI902NKpsnZQa67qjUR8LfyrBnaQRkMlQBKTE', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU1BEcDRyS3dKem9YVmRvdTlQU1JIZ0NNSlJYVDVkWFZxWHNhYXVUMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750664604),
('xehbFS01UEBvnk5WjjVs9l7mzfnKOJJmTjuNxCH5', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRDdMQnJLaTlLdGoyRGNtTWRQd21xdmhvR1hKUE1ONVZ6SXJ0bm1BTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659527),
('xH9mnuiDtgRaTINihHhU2tIFwtoelHwWSIxEgAtH', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicHY3VTdmVVJUTzNCV2JEME8wbk9hb2ZadXg4d2lEZWFHU0tHTG13QyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660123),
('XHRf3wnGkuCAJcHJe5gUiw3bQ26IsGERKzIQjtuI', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaFFZYm9EQ2VtbHUzM3IxenlZaTBJQlBQTFlIblpjbnRqYnIxUk1zTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660334),
('XKbFxri2392NFKkHNDCSqAfBTuhr58BdCl7I5bmo', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieEw2TmhtWWhkaEJZbm5nMEZ5ekN0dE1CZzMwUEpDZTlaTUJEeXFqYyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660406),
('xo8x0gqyojIpZQqlQyWtvgwRrTv6Of5kUTGBmmGj', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSzR2SnozR3ZUdUV1ZnBSMEFqdUk2NmVUVGF0dEZNemYydnBRbmJPSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660292),
('XrNhFFgu7Ee47ar6TNHTG1GkwxW04lumuSzSg6m5', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRXFtYnJxQ0xmbElVV2dJeVN2TjFieWxXMDdFYXN4T3ZHbnY2UklKMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660371),
('xVwoHjSV80rcMkCFZVwdXG3xlS4HmjzfS7IWuSpE', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZVJzSU9vSFlRTEZmRnNYNlJLZWR6SUM5dkNGZWdSNFJxMkZBNGY5SiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750659491),
('XX4110YWvm5mutm9iK2D1oz2PqdULxpn3O3SjpNS', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibzU1RW00dldoMW45MXJhWlFZQmdqcWJQNlZZRWo1a09FV25ZdTd0QyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660123),
('Yer2DzmXf590c99Y1VTMEoc43P0MtHtm8jBUJBfO', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoidE1vMFBVTnl4a2dId0RYMUpJODZvdE1pbFhiM2FyM2FJaTZoMWJtTSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750659682),
('YGYBZyQRALXK3ylEE702UE9ATm0JWOvzuYJIdUar', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWnludUJlbmJuUHhlQ1dqbklScjFPWFRMbE5oZUx3bGJNMDVYNkJXeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750662157),
('yjNjM5IQoTreBivLvBTpVvCdsx8umpzMwxV2wVqA', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidFNQRkFFT2pmbHpTNE9td2hBQVhHSFJzYUc0d25uZDlRT0N1WlZFViI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660122),
('YNlgizp3GX9sq6qMDqs2lcZC6YWVFIwEIKVgj349', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQWNmU1JMMDRiMHNVV09WYlFYWEVyTW9hZXN2YlhlWWdlMDA0STk3RSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660408),
('yrAqhNSdFU9SeEL9zkNxM6AdkrwiKcwrki1h9HO4', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSktYUU1IYWF0bGNUMTlNRHVsS3hEZHJZQmMxeDVUb2ZubFVNQVRBMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660400),
('ytzXdgZbX6v3hl3hlOqxcUXCFuyVw2zgA4FtgfOy', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidU0wZGpWUWJIVjNUbzcyY0hrUEdwRXU4VDNzR0JmWnBOTWtrMEdKRiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660400),
('yVaXBbQLkNljOpCTeAkNPYQziju3zlWBYcgWhgmM', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM3dtaXB2SFhtSVZXekQ3SUtUalMyTlI1MnJJcmFSZ2dZZGlYRGFJOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660348),
('yYDwZiDKvhf1O6qAGDbu8dIeNDxUsAOtxdghCFd4', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibkF5Nk5heUVYajhibkNNVVhPNjl5bzBLaEpjSFdwZWt2UkFYdnNSMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660130),
('z98dzTiNxBhSgEzAMOm5BC5C6keNJzvGA5qfupkQ', 41, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNnI2dXVwbHNmSklXejZxeWJ5ZmFVNW5DSThTTVBScUt3MVg1Qm5HTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTExNTYwOTMxODk0OTg4NzY4MzUzMSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660371),
('zAmZRinYTgmpDpFYx7Ym0Vv9jgSeJV6hZTsqyuqV', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSFdaTnZoTXN2YVZKMHdQTzlVZ09PVjhIdzB4U2NYWkhxTXI5WFpmVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660317),
('ZfNr2leYqKg1lq7fqsT5JxB6rEXPlny6YnZ5rqs5', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYVQ2QzFkeGlJOXM1ZndINVMwaXBRd1FzSmRGU0c2WVU3dlh0WDU4eCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660334),
('ZnjvG6MlxABfmAgZ2lzNlrRusWbTvfm8y7Rcnssc', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSVo4UVM5YTRYaDZid0s0YzJwelFvRDl0RjIwbnZ0enhTanUxNXBzVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660348),
('ZowM7UUHbz46mGbVBq1JB8gRlbfmoPYnapbeahFV', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia2JYVzFJTWFvcE4xaUZlVkxWNGF0N2VIc29iNGdsT1llNjF1elNGcCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660404),
('zPUuLGX5AVkL8xB3b2WRAYqDKebtNGo5GhxpE1ti', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUDVHMTdQUGtnckZMSU1yNXY3T3ZiRXh1cnpkWkprYndGV2Q0b01obSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750660379),
('ZqD30chSJkii5LFWTB3StgvCTrmqG7OtAVZkXPq8', 55, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV1k5WVVvOUhxTDVsVXpvaWRicmUwWlE2dnlrS3VEVEhScE9ucDBlbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTA0OiJodHRwczovL3RhbGVudGh1Yi5uZXdsaW5rbWFya2V0aW5nLmNvbS9hcGkvdmlld19ub3RpZmljYXRpb24/cGFnZT0xJnVzZXJfZ29vZ2xlX2lkPTEwNTExMjM5MjY0NzY5MTgyMDU4NSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1750662073),
('ZwbPMAEilaHPqUtwy2ThMy61YRnk7M6c2inYNGjp', NULL, '202.62.41.97', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY1MzV1NPWjNmbkxqNXl5a0VVUllETU1GQm9qb3NPYks1RUhVRzY4eCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Njc6Imh0dHBzOi8vdGFsZW50aHViLm5ld2xpbmttYXJrZXRpbmcuY29tL2FwaS9zZWFyY2hfcG9ydGZvbGlvP25hbWU9cmEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750660311);

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `portfolio_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `skills`
--

INSERT INTO `skills` (`id`, `portfolio_id`, `title`, `description`, `created_at`, `updated_at`) VALUES
(160, 40, 'Penetration Testing', 'I enrolled in a course where I studied on how to scan network, and applications.', '2025-04-03 15:32:25', '2025-05-11 06:38:32'),
(162, 49, 'AI Developer', 'I develop AI systems that are related to Khmer NLP and Computer vision.', '2025-05-12 04:45:46', '2025-06-18 15:26:29'),
(163, 59, 'fyp skill', 'kru oy defense', '2025-05-12 06:49:52', '2025-05-12 06:49:52'),
(164, 64, 'Web Development', 'I have studied and build many web projects in school and works.', '2025-05-25 09:11:17', '2025-06-18 15:20:11'),
(165, 67, 'Feed Goose', 'give food to goose', '2025-05-28 08:27:49', '2025-05-28 08:27:49'),
(166, 70, 'Dek C', 'Dek teas c bay', '2025-05-28 13:17:10', '2025-05-28 13:17:10'),
(167, 73, 'hello', 'hi', '2025-05-28 15:51:35', '2025-05-28 15:51:35'),
(168, 77, 'Poster Design & Social Media Advertisement.', 'I design posters for advertisement purpose for different and verity social platform. I also do printing as well. \n(Printing: PVC 6pass, PVC 4pass, Stickers, Standing bord. . .)', '2025-05-29 06:29:11', '2025-05-31 07:12:42'),
(170, 85, 'Laravel', 'PHP framework for frontend and backend development', '2025-05-30 06:49:50', '2025-05-30 06:49:50'),
(171, 77, 'ID-Card & Name-card', 'I design Name Card and ID card that represent your business or individual. If you are an Freelancer like myself in need of ID card to represent yourself, I also do printing as well. Good quality.', '2025-05-31 07:09:12', '2025-05-31 07:29:33'),
(172, 77, 'Brand Identity - Branding Design.', 'Whether you\'re launching a new business or rebranding, I provide complete brand identity design—from logo, color palette, and typography to marketing materials, packaging, and more. Everything you need to present a professional and cohesive brand.', '2025-05-31 07:31:04', '2025-05-31 07:32:21'),
(173, 97, 'awoidjald', 'awdliajwd', '2025-05-31 09:47:21', '2025-05-31 09:47:21'),
(174, 113, 'Eating', 'Eat meat everyday', '2025-06-02 08:01:14', '2025-06-02 08:01:14'),
(175, 115, 'test', 'tttttt', '2025-06-02 11:44:16', '2025-06-02 11:44:21');

-- --------------------------------------------------------

--
-- Table structure for table `skill_endorsement_statuses`
--

CREATE TABLE `skill_endorsement_statuses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `skill_id` int(11) NOT NULL,
  `endorsement_status_id` int(11) NOT NULL,
  `endorser_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `skill_endorsement_statuses`
--

INSERT INTO `skill_endorsement_statuses` (`id`, `skill_id`, `endorsement_status_id`, `endorser_id`, `created_at`, `updated_at`) VALUES
(173, 160, 2, '105112392647691820585', '2025-05-11 06:38:32', '2025-05-11 06:38:42'),
(175, 162, 2, '116476710830297179900', '2025-05-26 14:43:21', '2025-05-26 14:44:37'),
(176, 164, 2, '116973618827169503318', '2025-05-30 04:16:15', '2025-05-30 04:17:26'),
(178, 164, 2, '118402940873463506267', '2025-05-31 06:01:52', '2025-05-31 06:02:19'),
(179, 173, 2, '105112392647691820585', '2025-05-31 09:47:21', '2025-05-31 09:47:30'),
(180, 164, 2, '104528518324137756996', '2025-05-31 12:04:51', '2025-05-31 12:08:00'),
(184, 162, 2, '118098064367283271535', '2025-06-18 15:26:29', '2025-06-18 15:26:35');

-- --------------------------------------------------------

--
-- Table structure for table `skill_endorsers`
--

CREATE TABLE `skill_endorsers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `skill_id` int(11) NOT NULL,
  `user_id` varchar(256) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `skill_endorsers`
--

INSERT INTO `skill_endorsers` (`id`, `skill_id`, `user_id`, `created_at`, `updated_at`) VALUES
(177, 162, '116476710830297179900', '2025-05-26 14:43:21', '2025-05-26 14:43:21'),
(178, 164, '116973618827169503318', '2025-05-30 04:16:15', '2025-05-30 04:16:15'),
(180, 164, '118402940873463506267', '2025-05-31 06:01:52', '2025-05-31 06:01:52'),
(181, 173, '105112392647691820585', '2025-05-31 09:47:21', '2025-05-31 09:47:21'),
(182, 164, '104528518324137756996', '2025-05-31 12:04:51', '2025-05-31 12:04:51'),
(186, 162, '118098064367283271535', '2025-06-18 15:26:29', '2025-06-18 15:26:29');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `google_id` varchar(255) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `name`, `photo`, `google_id`, `role_id`, `status`, `created_at`, `updated_at`) VALUES
(41, 'rduong1@paragoniu.edu.kh', 'Ratanakvisal Duong', 'https://talenthub.newlinkmarketing.com/storage/photos/W64U03s9UnrdF16oDUWqkRZQuWNIsbXLOiibDfsP.png', '115609318949887683531', 1, 1, '2025-03-27 03:13:22', '2025-06-18 16:02:54'),
(46, 'cky2@paragoniu.edu.kh', 'Chhorng Ky', 'https://talenthub.newlinkmarketing.com/storage/photos/8olxxu2D7VVgpwaajqosSCfpY8xaJjy7KVruSC2p.jpg', '116476710830297179900', 1, 1, '2025-04-01 03:19:04', '2025-06-17 15:27:55'),
(47, 'tsuon@paragoniu.edu.kh', 'Thavorak Suon', 'https://talenthub.newlinkmarketing.com/storage/photos/vorak.jpg', '109256411017728322719', 1, 1, '2025-04-01 03:19:10', '2025-06-01 06:59:10'),
(50, 'ccheam@paragoniu.edu.kh', 'Chanphearun Cheam', 'https://talenthub.newlinkmarketing.com/storage/photos/rfAEXSGlc2o7FCoGt2h4cULMKfaEnDYLUuSFA1ah.jpg', '105664580476841290147', 1, 1, '2025-04-01 08:46:59', '2025-05-04 07:31:52'),
(55, 'salduong97@gmail.com', 'Duong RatanakVisal', 'https://talenthub.newlinkmarketing.com/storage/photos/UwckRN8G07AtfnQnc62IKoMmWTihQATtqdKMYp7H.png', '105112392647691820585', 2, 1, '2025-04-30 04:02:48', '2025-06-18 16:07:55'),
(58, 'kthy@paragoniu.edu.kh', 'Kimsongyean Thy', 'https://lh3.googleusercontent.com/a/ACg8ocL4ZgUaTjN2jtmwunNOcHxbIT-qV-hmL3Eyf5RdgLIizlXdEw=s96-c', '111037384532008328218', 1, 1, '2025-05-07 15:30:15', '2025-05-07 15:30:15'),
(59, 'narun.molika11@gmail.com', 'Molika\'s Log', 'https://lh3.googleusercontent.com/a/ACg8ocJfszSEeg36A3SnsAbfvj8cMIx2nZNYurlRHW3PnKgFvsZ6zg=s96-c', '103496679620329732532', 1, 1, '2025-05-07 15:31:26', '2025-05-07 15:31:26'),
(60, 'kduch@paragoniu.edu.kh', 'Kimlux Duch', 'https://lh3.googleusercontent.com/a/ACg8ocIQjRlsZV26pJLutq2eQwaoOA833I4m5pIU9aTZYzFwj-p0Bw=s96-c', '112579669774957438364', 1, 1, '2025-05-12 06:43:23', '2025-05-25 07:22:09'),
(61, 'ukim@paragoniu.edu.kh', 'Usphea Kim', 'https://lh3.googleusercontent.com/a/ACg8ocKrE8guNXPKxkM6JTimic_OU5H7_VM02AApFTws18LGajHRl21n=s96-c', '109689464774317234827', 1, 1, '2025-05-20 04:16:41', '2025-05-25 07:38:51'),
(68, 'lsorkeo@paragoniu.edu.kh', 'Lysa Sorkeo', 'https://lh3.googleusercontent.com/a/ACg8ocIhvkZacvzqDRJTq677E0uqehlaHag8Br831G7FyKXyxDfztihd=s96-c', '100632280883951344419', 1, 1, '2025-05-25 07:54:57', '2025-05-25 09:46:10'),
(69, 'syours@paragoniu.edu.kh', 'Sovannsak Yours', 'https://lh3.googleusercontent.com/a/ACg8ocK0P3Oj3jN4jw0fjQHeKPChYM_2oCFI0O7NBIQ0xs-dET-5fx0W=s96-c', '117923283157965530322', 1, 1, '2025-05-28 08:23:36', '2025-05-28 08:23:36'),
(70, 'ksoth@paragoniu.edu.kh', 'Kimleng Soth', 'https://lh3.googleusercontent.com/a/ACg8ocLsTZJTKQHitzBbb2Sfx5X9EG61N7eupuTGdY99gGr_Yt-r2iV_=s96-c', '113481086482515968867', 1, 1, '2025-05-28 10:34:24', '2025-05-28 10:34:24'),
(71, 'bkem@paragoniu.edu.kh', 'Bunheang Kem', 'https://lh3.googleusercontent.com/a/ACg8ocLViPAZObdEg5WIip8MxigYRGkl-KsMRvdK199OpWe_tGbYDysL=s96-c', '108876146476379244781', 1, 1, '2025-05-28 12:51:43', '2025-05-28 12:51:43'),
(72, 'kseang1@paragoniu.edu.kh', 'Kimsinh Seang', 'https://lh3.googleusercontent.com/a/ACg8ocKgSJz1_3ZTE2XUfzlD7F8iIz5Ag3n_1inVqDxrNS0hQfqJHSk=s96-c', '108167943679095175390', 1, 1, '2025-05-28 13:16:19', '2025-05-28 13:16:19'),
(73, 'obol@paragoniu.edu.kh', 'Oudom Bol', 'https://lh3.googleusercontent.com/a/ACg8ocJm1Gr-Vv96qkWGL773INLsWaTY0JpG4yjiwX5rUrGZ-Kd3uw=s96-c', '100606516072338303383', 1, 1, '2025-05-28 13:47:14', '2025-05-28 13:47:14'),
(74, 'sprom2@paragoniu.edu.kh', 'Sovathara Prom', 'https://lh3.googleusercontent.com/a/ACg8ocKmodUx8VVadvvpBycOgS2I2hriZk2SbS4AWUkWHIp0R8hLwKQc=s96-c', '102455700561975003395', 1, 1, '2025-05-28 15:28:14', '2025-05-28 15:28:14'),
(75, 'esok@paragoniu.edu.kh', 'Eav Long Sok', 'https://lh3.googleusercontent.com/a/ACg8ocJ0WItSUUkzaLDvGa8iA2yb88ytO67eajG6Ycsmuz99pVpVe1Uc=s96-c', '116982373330549749328', 1, 1, '2025-05-28 15:30:28', '2025-05-28 15:30:28'),
(76, 'sdareth@paragoniu.edu.kh', 'Sovithiea Dareth', 'https://lh3.googleusercontent.com/a/ACg8ocKssNjqWdTVtNlmyqSHwri8zK9n3mYezVKyKEicx-oJXUBPmw=s96-c', '105800202714559282436', 1, 1, '2025-05-28 15:59:19', '2025-05-28 15:59:19'),
(77, 'rouk@paragoniu.edu.kh', 'Rithrolendo Ouk', 'https://talenthub.newlinkmarketing.com/storage/photos/NsKng8hOoe1SpFTuVeL2Xa6A23cfFk8Jvz2JHMlc.jpg', '108507708017297844247', 1, 1, '2025-05-29 03:17:30', '2025-05-29 03:21:38'),
(78, 'smeung@paragoniu.edu.kh', 'Sovathvathanak Meung', 'https://talenthub.newlinkmarketing.com/storage/photos/tXmnyrPjBR0yavd78zynUNfMyhJpl7SuKip59BOJ.png', '104431353302662109466', 1, 1, '2025-05-29 03:22:33', '2025-05-29 03:24:28'),
(79, 'cserey@paragoniu.edu.kh', 'Chanpanha Serey', 'https://talenthub.newlinkmarketing.com/storage/photos/5BMcRd66cnvnJSIYm6jCqc55L2IhGiZi3qZMHaKw.png', '117105768751399130157', 1, 1, '2025-05-29 06:06:38', '2025-05-29 06:11:12'),
(80, 'eear@paragoniu.edu.kh', 'Choungpheng Ear', 'https://lh3.googleusercontent.com/a/ACg8ocL6lKFPmDGgjeNaOqffLjzzX1hBKjtmLGqWqrmGPRrOM3lHrg=s96-c', '102710524414998808816', 1, 1, '2025-05-29 06:31:06', '2025-05-29 06:31:06'),
(81, 'schhum@paragoniu.edu.kh', 'Somnang Chhum', 'https://lh3.googleusercontent.com/a/ACg8ocKl5tooDniqKhscS5gJIVIOL-SLVkNXvaFtJWUEO-izEn65FQ=s96-c', '113626584035690878089', 1, 1, '2025-05-29 06:34:38', '2025-05-29 06:34:38'),
(82, 'vathanak110@gmail.com', 'Kosal Vathanak', 'https://talenthub.newlinkmarketing.com/storage/photos/qfE70Oj52kJRPHpEBIMq4bifYJaR1tWPZcJoaR6g.webp', '104616858926155738941', 1, 1, '2025-05-29 13:16:26', '2025-05-29 13:21:20'),
(83, 'lseng3@paragoniu.edu.kh', 'Long Seng', 'https://lh3.googleusercontent.com/a/ACg8ocIz3K4HCjh6BTfmEb9lf1Wj3t-Epqkq4_uAQEQ4U0gZIQYNx84=s96-c', '102216063992337294863', 1, 1, '2025-05-29 13:54:19', '2025-05-29 13:54:19'),
(84, 'bprak@paragoniu.edu.kh', 'Bunlong Prak', 'https://lh3.googleusercontent.com/a/ACg8ocIEyZSNXyqavpW8nx5h7vzu2Sd2HlaaSLTsJsdjW9eUpg_WvA=s96-c', '114272842745434634976', 1, 1, '2025-05-29 15:08:27', '2025-05-29 15:08:27'),
(85, 'shuot1@paragoniu.edu.kh', 'Sok Eng Huot', 'https://lh3.googleusercontent.com/a/ACg8ocLWBjTjw-qU65Gu-HyLEKGgv4pjwm-dCEUOHnOigOYkZ4ZSj6M=s96-c', '118016059024304193772', 1, 1, '2025-05-29 15:17:06', '2025-05-29 15:17:06'),
(86, 'shor1@paragoniu.edu.kh', 'Seakmeng Hor', 'https://lh3.googleusercontent.com/a/ACg8ocJwDoYp9EiXNTQT9kqCakJ2hUz-20hLXS74p1t7ZVZKf4tvBI38=s96-c', '108502640408441251364', 1, 1, '2025-05-29 19:21:35', '2025-05-29 19:21:35'),
(87, 'pvann2@paragoniu.edu.kh', 'Putmonyrath Vann', 'https://lh3.googleusercontent.com/a/ACg8ocLFK7n_lqchYUnvnX7u0aRe7jIgBUPoFb9zQqZV7dgON87twAgo=s96-c', '106315963701207381127', 1, 1, '2025-05-30 04:03:05', '2025-05-30 04:03:05'),
(88, 'lmaningo@paragoniu.edu.kh', 'Laurence Ebeo Maningo', 'https://lh3.googleusercontent.com/a/ACg8ocICAhpr5-KEBj7HEGHS-bl1PtxOTVm7f8742RX0fUYwX837=s96-c', '116973618827169503318', 2, 1, '2025-05-30 04:10:27', '2025-05-30 04:10:35'),
(89, 'sdo1@paragoniu.edu.kh', 'Sophy Do', 'https://lh3.googleusercontent.com/a/ACg8ocLF55k8ffebvXR7I3a9EfKP8xh4WVoxdHX_1EbJZpZz1mrYWgz2=s96-c', '112392944656503209536', 1, 1, '2025-05-30 04:17:04', '2025-05-30 04:17:04'),
(90, 'hlao@paragoniu.edu.kh', 'Haksrun Lao', 'https://talenthub.newlinkmarketing.com/storage/photos/xxElfj4oqnHUNKsC4YA6uT2tovwdGOUp54lMtiGy.png', '110615078229468432506', 2, 1, '2025-05-30 06:33:04', '2025-05-30 07:03:41'),
(91, 'ctry1@paragoniu.edu.kh', 'Chanreach Try', 'https://lh3.googleusercontent.com/a/ACg8ocK7QJXrS-nit3Z-QujbwnG4nctolcF8wno-URVP9dhJdfT3Sg=s96-c', '108410952512424132644', 1, 1, '2025-05-30 08:01:52', '2025-05-30 08:01:52'),
(92, 'cwattanak@paragoniu.edu.kh', 'Chansovisoth Wattanak', 'https://talenthub.newlinkmarketing.com/storage/photos/DHyHTL2ku1HyvjRGmV4wDCTdEjmO2BedmLBhnYsn.gif', '112856655077603959648', 1, 1, '2025-05-30 08:04:12', '2025-05-30 08:33:22'),
(93, 'phearun6600@gmail.com', 'Chanphearun Cheam', 'https://lh3.googleusercontent.com/a/ACg8ocK_J7P7mCxo5906iTLJc3EFvhJzrPFElkgdu5xiR-hzpnQjaKneYA=s96-c', '118098064367283271535', 2, 1, '2025-05-30 15:31:24', '2025-05-30 15:31:24'),
(94, 'auk@paragoniu.edu.kh', 'Amaracaitly Uk', 'https://lh3.googleusercontent.com/a/ACg8ocLRrJMnYy_nq8PpTKkSsoXNqS5i-SL7UCGA3EO8R-ANvuZIOS4=s96-c', '103796364275165575202', 1, 1, '2025-05-31 03:42:39', '2025-05-31 03:42:39'),
(95, 'vseng@paragoniu.edu.kh', 'Vengkim Seng', 'https://lh3.googleusercontent.com/a/ACg8ocLCPL4wsflT0LPEHyC0-y6NteNddXTo3H-NN1wH40mPsLrfwg=s96-c', '103436675094644153654', 1, 1, '2025-05-31 05:51:24', '2025-05-31 05:51:24'),
(96, 'rsreang@paragoniu.edu.kh', 'Rathanak Sreang', 'https://lh3.googleusercontent.com/a/ACg8ocLdeiDf8FtvizSeuhT9VYrwy_31s6adPtYobTjCE083PGZnW7E=s96-c', '118402940873463506267', 2, 1, '2025-05-31 05:56:47', '2025-05-31 05:57:03'),
(97, 'ste1@paragoniu.edu.kh', 'Sopanha Te', 'https://lh3.googleusercontent.com/a/ACg8ocINq7ZlfFuiYwnSPDJMNwjFyKQtHRXNh6-DmuGTX9AoMc0cVA=s96-c', '111975347209826473061', 1, 1, '2025-05-31 06:47:35', '2025-05-31 06:47:35'),
(98, 'songspanha34@gmail.com', 'Dr. Ocean', 'https://lh3.googleusercontent.com/a/ACg8ocIbC8teh5ObCSCYAG3g-PQoCceSclFTKiZAdlYaOy2rgIgNRxhgPQ=s96-c', '112540488722621950947', 1, 1, '2025-05-31 07:30:25', '2025-05-31 07:30:25'),
(99, 'kpen@paragoniu.edu.kh', 'Kolbot Pen', 'https://lh3.googleusercontent.com/a/ACg8ocLPHrQuclUNgYFKnbzG5ZsoXwUNkHWTi_tyiyvp2m0FifkLKqA=s96-c', '102071898084888450385', 1, 1, '2025-05-31 09:38:58', '2025-05-31 09:38:58'),
(100, 'ssin1@paragoniu.edu.kh', 'Sidavid Sin', 'https://lh3.googleusercontent.com/a/ACg8ocJpZENQ2JVRqU3IRPHDBNkr17EZGB-sGEtsZsvUiPo1R_w3r-o=s96-c', '104528518324137756996', 2, 1, '2025-05-31 12:03:28', '2025-05-31 12:03:42'),
(101, 'lseap@paragoniu.edu.kh', 'Lun Seap', 'https://lh3.googleusercontent.com/a/ACg8ocLHfGD7o8brjAoVO0tBPMYXSwvyPMsUb3Jt1I4o_XleT8x_RpO7=s96-c', '109929528358657444072', 1, 1, '2025-05-31 14:54:21', '2025-05-31 14:54:21'),
(102, 'schang@paragoniu.edu.kh', 'Sivtheng Chang', 'https://lh3.googleusercontent.com/a/ACg8ocJ3KKJ4lCSfIw8w1McwC8erzdhJu8P9MRE6CR67kJKBY7AWp-f6=s96-c', '113456994043230592967', 1, 1, '2025-06-01 02:59:56', '2025-06-01 02:59:56'),
(103, 'llim4@paragoniu.edu.kh', 'Ly Sing Lim', 'https://talenthub.newlinkmarketing.com/storage/photos/T4Ws7GRvBN6hrcTv6To4TuxwST1Upngfs8OvUBV5.png', '105749826662890121756', 1, 1, '2025-06-01 06:50:42', '2025-06-01 06:52:10'),
(104, 'hsuy@paragoniu.edu.kh', 'Heng Suy', 'https://lh3.googleusercontent.com/a/ACg8ocIX-fp02T4L8WYkd2rqvjwBI3eGEfw4WTFnSDMkDGWqXCNOUBw=s96-c', '111097408531013640252', 1, 1, '2025-06-01 06:54:15', '2025-06-01 06:54:15'),
(105, 'bzhou@paragoniu.edu.kh', 'Bovisal Zhou', 'https://lh3.googleusercontent.com/a/ACg8ocJUm3yE0CuGje-_uLFIYNKqpF9xSMjXwdIvbjNFQOxhu7UvFQ=s96-c', '105361487265780981862', 1, 1, '2025-06-01 06:58:37', '2025-06-01 06:58:37'),
(106, 'vuch@paragoniu.edu.kh', 'Vongsorya Uch', 'https://lh3.googleusercontent.com/a/ACg8ocIavNFB83gKAVsEEseWYPUEWRMhiO3scIo7M-_DCB1hfNHkc6M=s96-c', '101463281501466010459', 1, 1, '2025-06-01 07:26:46', '2025-06-01 07:26:46'),
(107, 'kkong2@paragoniu.edu.kh', 'Kelwin Kong', 'https://talenthub.newlinkmarketing.com/storage/photos/9Y9JUPDbqIn3hy3J4uOCy4E7BWnBOxwDFlFr7GpH.jpg', '110318519372219231972', 1, 1, '2025-06-01 07:27:04', '2025-06-17 15:28:09'),
(108, 'lsout@paragoniu.edu.kh', 'Lykuoyhay Sout', 'https://lh3.googleusercontent.com/a/ACg8ocJWosT0TvJygB1jEBHCZ6tieDExWk1K_L_CqlZIJL1MVawoWlY=s96-c', '114031057129221542789', 1, 1, '2025-06-01 08:10:37', '2025-06-01 08:10:37'),
(109, 'snov1@paragoniu.edu.kh', 'Seihamonyrath Nov', 'https://talenthub.newlinkmarketing.com/storage/photos/3SkX9qjZCSd8iESaKeUqdQrUNOkFi0uQpCF8by9t.jpg', '100600337465530178542', 1, 1, '2025-06-01 09:46:36', '2025-06-01 09:48:59'),
(110, 'smak1@paragoniu.edu.kh', 'Sammakara Mak', 'https://lh3.googleusercontent.com/a/ACg8ocL3yuQQqqWwmDnCamZHWLcsRB-1g6gyT6IJtm96riZ862Cvs0o=s96-c', '113201655955790775496', 1, 1, '2025-06-01 12:24:49', '2025-06-01 12:24:49'),
(111, 'sheng15@paragoniu.edu.kh', 'Sophavong Heng', 'https://lh3.googleusercontent.com/a/ACg8ocLOvIbay-lhWZzBSEpSgzcfIVLXf14unEE7cblwni_wSuZldfM=s96-c', '107213801914141063838', 1, 1, '2025-06-01 14:18:19', '2025-06-01 14:18:19'),
(112, 'drith@paragoniu.edu.kh', 'Darapong Rith', 'https://lh3.googleusercontent.com/a/ACg8ocI4tw72yZw9unNJhnetEkiiwmstlTk1DTPJLagehDQr290XwKI=s96-c', '116784175348453711353', 1, 1, '2025-06-01 14:59:38', '2025-06-01 14:59:38'),
(113, 'kvyry@paragoniu.edu.kh', 'Kanold Vyry', NULL, '105512814150697617580', 1, 1, '2025-06-01 16:07:13', '2025-06-18 14:42:52'),
(114, 'btang@paragoniu.edu.kh', 'Bunseng Tang', 'https://lh3.googleusercontent.com/a/ACg8ocL75C9RUvADeXaDpt7PJgzOn8GSwqBb09BSxJQDL_fRji9BJQ=s96-c', '107298935129324919069', 1, 1, '2025-06-02 01:20:39', '2025-06-02 01:20:39'),
(115, 'sry@paragoniu.edu.kh', 'Sokleng Ry', 'https://talenthub.newlinkmarketing.com/storage/photos/L29jpjhksRwtkwfLGCTA6ZVK6OHi6QOpfcjzvk4u.jpg', '107115742061888715994', 1, 1, '2025-06-02 07:59:33', '2025-06-02 08:02:48'),
(116, 'csom2@paragoniu.edu.kh', 'Chumvisotdaroth Som', 'https://lh3.googleusercontent.com/a/ACg8ocLyh4eAdYKpa87_cTt5NW6KMiNvhXlFiAvRPshM5wyVocTRNQ=s96-c', '111680111370746628196', 1, 1, '2025-06-02 08:10:51', '2025-06-02 08:10:51'),
(117, 'ohnoneil2024@gmail.com', 'vechaka chhom', 'https://talenthub.newlinkmarketing.com/storage/photos/Lal2mHpQ6LsJE3DJYvYQyqq8dCX9KAzpEjZ8qwZU.png', '102941384540875068611', 1, 1, '2025-06-02 11:43:13', '2025-06-02 11:52:28'),
(118, 'mchhea2@paragoniu.edu.kh', 'Morita Chhea', 'https://lh3.googleusercontent.com/a/ACg8ocITRdbMAj8nFDWu-eXWz3QA5BjFah5uNRdK9inqKLvX_kS2Iw=s96-c', '117392974911690747338', 1, 1, '2025-06-02 14:34:19', '2025-06-17 04:50:17'),
(119, 'schea5@paragoniu.edu.kh', 'Sopheaknita Chea', 'https://lh3.googleusercontent.com/a/ACg8ocJlraeVr2mm_HebVezaanYZV2_zbIBo85WGLOVUtzD6L8QVGjJo=s96-c', '102448098227121592728', 1, 1, '2025-06-02 15:17:42', '2025-06-17 04:44:11'),
(120, 'sly1@paragoniu.edu.kh', 'Sokleng Ly', 'https://lh3.googleusercontent.com/a/ACg8ocKS9UzTbrs_xjEHTUphFU8rUuAMVO25f3wevRrZZ-hOsOn8lA=s96-c', '113556364386504517312', 1, 1, '2025-06-03 06:23:46', '2025-06-03 06:23:46'),
(121, 'pmona@paragoniu.edu.kh', 'Panhaoudom Mona', 'https://lh3.googleusercontent.com/a/ACg8ocKZfCHcM7n3-PF6mC_FWouMWslDkQ70847EgWrabiWDS2E-NuA=s96-c', '107330600687878643134', 1, 1, '2025-06-03 06:41:22', '2025-06-03 06:41:22'),
(122, 'hhuy@paragoniu.edu.kh', 'Headangelly Huy', 'https://lh3.googleusercontent.com/a/ACg8ocKmC0vOlR1Pjzqbr3kIHh9f2NpJOai8mDPg_BxiM-xpBg94xA=s96-c', '106199674194179636945', 1, 1, '2025-06-10 23:35:53', '2025-06-17 15:25:56');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `delete_user_portfolio` AFTER DELETE ON `users` FOR EACH ROW BEGIN
    DELETE FROM portfolios WHERE user_id = OLD.google_id;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `achievements`
--
ALTER TABLE `achievements`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `achievement_endorsement_statuses`
--
ALTER TABLE `achievement_endorsement_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `achievement_endorsers`
--
ALTER TABLE `achievement_endorsers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `education`
--
ALTER TABLE `education`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `endorsement_statuses`
--
ALTER TABLE `endorsement_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `endorser_request`
--
ALTER TABLE `endorser_request`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `experiences`
--
ALTER TABLE `experiences`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `experience_endorsement_statuses`
--
ALTER TABLE `experience_endorsement_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `experience_endorsers`
--
ALTER TABLE `experience_endorsers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `majors`
--
ALTER TABLE `majors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `portfolios`
--
ALTER TABLE `portfolios`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `programming_languages`
--
ALTER TABLE `programming_languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_collaboration_statuses`
--
ALTER TABLE `project_collaboration_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_collaborators`
--
ALTER TABLE `project_collaborators`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_collaborator_invitation_statuses`
--
ALTER TABLE `project_collaborator_invitation_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_endorsement_statuses`
--
ALTER TABLE `project_endorsement_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_endorsers`
--
ALTER TABLE `project_endorsers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_images`
--
ALTER TABLE `project_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_languages`
--
ALTER TABLE `project_languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `skill_endorsement_statuses`
--
ALTER TABLE `skill_endorsement_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `skill_endorsers`
--
ALTER TABLE `skill_endorsers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `achievements`
--
ALTER TABLE `achievements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `achievement_endorsement_statuses`
--
ALTER TABLE `achievement_endorsement_statuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `achievement_endorsers`
--
ALTER TABLE `achievement_endorsers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `education`
--
ALTER TABLE `education`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `endorsement_statuses`
--
ALTER TABLE `endorsement_statuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `endorser_request`
--
ALTER TABLE `endorser_request`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `experiences`
--
ALTER TABLE `experiences`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `experience_endorsement_statuses`
--
ALTER TABLE `experience_endorsement_statuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT for table `experience_endorsers`
--
ALTER TABLE `experience_endorsers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=122;

--
-- AUTO_INCREMENT for table `majors`
--
ALTER TABLE `majors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=785;

--
-- AUTO_INCREMENT for table `portfolios`
--
ALTER TABLE `portfolios`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- AUTO_INCREMENT for table `programming_languages`
--
ALTER TABLE `programming_languages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `project_collaboration_statuses`
--
ALTER TABLE `project_collaboration_statuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `project_collaborators`
--
ALTER TABLE `project_collaborators`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `project_collaborator_invitation_statuses`
--
ALTER TABLE `project_collaborator_invitation_statuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `project_endorsement_statuses`
--
ALTER TABLE `project_endorsement_statuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `project_endorsers`
--
ALTER TABLE `project_endorsers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `project_images`
--
ALTER TABLE `project_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=147;

--
-- AUTO_INCREMENT for table `project_languages`
--
ALTER TABLE `project_languages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=337;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=176;

--
-- AUTO_INCREMENT for table `skill_endorsement_statuses`
--
ALTER TABLE `skill_endorsement_statuses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=185;

--
-- AUTO_INCREMENT for table `skill_endorsers`
--
ALTER TABLE `skill_endorsers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=187;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
