-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 25, 2026 at 06:03 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `post_pulmonary_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts_doctor`
--

CREATE TABLE `accounts_doctor` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `doctor_id` varchar(20) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` varchar(10) NOT NULL,
  `specialization` varchar(200) NOT NULL,
  `name` varchar(200) NOT NULL,
  `profile_image` varchar(100) DEFAULT NULL,
  `reset_otp` varchar(6) DEFAULT NULL,
  `reset_otp_created` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accounts_doctor`
--

INSERT INTO `accounts_doctor` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `doctor_id`, `phone`, `age`, `gender`, `specialization`, `name`, `profile_image`, `reset_otp`, `reset_otp_created`) VALUES
(1, 'pbkdf2_sha256$1000000$KJVF5Jj9ryB9SJgkQnPMB6$jvjT/lYmkioonFzhYJdam2/GEAsN4ugbUtjRP9BAJ/4=', NULL, 0, 'test2', '', '', 'test2@test.com', 0, 1, '2026-03-18 10:33:30.492306', 'd2', '1234', 30, 'M', 'None', 'Test', '', NULL, NULL),
(2, 'pbkdf2_sha256$600000$JJ7ZONEpReXefhIQuFReOY$gROhVZQ53Ab+P2rKEHzRc/LBnY1tSwkjOrZ2BIjz+Ms=', NULL, 0, 'ramsrinivas', '', '', 'gummasrinivas8106@gmail.com', 0, 1, '2026-03-18 10:35:03.796954', 'Doc0001', '9390088908', 22, 'Male', 'Anesthesia', 'Ram Srinivas', 'doctor_profiles/profile.jpg', '280287', '2026-04-24 08:06:22.645390'),
(3, 'pbkdf2_sha256$600000$KVjzbKVJOMLgDNEupFVMYJ$3kuWbaTLRNmYHeIPW1vyg3o7iIEb+028qtZadYiuoFs=', NULL, 0, 'ram', '', '', 'ramsrinivas2004@gmail.com', 0, 1, '2026-04-10 10:18:05.477680', 'Doc0002', '9390088908', 22, 'Male', 'Anesthesiologist', 'Ram Srinivas', '', '830609', '2026-04-10 10:27:21.102405'),
(5, 'pbkdf2_sha256$600000$2AVfBu8OjUGgez9dwSkqT8$4C2//H2whxO7zONm4yy17zZSiGu0RdT2vKantvLm9M0=', NULL, 0, '1Ab', '', '', '1@g.com', 0, 1, '2026-04-24 07:16:36.649801', 'Asasas21212', '0987654321', 120, 'Male', 'General', 'SARA', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `accounts_doctor_groups`
--

CREATE TABLE `accounts_doctor_groups` (
  `id` bigint(20) NOT NULL,
  `doctor_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `accounts_doctor_user_permissions`
--

CREATE TABLE `accounts_doctor_user_permissions` (
  `id` bigint(20) NOT NULL,
  `doctor_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `authtoken_token`
--

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `authtoken_token`
--

INSERT INTO `authtoken_token` (`key`, `created`, `user_id`) VALUES
('22eb69c6fe4b4682ab339d3da4f3da6e8b353b84', '2026-03-18 10:35:07.964714', 2);

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add user', 6, 'add_doctor'),
(22, 'Can change user', 6, 'change_doctor'),
(23, 'Can delete user', 6, 'delete_doctor'),
(24, 'Can view user', 6, 'view_doctor'),
(25, 'Can add patient', 7, 'add_patient'),
(26, 'Can change patient', 7, 'change_patient'),
(27, 'Can delete patient', 7, 'delete_patient'),
(28, 'Can view patient', 7, 'view_patient'),
(29, 'Can add survey', 8, 'add_survey'),
(30, 'Can change survey', 8, 'change_survey'),
(31, 'Can delete survey', 8, 'delete_survey'),
(32, 'Can view survey', 8, 'view_survey'),
(33, 'Can add section score', 9, 'add_sectionscore'),
(34, 'Can change section score', 9, 'change_sectionscore'),
(35, 'Can delete section score', 9, 'delete_sectionscore'),
(36, 'Can view section score', 9, 'view_sectionscore'),
(37, 'Can add answer', 10, 'add_answer'),
(38, 'Can change answer', 10, 'change_answer'),
(39, 'Can delete answer', 10, 'delete_answer'),
(40, 'Can view answer', 10, 'view_answer'),
(41, 'Can add Token', 11, 'add_token'),
(42, 'Can change Token', 11, 'change_token'),
(43, 'Can delete Token', 11, 'delete_token'),
(44, 'Can view Token', 11, 'view_token'),
(45, 'Can add Token', 12, 'add_tokenproxy'),
(46, 'Can change Token', 12, 'change_tokenproxy'),
(47, 'Can delete Token', 12, 'delete_tokenproxy'),
(48, 'Can view Token', 12, 'view_tokenproxy');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(6, 'accounts', 'doctor'),
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(11, 'authtoken', 'token'),
(12, 'authtoken', 'tokenproxy'),
(4, 'contenttypes', 'contenttype'),
(7, 'patients', 'patient'),
(5, 'sessions', 'session'),
(10, 'surveys', 'answer'),
(9, 'surveys', 'sectionscore'),
(8, 'surveys', 'survey');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-03-17 10:47:41.697736'),
(2, 'contenttypes', '0002_remove_content_type_name', '2026-03-17 10:47:41.720340'),
(3, 'auth', '0001_initial', '2026-03-17 10:47:41.807469'),
(4, 'auth', '0002_alter_permission_name_max_length', '2026-03-17 10:47:41.825601'),
(5, 'auth', '0003_alter_user_email_max_length', '2026-03-17 10:47:41.828396'),
(6, 'auth', '0004_alter_user_username_opts', '2026-03-17 10:47:41.831357'),
(7, 'auth', '0005_alter_user_last_login_null', '2026-03-17 10:47:41.834732'),
(8, 'auth', '0006_require_contenttypes_0002', '2026-03-17 10:47:41.835836'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2026-03-17 10:47:41.842070'),
(10, 'auth', '0008_alter_user_username_max_length', '2026-03-17 10:47:41.845266'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2026-03-17 10:47:41.847632'),
(12, 'auth', '0010_alter_group_name_max_length', '2026-03-17 10:47:41.857306'),
(13, 'auth', '0011_update_proxy_permissions', '2026-03-17 10:47:41.860450'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2026-03-17 10:47:41.864609'),
(15, 'accounts', '0001_initial', '2026-03-17 10:47:41.980768'),
(16, 'admin', '0001_initial', '2026-03-17 10:47:42.057707'),
(17, 'admin', '0002_logentry_remove_auto_add', '2026-03-17 10:47:42.061489'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2026-03-17 10:47:42.065092'),
(19, 'authtoken', '0001_initial', '2026-03-17 10:47:42.087112'),
(20, 'authtoken', '0002_auto_20160226_1747', '2026-03-17 10:47:42.102525'),
(21, 'authtoken', '0003_tokenproxy', '2026-03-17 10:47:42.104831'),
(22, 'authtoken', '0004_alter_tokenproxy_options', '2026-03-17 10:47:42.108816'),
(23, 'patients', '0001_initial', '2026-03-17 10:47:42.160184'),
(24, 'sessions', '0001_initial', '2026-03-17 10:47:42.190551'),
(25, 'surveys', '0001_initial', '2026-03-17 10:47:42.304192');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `patients_patient`
--

CREATE TABLE `patients_patient` (
  `id` bigint(20) NOT NULL,
  `patient_id` varchar(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` varchar(10) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `weight` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `bmi` double DEFAULT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `doctor_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients_patient`
--

INSERT INTO `patients_patient` (`id`, `patient_id`, `name`, `age`, `gender`, `phone`, `weight`, `height`, `bmi`, `photo`, `created_at`, `updated_at`, `doctor_id`) VALUES
(1, 'PID0001', 'Sathish', 22, 'Male', '8789988789', 56, 132, 32.14, '', '2026-03-19 02:36:27.393167', '2026-04-10 10:22:07.648019', 2),
(2, 'PID0002', 'Lakshman', 21, 'Male', '7869988678', 57, 231, 10.68, '', '2026-03-19 02:41:22.829887', '2026-03-19 02:41:22.829951', 2),
(3, 'PID0003', 'Vamsi', 32, 'Male', '9478877987', 60, 231, 11.24, '', '2026-03-19 02:43:59.615431', '2026-03-19 02:43:59.615464', 2),
(4, 'PID0004', 'Darby', 23, 'Male', '7868866567', 56, 179, 17.48, '', '2026-03-23 10:24:28.399677', '2026-03-23 10:24:28.399731', 2),
(5, 'PID0005', 'Ram', 45, 'Other', '4158523698', 74, 44, 382.23, '', '2026-03-26 16:05:11.658369', '2026-03-26 16:05:11.658424', 2),
(6, 'PID0006', 'Krishna', 22, 'Male', '9890088765', 53, 234, 9.68, '', '2026-04-01 10:40:02.023947', '2026-04-01 10:40:02.023999', 2),
(7, 'PID0007', 'Sat', 22, 'Male', '9878877656', 45, 231, 8.43, '', '2026-04-03 10:03:43.710844', '2026-04-03 10:03:43.710886', 2),
(10, 'PID0008', 'Rani', 20, 'Female', '8787766786', 45, 211, 10.11, '', '2026-04-10 10:50:20.116827', '2026-04-10 10:50:20.116897', 2),
(12, 'PID0009', 'Ramsey', 45, 'Female', '7678898784', 56, 231, 10.49, '', '2026-04-24 08:29:11.954598', '2026-04-24 08:29:11.954628', 2);

-- --------------------------------------------------------

--
-- Table structure for table `surveys_answer`
--

CREATE TABLE `surveys_answer` (
  `id` bigint(20) NOT NULL,
  `section_name` varchar(200) NOT NULL,
  `question` varchar(255) NOT NULL,
  `selected_option` varchar(255) NOT NULL,
  `score` int(11) NOT NULL,
  `survey_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `surveys_answer`
--

INSERT INTO `surveys_answer` (`id`, `section_name`, `question`, `selected_option`, `score`, `survey_id`) VALUES
(1, 'Patient Demographics', 'Age', 'Age<50', 1, 1),
(2, 'Patient Demographics', 'Sex', 'Male', 1, 1),
(3, 'Patient Demographics', 'Body Mass Index (BMI)', 'BMI<30', 1, 1),
(4, 'Patient Demographics', 'Smoking Status', 'Never', 1, 1),
(5, 'Patient Demographics', 'Alcohol', 'No', 1, 1),
(6, 'Medical History', 'COPD', 'Yes', 1, 1),
(7, 'Medical History', 'Asthma', 'Yes', 1, 1),
(8, 'Medical History', 'OSA', 'Yes', 1, 1),
(9, 'Medical History', 'ILD', 'Yes', 1, 1),
(10, 'Medical History', 'Heart Failure', 'Yes', 1, 1),
(11, 'Medical History', 'CAD', 'Yes', 1, 1),
(12, 'Medical History', 'Hypertension', 'Yes', 1, 1),
(13, 'Medical History', 'Diabetes', 'No', 0, 1),
(14, 'Medical History', 'CKD', 'No', 0, 1),
(15, 'Preoperative Considerations', 'ASA Physical Status', 'II', 2, 1),
(16, 'Preoperative Considerations', 'Exercise tolerance', '<4 METs', 3, 1),
(17, 'Preoperative Considerations', 'Dyspnea at rest', 'Yes', 2, 1),
(18, 'Preoperative Considerations', 'Recent respiratory infection', 'Yes', 2, 1),
(19, 'Preoperative Considerations', 'SpO2', '>=96%', 1, 1),
(20, 'Surgery Factors', 'Type of surgery', 'Thoracic', 3, 1),
(21, 'Surgery Factors', 'Urgency', 'Elective', 1, 1),
(22, 'Surgery Factors', 'Duration', '<2 hours', 1, 1),
(23, 'Surgery Factors', 'Estimated blood loss', '<500 ml', 1, 1),
(24, 'Planned Anesthesia', 'ARISCAT Choice', 'LMA', 2, 1),
(25, 'Planned Anesthesia', 'Ventilation Strategy', 'Low tidal volume', 1, 1),
(26, 'Planned Anesthesia', 'Muscle relaxant use', 'Yes', 2, 1),
(27, 'Planned Anesthesia', 'Planned Analgesia', 'IV opioids', 2, 1),
(28, 'Planned Anesthesia', 'Reversal', 'Neostigmine', 2, 1),
(29, 'Postoperative', 'Planned ICU/HDU admission', 'Yes', 2, 1),
(30, 'Postoperative', 'Anticipated >24h ventilation', 'No', 1, 1),
(31, 'Postoperative', 'Post-op analgesia', 'Opioid heavy', 2, 1),
(32, 'Postoperative', 'Early mobilization within 24h', 'Yes', 1, 1),
(33, 'Patient Demographics', 'Age', 'Age<50', 1, 2),
(34, 'Patient Demographics', 'Sex', 'Male', 1, 2),
(35, 'Patient Demographics', 'Body Mass Index (BMI)', 'BMI<30', 1, 2),
(36, 'Patient Demographics', 'Smoking Status', 'Never', 1, 2),
(37, 'Patient Demographics', 'Alcohol', 'No', 1, 2),
(38, 'Medical History', 'COPD', 'No', 0, 2),
(39, 'Medical History', 'Asthma', 'No', 0, 2),
(40, 'Medical History', 'OSA', 'No', 0, 2),
(41, 'Medical History', 'ILD', 'No', 0, 2),
(42, 'Medical History', 'Heart Failure', 'No', 0, 2),
(43, 'Medical History', 'CAD', 'No', 0, 2),
(44, 'Medical History', 'Hypertension', 'No', 0, 2),
(45, 'Medical History', 'Diabetes', 'Yes', 1, 2),
(46, 'Medical History', 'CKD', 'No', 0, 2),
(47, 'Preoperative Considerations', 'ASA Physical Status', 'I', 1, 2),
(48, 'Preoperative Considerations', 'Exercise tolerance', '<4 METs', 3, 2),
(49, 'Preoperative Considerations', 'Dyspnea at rest', 'No', 1, 2),
(50, 'Preoperative Considerations', 'Recent respiratory infection', 'No', 1, 2),
(51, 'Preoperative Considerations', 'SpO2', '<=90%', 3, 2),
(52, 'Surgery Factors', 'Type of surgery', 'Thoracic', 3, 2),
(53, 'Surgery Factors', 'Urgency', 'Elective', 1, 2),
(54, 'Surgery Factors', 'Duration', '<2 hours', 1, 2),
(55, 'Surgery Factors', 'Estimated blood loss', '<500 ml', 1, 2),
(56, 'Planned Anesthesia', 'ARISCAT Choice', 'Regional', 1, 2),
(57, 'Planned Anesthesia', 'Ventilation Strategy', 'Low tidal volume', 1, 2),
(58, 'Planned Anesthesia', 'Muscle relaxant use', 'Yes', 2, 2),
(59, 'Planned Anesthesia', 'Planned Analgesia', 'Non-opioid/Multimodal', 1, 2),
(60, 'Planned Anesthesia', 'Reversal', 'Neostigmine', 2, 2),
(61, 'Postoperative', 'Planned ICU/HDU admission', 'Yes', 2, 2),
(62, 'Postoperative', 'Anticipated >24h ventilation', 'No', 1, 2),
(63, 'Postoperative', 'Post-op analgesia', 'Opioid heavy', 2, 2),
(64, 'Postoperative', 'Early mobilization within 24h', 'Yes', 1, 2),
(65, 'Patient Demographics', 'Age', 'Age<50', 1, 3),
(66, 'Patient Demographics', 'Sex', 'Male', 1, 3),
(67, 'Patient Demographics', 'Body Mass Index (BMI)', 'BMI<30', 1, 3),
(68, 'Patient Demographics', 'Smoking Status', 'Never', 1, 3),
(69, 'Patient Demographics', 'Alcohol', 'No', 1, 3),
(70, 'Patient Demographics', 'Age', 'Age<50', 1, 4),
(71, 'Patient Demographics', 'Sex', 'Male', 1, 4),
(72, 'Patient Demographics', 'Body Mass Index (BMI)', 'BMI<30', 1, 4),
(73, 'Patient Demographics', 'Smoking Status', 'Never', 1, 4),
(74, 'Patient Demographics', 'Alcohol', 'Yes', 2, 4),
(75, 'Medical History', 'COPD', 'No', 0, 4),
(76, 'Medical History', 'Asthma', 'No', 0, 4),
(77, 'Medical History', 'OSA', 'No', 0, 4),
(78, 'Medical History', 'ILD', 'No', 0, 4),
(79, 'Medical History', 'Heart Failure', 'No', 0, 4),
(80, 'Medical History', 'CAD', 'No', 0, 4),
(81, 'Medical History', 'Hypertension', 'No', 0, 4),
(82, 'Medical History', 'Diabetes', 'No', 0, 4),
(83, 'Medical History', 'CKD', 'No', 0, 4),
(84, 'Preoperative Considerations', 'ASA Physical Status', 'I', 1, 4),
(85, 'Preoperative Considerations', 'Exercise tolerance', '<4 METs', 3, 4),
(86, 'Preoperative Considerations', 'Dyspnea at rest', 'No', 1, 4),
(87, 'Preoperative Considerations', 'Recent respiratory infection', 'No', 1, 4),
(88, 'Preoperative Considerations', 'SpO2', '<=90%', 3, 4),
(89, 'Surgery Factors', 'Type of surgery', 'Orthopedic', 2, 4),
(90, 'Surgery Factors', 'Urgency', 'Elective', 1, 4),
(91, 'Surgery Factors', 'Duration', '<2 hours', 1, 4),
(92, 'Surgery Factors', 'Estimated blood loss', '<500 ml', 1, 4),
(93, 'Planned Anesthesia', 'ARISCAT Choice', 'Regional', 1, 4),
(94, 'Planned Anesthesia', 'Ventilation Strategy', 'Low tidal volume', 1, 4),
(95, 'Planned Anesthesia', 'Muscle relaxant use', 'No', 1, 4),
(96, 'Planned Anesthesia', 'Planned Analgesia', 'IV opioids', 2, 4),
(97, 'Postoperative', 'Planned ICU/HDU admission', 'No', 1, 4),
(98, 'Postoperative', 'Anticipated >24h ventilation', 'No', 1, 4),
(99, 'Postoperative', 'Post-op analgesia', 'Multimodal/Regional', 1, 4),
(100, 'Postoperative', 'Early mobilization within 24h', 'No', 2, 4),
(101, 'Patient Demographics', 'Age', '50>Age<69', 2, 5),
(102, 'Patient Demographics', 'Sex', 'Female', 1, 5),
(103, 'Patient Demographics', 'Body Mass Index (BMI)', 'BMI<30', 1, 5),
(104, 'Patient Demographics', 'Smoking Status', 'Current_smoker', 3, 5),
(105, 'Patient Demographics', 'Alcohol', 'Yes', 2, 5),
(106, 'Medical History', 'COPD', 'No', 0, 5),
(107, 'Medical History', 'Asthma', 'No', 0, 5),
(108, 'Medical History', 'OSA', 'No', 0, 5),
(109, 'Medical History', 'ILD', 'No', 0, 5),
(110, 'Medical History', 'Heart Failure', 'No', 0, 5),
(111, 'Medical History', 'CAD', 'No', 0, 5),
(112, 'Medical History', 'Hypertension', 'No', 0, 5),
(113, 'Medical History', 'Diabetes', 'No', 0, 5),
(114, 'Medical History', 'CKD', 'No', 0, 5),
(115, 'Preoperative Considerations', 'ASA Physical Status', 'I', 1, 5),
(116, 'Preoperative Considerations', 'Exercise tolerance', '<4 METs', 3, 5),
(117, 'Preoperative Considerations', 'Dyspnea at rest', 'Yes', 2, 5),
(118, 'Preoperative Considerations', 'Recent respiratory infection', 'Yes', 2, 5),
(119, 'Preoperative Considerations', 'SpO2', '>=96%', 1, 5),
(120, 'Surgery Factors', 'Type of surgery', 'Others', 1, 5),
(121, 'Surgery Factors', 'Urgency', 'Emergency', 3, 5),
(122, 'Surgery Factors', 'Duration', '<2 hours', 1, 5),
(123, 'Surgery Factors', 'Estimated blood loss', '<500 ml', 1, 5),
(124, 'Planned Anesthesia', 'ARISCAT Choice', 'Regional', 1, 5),
(125, 'Planned Anesthesia', 'Ventilation Strategy', 'Low tidal volume', 1, 5),
(126, 'Planned Anesthesia', 'Muscle relaxant use', 'Yes', 2, 5),
(127, 'Planned Anesthesia', 'Planned Analgesia', 'IV opioids', 2, 5),
(128, 'Planned Anesthesia', 'Reversal', 'Neostigmine', 2, 5),
(129, 'Postoperative', 'Planned ICU/HDU admission', 'No', 1, 5),
(130, 'Postoperative', 'Anticipated >24h ventilation', 'No', 1, 5),
(131, 'Postoperative', 'Post-op analgesia', 'Opioid heavy', 2, 5),
(132, 'Postoperative', 'Early mobilization within 24h', 'Yes', 1, 5),
(133, 'Patient Demographics', 'Age', 'Age<50', 1, 6),
(134, 'Patient Demographics', 'Sex', 'Male', 1, 6),
(135, 'Patient Demographics', 'Body Mass Index (BMI)', 'BMI<30', 1, 6),
(136, 'Patient Demographics', 'Smoking Status', 'Never', 1, 6),
(137, 'Patient Demographics', 'Alcohol', 'No', 1, 6),
(138, 'Medical History', 'COPD', 'No', 0, 6),
(139, 'Medical History', 'Asthma', 'No', 0, 6),
(140, 'Medical History', 'OSA', 'No', 0, 6),
(141, 'Medical History', 'ILD', 'No', 0, 6),
(142, 'Medical History', 'Heart Failure', 'No', 0, 6),
(143, 'Medical History', 'CAD', 'No', 0, 6),
(144, 'Medical History', 'Hypertension', 'No', 0, 6),
(145, 'Medical History', 'Diabetes', 'No', 0, 6),
(146, 'Medical History', 'CKD', 'No', 0, 6),
(147, 'Preoperative Considerations', 'ASA Physical Status', 'I', 1, 6),
(148, 'Preoperative Considerations', 'Exercise tolerance', '<4 METs', 3, 6),
(149, 'Preoperative Considerations', 'Dyspnea at rest', 'No', 1, 6),
(150, 'Preoperative Considerations', 'Recent respiratory infection', 'No', 1, 6),
(151, 'Preoperative Considerations', 'SpO2', '>=96%', 1, 6),
(152, 'Surgery Factors', 'Type of surgery', 'Thoracic', 3, 6),
(153, 'Surgery Factors', 'Urgency', 'Elective', 1, 6),
(154, 'Surgery Factors', 'Duration', '<2 hours', 1, 6),
(155, 'Surgery Factors', 'Estimated blood loss', '<500 ml', 1, 6),
(156, 'Planned Anesthesia', 'ARISCAT Choice', 'Regional', 1, 6),
(157, 'Planned Anesthesia', 'Ventilation Strategy', 'Low tidal volume', 1, 6),
(158, 'Planned Anesthesia', 'Muscle relaxant use', 'No', 1, 6),
(159, 'Planned Anesthesia', 'Planned Analgesia', 'IV opioids', 2, 6),
(160, 'Postoperative', 'Planned ICU/HDU admission', 'No', 1, 6),
(161, 'Postoperative', 'Anticipated >24h ventilation', 'No', 1, 6),
(162, 'Postoperative', 'Post-op analgesia', 'Multimodal/Regional', 1, 6),
(163, 'Postoperative', 'Early mobilization within 24h', 'No', 2, 6),
(164, 'Patient Demographics', 'Age', 'Age<50', 1, 7),
(165, 'Patient Demographics', 'Sex', 'Male', 1, 7),
(166, 'Patient Demographics', 'Body Mass Index (BMI)', 'BMI<30', 1, 7),
(167, 'Patient Demographics', 'Smoking Status', 'Never', 1, 7),
(168, 'Patient Demographics', 'Alcohol', 'Yes', 2, 7),
(206, 'Patient Demographics', 'Age', 'Age<50', 1, 10),
(207, 'Patient Demographics', 'Sex', 'Female', 1, 10),
(208, 'Patient Demographics', 'Body Mass Index (BMI)', 'BMI<30', 1, 10),
(209, 'Patient Demographics', 'Smoking Status', 'Never', 1, 10),
(210, 'Patient Demographics', 'Alcohol', 'No', 1, 10),
(211, 'Medical History', 'COPD', 'Yes', 1, 10),
(212, 'Medical History', 'Asthma', 'Yes', 1, 10),
(213, 'Medical History', 'OSA', 'No', 0, 10),
(214, 'Medical History', 'ILD', 'No', 0, 10),
(215, 'Medical History', 'Heart Failure', 'Yes', 1, 10),
(216, 'Medical History', 'CAD', 'No', 0, 10),
(217, 'Medical History', 'Hypertension', 'No', 0, 10),
(218, 'Medical History', 'Diabetes', 'Yes', 1, 10),
(219, 'Medical History', 'CKD', 'No', 0, 10),
(220, 'Preoperative Considerations', 'ASA Physical Status', 'I', 1, 10),
(221, 'Preoperative Considerations', 'Exercise tolerance', '<4 METs', 3, 10),
(222, 'Preoperative Considerations', 'Dyspnea at rest', 'No', 1, 10),
(223, 'Preoperative Considerations', 'Recent respiratory infection', 'No', 1, 10),
(224, 'Preoperative Considerations', 'SpO2', '91-95%', 2, 10),
(225, 'Surgery Factors', 'Type of surgery', 'Thoracic', 3, 10),
(226, 'Surgery Factors', 'Urgency', 'Elective', 1, 10),
(227, 'Surgery Factors', 'Duration', '2-4 hours', 2, 10),
(228, 'Surgery Factors', 'Estimated blood loss', '500-1000 ml', 2, 10),
(229, 'Planned Anesthesia', 'ARISCAT Choice', 'Regional', 1, 10),
(230, 'Planned Anesthesia', 'Ventilation Strategy', 'PEEP', 2, 10),
(231, 'Planned Anesthesia', 'Muscle relaxant use', 'No', 1, 10),
(232, 'Planned Anesthesia', 'Planned Analgesia', 'Non-opioid/Multimodal', 1, 10),
(233, 'Postoperative', 'Planned ICU/HDU admission', 'Yes', 2, 10),
(234, 'Postoperative', 'Anticipated >24h ventilation', 'No', 1, 10),
(235, 'Postoperative', 'Post-op analgesia', 'Multimodal/Regional', 1, 10),
(236, 'Postoperative', 'Early mobilization within 24h', 'Yes', 1, 10),
(237, 'Patient Demographics', 'Age', 'Age<50', 1, 11),
(238, 'Patient Demographics', 'Sex', 'Male', 1, 11),
(239, 'Patient Demographics', 'Body Mass Index (BMI)', 'BMI<30', 1, 11),
(240, 'Patient Demographics', 'Smoking Status', 'Never', 1, 11),
(241, 'Patient Demographics', 'Alcohol', 'Yes', 2, 11);

-- --------------------------------------------------------

--
-- Table structure for table `surveys_sectionscore`
--

CREATE TABLE `surveys_sectionscore` (
  `id` bigint(20) NOT NULL,
  `section_name` varchar(200) NOT NULL,
  `score` int(11) NOT NULL,
  `survey_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `surveys_sectionscore`
--

INSERT INTO `surveys_sectionscore` (`id`, `section_name`, `score`, `survey_id`) VALUES
(1, 'Patient Demographics', 5, 1),
(2, 'Medical History', 7, 1),
(3, 'Preoperative Considerations', 10, 1),
(4, 'Surgery Factors', 6, 1),
(5, 'Planned Anesthesia', 9, 1),
(6, 'Postoperative', 6, 1),
(7, 'Patient Demographics', 5, 2),
(8, 'Medical History', 1, 2),
(9, 'Preoperative Considerations', 9, 2),
(10, 'Surgery Factors', 6, 2),
(11, 'Planned Anesthesia', 7, 2),
(12, 'Postoperative', 6, 2),
(13, 'Patient Demographics', 5, 3),
(14, 'Patient Demographics', 6, 4),
(15, 'Medical History', 0, 4),
(16, 'Preoperative Considerations', 9, 4),
(17, 'Surgery Factors', 5, 4),
(18, 'Planned Anesthesia', 5, 4),
(19, 'Postoperative', 5, 4),
(20, 'Patient Demographics', 9, 5),
(21, 'Medical History', 0, 5),
(22, 'Preoperative Considerations', 9, 5),
(23, 'Surgery Factors', 6, 5),
(24, 'Planned Anesthesia', 8, 5),
(25, 'Postoperative', 5, 5),
(26, 'Patient Demographics', 5, 6),
(27, 'Medical History', 0, 6),
(28, 'Preoperative Considerations', 7, 6),
(29, 'Surgery Factors', 6, 6),
(30, 'Planned Anesthesia', 5, 6),
(31, 'Postoperative', 5, 6),
(32, 'Patient Demographics', 6, 7),
(40, 'Patient Demographics', 5, 10),
(41, 'Medical History', 4, 10),
(42, 'Preoperative Considerations', 8, 10),
(43, 'Surgery Factors', 8, 10),
(44, 'Planned Anesthesia', 5, 10),
(45, 'Postoperative', 5, 10),
(46, 'Patient Demographics', 6, 11);

-- --------------------------------------------------------

--
-- Table structure for table `surveys_survey`
--

CREATE TABLE `surveys_survey` (
  `id` bigint(20) NOT NULL,
  `total_score` int(11) NOT NULL,
  `risk_level` varchar(50) DEFAULT NULL,
  `status` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `patient_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `surveys_survey`
--

INSERT INTO `surveys_survey` (`id`, `total_score`, `risk_level`, `status`, `created_at`, `patient_id`) VALUES
(1, 43, 'High', 'postoperative', '2026-03-19 02:36:35.905857', 1),
(2, 34, 'Moderate', 'postoperative', '2026-03-19 02:41:32.099224', 2),
(3, 5, 'Low', 'patient_Demographics', '2026-03-19 02:44:12.482183', 3),
(4, 30, 'Moderate', 'postoperative', '2026-03-23 10:24:36.048461', 4),
(5, 37, 'Moderate', 'postoperative', '2026-03-26 16:05:30.363446', 5),
(6, 28, 'Moderate', 'postoperative', '2026-04-01 10:40:22.829817', 6),
(7, 6, 'Low', 'patient_Demographics', '2026-04-03 10:04:35.298139', 7),
(10, 35, 'Moderate', 'postoperative', '2026-04-10 10:50:28.772788', 10),
(11, 6, 'Low', 'patient_Demographics', '2026-04-24 08:29:23.656049', 12);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts_doctor`
--
ALTER TABLE `accounts_doctor`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `accounts_doctor_groups`
--
ALTER TABLE `accounts_doctor_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `accounts_doctor_groups_doctor_id_group_id_27a1b452_uniq` (`doctor_id`,`group_id`),
  ADD KEY `accounts_doctor_groups_group_id_c19eb0a2_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `accounts_doctor_user_permissions`
--
ALTER TABLE `accounts_doctor_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `accounts_doctor_user_per_doctor_id_permission_id_231bbaad_uniq` (`doctor_id`,`permission_id`),
  ADD KEY `accounts_doctor_user_permission_id_4980b691_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD PRIMARY KEY (`key`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_accounts_doctor_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `patients_patient`
--
ALTER TABLE `patients_patient`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_patient_per_doctor` (`doctor_id`,`patient_id`);

--
-- Indexes for table `surveys_answer`
--
ALTER TABLE `surveys_answer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `surveys_answer_survey_id_caa4663c_fk_surveys_survey_id` (`survey_id`);

--
-- Indexes for table `surveys_sectionscore`
--
ALTER TABLE `surveys_sectionscore`
  ADD PRIMARY KEY (`id`),
  ADD KEY `surveys_sectionscore_survey_id_b6cc3ffa_fk_surveys_survey_id` (`survey_id`);

--
-- Indexes for table `surveys_survey`
--
ALTER TABLE `surveys_survey`
  ADD PRIMARY KEY (`id`),
  ADD KEY `surveys_survey_patient_id_9c3c3bf3_fk_patients_patient_id` (`patient_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts_doctor`
--
ALTER TABLE `accounts_doctor`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `accounts_doctor_groups`
--
ALTER TABLE `accounts_doctor_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `accounts_doctor_user_permissions`
--
ALTER TABLE `accounts_doctor_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `patients_patient`
--
ALTER TABLE `patients_patient`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `surveys_answer`
--
ALTER TABLE `surveys_answer`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=242;

--
-- AUTO_INCREMENT for table `surveys_sectionscore`
--
ALTER TABLE `surveys_sectionscore`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `surveys_survey`
--
ALTER TABLE `surveys_survey`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts_doctor_groups`
--
ALTER TABLE `accounts_doctor_groups`
  ADD CONSTRAINT `accounts_doctor_groups_doctor_id_a9fa17db_fk_accounts_doctor_id` FOREIGN KEY (`doctor_id`) REFERENCES `accounts_doctor` (`id`),
  ADD CONSTRAINT `accounts_doctor_groups_group_id_c19eb0a2_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `accounts_doctor_user_permissions`
--
ALTER TABLE `accounts_doctor_user_permissions`
  ADD CONSTRAINT `accounts_doctor_user_doctor_id_b618ca96_fk_accounts_` FOREIGN KEY (`doctor_id`) REFERENCES `accounts_doctor` (`id`),
  ADD CONSTRAINT `accounts_doctor_user_permission_id_4980b691_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);

--
-- Constraints for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD CONSTRAINT `authtoken_token_user_id_35299eff_fk_accounts_doctor_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_doctor` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_accounts_doctor_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_doctor` (`id`);

--
-- Constraints for table `patients_patient`
--
ALTER TABLE `patients_patient`
  ADD CONSTRAINT `patients_patient_doctor_id_1c263247_fk_accounts_doctor_id` FOREIGN KEY (`doctor_id`) REFERENCES `accounts_doctor` (`id`);

--
-- Constraints for table `surveys_answer`
--
ALTER TABLE `surveys_answer`
  ADD CONSTRAINT `surveys_answer_survey_id_caa4663c_fk_surveys_survey_id` FOREIGN KEY (`survey_id`) REFERENCES `surveys_survey` (`id`);

--
-- Constraints for table `surveys_sectionscore`
--
ALTER TABLE `surveys_sectionscore`
  ADD CONSTRAINT `surveys_sectionscore_survey_id_b6cc3ffa_fk_surveys_survey_id` FOREIGN KEY (`survey_id`) REFERENCES `surveys_survey` (`id`);

--
-- Constraints for table `surveys_survey`
--
ALTER TABLE `surveys_survey`
  ADD CONSTRAINT `surveys_survey_patient_id_9c3c3bf3_fk_patients_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `patients_patient` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
