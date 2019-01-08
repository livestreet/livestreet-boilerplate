<?php

/**
 * Description of 
 *
 * @author oleg
 */
class ActionAjax_EventProfile extends Event {
      

    public function EventConfirmCompany()
    {
        $oConfirm = Engine::GetEntity('User_ConfirmCompany');
        $oConfirm->_setDataSafe($_REQUEST);
        
        if($oConfirm->_Validate()){
                
            $this->User_SendNotifyConfirmCompany($oConfirm->_getData());

            $this->Message_AddNotice($this->Lang_Get('user.confirm_company.notices.success_notify'));
            
            $this->Viewer_AssignAjax('sUrlRedirect', $oConfirm->getCompanyUrl(). '/confirm-company');
            
        }else{
            foreach ($oConfirm->_getValidateErrors() as $aError) {
                $this->Message_AddError(array_shift($aError));
            }
        }        
        
    }


}
