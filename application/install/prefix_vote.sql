-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Дек 24 2018 г., 15:55
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
-- Структура таблицы `prefix_vote`
--

CREATE TABLE `prefix_vote` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `vote` smallint(6) NOT NULL,
  `target_type` varchar(20) NOT NULL,
  `target_id` int(10) UNSIGNED NOT NULL,
  `date_update` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `date_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `prefix_vote`
--
ALTER TABLE `prefix_vote`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `target_type` (`target_type`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `vote` (`vote`),
  ADD KEY `date_update` (`date_update`),
  ADD KEY `date_create` (`date_create`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `prefix_vote`
--
ALTER TABLE `prefix_vote`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
