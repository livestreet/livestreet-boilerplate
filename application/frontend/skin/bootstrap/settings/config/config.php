<?php

$config = array();

// Подключение скриптов шаблона
$config['head']['template']['js'] = array(
	'___path.skin.assets.web___/js/init.js'
);

// Подключение стилей шаблона
$config['head']['template']['css'] = array(
	"___path.skin.assets.web___/css/style.css",
);

$config['components'] = Config::Get('components');
$config['components'][] = 'bootstrap';

return $config;