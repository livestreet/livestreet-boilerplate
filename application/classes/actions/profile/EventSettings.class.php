<?php

/**
 * Description of ActionProfile_EventSettings
 *
 * @author oleg
 */
class ActionProfile_EventSettings extends Event {
    
    public function Init() {
        if(!$this->CheckUserProfileAccess()){
            $this->Message_AddError($this->Lang_Get('common.error.system.code.404'), '404', true);
            Router::LocationAction('error');
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
    
    public function EventChangeMail() {
        
        if(isPost()){
            $this->oUserProfile->setMail(getRequest('mail'));
            
            if($this->oUserProfile->_Validate(['mail'])){
                
                $this->Message_AddNotice($this->Lang_Get('user.settings.change_mail.notices.success_send',  ['mail' => getRequest('mail')]));
                
                $sChangeUrl = $this->oUserProfile->getProfileUrl(). '/settings/change-mail-accept';
                $sChangeUrl .= '?mail='.$this->oUserProfile->getMail(). '&key='. $this->oUserProfile->getActivateKey();
                
                $this->Notify_Send(
                    $this->oUserProfile,
                    'change_mail.tpl',
                    $this->Lang_Get('emails.change_mail.subject'),
                    ['sChangeUrl' => $sChangeUrl], null, true
                );
                
            }else{
                $this->Message_AddError($this->oUserProfile->_getValidateError());
            }
        }
        
        $this->Viewer_Assign('sActiveItemSettings', 'change_mail');
        $this->SetTemplateAction('settings/change_mail');
    }
    
    
    public function EventChangeMailAccept() {
        
        if(isPost()){
            $this->oUserProfile->setMail(getRequest('mail'));
            
            if($this->oUserProfile->_Validate(['mail'])){
                
                $this->Message_AddNotice($this->Lang_Get('common.success.save'));
                $this->Notify_Send(
                    $this->oUserProfile,
                    'change_mail.tpl',
                    $this->Lang_Get('emails.change_mail.subject'),
                    ['change_url' => $this->oUserProfile->getProfileUrl(). '/settings/change-mail-accept?mail='.$this->oUserProfile->getMail(). '&key='. $this->oUserProfile->getActivateKey()], null, true
                );
                
            }else{
                $this->Message_AddError($this->oUserProfile->_getValidateError());
            }
        }
        
        $this->Viewer_Assign('sActiveItemSettings', 'change_mail');
        $this->SetTemplateAction('settings/change_mail');
    }
    public function EventSecurity() {
       
        $this->Viewer_Assign('sActiveItemSettings', 'security');
        $this->SetTemplateAction('settings/security');
    }
    
    public function EventSecurityAjax() {
        $this->Viewer_SetResponseAjax('json');
        
        if($this->User_MakeHashPassword(getRequest('password')) != $this->oUserProfile->getPassword()){
            $this->Message_AddError($this->Lang_Get('user.settings.security.notices.error_pass'));
            return;
        }
        
        if(getRequest('password_new') != getRequest('password_confirm')){
            $this->Message_AddError($this->Lang_Get('user.settings.security.notices.error_pass_new'));
            return;
        }
        
        $this->oUserProfile->setPassword($this->User_MakeHashPassword(getRequest('password_new')));
        $this->oUserProfile->Save();
        
        $this->Message_AddNotice('успешно');
        $this->Viewer_AssignAjax('data', $_REQUEST);
    }
    
    public function EventProfileAjax() {
        $this->Viewer_SetResponseAjax('json');
        
        $iPhoto = (isset(getRequest('photo')[0])?getRequest('photo')[0]:0);
        
        if(is_array(getRequest('sizes')) and isset(getRequest('sizes')[$iPhoto])){
            $aSize = getRequest('sizes')[$iPhoto];
        }
        if(is_array(getRequest('canvasWidth')) and isset(getRequest('canvasWidth')[$iPhoto])){
            $iCanvasWidth = getRequest('canvasWidth')[$iPhoto];
        }
        
        $mTarget = $this->Media_GetTargetByFilter([
            'target_type' => 'user_photo', 
            'target_id' => $this->oUserProfile->getId()
        ]);
        
        if($mTarget){
            $mTarget->Delete();
        }
        
        $sPath = '';
        if($oMedia = $this->Media_GetMediaById($iPhoto)){
            
            if(isset($aSize) and isset($iCanvasWidth)){
                if(($sResult = $this->Media_NewSizeFromCrop($oMedia, $aSize, $iCanvasWidth, 
                        'photo', [Config::Get('module.user.photo.width')]) ) !== true){
                    $this->Message_AddError($sResult);
                }
                
                if(($sResult = $this->Media_NewSizeFromCrop($oMedia, $aSize, $iCanvasWidth, 
                        'avatar', [Config::Get('module.user.avatar.width')]) ) !== true){
                    $this->Message_AddError($sResult);
                }
                
                if(($sResult = $this->Media_NewSizeFromCrop($oMedia, $aSize, $iCanvasWidth, 
                        'avatar_small', [Config::Get('module.user.avatar_small.width')]) ) !== true){
                    $this->Message_AddError($sResult);
                }
            }
            
            $mTarget = $this->Media_GetTargetByFilter([
                    'target_type' => 'user_photo', 
                    'target_id' => $this->oUserProfile->getId(), 
                    'media_id' => $iPhoto]);
            
            if(!$mTarget){
                $this->Media_AttachMediaToTarget($oMedia, 'user_photo', $this->oUserProfile->getId(), null,  ['size'=>'photo']);
            }
            
            $sPath = $this->Fs_GetPathRelative($oMedia->getFileServerPath('photo'), true);
            $this->oUserProfile->setPhoto($sPath);
        }
        
        $this->oUserProfile->setName(getRequest('name'));
        $this->oUserProfile->setAbout(getRequest('about'));
        $this->oUserProfile->setSite(getRequest('site'));
        $this->oUserProfile->setPhone(getRequest('phone'));
        $this->oUserProfile->setAddress(getRequest('address'));
        $this->oUserProfile->setLogin(getRequest('login'));
                
        if($this->oUserProfile->_Validate()){
            
            if($this->oUserProfile->Save()){
                $this->Message_AddNotice($this->Lang_Get('common.success.save'));
                $this->Viewer_AssignAjax('sUrlRedirect', $this->oUserProfile->getProfileUrl().'/settings');
            }
        }else{
            $this->Message_AddError($this->oUserProfile->_getValidateError());
            $this->Viewer_AssignAjax('errors', $this->oUserProfile->_getValidateErrors());
        }
               
    }
    
}
