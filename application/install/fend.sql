-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Янв 24 2019 г., 06:45
-- Версия сервера: 5.7.24-0ubuntu0.16.04.1
-- Версия PHP: 7.0.32-4+ubuntu16.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `fend`
--

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_admin_users_ban`
--

CREATE TABLE `prefix_admin_users_ban` (
  `id` int(11) NOT NULL,
  `restriction_type` tinyint(4) NOT NULL DEFAULT '1',
  `block_type` tinyint(4) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ip` int(10) UNSIGNED DEFAULT NULL,
  `ip_start` int(10) UNSIGNED DEFAULT NULL,
  `ip_finish` int(10) UNSIGNED DEFAULT NULL,
  `time_type` tinyint(4) NOT NULL,
  `date_start` datetime NOT NULL,
  `date_finish` datetime NOT NULL,
  `add_date` datetime NOT NULL,
  `edit_date` datetime DEFAULT NULL,
  `reason_for_user` varchar(500) DEFAULT NULL,
  `comment` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_category`
--

CREATE TABLE `prefix_category` (
  `id` int(11) NOT NULL,
  `pid` int(11) DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `url` varchar(250) NOT NULL,
  `url_full` varchar(250) NOT NULL,
  `date_create` datetime NOT NULL,
  `order` int(11) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `count_target` int(11) NOT NULL DEFAULT '0',
  `data` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_category_target`
--

CREATE TABLE `prefix_category_target` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target_id` int(11) NOT NULL,
  `date_create` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_category_type`
--

CREATE TABLE `prefix_category_type` (
  `id` int(11) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `title` varchar(200) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `date_create` datetime NOT NULL,
  `date_update` datetime DEFAULT NULL,
  `params` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_cron_task`
--

CREATE TABLE `prefix_cron_task` (
  `id` int(11) NOT NULL,
  `title` varchar(500) NOT NULL,
  `method` varchar(500) NOT NULL,
  `plugin` varchar(50) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `count_run` int(11) NOT NULL DEFAULT '0',
  `period_run` int(11) NOT NULL,
  `date_create` datetime NOT NULL,
  `date_run_last` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_media`
--

CREATE TABLE `prefix_media` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED DEFAULT NULL,
  `type` int(11) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_name` varchar(500) NOT NULL,
  `file_size` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `date_add` datetime NOT NULL,
  `data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_media_target`
--

CREATE TABLE `prefix_media_target` (
  `id` int(11) UNSIGNED NOT NULL,
  `media_id` int(11) UNSIGNED NOT NULL,
  `target_id` int(11) DEFAULT NULL,
  `target_type` varchar(50) NOT NULL,
  `target_tmp` varchar(50) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `is_preview` tinyint(1) NOT NULL DEFAULT '0',
  `data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_menu`
--

CREATE TABLE `prefix_menu` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(30) COLLATE utf8_bin NOT NULL,
  `title` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `state` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Дамп данных таблицы `prefix_menu`
--

INSERT INTO `prefix_menu` (`id`, `name`, `title`, `state`) VALUES
(1, 'main', 'Главное', 1),
(2, 'user', 'Пользователь', 1),
(3, 'settings', 'Настройка профиля', 1),
(4, 'profile', 'Профиль', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_menu_item`
--

CREATE TABLE `prefix_menu_item` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(30) NOT NULL,
  `url` varchar(1000) DEFAULT NULL,
  `menu_id` int(10) UNSIGNED NOT NULL,
  `pid` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(250) DEFAULT NULL,
  `state` tinyint(3) UNSIGNED NOT NULL,
  `priority` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `prefix_menu_item`
--

INSERT INTO `prefix_menu_item` (`id`, `name`, `url`, `menu_id`, `pid`, `title`, `state`, `priority`) VALUES
(1, 'people', 'people', 1, 0, 'menu.humans.text', 1, 100),
(5, 'companies', 'companies', 1, 0, 'menu.companies.text', 1, 99),
(11, 'settings', 'settings', 2, 0, 'user.profile.nav.settings', 1, 20);

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_notify_task`
--

CREATE TABLE `prefix_notify_task` (
  `notify_task_id` int(10) UNSIGNED NOT NULL,
  `user_login` varchar(30) DEFAULT NULL,
  `user_mail` varchar(50) DEFAULT NULL,
  `notify_subject` varchar(200) DEFAULT NULL,
  `notify_text` text,
  `date_created` datetime DEFAULT NULL,
  `notify_task_status` tinyint(2) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_plugin_migration`
--

CREATE TABLE `prefix_plugin_migration` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `version` varchar(50) NOT NULL,
  `date_create` datetime NOT NULL,
  `file` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_plugin_version`
--

CREATE TABLE `prefix_plugin_version` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `version` varchar(50) NOT NULL,
  `date_update` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `prefix_plugin_version`
--

INSERT INTO `prefix_plugin_version` (`id`, `code`, `version`, `date_update`) VALUES
(1, 'admin', '1.0.2', '2018-12-01 14:14:05');

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_property`
--

CREATE TABLE `prefix_property` (
  `id` int(11) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `type` enum('int','float','varchar','text','checkbox','select','tags','video_link') NOT NULL DEFAULT 'text',
  `code` varchar(50) NOT NULL,
  `title` varchar(250) NOT NULL,
  `date_create` datetime NOT NULL,
  `sort` int(11) NOT NULL,
  `validate_rules` varchar(500) DEFAULT NULL,
  `params` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_property_select`
--

CREATE TABLE `prefix_property_select` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `value` varchar(250) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_property_target`
--

CREATE TABLE `prefix_property_target` (
  `id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `date_create` datetime NOT NULL,
  `date_update` datetime DEFAULT NULL,
  `state` tinyint(4) NOT NULL DEFAULT '1',
  `params` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_property_value`
--

CREATE TABLE `prefix_property_value` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `property_type` varchar(30) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target_id` int(11) NOT NULL,
  `value_int` int(11) DEFAULT NULL,
  `value_float` float(11,2) DEFAULT NULL,
  `value_varchar` varchar(250) DEFAULT NULL,
  `value_text` text,
  `data` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_property_value_select`
--

CREATE TABLE `prefix_property_value_select` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target_id` int(11) NOT NULL,
  `select_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_property_value_tag`
--

CREATE TABLE `prefix_property_value_tag` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target_id` int(11) NOT NULL,
  `text` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_rating_stat`
--

CREATE TABLE `prefix_rating_stat` (
  `id` int(10) UNSIGNED NOT NULL,
  `target_type` varchar(20) COLLATE utf8_bin NOT NULL,
  `target_id` int(10) UNSIGNED NOT NULL,
  `rating` float DEFAULT '0',
  `count_vote` bigint(20) UNSIGNED DEFAULT '0',
  `data` text COLLATE utf8_bin,
  `date_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `date_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_rating_vote`
--

CREATE TABLE `prefix_rating_vote` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `from_id` int(11) NOT NULL,
  `vote` smallint(6) NOT NULL,
  `target_type` varchar(20) COLLATE utf8_bin NOT NULL,
  `target_id` int(10) UNSIGNED NOT NULL,
  `date_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `date_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_rbac_group`
--

CREATE TABLE `prefix_rbac_group` (
  `id` int(11) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `title` varchar(250) NOT NULL,
  `date_create` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `prefix_rbac_group`
--

INSERT INTO `prefix_rbac_group` (`id`, `code`, `title`, `date_create`) VALUES
(1, 'user', 'Пользователи', '2018-12-31 08:22:14');

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_rbac_permission`
--

CREATE TABLE `prefix_rbac_permission` (
  `id` int(11) UNSIGNED NOT NULL,
  `group_id` int(11) UNSIGNED DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `plugin` varchar(50) NOT NULL,
  `title` varchar(250) NOT NULL,
  `msg_error` varchar(250) DEFAULT NULL,
  `date_create` datetime NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `prefix_rbac_permission`
--

INSERT INTO `prefix_rbac_permission` (`id`, `group_id`, `code`, `plugin`, `title`, `msg_error`, `date_create`, `state`) VALUES
(1, 1, 'moderation', '', 'Модерация', '', '2018-12-31 05:26:17', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_rbac_role`
--

CREATE TABLE `prefix_rbac_role` (
  `id` int(11) UNSIGNED NOT NULL,
  `pid` int(11) UNSIGNED DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `title` varchar(250) NOT NULL,
  `date_create` datetime NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `prefix_rbac_role`
--

INSERT INTO `prefix_rbac_role` (`id`, `pid`, `code`, `title`, `date_create`, `state`) VALUES
(1, NULL, 'user', 'Личность', '2018-12-31 08:24:40', 1),
(2, NULL, 'company', 'Компания', '2018-12-31 08:24:40', 1),
(3, NULL, 'moderator', 'Модератор', '2018-12-31 05:25:36', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_rbac_role_permission`
--

CREATE TABLE `prefix_rbac_role_permission` (
  `id` int(11) UNSIGNED NOT NULL,
  `role_id` int(11) UNSIGNED NOT NULL,
  `permission_id` int(11) UNSIGNED NOT NULL,
  `date_create` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `prefix_rbac_role_permission`
--

INSERT INTO `prefix_rbac_role_permission` (`id`, `role_id`, `permission_id`, `date_create`) VALUES
(0, 3, 1, '2018-12-31 05:26:30');

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_rbac_role_user`
--

CREATE TABLE `prefix_rbac_role_user` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `role_id` int(11) UNSIGNED NOT NULL,
  `date_create` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `prefix_rbac_role_user`
--

INSERT INTO `prefix_rbac_role_user` (`id`, `user_id`, `role_id`, `date_create`) VALUES
(0, 5, 3, '2018-12-31 05:28:22');

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_reminder`
--

CREATE TABLE `prefix_reminder` (
  `code` varchar(32) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_create` datetime NOT NULL,
  `date_used` datetime DEFAULT '0000-00-00 00:00:00',
  `date_expire` datetime NOT NULL,
  `is_used` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `prefix_reminder`
--

INSERT INTO `prefix_reminder` (`code`, `user_id`, `date_create`, `date_used`, `date_expire`, `is_used`) VALUES
('2fd42063ee0f1612c5fab4b6244ad7ad', 1, '2018-12-14 04:06:50', NULL, '2018-12-21 04:06:50', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_session`
--

CREATE TABLE `prefix_session` (
  `key` varchar(32) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ip_create` varchar(40) NOT NULL,
  `ip_last` varchar(40) NOT NULL,
  `date_create` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_last` datetime NOT NULL,
  `date_close` datetime DEFAULT NULL,
  `extra` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `prefix_session`
--

INSERT INTO `prefix_session` (`key`, `user_id`, `ip_create`, `ip_last`, `date_create`, `date_last`, `date_close`, `extra`) VALUES
('807576f86e135bcd92fda05206c944a1', 1, '127.0.0.1', '127.0.0.1', '2019-01-24 03:45:25', '2019-01-24 03:45:25', NULL, '{"user_agent":"Mozilla\\/5.0 (X11; Linux x86_64) AppleWebKit\\/537.36 (KHTML, like Gecko) Ubuntu Chromium\\/70.0.3538.77 Chrome\\/70.0.3538.77 Safari\\/537.36"}');

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_storage`
--

CREATE TABLE `prefix_storage` (
  `id` int(11) NOT NULL,
  `key` varchar(50) NOT NULL,
  `value` mediumtext NOT NULL,
  `instance` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_talk_message`
--

CREATE TABLE `prefix_talk_message` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(50) COLLATE utf8_bin NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_name` varchar(200) COLLATE utf8_bin NOT NULL,
  `target_type` varchar(20) COLLATE utf8_bin NOT NULL,
  `target_id` bigint(20) UNSIGNED NOT NULL,
  `text` text COLLATE utf8_bin NOT NULL,
  `state` varchar(20) COLLATE utf8_bin NOT NULL,
  `rating` float NOT NULL,
  `date_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_user`
--

CREATE TABLE `prefix_user` (
  `id` int(11) NOT NULL,
  `login` varchar(100) NOT NULL,
  `mail` varchar(50) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `role` varchar(20) NOT NULL,
  `about` text,
  `site` varchar(500) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` varchar(500) NOT NULL,
  `photo` varchar(200) DEFAULT NULL,
  `password` varchar(32) NOT NULL,
  `date_create` datetime NOT NULL,
  `date_activate` datetime DEFAULT NULL,
  `ip_create` varchar(40) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `rating` float NOT NULL DEFAULT '0',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `activate` tinyint(1) NOT NULL DEFAULT '0',
  `confirmed` tinyint(4) NOT NULL DEFAULT '0',
  `activate_key` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `prefix_user`
--

INSERT INTO `prefix_user` (`id`, `login`, `mail`, `name`, `role`, `about`, `site`, `phone`, `address`, `photo`, `password`, `date_create`, `date_activate`, `ip_create`, `active`, `rating`, `is_admin`, `activate`, `confirmed`, `activate_key`) VALUES
(1, 'administrator', 'support@fend.ru', 'Администратор', 'user', 'Администратор', '', '', '', NULL, 'ac66e5100a5c96121ed922126522705d', '2019-01-01 00:00:00', '2019-01-01 00:00:00', '', 1, 0, 1, 1, 0, NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `prefix_admin_users_ban`
--
ALTER TABLE `prefix_admin_users_ban`
  ADD PRIMARY KEY (`id`),
  ADD KEY `restriction_type` (`restriction_type`),
  ADD KEY `block_type` (`block_type`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `ip` (`ip`),
  ADD KEY `ip_start` (`ip_start`),
  ADD KEY `ip_finish` (`ip_finish`),
  ADD KEY `time_type` (`time_type`),
  ADD KEY `date_start` (`date_start`),
  ADD KEY `date_finish` (`date_finish`),
  ADD KEY `add_date` (`add_date`),
  ADD KEY `edit_date` (`edit_date`);

--
-- Индексы таблицы `prefix_category`
--
ALTER TABLE `prefix_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`),
  ADD KEY `title` (`title`),
  ADD KEY `order` (`order`),
  ADD KEY `state` (`state`),
  ADD KEY `url` (`url`),
  ADD KEY `url_full` (`url_full`),
  ADD KEY `type_id` (`type_id`),
  ADD KEY `count_target` (`count_target`);

--
-- Индексы таблицы `prefix_category_target`
--
ALTER TABLE `prefix_category_target`
  ADD PRIMARY KEY (`id`),
  ADD KEY `target_type` (`target_type`),
  ADD KEY `target_id` (`target_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `type_id` (`type_id`);

--
-- Индексы таблицы `prefix_category_type`
--
ALTER TABLE `prefix_category_type`
  ADD PRIMARY KEY (`id`),
  ADD KEY `title` (`title`),
  ADD KEY `state` (`state`),
  ADD KEY `target_type` (`target_type`);

--
-- Индексы таблицы `prefix_cron_task`
--
ALTER TABLE `prefix_cron_task`
  ADD PRIMARY KEY (`id`),
  ADD KEY `count_run` (`count_run`),
  ADD KEY `state` (`state`),
  ADD KEY `plugin` (`plugin`),
  ADD KEY `method` (`method`(255)),
  ADD KEY `period_run` (`period_run`);

--
-- Индексы таблицы `prefix_media`
--
ALTER TABLE `prefix_media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `type` (`type`),
  ADD KEY `file_size` (`file_size`),
  ADD KEY `width` (`width`),
  ADD KEY `height` (`height`),
  ADD KEY `date_add` (`date_add`),
  ADD KEY `target_type` (`target_type`);

--
-- Индексы таблицы `prefix_media_target`
--
ALTER TABLE `prefix_media_target`
  ADD PRIMARY KEY (`id`),
  ADD KEY `media_id` (`media_id`),
  ADD KEY `target_id` (`target_id`),
  ADD KEY `target_type` (`target_type`),
  ADD KEY `target_tmp` (`target_tmp`),
  ADD KEY `date_add` (`date_add`),
  ADD KEY `is_preview` (`is_preview`);

--
-- Индексы таблицы `prefix_menu`
--
ALTER TABLE `prefix_menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Индексы таблицы `prefix_menu_item`
--
ALTER TABLE `prefix_menu_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `state` (`state`),
  ADD KEY `menu_id` (`menu_id`);

--
-- Индексы таблицы `prefix_notify_task`
--
ALTER TABLE `prefix_notify_task`
  ADD PRIMARY KEY (`notify_task_id`),
  ADD KEY `date_created` (`date_created`);

--
-- Индексы таблицы `prefix_plugin_migration`
--
ALTER TABLE `prefix_plugin_migration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `file` (`file`(255)),
  ADD KEY `code` (`code`),
  ADD KEY `version` (`version`);

--
-- Индексы таблицы `prefix_plugin_version`
--
ALTER TABLE `prefix_plugin_version`
  ADD PRIMARY KEY (`id`),
  ADD KEY `code` (`code`),
  ADD KEY `version` (`version`);

--
-- Индексы таблицы `prefix_property`
--
ALTER TABLE `prefix_property`
  ADD PRIMARY KEY (`id`),
  ADD KEY `target_type` (`target_type`),
  ADD KEY `code` (`code`),
  ADD KEY `type` (`type`),
  ADD KEY `date_create` (`date_create`),
  ADD KEY `sort` (`sort`);

--
-- Индексы таблицы `prefix_property_select`
--
ALTER TABLE `prefix_property_select`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`),
  ADD KEY `target_type` (`target_type`),
  ADD KEY `sort` (`sort`);

--
-- Индексы таблицы `prefix_property_target`
--
ALTER TABLE `prefix_property_target`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`),
  ADD KEY `date_create` (`date_create`),
  ADD KEY `date_update` (`date_update`),
  ADD KEY `state` (`state`);

--
-- Индексы таблицы `prefix_property_value`
--
ALTER TABLE `prefix_property_value`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`),
  ADD KEY `target_type` (`target_type`),
  ADD KEY `target_id` (`target_id`),
  ADD KEY `value_int` (`value_int`),
  ADD KEY `property_type` (`property_type`),
  ADD KEY `value_float` (`value_float`),
  ADD KEY `value_varchar` (`value_varchar`);

--
-- Индексы таблицы `prefix_property_value_select`
--
ALTER TABLE `prefix_property_value_select`
  ADD PRIMARY KEY (`id`),
  ADD KEY `target_type` (`target_type`),
  ADD KEY `target_id` (`target_id`),
  ADD KEY `property_id` (`property_id`),
  ADD KEY `select_id` (`select_id`);

--
-- Индексы таблицы `prefix_property_value_tag`
--
ALTER TABLE `prefix_property_value_tag`
  ADD PRIMARY KEY (`id`),
  ADD KEY `target_type` (`target_type`),
  ADD KEY `target_id` (`target_id`),
  ADD KEY `text` (`text`),
  ADD KEY `property_id` (`property_id`);

--
-- Индексы таблицы `prefix_rating_stat`
--
ALTER TABLE `prefix_rating_stat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `target_type` (`target_type`),
  ADD KEY `rating` (`rating`),
  ADD KEY `count_vote` (`count_vote`),
  ADD KEY `date_update` (`date_update`),
  ADD KEY `date_create` (`date_create`);

--
-- Индексы таблицы `prefix_rating_vote`
--
ALTER TABLE `prefix_rating_vote`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `vote` (`vote`),
  ADD KEY `date_update` (`date_update`),
  ADD KEY `date_create` (`date_create`),
  ADD KEY `target_type` (`target_type`) USING BTREE,
  ADD KEY `from_id` (`from_id`);

--
-- Индексы таблицы `prefix_rbac_group`
--
ALTER TABLE `prefix_rbac_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `code` (`code`);

--
-- Индексы таблицы `prefix_rbac_permission`
--
ALTER TABLE `prefix_rbac_permission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `code` (`code`),
  ADD KEY `date_create` (`date_create`),
  ADD KEY `state` (`state`),
  ADD KEY `plugin` (`plugin`),
  ADD KEY `group_id` (`group_id`);

--
-- Индексы таблицы `prefix_rbac_role`
--
ALTER TABLE `prefix_rbac_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`),
  ADD KEY `state` (`state`),
  ADD KEY `date_create` (`date_create`),
  ADD KEY `code` (`code`);

--
-- Индексы таблицы `prefix_rbac_role_permission`
--
ALTER TABLE `prefix_rbac_role_permission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `permission_id` (`permission_id`),
  ADD KEY `date_create` (`date_create`);

--
-- Индексы таблицы `prefix_rbac_role_user`
--
ALTER TABLE `prefix_rbac_role_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `date_create` (`date_create`);

--
-- Индексы таблицы `prefix_reminder`
--
ALTER TABLE `prefix_reminder`
  ADD PRIMARY KEY (`code`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Индексы таблицы `prefix_session`
--
ALTER TABLE `prefix_session`
  ADD PRIMARY KEY (`key`),
  ADD KEY `date_last` (`date_last`),
  ADD KEY `date_close` (`date_close`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `prefix_storage`
--
ALTER TABLE `prefix_storage`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `key_instance` (`key`,`instance`),
  ADD KEY `instance` (`instance`);

--
-- Индексы таблицы `prefix_talk_message`
--
ALTER TABLE `prefix_talk_message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `target_id` (`target_id`),
  ADD KEY `date_create` (`date_create`),
  ADD KEY `date_update` (`date_update`),
  ADD KEY `state` (`state`),
  ADD KEY `rating` (`rating`),
  ADD KEY `target_type` (`target_type`);
ALTER TABLE `prefix_talk_message` ADD FULLTEXT KEY `text` (`text`);

--
-- Индексы таблицы `prefix_user`
--
ALTER TABLE `prefix_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`),
  ADD KEY `mail` (`mail`),
  ADD KEY `password` (`password`),
  ADD KEY `activate_key` (`activate_key`),
  ADD KEY `active` (`active`),
  ADD KEY `activate` (`activate`),
  ADD KEY `rating` (`rating`),
  ADD KEY `role` (`role`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `prefix_admin_users_ban`
--
ALTER TABLE `prefix_admin_users_ban`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_category`
--
ALTER TABLE `prefix_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_category_target`
--
ALTER TABLE `prefix_category_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_category_type`
--
ALTER TABLE `prefix_category_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_cron_task`
--
ALTER TABLE `prefix_cron_task`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_media`
--
ALTER TABLE `prefix_media`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_media_target`
--
ALTER TABLE `prefix_media_target`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_menu`
--
ALTER TABLE `prefix_menu`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT для таблицы `prefix_menu_item`
--
ALTER TABLE `prefix_menu_item`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT для таблицы `prefix_notify_task`
--
ALTER TABLE `prefix_notify_task`
  MODIFY `notify_task_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_plugin_migration`
--
ALTER TABLE `prefix_plugin_migration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_plugin_version`
--
ALTER TABLE `prefix_plugin_version`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `prefix_property`
--
ALTER TABLE `prefix_property`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_property_select`
--
ALTER TABLE `prefix_property_select`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_property_target`
--
ALTER TABLE `prefix_property_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_property_value`
--
ALTER TABLE `prefix_property_value`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_property_value_select`
--
ALTER TABLE `prefix_property_value_select`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_property_value_tag`
--
ALTER TABLE `prefix_property_value_tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_rating_stat`
--
ALTER TABLE `prefix_rating_stat`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_rating_vote`
--
ALTER TABLE `prefix_rating_vote`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_rbac_permission`
--
ALTER TABLE `prefix_rbac_permission`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `prefix_rbac_role`
--
ALTER TABLE `prefix_rbac_role`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `prefix_rbac_role_permission`
--
ALTER TABLE `prefix_rbac_role_permission`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_rbac_role_user`
--
ALTER TABLE `prefix_rbac_role_user`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_storage`
--
ALTER TABLE `prefix_storage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_talk_message`
--
ALTER TABLE `prefix_talk_message`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `prefix_user`
--
ALTER TABLE `prefix_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


DROP TABLE IF EXISTS `prefix_profile_target`;
CREATE TABLE `prefix_profile_target` (
  `id` int(11) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `target_id` bigint(20) NOT NULL,
  `date_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `prefix_profile_target`
--
ALTER TABLE `prefix_profile_target`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `target_id` (`target_id`),
  ADD KEY `date_create` (`date_create`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `prefix_profile_target`
--
ALTER TABLE `prefix_profile_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;