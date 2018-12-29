-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Дек 26 2018 г., 07:14
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
-- Структура таблицы `prefix_talk_message`
--

CREATE TABLE `prefix_talk_message` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(50) NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `target_id` bigint(20) UNSIGNED NOT NULL,
  `text` text NOT NULL,
  `date_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8_bin;


--
-- Индексы таблицы `prefix_talk_message`
--
ALTER TABLE `prefix_talk_message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `target_id` (`target_id`),
  ADD KEY `date_create` (`date_create`),
  ADD KEY `date_update` (`date_update`);

