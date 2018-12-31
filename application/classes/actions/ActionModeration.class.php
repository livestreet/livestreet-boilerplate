<?php


/**
 * Обработка Профиля, т.е. УРЛа вида /profile/
 *
 * @package actions
 * @since 1.0
 */
class ActionModeration extends Action
{

    protected $sMenuHeadItemSelect = 'index';
    
    protected $oUserProfile;
    
    protected $oUserCurrent;



    /**
     * Инициализация
     *
     */
    public function Init()
    {
        if(!$this->CheckUserAccess()){
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
        //$this->AddEventPreg('/^.+$/i', '/^$/i',['EventIndex' , 'profile']);
        
        $this->RegisterEventExternal('Settigns', 'ActionProfile_EventSettings');
        $this->AddEventPreg('/^.+$/i', '/^settings$/i', '/^(profile)?$/i', ['Settigns::EventProfile' , 'settings']);
        $this->AddEventPreg('/^.+$/i', '/^settings$/i', '/^notices$/i', ['Settigns::EventNotices' , 'notices']);
        $this->AddEventPreg('/^.+$/i', '/^settings$/i', '/^security$/i', ['Settigns::EventSecurity' , 'security']);
       // $this->AddEventPreg('/^.+$/i', '/^settings$/i', '/^security-ajax$/i', 'Settigns::EventSecurityAjax' );
        $this->AddEventPreg('/^.+$/i', '/^settings$/i', '/^profile-ajax$/i', 'Settigns::EventProfileAjax' );
        
        $this->RegisterEventExternal('Profile', 'ActionProfile_EventProfile');
        $this->AddEventPreg('/^.+$/i', '/^(all)?$/i', '/^(page(\d))?$/i', ['Profile::EventIndex' , 'profile']);
        $this->AddEventPreg('/^.+$/i', '/^responses$/i', '/^(page(\d))?$/i', ['Profile::EventResponses' , 'profile']);
        $this->AddEventPreg('/^.+$/i', '/^proposals$/i', '/^(page(\d))?$/i', ['Profile::EventProposals' , 'profile']);
        $this->AddEventPreg('/^.+$/i', '/^arbitrage$/i', '/^(page(\d))?$/i', ['Profile::EventArbitrage' , 'profile']);
        $this->AddEventPreg('/^.+$/i', '/^my-responses$/i', '/^(page(\d))?$/i', ['Profile::EventMyResponses' , 'profile']);
        $this->AddEventPreg('/^.+$/i', '/^my-proposals$/i', '/^(page(\d))?$/i', ['Profile::EventMyProposals' , 'profile']);
        
    }


    /**********************************************************************************
     ************************ РЕАЛИЗАЦИЯ ЭКШЕНА ***************************************
     **********************************************************************************
     */
    
    /**
     * Проверка корректности профиля
     */
    protected function CheckUserAccess()
    {
        /**
         * Проверяем есть ли такой юзер
         */
        if (!$this->oUserCurrent = $this->User_GetUserCurrent()) {
            return false;
        }        
        
        if($this->oUserCurrent->isAdministrator()){
            return true;
        } 
        
        if(! $this->Rbac_IsAllow('moderation')){
            return false;
        }
        
        return true;
    }
    
    
    /**
     * Выполняется при завершении каждого эвента
     */
    public function EventShutdown()
    {
        $this->Viewer_Assign('sMenuHeadItemSelect', $this->sMenuHeadItemSelect);

    }


}