<?php

/**
 * Description of ActionModeration_EventModeration
 *
 * @author oleg
 */
class ActionModeration_EventArbitrage extends Event {
    
    
    public function EventArbitrage()
    {
        $this->sMenuItemSelect = 'arbitrage';
        $this->SetTemplateAction('arbitrage');
    }
    
    public function EventArbitrageChat() {
        $this->sMenuItemSelect = 'arbitrage';
        $this->SetTemplateAction('arbitrage-chat');
        
        if(!$oResponse->getTargetId() != $this->User_GetUserCurrent()->getId()){
            return $this->EventNotFound();
        }
        
        $iArbId = $this->GetParam(0);
        
        $oResponse = $this->Talk_GetResponseByFilter([
            'id' => $iArbId, 
            '#where' => ['t.state != ?' => ['delete']]
        ]);
        
        if(!$oResponse){
            return $this->EventNotFound();
        }
        
        
        $this->Viewer_Assign('oResponse', $oResponse);
    }
    
    public function EventAjaxCreateAnswer() {
        $this->Viewer_SetResponseAjax('json');
        
        $oArbitrage = Engine::GetEntity('Talk_Arbitrage');
        
        $oArbitrage->_setDataSafe($_REQUEST);
        $oArbitrage->setState('chat');
        
        $oResponse = $this->Talk_GetResponseByFilter(['id' => getRequest('target_id')]);        
        if($oResponse  and $oResponse->getState() == 'arbitrage'){
            $oResponse->setState('chat');
            $oResponse->Save();
        }else{
            $this->Message_AddError($this->Lang_Get('common.error.error'));
            return;
        }
        
        if($oArbitrage->_Validate()){
            if($oArbitrage->Save()){
                /*
                 * Оповещение
                 */
                $this->Notify_Send(
                    $oResponse->getTargetUser(),
                    'arbitrage_answer.tpl',
                    $this->Lang_Get('emails.arbitrage_answer.subject'),
                    ['oArbitrage' => $oArbitrage], null, true
                );
                
                $this->Media_AttachMedia(getRequest('photos'), 'arbitrage', $oArbitrage->getId());
                
                $this->Viewer_AssignAjax('sUrlRedirect', getRequest('redirect'));
                
                $this->Message_AddNotice($this->Lang_Get('common.success.add'));
            }else{
                $this->Message_AddError($this->Lang_Get('common.error.error'));
            }
        }else{
            foreach ($oArbitrage->_getValidateErrors() as $aError) {
                $this->Message_AddError(array_shift($aError));
            }
        }
        
    }
    
    public function EventAjaxResponses()
    {
        $this->Viewer_SetResponseAjax('json');
        $this->SetTemplate(false);
        
        $iStart = getRequest('start', 0);
        $iLimit = getRequest('limit', Config::Get('moderation.talk.page_count'));
        
        $aResponses = $this->Talk_GetResponseItemsByFilter([
            '#index-from'   => 'id',
            '#with'         => ['user'],
            '#order'        => ['date_create' => 'desc'],
            '#limit'        => [ $iStart, $iLimit],
            'state in'      => ['arbitrage', 'chat']
        ]);
        
        
        $oViewer = $this->Viewer_GetLocalViewer();
        $oViewer->GetSmartyObject()->addPluginsDir(Config::Get('path.application.server').'/classes/modules/viewer/plugs');
        $oViewer->Assign('items', $aResponses, true);
        $sHtml = $oViewer->Fetch('component@arbitrage.response-list');
        
        $iCountAll = $this->Talk_GetCountFromResponseByFilter([ 'state in' => ['arbitrage', 'chat']]);
        
        $iCount = ($iCountAll - ($iStart+$iLimit))<0?0:($iCountAll - ($iStart+$iLimit));
        
        $this->Viewer_AssignAjax('html', $sHtml);
        $this->Viewer_AssignAjax('countAll', $iCountAll);
        $this->Viewer_AssignAjax('count', $iCount);
    }
    
    public function EventAjaxPublish()
    {
        $this->Viewer_SetResponseAjax('json');
        
        if(!$oResponse = $this->Talk_GetResponseByFilter(['id' => getRequest('id')])){
            $this->Message_AddError($this->Lang_Get('talk.response.notice.error_not_found'));
            return;
        }
        
        $oResponse->setState('publish');
        
        if($oResponse->Save()){
            
            if($oArbitrage = $oResponse->getArbitrage()){
                $oArbitrage->setState('closed');
                $oArbitrage->Save();
            }
            
            $this->Notify_Send(
                $oResponse->getTargetUser(),
                'arbitrage_closed.tpl',
                $this->Lang_Get('emails.arbitrage_closed.subject'),
                ['oResponse' => $oResponse, 'oArbitrage' => $oArbitrage], null, true
            );
            
            $this->Message_AddNotice($this->Lang_Get('moderation.responses.notice.success_publish'));
            
        }else{
            $this->Message_AddError($this->Lang_Get('common.error.error'));
            return;
        }        
        
        $this->Viewer_AssignAjax('sUrlRedirect', getRequest('redirect'));
        $this->Viewer_AssignAjax('remove', 1);
        $this->Viewer_AssignAjax('countAll', $this->Talk_GetCountFromArbitrageByFilter([ 'state' => 'moderate']));
    }
    
    public function EventAjaxDelete()
    {
        $this->Viewer_SetResponseAjax('json');
        
        if(!$oResponse = $this->Talk_GetResponseByFilter(['id' => getRequest('id')])){
            $this->Message_AddError($this->Lang_Get('talk.response.notice.error_not_found'));
            return;
        }
        
        $oResponse->setState('delete');
        
                
        if($oResponse->Save()){
            
            if($oArbitrage = $oResponse->getArbitrage()){
                $oArbitrage->setState('closed');
                $oArbitrage->Save();
            }
            
            $this->Notify_Send(
                $oResponse->getTargetUser(),
                'arbitrage_closed.tpl',
                $this->Lang_Get('emails.arbitrage_closed.subject'),
                ['oResponse' => $oResponse, 'oArbitrage' => $oArbitrage], null, true
            );
            
            $this->Message_AddNotice($this->Lang_Get('moderation.responses.notice.success_delete'));
            $this->Viewer_AssignAjax('sUrlRedirect', getRequest('redirect'));
        }else{
            $this->Message_AddError($this->Lang_Get('common.error.error'));
            return;
        }        
        
        $this->Viewer_AssignAjax('remove', 1);
        $this->Viewer_AssignAjax('countAll', 
        $this->Talk_GetCountFromArbitrageByFilter([ 'state' => 'moderate']));
    }
    
}
