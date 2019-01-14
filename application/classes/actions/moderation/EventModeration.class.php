<?php

/**
 * Description of ActionModeration_EventModeration
 *
 * @author oleg
 */
class ActionModeration_EventModeration extends Event {
    
    
    public function EventResponses()
    {
        $this->sMenuItemSelect = 'moderation';
        $this->SetTemplateAction('moderation');
    }
    
    public function EventAjaxResponses()
    {
        $this->Viewer_SetResponseAjax('json');
        
        $iStart = getRequest('start', 0);
        $iLimit = getRequest('limit', Config::Get('moderation.talk.page_count'));
        
        $aFilter =  [
            '#with'         => ['user'],
            '#index-from'   => 'id',
            '#order'        => ['date_create' => 'desc'],
            '#limit'         => [ $iStart, $iLimit],
            'state in'      => ['moderate']
        ];
        
        $aMessages = $this->Talk_GetResponseItemsByFilter($aFilter);

        $oViewer = $this->Viewer_GetLocalViewer();
        $oViewer->GetSmartyObject()->addPluginsDir(Config::Get('path.application.server').'/classes/modules/viewer/plugs');
        $oViewer->Assign('items', $aMessages, true);
        $sHtml = $oViewer->Fetch('component@moderation.response-list');
        
        $iCountAll = $this->Talk_GetCountFromResponseByFilter([ 'state' => 'moderate']);
        
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
        
        $this->Rating_Vote(
            $oResponse->getUserId(), 
            $oResponse->getTargetType(), 
            $oResponse->getTargetId(), 
            $oResponse->getRating(), 
            $oResponse->getId()
        );
        
                
        if($oResponse->Save()){
            /*
             * Оппевещение о ппублиакции
             */
            $this->Notify_Send(
                $oResponse->getUser(),
                'response_moderate.tpl',
                $this->Lang_Get('emails.response_moderate.subject'),
                ['oResponse' => $oResponse], null, true
            );
            
            $this->Message_AddNotice($this->Lang_Get('moderation.responses.notice.success_publish'));
        }else{
            $this->Message_AddError($this->Lang_Get('common.error.error'));
            return;
        }        
        
        $this->Viewer_AssignAjax('remove', 1);
        $this->Viewer_AssignAjax('countAll', 
        $this->Talk_GetCountFromResponseByFilter([ 'state' => 'moderate']));
    }
    
    
    public function EventAjaxDelete()
    {
        $this->Viewer_SetResponseAjax('json');
        
        if(!$oResponse = $this->Talk_GetResponseByFilter(['id' => getRequest('id')])){
            $this->Message_AddError($this->Lang_Get('talk.response.notice.error_not_found'));
            return;
        }
        
        $oResponse->setState('delete');
        $oResponse->deleteVote();
                
        if($oResponse->Save()){
            /*
             * Оповещение о удалении
             */
            $this->Notify_Send(
                $oResponse->getUser(),
                'response_deleted.tpl',
                $this->Lang_Get('emails.response_deleted.subject'),
                ['oResponse' => $oResponse], null, true
            );
            
            $this->Message_AddNotice($this->Lang_Get('moderation.responses.notice.success_delete'));
        }else{
            $this->Message_AddError($this->Lang_Get('common.error.error'));
            return;
        }        
        
        $this->Viewer_AssignAjax('remove', 1);
        $this->Viewer_AssignAjax('countAll', 
        $this->Talk_GetCountFromResponseByFilter([ 'state' => 'moderate']));
    }
    
}
