<?php


/**
 * Обработка Профиля, т.е. УРЛа вида /profile/
 *
 * @package actions
 * @since 1.0
 */
class ActionProfile extends Action
{

    protected $sMenuHeadItemSelect = 'index';
    
    protected $oUserProfile;

    /**
     * Инициализация
     *
     */
    public function Init()
    {
        if(!$this->CheckUserProfile()){
            $this->Message_AddError($this->Lang_Get('common.error.system.code.404'), '404');
            Router::LocationAction('error/404');
        }
        $this->SetDefaultEvent('index');
    }

    /**
     * Регистрация евентов
     *
     */
    protected function RegisterEvent()
    {
        //$this->AddEvent('index', 'EventIndex');
        $this->AddEventPreg('/^.+$/i', '/^$/i',['EventIndex' , 'profile']);
        
        $this->RegisterEventExternal('Settigns', 'ActionProfile_EventSettings');
        $this->AddEventPreg('/^.+$/i', '/^settings$/i', '/^(profile)?$/i', ['Settigns::EventProfile' , 'settings']);
        $this->AddEventPreg('/^.+$/i', '/^settings$/i', '/^notices$/i', ['Settigns::EventNotices' , 'notices']);
        $this->AddEventPreg('/^.+$/i', '/^settings$/i', '/^security$/i', ['Settigns::EventSecurity' , 'security']);
        $this->AddEventPreg('/^.+$/i', '/^settings$/i', '/^security-ajax$/i', 'Settigns::EventSecurityAjax' );
        
    }


    /**********************************************************************************
     ************************ РЕАЛИЗАЦИЯ ЭКШЕНА ***************************************
     **********************************************************************************
     */
    
    /**
     * Проверка корректности профиля
     */
    protected function CheckUserProfile()
    {
        /**
         * Проверяем есть ли такой юзер
         */
        if (!($this->oUserProfile = $this->User_GetUserByLogin(Router::GetActionEvent()))) {
            return false;
        }        
        
        return true;
    }
    
     /**
     * Проверка корректности профиля
     */
    protected function CheckUserProfileAccess()
    {
        if (!($oUserCurrent = $this->User_GetUserCurrent())) {
            return false;
        }

        if($oUserCurrent->getId() != $this->oUserProfile->getId() and !$oUserCurrent->isAdministrator()){
            return false;
        }
        
        if($oUserCurrent->getId() != $this->oUserProfile->getId()){
            $this->Message_AddNotice($this->Lang_Get('profile.notices.notice_alien_profile'),$this->Lang_Get('common.attention'));
        }
        return true;
    }

    /**
     * Главная страница
     *
     */
    protected function EventIndex()
    {
        if(!$this->CheckUserProfile()){
            return Router::ActionError($this->Lang_Get('common.error.system.code.404'), '404');
        }
        print_r(Router::GetParams());
        /**
         * Устанавливаем шаблон вывода
         */
        $this->SetTemplateAction('profile');
    }

    

    /**
     * Выполняется при завершении каждого эвента
     */
    public function EventShutdown()
    {
        $this->Viewer_Assign('sMenuHeadItemSelect', $this->sMenuHeadItemSelect);
        $this->Viewer_Assign('oUserProfile', $this->oUserProfile);
    }


}