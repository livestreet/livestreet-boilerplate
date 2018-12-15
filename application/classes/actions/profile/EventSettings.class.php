<?php

/**
 * Description of ActionProfile_EventSettings
 *
 * @author oleg
 */
class ActionProfile_EventSettings extends Event {
    
    public function EventProfile() {
        if(!$this->CheckUserProfile()){
            return Router::ActionError($this->Lang_Get('common.error.system.code.404'), '404');
        }
        
        $this->Viewer_Assign('sActiveItemSettings', 'profile');
        $this->SetTemplateAction('settings/profile');
    }
}
