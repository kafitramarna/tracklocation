-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 12, 2014 at 09:32 AM
-- Server version: 5.5.37
-- PHP Version: 5.5.12-2+deb.sury.org~precise+1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `test_tracker_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE IF NOT EXISTS `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2014_06_11_080917_create_tracker_tables', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tracker_agents`
--

CREATE TABLE IF NOT EXISTS `tracker_agents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `browser` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `browser_version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tracker_agents_name_unique` (`name`),
  KEY `tracker_agents_browser_index` (`browser`),
  KEY `tracker_agents_created_at_index` (`created_at`),
  KEY `tracker_agents_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_connections`
--

CREATE TABLE IF NOT EXISTS `tracker_connections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_connections_name_index` (`name`),
  KEY `tracker_connections_created_at_index` (`created_at`),
  KEY `tracker_connections_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_cookies`
--

CREATE TABLE IF NOT EXISTS `tracker_cookies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tracker_cookies_uuid_unique` (`uuid`),
  KEY `tracker_cookies_created_at_index` (`created_at`),
  KEY `tracker_cookies_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_devices`
--

CREATE TABLE IF NOT EXISTS `tracker_devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `kind` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `platform` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `platform_version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `is_mobile` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tracker_devices_kind_model_platform_platform_version_unique` (`kind`,`model`,`platform`,`platform_version`),
  KEY `tracker_devices_kind_index` (`kind`),
  KEY `tracker_devices_model_index` (`model`),
  KEY `tracker_devices_platform_index` (`platform`),
  KEY `tracker_devices_platform_version_index` (`platform_version`),
  KEY `tracker_devices_created_at_index` (`created_at`),
  KEY `tracker_devices_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_domains`
--

CREATE TABLE IF NOT EXISTS `tracker_domains` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_domains_name_index` (`name`),
  KEY `tracker_domains_created_at_index` (`created_at`),
  KEY `tracker_domains_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_errors`
--

CREATE TABLE IF NOT EXISTS `tracker_errors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `message` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_errors_code_index` (`code`),
  KEY `tracker_errors_message_index` (`message`),
  KEY `tracker_errors_created_at_index` (`created_at`),
  KEY `tracker_errors_updated_at_index` (`updated_at`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `tracker_errors`
--

INSERT INTO `tracker_errors` (`id`, `code`, `message`, `created_at`, `updated_at`) VALUES
(1, '500', 'Trying to get property of non-object', '2014-06-11 01:12:26', '2014-06-11 01:12:26'),
(2, '500', 'Missing argument 1 for PragmaRX\\Tracker\\Tracker::pageViews(), called in /var/www/html/laravel/lara4.2/vendor/laravel/framework/src/Illuminate/Support/Facades/Facade.php on line 205 and defined', '2014-06-11 03:06:16', '2014-06-11 03:06:16');

-- --------------------------------------------------------

--
-- Table structure for table `tracker_events`
--

CREATE TABLE IF NOT EXISTS `tracker_events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_events_name_index` (`name`),
  KEY `tracker_events_created_at_index` (`created_at`),
  KEY `tracker_events_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_events_log`
--

CREATE TABLE IF NOT EXISTS `tracker_events_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` bigint(20) unsigned NOT NULL,
  `class_id` bigint(20) unsigned NOT NULL,
  `log_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_events_log_event_id_index` (`event_id`),
  KEY `tracker_events_log_class_id_index` (`class_id`),
  KEY `tracker_events_log_log_id_index` (`log_id`),
  KEY `tracker_events_log_created_at_index` (`created_at`),
  KEY `tracker_events_log_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_geoip`
--

CREATE TABLE IF NOT EXISTS `tracker_geoip` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `latitude` float(8,2) DEFAULT NULL,
  `longitude` float(8,2) DEFAULT NULL,
  `country_code` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_code3` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `region` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal_code` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `area_code` bigint(20) DEFAULT NULL,
  `dma_code` float(8,2) DEFAULT NULL,
  `metro_code` float(8,2) DEFAULT NULL,
  `continent_code` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_geoip_latitude_index` (`latitude`),
  KEY `tracker_geoip_longitude_index` (`longitude`),
  KEY `tracker_geoip_country_code_index` (`country_code`),
  KEY `tracker_geoip_country_code3_index` (`country_code3`),
  KEY `tracker_geoip_country_name_index` (`country_name`),
  KEY `tracker_geoip_city_index` (`city`),
  KEY `tracker_geoip_created_at_index` (`created_at`),
  KEY `tracker_geoip_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_log`
--

CREATE TABLE IF NOT EXISTS `tracker_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` bigint(20) unsigned NOT NULL,
  `path_id` bigint(20) unsigned NOT NULL,
  `query_id` bigint(20) unsigned DEFAULT NULL,
  `method` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `route_path_id` bigint(20) unsigned DEFAULT NULL,
  `is_ajax` tinyint(1) NOT NULL,
  `is_secure` tinyint(1) NOT NULL,
  `is_json` tinyint(1) NOT NULL,
  `wants_json` tinyint(1) NOT NULL,
  `error_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_log_session_id_index` (`session_id`),
  KEY `tracker_log_path_id_index` (`path_id`),
  KEY `tracker_log_query_id_index` (`query_id`),
  KEY `tracker_log_method_index` (`method`),
  KEY `tracker_log_route_path_id_index` (`route_path_id`),
  KEY `tracker_log_error_id_index` (`error_id`),
  KEY `tracker_log_created_at_index` (`created_at`),
  KEY `tracker_log_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_paths`
--

CREATE TABLE IF NOT EXISTS `tracker_paths` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_paths_path_index` (`path`),
  KEY `tracker_paths_created_at_index` (`created_at`),
  KEY `tracker_paths_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_queries`
--

CREATE TABLE IF NOT EXISTS `tracker_queries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `query` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_queries_query_index` (`query`),
  KEY `tracker_queries_created_at_index` (`created_at`),
  KEY `tracker_queries_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_query_arguments`
--

CREATE TABLE IF NOT EXISTS `tracker_query_arguments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `query_id` bigint(20) unsigned NOT NULL,
  `argument` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_query_arguments_query_id_index` (`query_id`),
  KEY `tracker_query_arguments_argument_index` (`argument`),
  KEY `tracker_query_arguments_value_index` (`value`),
  KEY `tracker_query_arguments_created_at_index` (`created_at`),
  KEY `tracker_query_arguments_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_referers`
--

CREATE TABLE IF NOT EXISTS `tracker_referers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `domain_id` bigint(20) unsigned NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `host` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_referers_domain_id_index` (`domain_id`),
  KEY `tracker_referers_url_index` (`url`),
  KEY `tracker_referers_created_at_index` (`created_at`),
  KEY `tracker_referers_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_routes`
--

CREATE TABLE IF NOT EXISTS `tracker_routes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `action` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_routes_name_index` (`name`),
  KEY `tracker_routes_action_index` (`action`),
  KEY `tracker_routes_created_at_index` (`created_at`),
  KEY `tracker_routes_updated_at_index` (`updated_at`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `tracker_routes`
--

INSERT INTO `tracker_routes` (`id`, `name`, `action`, `created_at`, `updated_at`) VALUES
(1, '', 'closure', '2014-06-11 01:12:14', '2014-06-11 01:12:14');

-- --------------------------------------------------------

--
-- Table structure for table `tracker_route_paths`
--

CREATE TABLE IF NOT EXISTS `tracker_route_paths` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `route_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_route_paths_route_id_index` (`route_id`),
  KEY `tracker_route_paths_path_index` (`path`),
  KEY `tracker_route_paths_created_at_index` (`created_at`),
  KEY `tracker_route_paths_updated_at_index` (`updated_at`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `tracker_route_paths`
--

INSERT INTO `tracker_route_paths` (`id`, `route_id`, `path`, `created_at`, `updated_at`) VALUES
(1, '1', '/', '2014-06-11 01:12:15', '2014-06-11 01:12:15'),
(2, '1', 'city', '2014-06-11 01:12:26', '2014-06-11 01:12:26'),
(3, '1', 'errors', '2014-06-11 02:41:03', '2014-06-11 02:41:03'),
(4, '1', 'users', '2014-06-11 03:04:18', '2014-06-11 03:04:18'),
(5, '1', 'page', '2014-06-11 03:06:09', '2014-06-11 03:06:09'),
(6, '1', 'cview', '2014-06-11 03:50:47', '2014-06-11 03:50:47');

-- --------------------------------------------------------

--
-- Table structure for table `tracker_route_path_parameters`
--

CREATE TABLE IF NOT EXISTS `tracker_route_path_parameters` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `route_path_id` bigint(20) unsigned NOT NULL,
  `parameter` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_route_path_parameters_route_path_id_index` (`route_path_id`),
  KEY `tracker_route_path_parameters_parameter_index` (`parameter`),
  KEY `tracker_route_path_parameters_value_index` (`value`),
  KEY `tracker_route_path_parameters_created_at_index` (`created_at`),
  KEY `tracker_route_path_parameters_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_sessions`
--

CREATE TABLE IF NOT EXISTS `tracker_sessions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `device_id` bigint(20) unsigned NOT NULL,
  `agent_id` bigint(20) unsigned NOT NULL,
  `client_ip` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `referer_id` bigint(20) unsigned DEFAULT NULL,
  `cookie_id` bigint(20) unsigned DEFAULT NULL,
  `geoip_id` bigint(20) unsigned DEFAULT NULL,
  `is_robot` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tracker_sessions_uuid_unique` (`uuid`),
  KEY `tracker_sessions_user_id_index` (`user_id`),
  KEY `tracker_sessions_device_id_index` (`device_id`),
  KEY `tracker_sessions_agent_id_index` (`agent_id`),
  KEY `tracker_sessions_client_ip_index` (`client_ip`),
  KEY `tracker_sessions_referer_id_index` (`referer_id`),
  KEY `tracker_sessions_cookie_id_index` (`cookie_id`),
  KEY `tracker_sessions_geoip_id_index` (`geoip_id`),
  KEY `tracker_sessions_created_at_index` (`created_at`),
  KEY `tracker_sessions_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_sql_queries`
--

CREATE TABLE IF NOT EXISTS `tracker_sql_queries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sha1` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `statement` text COLLATE utf8_unicode_ci NOT NULL,
  `time` float(8,2) NOT NULL,
  `connection_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_sql_queries_sha1_index` (`sha1`),
  KEY `tracker_sql_queries_time_index` (`time`),
  KEY `tracker_sql_queries_created_at_index` (`created_at`),
  KEY `tracker_sql_queries_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_sql_queries_log`
--

CREATE TABLE IF NOT EXISTS `tracker_sql_queries_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `log_id` bigint(20) unsigned NOT NULL,
  `sql_query_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_sql_queries_log_log_id_index` (`log_id`),
  KEY `tracker_sql_queries_log_sql_query_id_index` (`sql_query_id`),
  KEY `tracker_sql_queries_log_created_at_index` (`created_at`),
  KEY `tracker_sql_queries_log_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_sql_query_bindings`
--

CREATE TABLE IF NOT EXISTS `tracker_sql_query_bindings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sha1` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `serialized` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_sql_query_bindings_sha1_index` (`sha1`),
  KEY `tracker_sql_query_bindings_created_at_index` (`created_at`),
  KEY `tracker_sql_query_bindings_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_sql_query_bindings_parameters`
--

CREATE TABLE IF NOT EXISTS `tracker_sql_query_bindings_parameters` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sql_query_bindings_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_sql_query_bindings_parameters_name_index` (`name`),
  KEY `tracker_sql_query_bindings_parameters_created_at_index` (`created_at`),
  KEY `tracker_sql_query_bindings_parameters_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tracker_system_classes`
--

CREATE TABLE IF NOT EXISTS `tracker_system_classes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `tracker_system_classes_name_index` (`name`),
  KEY `tracker_system_classes_created_at_index` (`created_at`),
  KEY `tracker_system_classes_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
