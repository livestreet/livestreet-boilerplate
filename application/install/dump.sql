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
 ADD PRIMARY KEY (`id`), ADD KEY `mail` (`mail`), ADD KEY `password` (`password`), ADD KEY `activate_key` (`activate_key`), ADD KEY `active` (`active`), ADD KEY `activate` (`activate`);

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