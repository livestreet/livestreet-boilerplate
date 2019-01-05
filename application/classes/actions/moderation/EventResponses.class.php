<?php

/**
 * Description of ActionModeration_EventModeration
 *
 * @author oleg
 */
class ActionModeration_EventResponses extends Event {
    
    
        
    public function EventResponsesAll()
    {
        $this->sMenuItemSelect = 'responses_all';
        
        $iPage = $this->GetParamEventMatch(0, 2);
        $iPage = $iPage?$iPage:1;
        
        $iLimit =  Config::Get('moderation.talk.page_count');
        
        $aFilter =  [
            '#with'         => ['user'],
            '#index-from'   => 'id',
            '#order'        => ['date_create' => 'asc'],
            '#page'         => [ $iPage, $iLimit],
            '#where'        => ['t.state != ?' => ['delete']]
        ];
        
        $oUserTarget = $this->User_GetUserByFilter(['login' => getRequest('login')]);  
        
        if(getRequest('how') == "from" and $oUserTarget){
            $aFilter['user_id'] = $oUserTarget->getId();
        }
        
        if(getRequest('how') == "to" and $oUserTarget){
            $aFilter['target_id'] = $oUserTarget->getId();
        }
        
        if(getRequest('text')){
            $aFilter['#where']['t.text LIKE ?'] = ['%'.getRequest('text').'%'];
        }
        
        $aResponses = $this->Talk_GetResponseItemsByFilter($aFilter);

        $aPaging = $this->Viewer_MakePaging($aResponses['count'], $iPage, $iLimit, 
                Config::Get('module.talk.pagination.pages.count'), Router::GetPath('moderation/responses-all'));
        
        $this->Viewer_Assign('aPaging', $aPaging);        
        $this->Viewer_Assign('aResponses', $aResponses['collection']);
        $this->Viewer_Assign('count', $aResponses['count']);
        
        $this->SetTemplateAction('responses-all');
    }
    
    public function EventResponsesDeleted() {
        $this->sMenuItemSelect = 'responses_deleted';
        
        $iPage = $this->GetParamEventMatch(0, 2);
        $iPage = $iPage?$iPage:1;
        
        $iLimit =  Config::Get('moderation.talk.page_count');
        
        $aFilter =  [
            '#with'         => ['user'],
            '#index-from'   => 'id',
            '#order'        => ['date_create' => 'asc'],
            '#page'         => [ $iPage, $iLimit],
            'state'         => 'delete'
        ];
        
        $oUserTarget = $this->User_GetUserByFilter(['login' => getRequest('login')]);  
        
        if(getRequest('how') == "from" and $oUserTarget){
            $aFilter['user_id'] = $oUserTarget->getId();
        }
        
        if(getRequest('how') == "to" and $oUserTarget){
            $aFilter['target_id'] = $oUserTarget->getId();
        }
        
        if(getRequest('text')){
            $aFilter['#where']['t.text LIKE ?'] = ['%'.getRequest('text').'%'];
        }
        
        $aResponses = $this->Talk_GetResponseItemsByFilter($aFilter);

        $aPaging = $this->Viewer_MakePaging($aResponses['count'], $iPage, $iLimit, 
                Config::Get('module.talk.pagination.pages.count'), Router::GetPath('moderation/responses-all'));
        
        $this->Viewer_Assign('aPaging', $aPaging);        
        $this->Viewer_Assign('aResponses', $aResponses['collection']);
        $this->Viewer_Assign('count', $aResponses['count']);
        
        $this->SetTemplateAction('responses-deleted');
    }
    
}
