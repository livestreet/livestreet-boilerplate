<?php

/**
 * Description of 
 *
 * @author oleg
 */
class ActionAjax_EventProfile extends Event {
      

    public function EventConfirmCompany()
    {
        $aParams = [
            'name'  => getRequest('name'),
            'email' => getRequest('mail'),
            'job'   => getRequest('job'),
            'phone' => getRequest('phone'),
            'mess'  => getRequest('mess')
        ];
        
        $this->User_SendNotifyConfirmCompany($aParams);
        
        $this->Viewer_AssignAjax('ok', 1);
    }


}
