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
        
        $oResponse = Engine::GetEntity('Talk_Message', ['type' => 'response']);
        $oResponse->_setDataSafe($_REQUEST);
        
        $oResponse->setState('publish');
        
        if($oResponse->_Validate()){
            if($oResponse->Save()){
                $this->AttachMedia(getRequest('photos'), 'response', $oResponse->getId());
                
                $this->Viewer_AssignAjax('sUrlRedirect', getRequest('redirect'));
                
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
        
        $oProposal = Engine::GetEntity('Talk_Message', ['type' => 'proposal']);
        $oProposal->_setDataSafe($_REQUEST);
        
        $oProposal->setState('publish');
        
        if($oProposal->_Validate()){
            if($oProposal->Save()){
                $this->AttachMedia(getRequest('photos'), 'proposal', $oProposal->getId());
                
                $this->Viewer_AssignAjax('sUrlRedirect', getRequest('redirect'));
                
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
    
    public function EventAjaxAnswerCreate() {
        
        $oAnswer = Engine::GetEntity('Talk_Message', ['type' => 'answer']);
        $oAnswer->_setDataSafe($_REQUEST);
        
        $oAnswer->setState('publish');
        
        
        
        if($oAnswer->_Validate()){
            if($oAnswer->Save()){
                $this->AttachMedia(getRequest('photos'), 'answer', $oAnswer->getId());
                
                $this->Viewer_AssignAjax('sUrlRedirect', getRequest('redirect'));
                
                $this->Message_AddNotice($this->Lang_Get('talk.answer.notice.success_add'));
            }else{
                $this->Message_AddError($this->Lang_Get('common.error.error'));
            }
        }else{
            foreach ($oAnswer->_getValidateErrors() as $aError) {
                $this->Message_AddError(array_shift($aError));
            }
        }
    }
    
    public function EventAjaxArbitrageCreate() {
        
        $oArbitrage = Engine::GetEntity('Talk_Message', ['type' => 'arbitrage']);
        $oArbitrage->_setDataSafe($_REQUEST);
        
        $oArbitrage->setState('publish');
        
        
        
        if($oArbitrage->_Validate()){
            if($oArbitrage->Save()){
                $this->AttachMedia(getRequest('photos'), 'arbitrage', $oArbitrage->getId());
                
                $this->Viewer_AssignAjax('sUrlRedirect', getRequest('redirect'));
                
                $this->Message_AddNotice($this->Lang_Get('talk.arbitrage.notice.success_add'));
            }else{
                $this->Message_AddError($this->Lang_Get('common.error.error'));
            }
        }else{
            foreach ($oArbitrage->_getValidateErrors() as $aError) {
                $this->Message_AddError(array_shift($aError));
            }
        }
    }
    
    public function EventAjaxMessageDelete() {
        if(!$aMessage = $this->Talk_GetMessageById(getRequest('id'))){
            $this->Message_AddError($this->Lang_Get('common.error.error'));
        }
        
        if($aMessage->Delete()){
            $this->Message_AddNotice($this->Lang_Get('talk.answer.notice.success_remove'));
            $this->Viewer_AssignAjax('sUrlRedirect', getRequest('redirect'));
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
