<?php
/*-------------------------------------------------------
*
*   LiveStreet Engine Social Networking
*   Copyright © 2008 Mzhelskiy Maxim
*
*--------------------------------------------------------
*
*   Official site: www.livestreet.ru
*   Contact e-mail: rus.engine@gmail.com
*
*   GNU General Public License, version 2:
*   http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
*
---------------------------------------------------------
*/

/**
 * !!!!! ВНИМАНИЕ !!!!!
 *
 * Ничего не изменяйте в этом файле!
 * Все изменения нужно вносить в файл config/config.local.php
 */
define('LS_VERSION','2.0.0');

/**
 * Основные настройки путей
 * Если необходимо установить движек в директорию(не корень сайта) то следует сделать так:
 * $config['path']['root']['web']    = 'http://'.$_SERVER['HTTP_HOST'].'/subdir';
 * и увеличить значение $config['path']['offset_request_url'] на число вложенных директорий,
 * например, для директории первой вложенности www.site.ru/livestreet/ поставить значение равное 1
 */
$config['path']['root']['server']		= dirname(dirname(dirname(__FILE__)));
$config['path']['root']['web']			= isset($_SERVER['HTTP_HOST']) ? 'http://'.$_SERVER['HTTP_HOST'] : null;
$config['path']['offset_request_url']	= 0;

$config['sys']['cache']['use'] = false;
/**
 * Настройки HTML вида
 */
$config['view']['skin']        = 'bootstrap';		// Название текущего шаблона
$config['view']['theme'] = 'default';			// тема оформления шаблона (шаблон должен поддерживать темы)
$config['view']['name']        = 'Fend';                   // название сайта
$config['view']['description'] = 'Description your site'; // seo description
$config['view']['keywords']    = 'site, google, internet';      // seo keywords
$config['view']['wysiwyg']         = false;  // использовать или нет визуальный редактор TinyMCE
$config['view']['noindex']          = true;   // "прятать" или нет ссылки от поисковиков, оборачивая их в тег <noindex> и добавляя rel="nofollow"
$config['view']['img_resize_width'] = 570;    // до какого размера в пикселях ужимать картинку по щирине при загрузки её в топики и комменты
$config['view']['img_max_width'] = 5000;    // максимальная ширина загружаемых изображений в пикселях
$config['view']['img_max_height'] = 5000;    // максимальная высота загружаемых изображений в пикселях
$config['view']['img_max_size_url'] = 500;    // максимальный размер картинки в kB для загрузки по URL


/**
 * Общие настройки
 */
$config['general']['admin_mail']  = 'admin@admin.adm'; // email администратора
$config['general']['captcha']['type'] = 'recaptcha'; // тип используемой каптчи: kcaptcha, recaptcha

/**
 * Настройки модулей
 */
// User
$config['module']['user']['time_login_remember'] = 60 * 60 * 24 * 7;   // время жизни куки когда пользователь остается залогиненым на сайте, 7 дней
$config['module']['user']['count_auth_session'] = 4; // Количество разрешенных сессий пользователя (авторизаций в разных браузерах)
$config['module']['user']['count_auth_session_history'] = 10; // Общее количество сессий для хранения (значение должно быть больше чем count_auth_session)
$config['module']['user']['login']['charset'] = '0-9a-z_\-'; // Допустимые в имени пользователя символы
$config['module']['user']['login']['min_size'] = 3; // Минимальное количество символов в логине
$config['module']['user']['login']['max_size'] = 30; // Максимальное количество символов в логине
$config['module']['user']['captcha_use_registration'] = true; // Использовать капчу при регистрации
$config['module']['user']['user_guest'] = true; //Разрешать анониму создавать отзывы

$config['module']['user']['photo']['width'] = 300; // 
$config['module']['user']['avatar']['width'] = 50; // 
$config['module']['user']['avatar_small']['width'] = 30; // 

$config['module']['user']['search']['per_page'] = 2; //
$config['module']['user']['search']['pagination']['pages_count'] =5; //
$config['module']['user']['search_ajax']['limit'] = 6; //

//Модуль рейтинг
$config['module']['rating']['max_rating'] = 5; // 

// Модуль Lang
$config['module']['lang']['delete_undefined'] = true;   // Если установлена true, то модуль будет автоматически удалять из языковых конструкций переменные вида %%var%%, по которым не была произведена замена
$config['lang']['load_to_js'] = [
    'media.uploader.notices.errorDublicate',
    'media.notices.confirm_remove_file',
    'common.remove_confirm'
];
// Модуль Notify
$config['module']['notify']['delayed']       = false;    // Указывает на необходимость использовать режим отложенной рассылки сообщений на email
$config['module']['notify']['insert_single'] = false;    // Если опция установлена в true, систему будет собирать записи заданий удаленной публикации, для вставки их в базу единым INSERT
$config['module']['notify']['per_process']   = 10;       // Количество отложенных заданий, обрабатываемых одним крон-процессом
$config['module']['notify']['dir']           = 'emails'; // Путь до папки с емэйлами относительно шаблона
$config['module']['notify']['prefix']        = 'email';  // Префикс шаблонов емэйлов

// Модуль Security
$config['module']['security']['hash']  = "livestreet_security_key"; // "примесь" к строке, хешируемой в качестве security-кода
/**
 * Модуль Talk
 */
$config['module']['talk']['pagination']['pages']['count'] = 5;
$config['module']['talk']['page_count'] = 10;

/*
 * Модерация
 */
$config['moderation']['talk']['page_count'] = 10;
/**
 * Модуль Media
 */
$config['module']['media']['max_size'] = 3*1024; // Максимальный размер файла в kB
$config['module']['media']['max_count_files'] = 30; // Максимальное количество файлов медиа у одного объекта
$config['module']['media']['image']['max_size'] = 1*1024; // Максимальный размер файла изображения в kB
$config['module']['media']['image']['autoresize'] = true; // Разрешает автоматическое создание изображений нужного размера при их запросе
$config['module']['media']['image']['original'] = '1500x'; // Размер для хранения оригинала. Если true, то будет сохраняться исходный оригинал без ресайза. Если false, то оригинал сохраняться не будет
$config['module']['media']['image']['sizes'] = array(  // список размеров, которые необходимо делать при загрузке изображения
    
    array(
        'w'    => 200,
        'h'    => null,
        'crop' => false,
    ),
    array(
        'w'    => 500,
        'h'    => null,
        'crop' => false,
    ),
    array(
        'w'    => null,
        'h'    => 200,
        'crop' => true,
    ),
    array(
        'w'    => 50,
        'h'    => 50,
        'crop' => true,
    )
);
$config['module']['media']['image']['preview']['sizes'] = array(  // список размеров, которые необходимо делать при создании превью
    array(
        'w'    => 900,
        'h'    => 300,
        'crop' => true,
    ),
    array(
        'w'    => 250,
        'h'    => 150,
        'crop' => true,
    ),
);


// Настройки Google рекаптчи - https://www.google.com/recaptcha/admin#createsite
$config['module']['validate']['recaptcha']= array(
	'site_key' => '', // Ключ
	'secret_key' => '', // Секретный ключ
	'use_ip' => false, // Использовать при валидации IP адрес клиента
);



// Какие модули должны быть загружены на старте
$config['module']['autoLoad'] = array('Hook','Cache','Logger','Security','Session','Lang','Message');
/**
 * Настройка базы данных
 */
$config['db']['params']['host']   = 'localhost';
$config['db']['params']['port']   = '3306';
$config['db']['params']['user']   = 'root';
$config['db']['params']['pass']   = '';
$config['db']['params']['type']   = 'mysqli';
$config['db']['params']['dbname'] = 'social';
$config['db']['tables']['engine'] = 'InnoDB';  // InnoDB или MyISAM
/**
 * Настройка таблиц базы данных
 */
$config['db']['table']['prefix'] = 'prefix_';
$config['db']['table']['notify_task'] = '___db.table.prefix___notify_task';
$config['db']['table']['plugin_manager_migration'] = '___db.table.prefix___plugin_migration';
$config['db']['table']['plugin_manager_version'] = '___db.table.prefix___plugin_version';
$config['db']['table']['storage'] = '___db.table.prefix___storage';

$config['db']['table']['user'] = '___db.table.prefix___user';
$config['db']['table']['user_session'] = '___db.table.prefix___session';
$config['db']['table']['session'] = $config['db']['table']['user_session'];
$config['db']['table']['user_reminder'] = '___db.table.prefix___reminder';
$config['db']['table']['media'] = '___db.table.prefix___media';
$config['db']['table']['media_target'] = '___db.table.prefix___media_target';
$config['db']['table']['rating_vote'] = '___db.table.prefix___rating_vote';
$config['db']['table']['talk_message'] = '___db.table.prefix___talk_message';
$config['db']['table']['talk_proposal'] = '___db.table.prefix___talk_message';
$config['db']['table']['talk_response'] = '___db.table.prefix___talk_message';
$config['db']['table']['talk_answer'] = '___db.table.prefix___talk_message';
$config['db']['table']['talk_arbitrage'] = '___db.table.prefix___talk_message';
$config['db']['table']['rbac_role'] = '___db.table.prefix___rbac_role';
$config['db']['table']['rbac_permission'] = '___db.table.prefix___rbac_permission';
$config['db']['table']['rbac_role_permission'] = '___db.table.prefix___rbac_role_permission';
$config['db']['table']['rbac_role_user'] = '___db.table.prefix___rbac_role_user';

/**
 * Настройки роутинга
 */
$config['router']['rewrite'] = array();
// Правила реврайта для REQUEST_URI
$config['router']['uri'] = array(
	'~^page\-num\-(\d+)~i' => "index/page-num-\\1",
);
// Распределение action
$config['router']['page']['admin']          = 'ActionAdmin';
$config['router']['page']['error']          = 'ActionError';
$config['router']['page']['index']          = 'ActionIndex';
$config['router']['page']['ajax']           = 'ActionAjax';
$config['router']['page']['auth']           = 'ActionAuth';
$config['router']['page']['profile']        = 'ActionProfile';
$config['router']['page']['moderation']     = 'ActionModeration';
$config['router']['page']['companies']      = 'ActionCompanies';
$config['router']['page']['people']         = 'ActionPeople';
// Глобальные настройки роутинга
$config['router']['config']['default']['action']	= 'index';
$config['router']['config']['default']['event']		= null;
$config['router']['config']['default']['params']	= null;
$config['router']['config']['default']['request']	= null;
$config['router']['config']['action_not_found']		= 'error';
// Принудительное использование https для экшенов. Например, 'login' и 'registration'
$config['router']['force_secure'] = array();


/**
 * Подключение компонентов
 */
$config['components'] = array(
	// Базовые компоненты
	'css-reset', 'css-helpers', 'typography', 'forms', 'grid', 'ls-vendor', 'ls-core', 'ls-component', 'lightbox', 'avatar', 'slider', 'details', 'alert', 'dropdown', 'button', 'block',
	'nav', 'tooltip', 'tabs', 'modal', 'table', 'text', 'uploader', 'email', 'field', 'pagination', 'editor', 'more', 'crop',
	'performance', 'toolbar', 'actionbar', 'badge', 'autocomplete', 'icon', 'item', 'highlighter', 'jumbotron', 'notification', 'blankslate',

	// Компоненты приложения
	'auth', 'userbar', 'toolbar-scrollup',
);

$config['head']['default']['js'] = array(
	//"https://www.google.com/recaptcha/api.js?onload=__do_nothing__&render=explicit" => array('merge' => false),
);
$config['head']['default']['css'] = array();

// Подключение темы
if ( $config['view']['theme'] ) {
	//$config['head']['default']['css'][] = "___path.skin.web___/themes/___view.theme___/style.css";
}


/**
 * Установка локали
 */
setlocale(LC_ALL, "ru_RU.UTF-8");
date_default_timezone_set('Europe/Moscow'); // See http://php.net/manual/en/timezones.php

/**
 * Настройки типографа текста Jevix
 * Добавляем к настройках из /framework/config/jevix.php
 */
$config['jevix']=array_merge_recursive((array)Config::Get('jevix'),require(dirname(__FILE__).'/jevix.php'));


return $config;