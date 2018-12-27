<?php

/**
 * Description of ActionProfile_EventSettings
 *
 * @author oleg
 */
class ActionProfile_EventProfile extends Event {
    
       
    /**
     * Главная страница
     *
     */
    public function EventIndex()
    {
        $iLimit = 20;
        
        $iPage = 1;
        
        $aResponses = $this->Talk_GetResponseItemsByFilter([
            'target_id'     => $this->oUserProfile->getId(),
            '#index-from'   => 'date_create',
            '#limit'        => [$iPage, $iLimit/2]
        ]);
        
        $aProposals = $this->Talk_GetProposalItemsByFilter([
            'target_id' => $this->oUserProfile->getId(),
            '#index-from' => 'date_create',
            '#limit'        => [$iPage, $iLimit/2],
        ]);
        
        $aResults = array_merge($aProposals, $aResponses);
        
        ksort($aResults);
        /**
         * Устанавливаем шаблон вывода
         */
        $this->Viewer_Assign('results', $aResults);
        $this->Viewer_Assign('count', count($aResults));
        
        $this->sMenuHeadItemSelect = 'index';
        $this->SetTemplateAction('index');
    }
    
    public function EventResponses()
    {
       
        /**
         * Устанавливаем шаблон вывода
         */
        $this->sMenuHeadItemSelect = 'responses';
        $this->SetTemplateAction('responses');
    }
    
    public function EventProposals() {
        /**
         * Устанавливаем шаблон вывода
         */
        $this->sMenuHeadItemSelect = 'proposals';
        $this->SetTemplateAction('proposals');
    }
    
}
