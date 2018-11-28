<?php

class ModuleUser extends ModuleORM
{

    /**
     * Объект текущего пользователя
     *
     * @var ModuleUser_EntityUser|null
     */
    protected $oUserCurrent = null;
    /**
     * Объект сессии текущего пользователя
     *
     * @var ModuleUser_EntitySession|null
     */
    protected $oSession = null;

    /**
     * Инициализация
     *
     */
    public function Init()
    {
        parent::Init();
        /**
         * Проверяем есть ли у юзера сессия, т.е. залогинен или нет
         */
        $sUserId = $this->Session_Get('user_id');
        $sSessionKey = $this->Session_Get('session_key');
        if ($sUserId and $oUser = $this->GetUserById($sUserId) and $oUser->getActive() and $oUser->getActivate()) {
            /**
             * Проверяем сессию
             */
            if ($oSession = $oUser->getSession()) {
                $bSessionValid = false;
                /**
                 * Т.к. у пользователя может быть несколько сессий (разные браузеры), то нужно дополнительно сверить
                 */
                if ($oSession->getKey() == $sSessionKey and $oSession->isActive()) {
                    $bSessionValid = true;
                } else {
                    /**
                     * Пробуем скорректировать сессию
                     */
                    if ($oSession = $this->GetSessionByKey($sSessionKey) and $oSession->getUserId() == $oUser->getId() and $oSession->isActive()) {
                        $bSessionValid = true;
                        $oUser->setSession($oSession);
                    }
                }
                if ($bSessionValid) {
                    /**
                     * Сюда можно вставить условие на проверку айпишника сессии
                     */
                    $this->oUserCurrent = $oUser;
                    $this->oSession = $oSession;
                }
            }
        }
        /**
         * Запускаем автозалогинивание
         * В куках стоит время на сколько запоминать юзера
         */
        $this->AutoLogin();
        /**
         * Обновляем сессию
         */
        if ($this->oSession) {
            $this->_UpdateSession();
        }
    }

    /**
     * Получить текущего юзера
     *
     * @return ModuleUser_EntityUser|null
     */
    public function GetUserCurrent()
    {
        return $this->oUserCurrent;
    }

    /**
     * Устанавливает текущего пользователя
     *
     * @param ModuleUser_EntityUser $oUser
     */
    public function SetUserCurrent($oUser)
    {
        $this->oUserCurrent = $oUser;
    }

    /**
     * Обновляет данные текущего пользователя
     *
     * @param bool $bSafe Обновлять только данные объекта ($bSafe=true) или полностью весь объект. При обновлении всего объекта происходит потеря связей старых ссылок на объект.
     */
    public function ReloadUserCurrent($bSafe = true)
    {
        if ($this->oUserCurrent and $oUser = $this->GetUserById($this->oUserCurrent->getId())) {
            if ($bSafe) {
                $this->oUserCurrent->_setData($oUser->_getData());
            } else {
                $this->oUserCurrent = $oUser;
            }
        }
    }

    /**
     * Авторизован ли юзер
     *
     * @return bool
     */
    public function IsAuthorization()
    {
        if ($this->oUserCurrent) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * Авторизовывает юзера
     *
     * @param ModuleUser_EntityUser $oUser Объект пользователя
     * @param bool $bRemember Запоминать пользователя или нет
     * @param string $sKey Ключ авторизации для куков
     * @return bool
     */
    public function Authorization(ModuleUser_EntityUser $oUser, $bRemember = true, $sKey = null)
    {
        if (!$oUser->getId() or !$oUser->getActive() or !$oUser->getActivate()) {
            return false;
        }
        /**
         * Создаём новую сессию
         */
        if (!$this->CreateSession($oUser, $sKey)) {
            return false;
        }

        /**
         * Запоминаем в сесси юзера
         */
        $this->Session_Set('user_id', $oUser->getId());
        $this->Session_Set('session_key', $this->oSession->getKey());
        $this->oUserCurrent = $oUser;
        /**
         * Ставим куку
         */
        if ($bRemember) {
            $this->Session_SetCookie('key', $this->oSession->getKey(),
                time() + Config::Get('module.user.time_login_remember'), false,
                true);
        }
        return true;
    }

    /**
     * Создание пользовательской сессии
     *
     * @param ModuleUser_EntityUser $oUser Объект пользователя
     * @param string $sKey Сессионный ключ
     * @return bool
     */
    protected function CreateSession(ModuleUser_EntityUser $oUser, $sKey = null)
    {
        /**
         * Генерим новый ключ
         */
        if (is_null($sKey)) {
            $sKey = md5(func_generator() . time() . $oUser->getId());
        }

        /**
         * Проверяем ключ сессии
         */
        if ($oSession = $this->GetSessionByKey($sKey)) {
            /**
             * Если сессия уже не активна, то удаляем её
             */
            if (!$oSession->isActive()) {
                $oSession->delete();
                unset($oSession);
            }
        }

        if (!isset($oSession)) {
            /**
             * Проверяем количество активных сессий у пользователя и завершаем сверх лимита
             */
            $iCountMaxSessions = Config::Get('module.user.count_auth_session');
            $aSessions = $this->GetSessionItemsByFilter(array(
                'user_id' => $oUser->getId(),
                '#order'  => array('date_last' => 'desc'),
                '#where'  => array('t.date_create IS NULL' => array())
            ));
            $aSessions = array_slice($aSessions, ($iCountMaxSessions - 1 < 0) ? 0 : $iCountMaxSessions - 1);
            foreach ($aSessions as $oSessionOld) {
                $oSessionOld->setDateClose(date("Y-m-d H:i:s"));
                $oSessionOld->update();
            }
            /**
             * Проверяем количество всех сессий у пользователя и удаляем сверх лимита
             */
            $iCountMaxSessions = Config::Get('module.user.count_auth_session_history');
            $aSessions = $this->GetSessionItemsByFilter(array(
                'user_id' => $oUser->getId(),
                '#order'  => array('date_last' => 'desc')
            ));
            $aSessions = array_slice($aSessions, ($iCountMaxSessions - 1 < 0) ? 0 : $iCountMaxSessions - 1);
            foreach ($aSessions as $oSessionOld) {
                $oSessionOld->delete();
            }
        }

        $this->Cache_Clean(Zend_Cache::CLEANING_MODE_MATCHING_TAG, array('user_session_update'));
        $this->Cache_Delete("user_session_{$oUser->getId()}");
        /**
         * Создаем новую или обновляем данные у старой
         */
        if (!isset($oSession)) {
            $oSession = Engine::GetEntity('User_Session');
            $oSession->setKey($sKey);
            $oSession->setIpCreate(func_getIp());
            $oSession->setDateCreate(date("Y-m-d H:i:s"));
            $oSession->setExtraParam('user_agent',
                isset($_SERVER['HTTP_USER_AGENT']) ? $_SERVER['HTTP_USER_AGENT'] : '');
        }
        $oSession->setUserId($oUser->getId());
        $oSession->setIpLast(func_getIp());
        $oSession->setDateLast(date("Y-m-d H:i:s"));

        if ($oSession->save()) {
            $this->oSession = $oSession;
            return true;
        }
        return false;
    }

    protected function AutoLogin()
    {
        if ($this->oUserCurrent) {
            return;
        }
        if ($sKey = $this->Session_GetCookie('key') and is_string($sKey)) {
            if ($oSession = $this->GetSessionByKey($sKey) and $oSession->isActive() and $oUser = $oSession->getUser()) {
                /**
                 * Перед запуском авторизации дополнительно можно проверить user-agent'а пользователя
                 */
                $this->Authorization($oUser, true, $oSession->getKey());
            } else {
                $this->Logout();
            }
        }
    }

    /**
     * Разлогинивание
     *
     */
    public function Logout()
    {
        /**
         * Закрываем текущую сессию
         */
        if ($this->oSession) {
            $this->oSession->setDateLast(date("Y-m-d H:i:s"));
            $this->oSession->setIpLast(func_getIp());
            $this->oSession->setDateClose(date("Y-m-d H:i:s"));
            $this->oSession->update();
            $this->Cache_Clean(Zend_Cache::CLEANING_MODE_MATCHING_TAG, array('user_session_update'));
        }
        $this->oUserCurrent = null;
        $this->oSession = null;
        /**
         * Дропаем из сессии
         */
        $this->Session_Drop('user_id');
        $this->Session_Drop('session_key');
        /**
         * Дропаем куку
         */
        $this->Session_DropCookie('key');
    }

    public function Shutdown()
    {
        $this->Viewer_Assign('oUserCurrent', $this->oUserCurrent);
    }

    /**
     * Обновление данных сессии
     * Важный момент: сессию обновляем в кеше и раз в 10 минут скидываем в БД
     */
    protected function _UpdateSession()
    {
        $this->oSession->setDateLast(date("Y-m-d H:i:s"));
        $this->oSession->setIpLast(func_getIp());
        if (false === ($data = $this->Cache_Get("user_session_{$this->oSession->getUserId()}"))) {
            $data = array(
                'time'    => time(),
                'session' => $this->oSession
            );
        } else {
            $data['session'] = $this->oSession;
        }
        if (!Config::Get('sys.cache.use') or $data['time'] < time() - 60 * 10) {
            $data['time'] = time();
            $this->oSession->update();
            $this->Cache_Clean(Zend_Cache::CLEANING_MODE_MATCHING_TAG, array('user_session_update'));
        }
        $this->Cache_Set($data, "user_session_{$this->oSession->getUserId()}", array(), 60 * 60 * 24 * 4);
    }

    /**
     * Генерация хеша пароля
     *
     * @param $sPassword
     * @return string
     */
    public function MakeHashPassword($sPassword)
    {
        return func_encrypt($sPassword);
    }

    /**
     * Проверка доступа к авторизации
     *
     * @param $oUser
     * @return bool
     */
    public function VerifyAccessAuth($oUser)
    {
        return true;
    }

    /**
     * Проверяет является ли текущий пользователь администратором
     *
     * @param bool $bReturnUser Возвращать или нет объект пользователя
     *
     * @return bool|ModuleUser_EntityUser
     */
    public function GetIsAdmin($bReturnUser = false)
    {
        if ($this->oUserCurrent and $this->oUserCurrent->isAdmin()) {
            return $bReturnUser ? $this->oUserCurrent : true;
        }
        return false;
    }

    /**
     * Отправляет уведомление при регистрации с активацией
     *
     * @param ModuleUser_EntityUser $oUser Объект пользователя
     * @param string $sPassword Пароль пользователя
     */
    public function SendNotifyRegistrationActivate(ModuleUser_EntityUser $oUser, $sPassword)
    {
        $this->Notify_Send(
            $oUser,
            'registration_activate.tpl',
            'Активация аккаунта',
            array(
                'oUser'     => $oUser,
                'sPassword' => $sPassword,
            ), null, true
        );
    }

    /**
     * Уведомление с новым паролем после его восставновления
     *
     * @param ModuleUser_EntityUser $oUser Объект пользователя
     * @param string $sNewPassword Новый пароль
     */
    public function SendNotifyReminderPassword(ModuleUser_EntityUser $oUser, $sNewPassword)
    {
        $this->Notify_Send(
            $oUser,
            'reminder_password.tpl',
            $this->Lang_Get('emails.reminder_password.subject'),
            array(
                'oUser'        => $oUser,
                'sNewPassword' => $sNewPassword,
            ), null, true
        );
    }

    /**
     * Уведомление при восстановлении пароля
     *
     * @param ModuleUser_EntityUser $oUser Объект пользователя
     * @param ModuleUser_EntityReminder $oReminder объект напоминания пароля
     */
    public function SendNotifyReminderCode(ModuleUser_EntityUser $oUser, ModuleUser_EntityReminder $oReminder)
    {
        $this->Notify_Send(
            $oUser,
            'reminder_code.tpl',
            $this->Lang_Get('emails.reminder_code.subject'),
            array(
                'oUser'     => $oUser,
                'oReminder' => $oReminder,
            ), null, true
        );
    }

    /**
     * Отправляет уведомление с новым линком активации
     *
     * @param ModuleUser_EntityUser $oUser Объект пользователя
     */
    public function SendNotifyReactivationCode(ModuleUser_EntityUser $oUser)
    {
        $this->Notify_Send(
            $oUser,
            'reactivation.tpl',
            $this->Lang_Get('emails.reactivation.subject'),
            array(
                'oUser' => $oUser,
            ), null, true
        );
    }
}