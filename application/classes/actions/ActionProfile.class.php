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
    
    protected $oUserCurrent;

    /**
     * Инициализация
     *
     */
    public function Init()
    {
        
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
        if (!($this->oUserProfile = $this->User_GetUserByLogin($this->sCurrentEvent))) {
            return false;
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
        $this->Viewer_Assign('oUserCurrent', $this->oUserCurrent);
    }


}