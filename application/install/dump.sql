-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Апр 20 2015 г., 09:22
-- Версия сервера: 5.5.39
-- Версия PHP: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- База данных: `boilerplate`
--

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_cron_task`
--

CREATE TABLE IF NOT EXISTS `prefix_cron_task` (
`id` int(11) NOT NULL,
  `title` varchar(500) NOT NULL,
  `method` varchar(500) NOT NULL,
  `plugin` varchar(50) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `count_run` int(11) NOT NULL DEFAULT '0',
  `period_run` int(11) NOT NULL,
  `date_create` datetime NOT NULL,
  `date_run_last` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_notify_task`
--

CREATE TABLE IF NOT EXISTS `prefix_notify_task` (
`notify_task_id` int(10) unsigned NOT NULL,
  `user_login` varchar(30) DEFAULT NULL,
  `user_mail` varchar(50) DEFAULT NULL,
  `notify_subject` varchar(200) DEFAULT NULL,
  `notify_text` text,
  `date_created` datetime DEFAULT NULL,
  `notify_task_status` tinyint(2) unsigned DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_plugin_migration`
--

CREATE TABLE IF NOT EXISTS `prefix_plugin_migration` (
`id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `version` varchar(50) NOT NULL,
  `date_create` datetime NOT NULL,
  `file` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_plugin_version`
--

CREATE TABLE IF NOT EXISTS `prefix_plugin_version` (
`id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `version` varchar(50) NOT NULL,
  `date_update` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_reminder`
--

CREATE TABLE IF NOT EXISTS `prefix_reminder` (
  `code` varchar(32) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_create` datetime NOT NULL,
  `date_used` datetime DEFAULT '0000-00-00 00:00:00',
  `date_expire` datetime NOT NULL,
  `is_used` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_session`
--

CREATE TABLE IF NOT EXISTS `prefix_session` (
  `key` varchar(32) NOT NULL,
  `user_id` int(11) NOT NULL,
  `ip_create` varchar(40) NOT NULL,
  `ip_last` varchar(40) NOT NULL,
  `date_create` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_last` datetime NOT NULL,
  `date_close` datetime DEFAULT NULL,
  `extra` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_storage`
--

CREATE TABLE IF NOT EXISTS `prefix_storage` (
`id` int(11) NOT NULL,
  `key` varchar(50) NOT NULL,
  `value` mediumtext NOT NULL,
  `instance` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_user`
--

CREATE TABLE IF NOT EXISTS `prefix_user` (
`id` int(11) NOT NULL,
`login` VARCHAR(100) NOT NULL,
  `mail` varchar(50) NOT NULL,
  `password` varchar(32) NOT NULL,
  `date_create` datetime NOT NULL,
  `date_activate` datetime DEFAULT NULL,
  `ip_create` varchar(40) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `activate` tinyint(1) NOT NULL DEFAULT '0',
  `activate_key` varchar(32) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


ALTER TABLE `prefix_user` ADD `rating` FLOAT NOT NULL DEFAULT '0' AFTER `active`, ADD INDEX (`rating`);
--
-- Indexes for dumped tables
--

--
-- Indexes for table `prefix_cron_task`
--
ALTER TABLE `prefix_cron_task`
 ADD PRIMARY KEY (`id`), ADD KEY `count_run` (`count_run`), ADD KEY `state` (`state`), ADD KEY `plugin` (`plugin`), ADD KEY `method` (`method`(255)), ADD KEY `period_run` (`period_run`);

--
-- Indexes for table `prefix_notify_task`
--
ALTER TABLE `prefix_notify_task`
 ADD PRIMARY KEY (`notify_task_id`), ADD KEY `date_created` (`date_created`);

--
-- Indexes for table `prefix_plugin_migration`
--
ALTER TABLE `prefix_plugin_migration`
 ADD PRIMARY KEY (`id`), ADD KEY `file` (`file`(255)), ADD KEY `code` (`code`), ADD KEY `version` (`version`);

--
-- Indexes for table `prefix_plugin_version`
--
ALTER TABLE `prefix_plugin_version`
 ADD PRIMARY KEY (`id`), ADD KEY `code` (`code`), ADD KEY `version` (`version`);

--
-- Indexes for table `prefix_reminder`
--
ALTER TABLE `prefix_reminder`
 ADD PRIMARY KEY (`code`), ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `prefix_session`
--
ALTER TABLE `prefix_session`
 ADD PRIMARY KEY (`key`), ADD KEY `date_last` (`date_last`), ADD KEY `date_close` (`date_close`), ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `prefix_storage`
--
ALTER TABLE `prefix_storage`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `key_instance` (`key`,`instance`), ADD KEY `instance` (`instance`);

--
-- Indexes for table `prefix_user`
--
ALTER TABLE `prefix_user`
 ADD PRIMARY KEY (`id`),  ADD UNIQUE (`login`), ADD KEY `mail` (`mail`), ADD KEY `password` (`password`), ADD KEY `activate_key` (`activate_key`), ADD KEY `active` (`active`), ADD KEY `activate` (`activate`);

ALTER TABLE `prefix_user` ADD `login` VARCHAR(50) NULL DEFAULT NULL AFTER `id`, ADD UNIQUE (`login`);
--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `prefix_cron_task`
--
ALTER TABLE `prefix_cron_task`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prefix_notify_task`
--
ALTER TABLE `prefix_notify_task`
MODIFY `notify_task_id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;
--
-- AUTO_INCREMENT for table `prefix_plugin_migration`
--
ALTER TABLE `prefix_plugin_migration`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prefix_plugin_version`
--
ALTER TABLE `prefix_plugin_version`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prefix_storage`
--
ALTER TABLE `prefix_storage`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `prefix_user`
--
ALTER TABLE `prefix_user`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1;

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
(2, 'user', 'Пользователь', 1);

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
(1, 'humans', 'humans', 1, 0, 'menu.humans.text', 1, 100),
(5, 'companies', 'companies', 1, 0, 'menu.companies.text', 1, 99),
(11, 'settings', 'settings', 2, 0, 'user.profile.nav.settings', 1, 20);

--
-- Индексы сохранённых таблиц
--

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
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `prefix_menu`
--
ALTER TABLE `prefix_menu`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `prefix_menu_item`
--
ALTER TABLE `prefix_menu_item`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

-- 26.05.2014
--
-- Структура таблицы `prefix_category`
--

CREATE TABLE IF NOT EXISTS `prefix_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `url` varchar(250) NOT NULL,
  `url_full` varchar(250) NOT NULL,
  `date_create` datetime NOT NULL,
  `order` int(11) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `title` (`title`),
  KEY `order` (`order`),
  KEY `state` (`state`),
  KEY `url` (`url`),
  KEY `url_full` (`url_full`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_category_target`
--

CREATE TABLE IF NOT EXISTS `prefix_category_target` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target_id` int(11) NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `target_type` (`target_type`),
  KEY `target_id` (`target_id`),
  KEY `category_id` (`category_id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_category_type`
--

CREATE TABLE IF NOT EXISTS `prefix_category_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_type` varchar(50) NOT NULL,
  `title` varchar(200) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  `date_create` datetime NOT NULL,
  `date_update` datetime DEFAULT NULL,
  `params` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `title` (`title`),
  KEY `state` (`state`),
  KEY `target_type` (`target_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


-- 10.07.2014
ALTER TABLE `prefix_category` ADD `data` VARCHAR( 500 ) NOT NULL ;
ALTER TABLE `prefix_category` ADD `count_target` INT NOT NULL DEFAULT '0' AFTER `state` ,
ADD INDEX ( `count_target` ) ;


-- 01-10-2013

--
-- Структура таблицы `prefix_property`
--

CREATE TABLE IF NOT EXISTS `prefix_property` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_type` varchar(50) NOT NULL,
  `type` enum('int','float','varchar','text','checkbox','select','tags','video_link') NOT NULL DEFAULT 'text',
  `code` varchar(50) NOT NULL,
  `title` varchar(250) NOT NULL,
  `date_create` datetime NOT NULL,
  `sort` int(11) NOT NULL,
  `validate_rules` varchar(500) DEFAULT NULL,
  `params` text,
  PRIMARY KEY (`id`),
  KEY `target_type` (`target_type`),
  KEY `code` (`code`),
  KEY `type` (`type`),
  KEY `date_create` (`date_create`),
  KEY `sort` (`sort`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_property_value`
--

CREATE TABLE IF NOT EXISTS `prefix_property_value` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NOT NULL,
  `property_type` varchar(30) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target_id` int(11) NOT NULL,
  `value_int` int(11) DEFAULT NULL,
  `value_float` float(11,2) DEFAULT NULL,
  `value_varchar` varchar(250) DEFAULT NULL,
  `value_text` text,
  `data` text,
  PRIMARY KEY (`id`),
  KEY `property_id` (`property_id`),
  KEY `target_type` (`target_type`),
  KEY `target_id` (`target_id`),
  KEY `value_int` (`value_int`),
  KEY `property_type` (`property_type`),
  KEY `value_float` (`value_float`),
  KEY `value_varchar` (`value_varchar`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_property_value_tag`
--

CREATE TABLE IF NOT EXISTS `prefix_property_value_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target_id` int(11) NOT NULL,
  `text` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `target_type` (`target_type`),
  KEY `target_id` (`target_id`),
  KEY `text` (`text`),
  KEY `property_id` (`property_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


-- 29-10-2013

--
-- Структура таблицы `prefix_property_select`
--

CREATE TABLE IF NOT EXISTS `prefix_property_select` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `value` varchar(250) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `property_id` (`property_id`),
  KEY `target_type` (`target_type`),
  KEY `sort` (`sort`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_property_value_select`
--

CREATE TABLE IF NOT EXISTS `prefix_property_value_select` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target_id` int(11) NOT NULL,
  `select_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `target_type` (`target_type`),
  KEY `target_id` (`target_id`),
  KEY `property_id` (`property_id`),
  KEY `select_id` (`select_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- 23.01.2014
--
-- Структура таблицы `prefix_property_target`
--

CREATE TABLE IF NOT EXISTS `prefix_property_target` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `date_create` datetime NOT NULL,
  `date_update` datetime DEFAULT NULL,
  `state` tinyint(4) NOT NULL DEFAULT '1',
  `params` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `date_create` (`date_create`),
  KEY `date_update` (`date_update`),
  KEY `state` (`state`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


-- 27.01.2014
--
-- Структура таблицы `prefix_rbac_permission`
--

CREATE TABLE IF NOT EXISTS `prefix_rbac_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `title` varchar(250) NOT NULL,
  `msg_error` varchar(250) NOT NULL,
  `date_create` datetime NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `code` (`code`),
  KEY `date_create` (`date_create`),
  KEY `state` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_rbac_role`
--

CREATE TABLE IF NOT EXISTS `prefix_rbac_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `title` varchar(250) NOT NULL,
  `date_create` datetime NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `state` (`state`),
  KEY `date_create` (`date_create`),
  KEY `code` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Структура таблицы `prefix_rbac_role_permission`
--

CREATE TABLE IF NOT EXISTS `prefix_rbac_role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `permission_id` (`permission_id`),
  KEY `date_create` (`date_create`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `prefix_rbac_user_role`
--

CREATE TABLE IF NOT EXISTS `prefix_rbac_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `role_id` int(11) NOT NULL,
  `date_create` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  KEY `date_create` (`date_create`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `prefix_rbac_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `title` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE `prefix_rbac_permission` ADD `group_id` INT NULL DEFAULT NULL AFTER `id` ,
ADD INDEX ( `group_id` );
ALTER TABLE `prefix_rbac_group` ADD `date_create` DATETIME NOT NULL ;
RENAME TABLE `prefix_rbac_user_role` TO `prefix_rbac_role_user`;



-- 07.12.2014

--
-- Дамп данных таблицы `prefix_rbac_group`
--

INSERT INTO `prefix_rbac_group` (`id`, `code`, `title`, `date_create`) VALUES
(1, 'user', 'Пользователи', '2014-12-07 07:52:18');