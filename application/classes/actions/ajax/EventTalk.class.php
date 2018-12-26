<?php

/**
 * Description of ActionProfile_EventSettings
 *
 * @author oleg
 */
class ActionAjax_EventTalk extends Event {
    
    public $oUserCurrent;


    public function Init() {
        
    }
    
    public function EventAjaxResponseCreate() {
        
        $oResponse = Engine::GetEntity('Talk_Response');
        $oResponse->_setDataSafe($_REQUEST);
        
        $oResponse->setState('moderate');
        
        if($oResponse->_Validate()){
            if($oResponse->Save()){
                $this->AttachMedia(getRequest('photos'), 'response', $oResponse->getId());
                
                $this->Message_AddNotice($this->Lang_Get('talk.response.notice.success_add'));
            }else{
                $this->Message_AddError($this->Lang_Get('common.error.error'));
            }
        }else{
            foreach ($oResponse->_getValidateErrors() as $aError) {
                $this->Message_AddError(array_shift($aError));
            }
        }
    }
    
    protected function AttachMedia( $aMediaIds, $sTargetType, $iTargetId) {
        if(!is_array($aMediaIds)){
            return;
        }
        foreach ($aMediaIds as $iMediaId) {            $this->Logger_Notice($iMediaId);
            if(!$oMedia = $this->Media_GetMediaById($iMediaId)){
                continue;
            }
            $this->Media_AttachMediaToTarget($oMedia, $sTargetType, $iTargetId);
        }
    }

}
