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

    public function EventSearchUsers() {
        
        if(getRequest('query') == ''){
            $this->Viewer_AssignAjax('count', 0);
            $this->Viewer_AssignAjax('html', '');
            return;
        }
        
        $aFilter = [
            "#where" => [
                '(t.login LIKE ? OR t.mail LIKE ? OR t.about LIKE ? OR t.name LIKE ?)' => [
                    '%'.getRequest('query').'%',
                    '%'.getRequest('query').'%',
                    '%'.getRequest('query').'%',
                    '%'.getRequest('query').'%'
                ]
            ],
            'active' => 1,
            'activate' => 1,
            '#limit' => Config::Get('module.user.search_ajax.limit')
        ];
        
        $aUsers = $this->User_GetUserItemsByFilter($aFilter);
        
        
        $oViewer = $this->Viewer_GetLocalViewer();
        $oViewer->GetSmartyObject()->addPluginsDir(Config::Get('path.application.server').'/classes/modules/viewer/plugs');
        $oViewer->Assign('items', $aUsers, true);
        $sHtml = $oViewer->Fetch('component@user.list');
        
        
        $this->Viewer_AssignAjax('count', count($aUsers));
        $this->Viewer_AssignAjax('html', $sHtml);
    }
}
