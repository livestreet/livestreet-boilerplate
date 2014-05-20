<?php

$config = array();

$config['head']['default']['js'] = Config::Get('head.default.js');
$config['head']['default']['js'][] = '___path.skin.assets.web___/js/init.js';


$aCss = array(
	// Base styles
	"___path.skin.assets.web___/css/style.css",
);

// Подключение темы
if ( Config::Get('view.theme') ) {
	$aCss[] = "___path.skin.web___/themes/___view.theme___/style.css";
}

// Подключение фронтенд фреймворка
$config['head']['default']['css'] = array_merge(Config::Get('head.default.css'), $aCss);


return $config;