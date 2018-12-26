<?php

class ModuleUser_EntityUser extends EntityORM
{
    protected $aValidateRules = array(
        array('mail', 'email', 'allowEmpty' => false, 'on' => array('registration')),
        array('mail', 'mail_exists',  'on' => array('registration')),
        array(
            'password', 
            'string', 
            'allowEmpty' => false, 
            'min' => 5, 
            'max' => 100,
            'on' => array('registration'), 
            'msg' => 'auth.registration.notices.password_no_valid'
        ),
        [   
            'login', 
            'login', 
            'on' => array('registration'),
            'allowEmpty' => false
        ],
        [
            'login', 
            'login_exists', 
            'on' => array('registration')
        ],
        [   'name', 
            'string', 
            'min' => 5, 
            'max' => 200, 
            'allowEmpty' => false,
            'on' => array('registration'), 
            'msg' => 'auth.registration.notices.name_no_valid'
        ],
        [   
            'role', 
            'string', 
            'allowEmpty' => false,
            'on' => array('registration'), 
            'msg' => 'auth.registration.notices.role_no_valid'
        ],
        [   
            'role', 
            'role_exists', 
            'on' => array('registration')
        ],
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
       
        parent::__construct($aParam);
    }
    
    public function ValidateLogin($sValue, $aParams)
    {
        if ($this->User_CheckLogin($sValue)) {
            return true;
        }
        return $this->Lang_Get('auth.registration.notices.error_login');
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
    
    public function ValidateRoleExists($sValue, $aParams)
    {
        if ($this->Rbac_GetRoleByFilter(['code' => $sValue])) {
            return true;
        }
        return $this->Lang_Get('auth.registration.notices.role_no_exists', ['role' => $sValue]);
    }
    
    public function ValidateLoginExists($sValue, $aParams)
    {
        if (!$this->User_GetUserByLogin($sValue)) {
            return true;
        }
        return $this->Lang_Get('auth.registration.notices.error_login_used');
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
        return Router::GetPathRootWeb(). '/' .($this->getLogin()?$this->getLogin():$this->getId());
    }
    
    public function afterSave() {
        parent::afterSave();
        $this->Rbac_AddRoleToUser($this->getRole(), $this->getId());
    }
    
    public function getMedia($sTargetType = '') {
        return $this->Media_GetMediaByTarget($sTargetType, $this->getId());
    }
    
    public function getProfilePhoto() {
        $aMedia = $this->getMedia('user_photo');
        if(sizeof($aMedia)){
            return array_shift($aMedia)->getFileWebPath('photo');
        }
        return $this->User_GetDefaultPhoto();
    }
    
    public function getProfileAvatar() {
        $aMedia = $this->getMedia('user_photo');
        if(sizeof($aMedia)){
            return array_shift($aMedia)->getFileWebPath('avatar');
        }
        return $this->User_GetDefaultAvatar();
    }
    
    public function isRole($sRole) {
        $aRoles = $this->Rbac_GetRolesByUser($this);
        foreach ($aRoles as $oRole) {
            if($oRole->getCode() == $sRole){
                return true;
            }
        }
        return false;
    }
    
    public function getRating() {
        return 4.5;
    }
    
    public function getCountRated() {
        return 5505;
    }
    
    public function getRatingStat() {
        return [
            5 => 50,
            4 => 40,
            3 => 60,
            2 => 30,
            1 => 20
        ];
    }
}