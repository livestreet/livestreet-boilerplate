<?php


/**
 * Обработка Профиля, т.е. УРЛа вида /profile/
 *
 * @package actions
 * @since 1.0
 */
class ActionModeration extends Action
{

    protected $sMenuItemSelect = 'responses';
    
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
        $this->SetDefaultEvent('responses');
        
        $this->Component_Add('moderation');
    }

    /**
     * Регистрация евентов
     *
     */
    protected function RegisterEvent()
    {
               
        $this->RegisterEventExternal('Moderation', 'ActionModeration_EventModeration');
        $this->AddEventPreg('/^responses$/i',  '/^$/i', ['Moderation::EventResponses' , 'moderation']);
        $this->AddEventPreg('/^ajax-responses$/i',  'Moderation::EventAjaxResponses');
        $this->AddEventPreg('/^ajax-publish$/i',  'Moderation::EventAjaxPublish');
        $this->AddEventPreg('/^ajax-delete$/i',  'Moderation::EventAjaxDelete');
        
        $this->RegisterEventExternal('Arbitrage', 'ActionModeration_EventArbitrage');
        $this->AddEventPreg('/^arbitrage$/i', '/^$/i',['Arbitrage::EventArbitrage' , 'moderation'] );
        $this->AddEventPreg('/^arbitrage-chat$/i', '/^\d+$/i',['Arbitrage::EventArbitrageChat' , 'moderation'] );
        $this->AddEventPreg('/^arbitrage$/i','/^ajax-responses$/i',  'Arbitrage::EventAjaxResponses');
        $this->AddEventPreg('/^arbitrage$/i','/^ajax-publish$/i',  'Arbitrage::EventAjaxPublish');
        $this->AddEventPreg('/^arbitrage$/i','/^ajax-delete$/i',  'Arbitrage::EventAjaxDelete');
        $this->AddEventPreg('/^arbitrage$/i','/^create-answer$/i',  'Arbitrage::EventAjaxCreateAnswer');
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
        $this->Viewer_Assign('sMenuItemSelect', $this->sMenuItemSelect);
        
        $this->Menu_Get('moderation')->setActiveItem($this->sMenuItemSelect);

    }


}