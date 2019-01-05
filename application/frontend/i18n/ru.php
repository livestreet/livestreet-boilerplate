<?php

/* -------------------------------------------------------
 *
 *   LiveStreet Engine Social Networking
 *   Copyright © 2008 Mzhelskiy Maxim
 *
 * --------------------------------------------------------
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
 * Русский языковой файл.
 * Содержит все текстовки движка.
 */
return array(
    'menu' => [
        'humans' => [
            'text'=>'Люди'
        ],
        'companies' => [
            'text'=>'Комппании'
        ]
    ],
    'user' => [
        'userbar' => [
            'nav' => [
                'profile'       => 'Моя страница',
                'settings'      => 'Настройки',
                'responses'     => 'Отзывы',
                'proposals'     => 'Предложения',
                'proposed'      => 'Я предложил',
                'responsed'     => 'Я написал',
                'arbitrage'     => 'Арбитраж',
                'moderation'    => 'Модерация'
            ]
        ],
        'profile' => [
            'counts' => [
                'responses'     => '%%count%% отзыв; %%count%% отзыва; %%count%% отзывов',
                'answers'     => '%%count%% ответ; %%count%% ответа; %%count%% ответов',
                'proposals'     => '%%count%% предложение; %%count%% предложения; %%count%% предложений',
            ],
            'nav' => [
                'all'           => 'Все',
                'responses_votes'     => 'Оценки и отзывы',
                'proposals'     => 'Предложения'
                
            ],
            'notices' => [
                'response_blankslate'    => 'Отзывов пока нет',
                'proposal_blankslate'    => 'Предложений пока нет',
                'arbitrage_blankslate'    => 'Арбитраж пуст',
                'all_blankslate'    => 'Отзывов и предложений пока нет',
            ],
            'actions' => [
                'confirm' => [
                    'text' => 'Вы владелец этой компании?'
                ],  
                'response' => [
                    'text' => 'Написать отзыв'
                ],
                'proposal' => [
                    'text' => 'Предложение'
                ]
            ],
        ],
        'settings' => [
            "profile" => [
                'title' => 'Настройки профиля',
                'form' => [
                    'photo' => [
                        'label' => 'Фото',
                        'text'  => 'Выберете фото'
                    ],
                    'name' => [
                        'label' => 'Фамилия Имя'
                    ],
                    'name_company' => [
                        'label' => 'Название компании'
                    ],
                    'about' => [
                        'label' => 'О себе'
                    ],
                    'about_company' => [
                        'label' => 'О комании'
                    ]
                ]
            ],
            "notices" => [
                'title' => 'Оповещения',
                'form' => [
                    'password' => [
                        'label' => 'Текущий пароль'
                    ]
                ]
            ],
            "security" => [
                'title' => 'Сменить пароль',
                'form' => [
                    'password' => [
                        'label' => 'Текущий пароль'
                    ]
                ]
            ]
        ]
    ],
    'rating' => [
        'of' => 'из',
        'count' => 'Оценок',
        'stars' => [
            'title' => '%%val%% из %%of%% звезд',
            'clear' => 'Очистить'
        ]
    ],
    'profile' => [
        'notices' => [
            'error_user_not_found' => 'Пользователь не найден',
            'notice_alien_profile' => 'Вы находитесь в настройках чужого профиля'
        ]
    ],
    'talk' => [
        'response' => [
            'modal' => [
                'title' => 'Написать отзыв',
                'title_edit' => 'Редактировать отзыв'
            ],
            'form' => [
                'text' => [
                    'label' => 'Текст отзыва',
                    'placeholder' => 'Оставте свой отзыв',
                    'error_validate' => 'Введите текст от %%min%% до %%max%% символов'
                ],
                'photo' => [
                    'label' => 'Добавить фото',
                    'text' => 'Выбрать'
                ],
                'stars' => [
                    'label' => 'Ваша оценка',
                    'error_validate' => 'Поставте оценку'
                ],
                'submit' => [
                    'text' => 'Отправить'
                ]
            ],
            'notice' => [
                'error_double_text' => 'Отзыв с таким текстом уже добавлен',
                'success_add' => 'Успешно добавлено. Спасибо за ваш отзыв.',
                'error_not_found' => 'Отзыв не найден'
            ]
        ],
        'proposal' => [
            'modal' => [
                'title' => 'Написать предложение'
            ],
            'form' => [
                'text' => [
                    'label' => 'Оставте свое предложение',
                    'placeholder' => 'Текст предложения',
                    'error_validate' => 'Введите текст от %%min%% до %%max%% символов'
                ],
                'photo' => [
                    'label' => 'Добавить фото',
                    'text' => 'Выбрать'
                ],
                'submit' => [
                    'text' => 'Отправить'
                ]
            ],
            'notice' => [
                'error_double_text' => 'Предложение с таким текстом уже добавлено',
                'success_add' => 'Успешно добавлено. Спасибо за ваше ппредложение.'
            ]
        ],
        'answer' => [
            'btn' => [
                'text' => 'Ответить'
            ],
            'form' => [
                'text' => [
                    'label' => 'Ответ',
                    'placeholder' => 'Текст ответа',
                    'error_validate' => 'Введите текст от %%min%% до %%max%% символов'
                ],
                'photo' => [
                    'label' => 'Добавить изображение',
                    'text' => 'Выбрать'
                ],
                'submit' => [
                    'text' => 'Отправить'
                ]
            ],
            'notice' => [
                'error_double_text' => 'Ответ с таким текстом уже добавлен',
                'success_add' => 'Успешно добавлено.',
                'success_remove' => 'Успешно удалено'
            ]
        ],
        'arbitrage' => [
            'btn' => [
                'text' => 'В арбитраж'
            ],
            'link_chat' => [
                'text' => 'Перейти в чат'
            ],
            'form' => [
                'text' => [
                    'label' => 'Напишите чем Вам не нравится этот отыв',
                    'placeholder' => 'Текст жалобы',
                    'error_validate' => 'Введите текст от %%min%% до %%max%% символов'
                ],
                'photo' => [
                    'label' => 'Добавить фото',
                    'text' => 'Выбрать'
                ],
                'submit' => [
                    'text' => 'Отправить'
                ]
            ],
            'notice' => [
                'wait_moderate' => 'Ожидает ответа модератора',
                'error_double_text' => 'Арбитраж с таким текстом уже добавлен',
                'success_add' => 'Арбитраж создан.'
            ]
        ]
    ],
    'moderation' => [
        'menu' => [
            'moderation' => 'Модерация',
            'arbitrage' => 'Арбитраж',
            'responses_all' => 'Все отзывы'
        ],
        'btn_view' => [
            'text' => 'Полный / Свернутый'
        ],
        'responses' => [
            'title' => 'Модерация отзывов',
            'table_row' => [
                'number'    => '№',
                'from'      => 'От кого',
                'to'        => 'Кому',
                'rating'    => 'Оценка'
            ],
            'actions' => [
                'edit'      => 'Редактировать',
                'delete'    => 'Удалить',
                'publish'   => 'Опубликовать'
            ],
            'blankslate' => [
                'text' => 'Отзывов для модерации нет'
            ],
            'notice' => [
                'confirm_publish'   => 'Вы действительно хотите оставить этот отзыв?',
                'confirm_delete'   => 'Вы действительно хотите переместить этот отзыв в удаленные?',
                'success_publish' => 'Опубликовано',
                'success_delete' => 'Перемещено в удаленные'
            ]
        ],
        'responses_all' => [
            'title' => 'Все отзывы',
            'form' => [
                'from' => 'От кого',
                'to'    => 'Кому',
                'login' => [
                    'placeholder' => 'Логин пользователя'
                ],
                'text'  => 'Текст содержит',
                'sort'  => 'Сортировать',
                'submit' => 'Искать'
            ]
        ],
        'arbitrage' => [
            'title' => 'Арбитраж',
            
            'actions' => [
                'delete'    => 'Удалить',
                'publish'   => 'Опубликовать'
            ],
            'blankslate' => [
                'text' => 'Здесь пусто'
            ],
            'notice' => [
                'confirm_publish'   => 'Вы действительно хотите оставить этот отзыв?',
                'confirm_delete'   => 'Вы действительно хотите переместить этот отзыв в удаленные?',
                'success_publish' => 'Промодерировано',
                'success_delete' => 'Перемещено в удаленные'
            ]
        ]
    ],
    /**
     * Поля
     */
    'field'          => array(
        'email'       => array(
            'label'   => 'E-mail',
            'notices' => array(
                'error' => 'Неверный формат e-mail',
            ),
        ),
        'geo'         => array(
            'select_country' => 'Выберите страну',
            'select_region'  => 'Укажите регион',
            'select_city'    => 'Укажите город',
        ),
        'upload_area' => array(
            'label' => 'Перетащите сюда файлы или кликните по этому тексту',
        ),
        'category'    => array(
            'label' => 'Категория'
        ),
    ),
    /**
     * Авторизация
     */
    'auth'           => array(
        'authorization' => 'Авторизация',
        'logout'        => 'Выйти',
        // Вход
        'login'         => array(
            'title'   => 'Войти',
            'form'    => array(
                // Поля
                'fields' => array(
                    'login_or_email'    => array(
                        'placeholder' => 'Логин или Email'
                    ),
                    'password'    => array(
                        'placeholder' => 'Пароль'
                    ),
                    'remember' => array(
                        'label' => 'Запомнить меня'
                    ),
                    'submit'   => array(
                        'text' => 'Войти'
                    )
                )
            ),
            // Всплывающие сообщения
            'notices' => array(
                'error_login'         => 'Неправильно указан логин (e-mail) или пароль!',
                'error_not_activated' => 'Вы не активировали вашу учетную запись. <br/> <a href="%%reactivation_path%%">Повторный запрос активации</a>'
            ),
        ),
        // Повторный запрос активации
        'reactivation'  => array(
            'title'   => 'Повторный запрос активации',
            'form'    => array(
                // Поля
                'fields' => array(
                    'mail'   => array(
                        'label' => 'Ваш e-mail'
                    ),
                    'submit' => array(
                        'text' => 'Получить ссылку на активацию'
                    )
                )
            ),
            // Всплывающие сообщения
            'notices' => array(
                'success' => 'Ссылка для активации отправлена на ваш адрес электронной почты',
            )
        ),
        // Сброс пароля
        'reset'         => array(
            'title'   => 'Восстановление пароля',
            'form'    => array(
                // Поля
                'fields' => array(
                    'mail'   => array(
                        'label' => 'Ваш e-mail'
                    ),
                    'submit' => array(
                        'text' => 'Получить ссылку на изменение пароля'
                    )
                )
            ),
            // Всплывающие сообщения
            'notices' => array(
                'success_send_password' => 'Новый пароль отправлен на ваш адрес электронной почты',
                'success_send_link'     => 'Ссылка для восстановления пароля отправлена на ваш адрес электронной почты',
            ),
            // Сообщения
            'alerts'  => array(
                'error_bad_code' => 'Неверный код на восстановление пароля.',
            )
        ),
        // Регистрация
        'registration'  => array(
            'title'   => 'Регистрация',
            'form'    => array(
                // Поля
                'fields' => array(
                    'email' => [
                        'error' => 'Введите корректный email',
                        'placeholder' => 'Email'
                    ],
                    'name' => [
                        'placeholder' => 'Имя Фамилия',
                    ],
                    'name_company' => [
                        'placeholder' => 'Название компании',
                    ],
                    'login' =>[
                        'placeholder' => 'Логин',
                        'desc' => 'Будет использоваться как ссылка на профиль (fend.ru/login)'
                    ],
                    'password_confirm' => array(
                        'label' => 'Повторите пароль'
                    ),
                    'submit'           => array(
                        'text' => 'Зарегистрироваться'
                    ),
                    'password' => [
                        'placeholder' => 'Пароль',
                    ]
                )
            ),
            'confirm' => array(
                'title' => 'Активация аккаунта',
                'text'  => 'Вы почти зарегистрировались, осталось только активировать аккаунт. Инструкции по активации отправлены по электронной почте на адрес, указанный при регистрации.'
            ),
            // Сообщения
            'notices' => array(
                'password_no_valid'  => 'Введите от %%min%% до %%max%% символов',
                'name_no_valid'      => 'Введите от %%min%% до %%max%% символов',
                'already_registered' => 'Вы уже зарегистрированы у нас и даже авторизованы!',
                'success'            => 'Поздравляем! Регистрация прошла успешно',
                'success_activate'   => 'Поздравляем! Ваш аккаунт успешно активирован.',
                'error_login'        => 'Неверный логин, допустим от 3 до 30 символов',
                'error_login_used'   => 'Этот логин уже занят',
                'error_mail_used'    => 'Этот e-mail уже используется',
                'error_reactivate'   => 'Ваш аккаунт уже активирован',
                'error_code'         => 'Неверный код активации!',
                'role_no_exists'     => 'Роль %%role%% не найдена'
            ),
        ),
        // Общие лэйблы
        'labels'        => array(
            'login'    => 'Логин',
            'password' => 'Пароль',
            'captcha'  => 'Введите цифры и буквы',
            'captcha_field' => 'Каптча',
        ),
        // Общие всплывающие сообщения
        'notices'       => array(
            'error_bad_email' => 'Пользователь с таким e-mail не найден',
        ),
    ),
    /**
     * Мэйлы
     */
    'emails'         => array(
        'common'                => array(
            'regards'      => 'С уважением, администрация сайта',
        ),
        // Повторная активация
        'reactivation'          => array(
            'subject' => 'Повторный запрос активации',
            'text'    =>
                'Вы запросили повторную активацию на сайте <a href="%%website_url%%">%%website_name%%</a>
				<br><br>
				Ссылка на активацию аккаунта:
				<br>
				<a href="%%activation_url%%">%%activation_url%%</a>'
        ),
        // Регистрация
        'registration'          => array(
            'subject' => 'Регистрация',
            'text'    =>
                'Вы зарегистрировались на сайте <a href="%%website_url%%">%%website_name%%</a>
				<br><br>
				Ваши регистрационные данные:
				<br><br>
				E-mail: <b>%%mail%%</b><br>'
        ),
        // Подтверждение регистрации
        'registration_activate' => array(
            'subject' => 'Регистрация',
            'text'    =>
                'Вы зарегистрировались на сайте <a href="%%website_url%%">%%website_name%%</a>
				<br><br>
				Ваши регистрационные данные:
				<br><br>
				E-mail: <b>%%mail%%</b>
				<br><br>
				Для завершения регистрации вам необходимо активировать аккаунт пройдя по ссылке:<br>
				<a href="%%activation_url%%">%%activation_url%%</a>'
        ),
        // Смена пароля
        'reminder_code'         => array(
            'subject' => 'Восстановление пароля',
            'text'    =>
                'Если вы хотите сменить себе пароль на сайте <a href="%%website_url%%">%%website_name%%</a>, то перейдите по ссылке ниже:<br>
				<a href="%%recover_url%%">%%recover_url%%</a>'
        ),
        // Новый пароль
        'reminder_password'     => array(
            'subject' => 'Новый пароль',
            'text'    =>
                'Вам присвоен новый пароль: <b>%%password%%</b>'
        ),
    ),
    /**
     * Загрузка изображений
     */
    'media'         => array(
        'library' => [
            'files' => [
                'empty' => 'Файлов нет'
            ],
            'info' => [
                'empty' => 'Выберете файл',
                'list'  => [
                    'id'    => 'ID',
                    'name'  => 'Имя',
                    'date'  => 'Добавлено',
                    'dimensions' => 'Разрешение',
                    'size'  => 'Размер',
                    'sizes' => 'Размеры',
                    'count_targets' => 'Использовано'
                ]
            ],
            'cutButton'     => [
                'title'     => 'Добавить размер'
            ],
            'primaryButton' => 'Вставить'
        ],
        'title'       => 'Загрузка медиа-файлов',
        'notices'     => [
            'confirm_remove_file' => 'Вы уверены, что хотите удалить файл?'
        ],
        'error'       => array(
            'upload'            => 'Не удалось загрузить файл',
            'not_image'         => 'Файл не является изображением',
            'too_large'         => 'Превышен максимальный размер файла: %%size%%Кб',
            'incorrect_type'    => 'Неверный тип файла',
            'max_count_files'   => 'Превышено максимальное число файлов',
            'need_choose_items' => 'Необходимо выбрать элементы',
        ),
        'nav'         => array(
            'insert'   => 'Вставить',
            'photoset' => 'Создать фотосет',
            'url'      => 'Вставить по ссылке',
            'preview'  => 'Превью',
        ),
        'image_align' => array(
            'title'  => 'Выравнивание',
            'no'     => 'Нет',
            'left'   => 'Слева',
            'right'  => 'Справа',
            'center' => 'По центру',
        ),
        'insert'      => array(
            'submit'   => 'Вставить',
            'settings' => array(
                'title'  => 'Опции вставки',
                'fields' => array(
                    'size' => array(
                        'label'    => 'Размер',
                        'original' => 'Оригинал'
                    ),
                )
            ),
        ),
        'photoset'    => array(
            'submit'   => 'Создать фотосет',
            'settings' => array(
                'title'  => 'Опции фотосета',
                'fields' => array(
                    'use_thumbs'   => array(
                        'label' => 'Показывать ленту с превьюшками'
                    ),
                    'show_caption' => array(
                        'label' => 'Показывать описания фотографий'
                    )
                )
            ),
        ),
        'url'         => array(
            'fields'        => array(
                'url'   => array(
                    'label' => 'Ссылка',
                ),
                'title' => array(
                    'label' => 'Описание',
                ),
            ),
            'submit_insert' => 'Вставить как ссылку',
            'submit_upload' => 'Загрузить и вставить'
        ),
        'uploader' => [
            'notices' => [
                'errorDublicate' => 'Файл с таким именем уже добавлен'
            ]
        ]
    ),
    
    'crop' => [
        'title' => 'Обрезать фото'
    ],
    /**
     * Админка
     */
    'admin'         => array(
        'title'                => 'Админка',
        'items'                => array(
            'plugins' => '___admin.plugins.title___',
        ),
        'install_plugin_admin' => 'Установить расширенную админ-панель',
        // Страница администрирования плагинов
        'plugins'              => array(
            'title'   => 'Управление плагинами',
            'plugin'  => array(
                'author'       => 'Автор',
                'version'      => 'Версия',
                'url'          => 'Сайт',
                'activate'     => 'Активировать',
                'deactivate'   => 'Деактивировать',
                'settings'     => 'Настройки',
                'remove'       => '___common.remove___',
                'apply_update' => 'Применить обновление',
            ),
            // Сообщения
            'notices' => array(
                'unknown_action'              => 'Указано неизвестное действие',
                'action_ok'                   => 'Успешно выполнено',
                'activation_overlap'          => 'Конфликт с активированным плагином. Ресурс %%resource%% переопределен на %%delegate%% плагином %%plugin%%.',
                'activation_overlap_inherit'  => 'Конфликт с активированным плагином. Ресурс %%resource%% используется как наследник в плагине %%plugin%%.',
                'activation_file_not_found'   => 'Файл плагина не найден',
                'activation_file_write_error' => 'Файл плагина не доступен для записи',
                'activation_version_error'    => 'Для работы плагина необходимо ядро LiveStreet версии не ниже %%version%%',
                'activation_requires_error'   => 'Для работы плагина необходим активированный плагин <b>%%plugin%%</b>',
                'activation_already_error'    => 'Плагин уже активирован',
                'deactivation_already_error'  => 'Плагин не активирован',
                'deactivation_requires_error' => 'От плагина зависит другой плагин, сначала отключите его -  <b>%%plugin%%</b>',
            )
        ),
    ),
);