<?php

class ModuleUser_EntityUser extends EntityORM
{
    protected $aValidateRules = array(
        array('mail', 'email', 'allowEmpty' => false, 'on' => array('registration')),
        array('mail', 'mail_exists', 'on' => array('registration')),
        array('password', 'string', 'allowEmpty' => false, 'min' => 5, 'on' => array('registration')),
        array('password_confirm', 'compare', 'compareField' => 'password', 'on' => array('registration')),
        ['name', 'string', 'min' => 3, 'max' => 100,'on' => array('registration')],
        ['login', 'string', 'min' => 3, 'max' => 100,'on' => array('registration')]
    );

    protected $aRelations = array(
        'session' => array(self::RELATION_TYPE_HAS_ONE, 'ModuleUser_EntitySession', 'user_id'),
    );


    /**
     * Определяем дополнительные правила валидации
     *
     * @param array|bool $aParam
     */
    public function __construct($aParam = false)
    {
        $sCaptchaValidateType = func_camelize('captcha_' . Config::Get('general.captcha.type'));
        $this->aValidateRules[] = array(
            'captcha',
            $sCaptchaValidateType,
            'name' => 'user_signup',
            'on' => array('registration'),
            'label' => $this->Lang_Get('auth.labels.captcha_field')
        );

        parent::__construct($aParam);
    }

    /**
     * Проверка емайла на существование
     *
     * @param string $sValue Валидируемое значение
     * @param array $aParams Параметры
     * @return bool
     */
    public function ValidateMailExists($sValue, $aParams)
    {
        if (!$this->User_GetUserByMail($sValue)) {
            return true;
        }
        return $this->Lang_Get('auth.registration.notices.error_mail_used');
    }


    protected function beforeSave()
    {
        if ($this->_isNew()) {
            if (!$this->getDateCreate()) {
                $this->setDateCreate(date("Y-m-d H:i:s"));
            }
            if (!$this->getIpCreate()) {
                $this->setIpCreate(func_getIp());
            }
        }
        return true;
    }

    public function isAdministrator()
    {
        return $this->isAdmin();
    }

    public function isAdmin()
    {
        return $this->getIsAdmin();
    }

    public function getUrl($sPage = null)
    {
        return '#';
        return Router::GetPath('profile') . $this->getId() . '/' . ($sPage ? $sPage . '/' : '');
    }

    public function getDisplayName()
    {
        return htmlspecialchars($this->getMail());
    }

    /**
     * Возвращает статус онлайн пользователь или нет
     *
     * @return bool
     */
    public function isOnline()
    {
        if ($oSession = $this->getSession()) {
            if (time() - strtotime($oSession->getDateLast()) < Config::Get('module.user.time_onlive')) { // 10 минут
                return true;
            }
        }
        return false;
    }

    public function getProfileUrl() {
        return Router::GetPathRootWeb(). $this->getLogin()?$this->getLogin():$this->getId();
    }
    
}