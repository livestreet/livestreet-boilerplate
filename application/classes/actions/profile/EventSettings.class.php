<?php

/**
 * Description of ActionProfile_EventSettings
 *
 * @author oleg
 */
class ActionProfile_EventSettings extends Event {
    
    public function Init() {
        if(!$this->CheckUserProfileAccess()){
            $this->Message_AddError($this->Lang_Get('common.error.system.code.404'), '404');
            Router::LocationAction('error/404');
        }
        
    }
    
    public function EventProfile() {
        
        $this->Viewer_Assign('sActiveItemSettings', 'profile');
        $this->SetTemplateAction('settings/profile');
    }
    
    public function EventNotices() {
        
        $this->Viewer_Assign('sActiveItemSettings', 'notices');
        $this->SetTemplateAction('settings/notices');
    }
    public function EventSecurity() {
       
        $this->Viewer_Assign('sActiveItemSettings', 'security');
        $this->SetTemplateAction('settings/security');
    }
    
    public function EventSecurityAjax() {
        $this->Viewer_SetResponseAjax('json');
        
        $this->Message_AddNotice('успешно');
        $this->Viewer_AssignAjax('data', $_REQUEST);
    }
    
}
