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
    
    public function EventMediaUploadLink()
    {
        /**
         * Пользователь авторизован?
         */
        if (!$this->oUserCurrent) {
            $this->Message_AddErrorSingle($this->Lang_Get('common.error.need_authorization'), $this->Lang_Get('common.error.error'));
            return;
        }
        /**
         * URL передали?
         */
        if (!($sUrl = getRequestStr('url'))) {
            return $this->EventErrorDebug();
        }
        /**
         * Необходимо выполнить загрузку файла
         */
        if (getRequest('upload')) {
            /**
             * Проверяем корректность target'а
             */
            $sTargetType = getRequestStr('target_type');
            $sTargetId = getRequestStr('target_id');

            $sTargetTmp = $this->Session_GetCookie('media_target_tmp_' . $sTargetType) ? $this->Session_GetCookie('media_target_tmp_' . $sTargetType) : getRequestStr('target_tmp');
            if ($sTargetId) {
                $sTargetTmp = null;
                if (true !== $res = $this->Media_CheckTarget($sTargetType, $sTargetId,
                        ModuleMedia::TYPE_CHECK_ALLOW_ADD,
                        array('user' => $this->oUserCurrent))
                ) {
                    $this->Message_AddError(is_string($res) ? $res : $this->Lang_Get('common.error.system.base'),
                        $this->Lang_Get('common.error.error'));
                    return false;
                }
            } else {
                $sTargetId = null;
                if (!$sTargetTmp) {
                    return $this->EventErrorDebug();
                }
                if (true !== $res = $this->Media_CheckTarget($sTargetType, null, ModuleMedia::TYPE_CHECK_ALLOW_ADD,
                        array('user' => $this->oUserCurrent), $sTargetTmp)
                ) {
                    $this->Message_AddError(is_string($res) ? $res : $this->Lang_Get('common.error.system.base'),
                        $this->Lang_Get('common.error.error'));
                    return false;
                }
            }

            /**
             * Выполняем загрузку файла
             */
            if ($mResult = $this->Media_UploadUrl($sUrl, $sTargetType, $sTargetId, $sTargetTmp) and is_object($mResult)
            ) {
                $aParams = array(
                    'align' => getRequestStr('align'),
                    'title' => getRequestStr('title')
                );
                $this->Viewer_AssignAjax('sText', $this->Media_BuildCodeForEditor($mResult, $aParams));
            } else {
                $this->Message_AddError(is_string($mResult) ? $mResult : $this->Lang_Get('common.error.system.base'),
                    $this->Lang_Get('common.error.error'));
            }
        } else {
            /**
             * Формируем параметры для билдера HTML
             */
            $aParams = array(
                'align'     => getRequestStr('align'),
                'title'     => getRequestStr('title'),
                'image_url' => $sUrl
            );
            $this->Viewer_AssignAjax('sText', $this->Media_BuildImageCodeForEditor($aParams));
        }
    }

    public function EventMediaSaveDataFile()
    {
        /**
         * Пользователь авторизован?
         */
        if (!$this->oUserCurrent) {
            $this->Message_AddErrorSingle($this->Lang_Get('common.error.need_authorization'), $this->Lang_Get('common.error.error'));
            return;
        }
        $aAllowData = array('title');
        $sName = getRequestStr('name');
        $sValue = getRequestStr('value');
        if (!in_array($sName, $aAllowData)) {
            return $this->EventErrorDebug();
        }
        $sId = getRequestStr('id');
        if (!$oMedia = $this->Media_GetMediaById($sId)) {
            return $this->EventErrorDebug();
        }
        if (true === $res = $this->Media_CheckTarget($oMedia->getTargetType(), null,
                ModuleMedia::TYPE_CHECK_ALLOW_UPDATE, array('media' => $oMedia, 'user' => $this->oUserCurrent))
        ) {
            $oMedia->setDataOne($sName, $sValue);
            $oMedia->Update();
        } else {
            $this->Message_AddErrorSingle(is_string($res) ? $res : $this->Lang_Get('common.error.system.base'));
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

    public function EventMediaCreatePreviewFile()
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

        $sTargetType = getRequestStr('target_type');
        $sTargetId = getRequestStr('target_id') ?: null;
        $sTargetTmp = getRequestStr('target_tmp') ?: null;

        /**
         * Доступ к файлу медиа
         */
        if (!$this->Media_GetAllowMediaItemsById(array($oMedia->getId()))) {
            return $this->EventErrorDebug();
        }

        /**
         * Проверяем доступ к этому объекту медиа
         */
        if (true !== $res = $this->Media_CheckTarget($sTargetType, $sTargetId,
                ModuleMedia::TYPE_CHECK_ALLOW_PREVIEW, array('media' => $oMedia, 'user' => $this->oUserCurrent))
        ) {
            $this->Message_AddErrorSingle(is_string($res) ? $res : $this->Lang_Get('common.error.system.base'));
        }

        /**
         * Получаем объект связи
         */
        $aFilter = array('media_id' => $oMedia->getId(), 'target_type' => $sTargetType);
        if ($sTargetTmp) {
            $aFilter['target_tmp'] = $sTargetTmp;
        } else {
            $aFilter['target_id'] = $sTargetId;
        }
        if (!$oTarget = $this->Media_GetTargetByFilter($aFilter)) {
            /**
             * Попытка добавить в качестве превью ранее загруженный файл для другого объекта
             * Делаем новую связь медиа с текущим объектом
             */
            if (!($oTarget = $this->Media_AttachMediaToTarget($oMedia, $sTargetType, $sTargetId, $sTargetTmp))) {
                return $this->EventErrorDebug();
            }
        }

        /**
         * Удаляем все текущие превью
         */
        $this->Media_RemoveAllPreviewByTarget($oTarget->getTargetType(), $oTarget->getTargetId(), $oTarget->getTargetTmp());

        if (true === $res2 = $this->Media_CreateFilePreview($oMedia, $oTarget)) {
            $this->Viewer_AssignAjax('bUnsetOther', true);
        } else {
            $this->Message_AddErrorSingle(is_string($res2) ? $res2 : $this->Lang_Get('common.error.system.base'));
        }
    }

    public function EventMediaRemovePreviewFile()
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

        $sTargetType = getRequestStr('target_type');
        $sTargetId = getRequestStr('target_id');
        $sTargetTmp = getRequestStr('target_tmp');

        /**
         * Получаем объект связи
         */
        $aFilter = array('media_id' => $oMedia->getId(), 'target_type' => $sTargetType);
        if ($sTargetTmp) {
            $aFilter['target_tmp'] = $sTargetTmp;
        } else {
            $aFilter['target_id'] = $sTargetId;
        }
        if (!$oTarget = $this->Media_GetTargetByFilter($aFilter)) {
            return $this->EventErrorDebug();
        }
        if (!$oTarget->getIsPreview()) {
            return $this->EventErrorDebug();
        }


        /**
         * Проверяем доступ к этому медиа
         */
        if (true === $res = $this->Media_CheckTarget($oTarget->getTargetType(), $oTarget->getTargetId(),
                ModuleMedia::TYPE_CHECK_ALLOW_PREVIEW, array('media' => $oMedia, 'user' => $this->oUserCurrent))
        ) {
            /**
             * Удаляем превью
             */
            $this->Media_RemoveFilePreview($oMedia, $oTarget);
        } else {
            $this->Message_AddErrorSingle(is_string($res) ? $res : $this->Lang_Get('common.error.system.base'));
        }
    }
    
    public function EventMediaRemoveTarget()
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

        $sTargetType = getRequestStr('target_type');
        $sTargetId = getRequestStr('target_id');
        $sTargetTmp = getRequestStr('target_tmp');

        /**
         * Получаем объект связи
         */
        $aFilter = array('media_id' => $oMedia->getId(), 'target_type' => $sTargetType);
        if ($sTargetTmp) {
            $aFilter['target_tmp'] = $sTargetTmp;
        } else {
            $aFilter['target_id'] = $sTargetId;
        }
        if (!$oTarget = $this->Media_GetTargetByFilter($aFilter)) {
            return $this->EventErrorDebug();
        }
        $oTarget->Delete();

        $this->Viewer_AssignAjax('bRemoveResult', $oTarget->Delete());
        
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
//            '#select'       => ['t.*', 'count(mt.id) as count_targets'],
            '#page'         => array($iPage, 12),
//            '#join'         => array(
//                'LEFT JOIN ' . Config::Get('db.table.media_target') . ' mt ON ( t.id = mt.media_id ) ' => array(),
//            ),
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

    public function EventMediaLoadPreviewItems()
    {
        /**
         * Пользователь авторизован?
         */
        if (!$this->oUserCurrent) {
            $this->Message_AddErrorSingle($this->Lang_Get('common.error.need_authorization'), $this->Lang_Get('common.error.error'));
            return;
        }

        $sType = getRequestStr('target_type');
        $sId = getRequestStr('target_id');
        $sTmp = getRequestStr('target_tmp');

        $aFilter = array(
            'target_type' => $sType,
            'is_preview'  => 1,
        );
        if ($sId) {
            $aFilter['target_id'] = $sId;
        } else {
            $aFilter['target_tmp'] = $sTmp;
        }
        $aTargetItems = $this->Media_GetTargetItemsByFilter($aFilter);
        $oViewer = $this->Viewer_GetLocalViewer();
        $oViewer->Assign('imagePreviewItems', $aTargetItems);
        $this->Viewer_AssignAjax('sTemplatePreview', $oViewer->Fetch('component@field.image-ajax-items'));
    }

    public function EventMediaSubmitInsert()
    {
        $aIds = array(0);
        foreach ((array)getRequest('ids') as $iId) {
            $aIds[] = (int)$iId;
        }

        if (!($aMediaItems = $this->Media_GetAllowMediaItemsById($aIds))) {
            $this->Message_AddError($this->Lang_Get('media.error.need_choose_items'));
            return false;
        }

        $aParams = array(
            'align'        => getRequestStr('align'),
            'size'         => getRequestStr('size'),
            'relative_web' => true
        );
        /**
         * Если изображений несколько, то генерируем идентификатор группы для лайтбокса
         */
        if (count($aMediaItems) > 1) {
            $aParams['lbx_group'] = rand(1, 100);
        }

        $sTextResult = '';
        foreach ($aMediaItems as $oMedia) {
            $sTextResult .= $this->Media_BuildCodeForEditor($oMedia, $aParams) . "\r\n";
        }
        $this->Viewer_AssignAjax('sTextResult', $sTextResult);
    }

    public function EventMediaSubmitCreatePhotoset()
    {
        $aMediaItems = $this->Media_GetAllowMediaItemsById(getRequest('ids'));
        if (!$aMediaItems) {
            $this->Message_AddError($this->Lang_Get('media.error.need_choose_items'));
            return false;
        }

        $aItems = array();
        foreach ($aMediaItems as $oMedia) {
            $aItems[] = $oMedia->getId();
        }

        $sTextResult = '<gallery items="' . join(',', $aItems) . '"';
        if (getRequest('use_thumbs')) {
            $sTextResult .= ' nav="thumbs" ';
        }
        if (getRequest('show_caption')) {
            $sTextResult .= ' caption="1" ';
        }
        $sTextResult .= ' />';

        $this->Viewer_AssignAjax('sTextResult', $sTextResult);
    }

    public function EventMediaGenerateTargetTmp()
    {
        $sType = getRequestStr('type');
        if ($this->Media_IsAllowTargetType($sType)) {
            $sTmp = func_generator();
            $this->Session_SetCookie('media_target_tmp_' . $sType, $sTmp, time() + 24 * 3600);
            $this->Viewer_AssignAjax('sTmpKey', $sTmp);
        }
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
        $sTargetType = getRequestStr('target_type');
        $sTargetId = getRequestStr('target_id');

        /**
         * TODO: необходима проверка на максимальное общее количество файлов, на максимальный размер файла
         * Эти настройки можно хранить в конфиге: module.media.type.topic.max_file_count=30 и т.п.
         */

        /**
         * Выполняем загрузку файла
         */
        if ($mResult = $this->Media_Upload($_FILES['filedata'], "user{$this->oUserCurrent->getId()}", null) and is_object($mResult)) {
            $this->Viewer_AssignAjax('iMediaId', $mResult->getId());
        } else {
            $this->Message_AddError(is_string($mResult) ? $mResult : $this->Lang_Get('common.error.system.base'),
                $this->Lang_Get('common.error.error'));
        }
    }

}
