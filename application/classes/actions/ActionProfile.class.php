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
    
    protected $iCountResponses = 0;
    
    protected $iCountProposals = 0;
    
    protected $iCountAnswers = 0;

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
        
        $this->iCountResponses = $this->Talk_GetCountFromResponseByFilter([
            'state in' => ['publish', 'arbitrage', 'chat'],
            'target_type' => 'user',
            'target_id'     => $this->oUserProfile->getId()
        ]);
        
        $this->iCountProposals = $this->Talk_GetCountFromProposalByFilter([
            'state' => 'publish',
            'target_type' => 'user',
            'target_id'     => $this->oUserProfile->getId()
        ]);
        
        $this->iCountAnswers = $this->Talk_GetCountFromAnswerByFilter([
            'state' => 'publish',
            'user_id'     => $this->oUserProfile->getId()
        ]);
        
        
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
        $this->AddEventPreg('/^.+$/i', '/^confirm-company$/i', ['Profile::EventConfirmCompany' , 'confirm_company']);
        $this->AddEventPreg('/^.+$/i', '/^response-success$/i', ['Profile::EventResponseSuccess' , 'response_success']);
        $this->AddEventPreg('/^.+$/i', '/^proposal-success$/i', ['Profile::EventProposalSuccess' , 'proposal_success']);
        $this->AddEventPreg('/^.+$/i', '/^confirm-company$/i', ['Profile::EventConfirmCompany' , 'confirm_company']);
        $this->AddEventPreg('/^.+$/i', '/^(all)?$/i', '/^(page(\d))?$/i', ['Profile::EventIndex' , 'profile']);
        $this->AddEventPreg('/^.+$/i', '/^responses$/i', '/^(page(\d))?$/i', ['Profile::EventResponses' , 'profile']);
        $this->AddEventPreg('/^.+$/i', '/^proposals$/i', '/^(page(\d))?$/i', ['Profile::EventProposals' , 'profile']);
        $this->AddEventPreg('/^.+$/i', '/^arbitrage$/i', '/^(page(\d))?$/i', ['Profile::EventArbitrage' , 'profile']);
        $this->AddEventPreg('/^.+$/i', '/^arbitrage$/i', '/^\d+$/i', ['Profile::EventArbitrageChat' , 'profile']);
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
    protected function CheckUserProfile()
    {
        /**
         * Проверяем есть ли такой юзер
         */
        if (!($this->oUserProfile = $this->User_GetUserByLogin(Router::GetActionEvent()))) {
            return false;
        }        
        
        return $this->oUserProfile->getActivate();
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
     * Выполняется при завершении каждого эвента
     */
    public function EventShutdown()
    {
        $this->Viewer_Assign('sMenuHeadItemSelect', $this->sMenuHeadItemSelect);
        $this->Viewer_Assign('iCountProposals', $this->iCountProposals);
        $this->Viewer_Assign('iCountResponses', $this->iCountResponses);
        $this->Viewer_Assign('iCountAnswers', $this->iCountAnswers);
        $this->Viewer_Assign('oUserProfile', $this->oUserProfile);
        
        if( in_array('admin', array_keys(Engine::getInstance()->GetPlugins()) )){
            $this->Viewer_SetSeoTags([
                'login'         => $this->oUserProfile->getLogin(),
                'name'          => $this->oUserProfile->getName(),
                'rating'        => round($this->oUserProfile->getRating(), 1). " ". $this->Lang_Get('rating.of')." 5" ,
                'count_vote'    => $this->oUserProfile->getCountRated(),
                'about'         => $this->oUserProfile->getAbout()
            ]);
        }
    }


}