<?php

$config = array();

$config['view']['container']['fluid'] = true;

$config['view']['grid']['breakpoint'] = 'md';

// Подключение скриптов шаблона
$config['head']['template']['js'] = array(
    "https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js",
    "___path.skin.web___/themes/___view.theme___/js/bootstrap.min.js",
    '___path.skin.assets.web___/js/init.js',
);

// Подключение стилей шаблона
$config['head']['template']['css'] = array(
    "___path.skin.assets.web___/css/layout.css",
    "___path.skin.assets.web___/css/print.css",
    "___path.skin.web___/themes/___view.theme___/css/bootstrap.min.css"
);

$config['view']['bs_themes'] = [
    'default' => [
        'color' => 'light',
        'bg' => 'light'
    ],
    'light' => [
        'color' => 'light',
        'bg' => 'light'
    ],

];

// Подключение темы
$theme = Config::Get('view.theme')?Config::Get('view.theme'):'default'; 

$config['view']['bs_theme'] = $config['view']['bs_themes'][$theme];

$config['components'] = [
    // Базовые компоненты
    'ls-vendor', 'ls-core', 'ls-component', 'editor', 'notification', 'auth',

    //Компоненты шаблона
    'bs-dropdown', 'bs-form'
];

$config['head']['default']['js'] = array(
	//"https://www.google.com/recaptcha/api.js?onload=__do_nothing__&render=explicit" => array('merge' => false),
);

/**
 * SEO
 */

// Тег используемый для заголовков топиков
$config['view']['seo']['topic_heading'] = 'h1';
$config['view']['seo']['topic_heading_list'] = 'h2';

return $config;
