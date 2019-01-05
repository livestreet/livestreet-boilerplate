<?php

/**
 * Description of 
 *
 * @author oleg
 */
class ActionAjax_EventAutocomplete extends Event {
      

    public function EventUser()
    {
        
        
        $aUsers = $this->User_GetUserItemsByFilter([
            '#index-from' => 'login',
            '#where' => ["t.login LIKE ?" => ['%'.getRequest('text', ' ').'%']]
        ]);
        
        $aUserSource = [];
        
        foreach ($aUsers as $oUser) {
            $aUserSource[] = ['id' => $oUser->getId(), 'name' => $oUser->getLogin()];
        }
        
        $this->Viewer_AssignAjax('source', $aUserSource);
    }


}
