<?php

/**
 * Description of ActionProfile_EventSettings
 *
 * @author oleg
 */
class ActionAjax_EventMedia extends Event {
    
    public $oUserCurrent;


    public function Init() {
        /**
         * Пользователь авторизован?
         */
        if (!$this->oUserCurrent = $this->User_GetUserCurrent()) {
            $this->Message_AddErrorSingle($this->Lang_Get('common.error.need_authorization'), $this->Lang_Get('common.error.error'));
            return;
        }
    }
    
    

    public function EventMediaRemoveFile()
    {
        /**
         * Пользователь авторизован?
         */
        if (!$this->oUserCurrent) {
            $this->Message_AddErrorSingle($this->Lang_Get('common.error.need_authorization'), $this->Lang_Get('common.error.error'));
            return;
        }
        $sId = getRequestStr('id');
        if (!$oMedia = $this->Media_GetMediaById($sId)) {
            return $this->EventErrorDebug();
        }
        
        if ($aMediaTargets = $this->Media_GetTargetItemsByFilter(['media_id' => $oMedia->getId()])) {
            foreach ($aMediaTargets as $oMediaTarget) {
                $oMediaTarget->Delete();
            }
        }
        
        if (!$oMedia->Delete()) {
            $this->Message_AddErrorSingle(is_string($res) ? $res : $this->Lang_Get('common.error.system.base'));
        }else{
            $this->Message_AddNotice($this->Lang_Get('common.success.remove'));
        }
    }


    public function EventMediaLoadGallery()
    {
        

        $sType = getRequestStr('target_type');
        $sId = getRequestStr('target_id');
        $sTmp = getRequestStr('target_tmp');
        $iPage = (int)getRequestStr('page');
        $iPage = $iPage < 1 ? 1 : $iPage;

        /**
        * Получаем все медиа, созданные пользователем без учета временных
        */
        $aResult = $this->Media_GetMediaItemsByFilter(array(
            'user_id'       => $this->oUserCurrent->getId(),
            '#with'         => ['targets'],
            '#page'         => array($iPage, 12),
            '#group'        => 'id',
            '#order'        => array('id' => 'desc')
        ));
        
        $aPaging = $this->Viewer_MakePaging($aResult['count'], $iPage, 12, Config::Get('pagination.pages.count'), null);
        $aMediaItems = $aResult['collection'];

        $oViewer = $this->Viewer_GetLocalViewer();
        $sTemplate = '';
        $oViewer->Assign('items', $aMediaItems, true);
        $oViewer->Assign('paging', $aPaging, true);
        $sTemplate .= $oViewer->Fetch('component@bs-media.files');
        
        $this->Viewer_AssignAjax('html', $sTemplate);
    }

    
    public function EventMediaUpload()
    {
        
        /**
         * Файл был загружен?
         */
        if (!isset($_FILES['filedata']['tmp_name'])) {
            return $this->EventErrorDebug();
        }
        /**
         * Проверяем корректность target'а
         */
        $sTargetType = getRequestStr('target_type', "user");
        $sUserId = getRequestStr('user_id', 0);

        /**
         * TODO: необходима проверка на максимальное общее количество файлов, на максимальный размер файла
         * Эти настройки можно хранить в конфиге: module.media.type.topic.max_file_count=30 и т.п.
         */
        $oMedia = $this->Media_GetMediaByFilter([
            'target_type'   => $sTargetType,
            'user_id'     => $sUserId,
            'file_name'     => substr($_FILES['filedata']['name'], 0, strrpos($_FILES['filedata']['name'], "."))
        ]);
        if($oMedia){
            $this->Message_AddError( $this->Lang_Get('media.uploader.notices.errorDublicate'));
            return;
        }
        /**
         * Выполняем загрузку файла
         */
        if ($mResult = $this->Media_Upload($_FILES['filedata'], $sTargetType , $sUserId) and is_object($mResult)) {
            $this->Viewer_AssignAjax('iMediaId', $mResult->getId());
        } else {
            $this->Message_AddError(is_string($mResult) ? $mResult : $this->Lang_Get('common.error.system.base'),
                $this->Lang_Get('common.error.error'));
        }
    }

}
