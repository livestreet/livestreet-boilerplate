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
        
        
    }
    
    public function EventAjaxResponses()
    {
        $this->Viewer_SetResponseAjax('json');
        $this->SetTemplate(false);
        
        $iStart = getRequest('start', 0);
        $iLimit = getRequest('limit', Config::Get('moderation.talk.page_count'));
        
        $aFilter =  [
            '#with'         => ['user'],
            '#index-from'   => 'target_id',
            '#order'        => ['date_create' => 'desc'],
            '#limit'         => [ $iStart, $iLimit],
            'state in'      => ['moderate']
        ];
        
        $aArbitrages = $this->Talk_GetArbitrageItemsByFilter($aFilter);
        
        $aArbitrageIds = count($aArbitrages)?array_keys($aArbitrages):[0];
        
        $aResponses = $this->Talk_GetResponseItemsByFilter([
            'id in' => $aArbitrageIds,
            '#index-from'   => 'id'
        ]);
        
        foreach ($aResponses as $id => $oResponse) {
            $oResponse->setArbitrage($aArbitrages[$id]);
        }

        $oViewer = $this->Viewer_GetLocalViewer();
        $oViewer->GetSmartyObject()->addPluginsDir(Config::Get('path.application.server').'/classes/modules/viewer/plugs');
        $oViewer->Assign('items', $aResponses, true);
        $sHtml = $oViewer->Fetch('component@arbitrage.response-list');
        
        $iCountAll = $this->Talk_GetCountFromArbitrageByFilter([ 'state in'      => ['moderate']]);
        
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
        
        if($oArbitrage = $oResponse->getArbitrage()){
            $oArbitrage->setState('closed');
            $oArbitrage->Save();
        }
                
        if($oResponse->Save()){
            $this->Message_AddNotice($this->Lang_Get('moderation.responses.notice.success_publish'));
        }else{
            $this->Message_AddError($this->Lang_Get('common.error.error'));
            return;
        }        
        
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
        
         if($oArbitrage = $oResponse->getArbitrage()){
            $oArbitrage->setState('closed');
            $oArbitrage->Save();
        }
                
        if($oResponse->Save()){
            $this->Message_AddNotice($this->Lang_Get('moderation.responses.notice.success_delete'));
        }else{
            $this->Message_AddError($this->Lang_Get('common.error.error'));
            return;
        }        
        
        $this->Viewer_AssignAjax('remove', 1);
        $this->Viewer_AssignAjax('countAll', 
        $this->Talk_GetCountFromArbitrageByFilter([ 'state' => 'moderate']));
    }
    
}
