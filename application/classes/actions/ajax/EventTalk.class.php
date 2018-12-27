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
        
        $oResponse->setState('publish');
        
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
    
    
    public function EventAjaxProposalCreate() {
        
        $oProposal = Engine::GetEntity('Talk_Proposal');
        $oProposal->_setDataSafe($_REQUEST);
        
        $oProposal->setState('publish');
        
        if($oProposal->_Validate()){
            if($oProposal->Save()){
                $this->AttachMedia(getRequest('photos'), 'proposal', $oProposal->getId());
                
                $this->Message_AddNotice($this->Lang_Get('talk.proposal.notice.success_add'));
            }else{
                $this->Message_AddError($this->Lang_Get('common.error.error'));
            }
        }else{
            foreach ($oProposal->_getValidateErrors() as $aError) {
                $this->Message_AddError(array_shift($aError));
            }
        }
    }
    
    protected function AttachMedia( $aMediaIds, $sTargetType, $iTargetId) {
        if(!is_array($aMediaIds)){
            return;
        }
        $aMediaIds = array_unique($aMediaIds);
        foreach ($aMediaIds as $iMediaId) {
            if(!$oMedia = $this->Media_GetMediaById($iMediaId)){
                continue;
            }
            $this->Media_AttachMediaToTarget($oMedia, $sTargetType, $iTargetId);
        }
    }

}
