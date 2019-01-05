<?php

/**
 * Description of ActionModeration_EventModeration
 *
 * @author oleg
 */
class ActionModeration_EventResponses extends Event {
    
    
        
    public function EventResponsesAll()
    {
        
        $iPage = $this->GetParamEventMatch(0, 2);
        $iPage = $iPage?$iPage:1;
        
        $iLimit =  Config::Get('moderation.talk.page_count');
        
        $aFilter =  [
            '#with'         => ['user'],
            '#index-from'   => 'id',
            '#order'        => ['date_update' => 'desc'],
            '#page'         => [ $iPage, $iLimit],
            '#where'        => ['t.state != ?' => ['delete']]
        ];
        
        $aResponses = $this->Talk_GetResponseItemsByFilter($aFilter);

        $aPaging = $this->Viewer_MakePaging($aResponses['count'], $iPage, $iLimit, 
                Config::Get('module.talk.pagination.pages.count'), Router::GetPath('moderation/responses-all'));
        
        $this->Viewer_Assign('aPaging', $aPaging);        
        $this->Viewer_Assign('aResponses', $aResponses['collection']);
        $this->Viewer_Assign('count', $aResponses['count']);
        
        $this->SetTemplateAction('responses-all');
    }
    
}
