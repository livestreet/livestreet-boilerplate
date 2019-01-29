<?php

/**
 * Description of ActionModeration_EventModeration
 *
 * @author oleg
 */
class ActionModeration_EventProfiles extends Event {
    
    
        
    public function EventProfiles() 
    {
        
        $this->sMenuItemSelect = 'profiles';
        
        $iPage = $this->GetParamEventMatch(0, 2);
        $iPage = $iPage?$iPage:1;
        
        $iLimit =  Config::Get('moderation.profiles.page_count');
        
        
        
        
        $aUserTargets = $this->Moderation_GetProfileTargetItemsByFilter([
            'user_id' => $this->oUserCurrent->getId(),
            '#index-from'   => 'target_id',
            '#order' => ['date_create' => 'desc']
        ]);  
        
        $aFilter =  [
            'id in'         => array_merge([0],array_keys($aUserTargets)),
            '#index-from'   => 'id',
            '#page'         => [ $iPage, $iLimit],
        ];
        
        
        $aProfiles = $this->User_GetUserItemsByFilter($aFilter);

        $aPaging = $this->Viewer_MakePaging($aProfiles['count'], $iPage, $iLimit, 
                Config::Get('module.talk.pagination.pages.count'), Router::GetPath('moderation/profiles'));
        
        $this->Viewer_Assign('aPaging', $aPaging);        
        $this->Viewer_Assign('aProfiles', $aProfiles['collection']);
        $this->Viewer_Assign('count', $aProfiles['count']);
        
        $this->SetTemplateAction('profiles');
    }
    
    public function EventProfileEdit() 
    {
        
        $this->sMenuItemSelect = 'profiles';
        
        $iUserId = $this->GetParam(0);
               
        $oProfile = $this->User_GetUserById($iUserId);
        
        $this->Viewer_Assign('oProfile', $oProfile);
        $this->SetTemplateAction('profile-edit');
    }
    
    public function EventAjaxEditProfile() {
        $this->Viewer_SetResponseAjax('json');
        
        if( !$oProfile = $this->User_GetUserById(getRequest('id')) ){
            $oProfile = Engine::GetEntity('User_User');
        }
        
        $this->Rbac_RemoveRoleFromUser($oProfile->getRole(), $oProfile->getId());
        
        $oProfile->setMail($this->User_GetUserById(1)->getMail());
        $oProfile->setName(getRequest('name'));
        $oProfile->setAbout(getRequest('about'));
        $oProfile->setSite(getRequest('site'));
        $oProfile->setPhone(getRequest('phone'));
        $oProfile->setAddress(getRequest('address'));
        $oProfile->setLogin(getRequest('login'));
        $oProfile->setRole(getRequest('role'));
        $oProfile->setActivate((getRequest('activate') == 'on'));
        
        
        
        if($oProfile->_Validate()){
            
            
            
            if(!$oProfile->Save()){
                return;
            }
            
            if($oProfile->_isNew()){
                $oTarget = Engine::GetEntity('Moderation_ProfileTarget');
                $oTarget->setUserId($this->oUserCurrent->getId());
                $oTarget->setTargetId($oProfile->getId());
                $oTarget->Save();
            }
            
            $this->Message_AddNotice($this->Lang_Get('common.success.save'));
            $this->Viewer_AssignAjax('sUrlRedirect', Router::GetPath('moderation/profiles'));
            
        }else{
            $this->Message_AddError($oProfile->_getValidateError());
            $this->Viewer_AssignAjax('errors', $oProfile->_getValidateErrors());
            return;
        }   
        
        $iPhoto = (isset(getRequest('photo')[0])?getRequest('photo')[0]:0);
        
        if(is_array(getRequest('sizes')) and isset(getRequest('sizes')[$iPhoto])){
            $aSize = getRequest('sizes')[$iPhoto];
        }
        if(is_array(getRequest('canvasWidth')) and isset(getRequest('canvasWidth')[$iPhoto])){
            $iCanvasWidth = getRequest('canvasWidth')[$iPhoto];
        }
        
        $mTarget = $this->Media_GetTargetByFilter([
            'target_type' => 'user_photo', 
            'target_id' => $oProfile->getId()
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
                    'target_id' => $oProfile->getId(), 
                    'media_id' => $iPhoto]);
            
            if(!$mTarget){
                $this->Media_AttachMediaToTarget($oMedia, 'user_photo', $oProfile->getId(), null,  ['size'=>'photo']);
            }
            
            $sPath = $this->Fs_GetPathRelative($oMedia->getFileServerPath('photo'), true);
            $oProfile->setPhoto($sPath);
            $oProfile->Update();
        }
    }
    
}
