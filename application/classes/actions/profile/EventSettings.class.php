<?php

/**
 * Description of ActionProfile_EventSettings
 *
 * @author oleg
 */
class ActionProfile_EventSettings extends Event {
    
    public function Init() {
        if(!$this->CheckUserProfileAccess()){
            $this->Message_AddError($this->Lang_Get('common.error.system.code.404'), '404');
            Router::Rewrite('error');
        }
        
    }
    
    public function EventProfile() {
        
        $this->Viewer_Assign('sActiveItemSettings', 'profile');
        $this->SetTemplateAction('settings/profile');
    }
    
    public function EventNotices() {
        
        $this->Viewer_Assign('sActiveItemSettings', 'notices');
        $this->SetTemplateAction('settings/notices');
    }
    public function EventSecurity() {
       
        $this->Viewer_Assign('sActiveItemSettings', 'security');
        $this->SetTemplateAction('settings/security');
    }
    
    public function EventSecurityAjax() {
        $this->Viewer_SetResponseAjax('json');
        
        $this->Message_AddNotice('успешнddо');
        $this->Viewer_AssignAjax('data', $_REQUEST);
    }
    
    public function EventProfileAjax() {
        $this->Viewer_SetResponseAjax('json');
        
        if(is_array(getRequest('sizes')) and isset(getRequest('sizes')[getRequest('photo')])){
            $aSize = getRequest('sizes')[getRequest('photo')];
        }
        if(is_array(getRequest('canvasWidth')) and isset(getRequest('canvasWidth')[getRequest('photo')])){
            $iCanvasWidth = getRequest('canvasWidth')[getRequest('photo')];$this->Logger_Notice('canvas_width');
        }
        
        $mTarget = $this->Media_GetTargetByFilter([
            'target_type' => 'user_photo', 
            'target_id' => $this->oUserProfile->getId()
        ]);
        
        if($mTarget){
            $mTarget->Delete();
        }
        
        $sPath = '';
        if($oMedia = $this->Media_GetMediaById(getRequest('photo'))){
            
            if(isset($aSize) and isset($iCanvasWidth)){
                if(($sResult = $this->Media_NewSizeFromCrop($oMedia, $aSize, $iCanvasWidth, 'photo') ) !== true){
                    $this->Message_AddError($sResult);
                }
            }
            
            $mTarget = $this->Media_GetTargetByFilter([
                    'target_type' => 'user_photo', 
                    'target_id' => $this->oUserProfile->getId(), 
                    'media_id' => getRequest('photo')]);
            
            if(!$mTarget){
                $this->Media_AttachMediaToTarget($oMedia, 'user_photo', $this->oUserProfile->getId(), null,  ['size'=>'photo']);
            }
            
            $sPath = $this->Fs_GetPathRelative($oMedia->getFileServerPath('photo'), true);
        }
        
        $this->oUserProfile->setPhoto($sPath);
        $this->oUserProfile->setName(getRequest('name'));
        $this->oUserProfile->setAbout(getRequest('about'));
        
        if($this->oUserProfile->_Validate()){
            
            if($this->oUserProfile->Save()){
                $this->Message_AddNotice($this->Lang_Get('common.success.save'));
                //$this->Viewer_AssignAjax('sUrlRedirect', $this->oUserProfile->getProfileUrl().'/settings');
            }
        }else{
            $this->Viewer_AssignAjax('errors', $this->oUserProfile->_getValidateErrors());
        }        
        $this->Viewer_AssignAjax('data', $_REQUEST);
    }
    
}
