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
-- Индексы сохранённых таблиц
--

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
-- AUTO_INCREMENT для сохранённых таблиц
--

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
