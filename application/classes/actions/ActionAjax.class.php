<?php
/*
 * LiveStreet CMS
 * Copyright © 2013 OOO "ЛС-СОФТ"
 *
 * ------------------------------------------------------
 *
 * Official site: www.livestreetcms.com
 * Contact e-mail: office@livestreetcms.com
 *
 * GNU General Public License, version 2:
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
 *
 * ------------------------------------------------------
 *
 * @link http://www.livestreetcms.com
 * @copyright 2013 OOO "ЛС-СОФТ"
 * @author Maxim Mzhelskiy <rus.engine@gmail.com>
 *
 */

/**
 * Экшен обработки ajax запросов
 * Ответ отдает в JSON фомате
 *
 * @package actions
 * @since 1.0
 */
class ActionAjax extends Action
{
    /**
     * Инициализация
     */
    public function Init()
    {
        /**
         * Устанавливаем формат ответа
         */$this->Logger_Notice(print_r($_REQUEST, true));
        if (getRequest('is_iframe')) {
            $this->Viewer_SetResponseAjax('jsonIframe', false);
        } else {
            $this->Viewer_SetResponseAjax('json');
        }
        
    }

    /**
     * Регистрация евентов
     */
    protected function RegisterEvent()
    {
        $this->AddEventPreg('/^captcha$/i', '/^$/', 'EventCaptcha');
        $this->AddEventPreg('/^captcha$/i', '/^validate$/', '/^$/', 'EventCaptchaValidate');
        
        $this->AddEventPreg('/^verify-recaptcha/i', '/^$/', 'EventVerifyRecaptcha');

        $this->AddEventPreg('/^vote$/i', '/^user$/', 'EventVoteUser');
        
        $this->RegisterEventExternal('Media', 'ActionAjax_EventMedia');
        $this->AddEventPreg('/^media$/i', '/^upload$/', '/^$/', 'Media::EventMediaUpload');
        $this->AddEventPreg('/^media$/i', '/^upload-link$/', '/^$/', 'Media::EventMediaUploadLink');
        $this->AddEventPreg('/^media$/i', '/^generate-target-tmp$/', '/^$/', 'Media::EventMediaGenerateTargetTmp');
        $this->AddEventPreg('/^media$/i', '/^submit-insert$/', '/^$/', 'Media::EventMediaSubmitInsert');
        $this->AddEventPreg('/^media$/i', '/^submit-create-photoset$/', '/^$/', 'Media::EventMediaSubmitCreatePhotoset');
        $this->AddEventPreg('/^media$/i', '/^load-gallery$/', '/^$/', 'Media::EventMediaLoadGallery');
        $this->AddEventPreg('/^media$/i', '/^remove-file$/', '/^$/', 'Media::EventMediaRemoveFile');
        $this->AddEventPreg('/^media$/i', '/^create-preview-file$/', '/^$/', 'Media::EventMediaCreatePreviewFile');
        $this->AddEventPreg('/^media$/i', '/^remove-preview-file$/', '/^$/', 'Media::EventMediaRemovePreviewFile');
        $this->AddEventPreg('/^media$/i', '/^remove-target$/', '/^$/', 'Media::EventMediaRemoveTarget');
        $this->AddEventPreg('/^media$/i', '/^load-preview-items$/', '/^$/', 'Media::EventMediaLoadPreviewItems');
        $this->AddEventPreg('/^media$/i', '/^save-data-file$/', '/^$/', 'Media::EventMediaSaveDataFile');
    }


    /**********************************************************************************
     ************************ РЕАЛИЗАЦИЯ ЭКШЕНА ***************************************
     **********************************************************************************
     */

    /**
     * Отображение каптчи
     */
    protected function EventCaptcha()
    {
        $this->Viewer_SetResponseAjax(null);
        /**
         * Подключаем каптчу
         */
        require_once(Config::Get('path.framework.libs_vendor.server') . '/kcaptcha/kcaptcha.php');
        /**
         * Определяем уникальное название (возможность нескольких каптч на одной странице)
         */
        $sName = '';
        if (isset($_GET['name']) and is_string($_GET['name']) and $_GET['name']) {
            $sName = $_GET['name'];
        }
        /**
         * Генерируем каптчу и сохраняем код в сессию
         */
        $oCaptcha = new KCAPTCHA();
        $this->Session_Set('captcha_keystring' . ($sName ? '_' . $sName : ''), $oCaptcha->getKeyString());
        $this->SetTemplate(false);
    }

    /**
     * Ajax валидация каптчи
     */
    protected function EventCaptchaValidate()
    {
        $sName = isset($_REQUEST['name']) ? $_REQUEST['name'] : '';
        $sValue = isset($_REQUEST['captcha']) ? $_REQUEST['captcha'] : '';

        $sCaptchaValidateType = func_camelize('captcha_' . Config::Get('sys.captcha.type'));
        if (!$this->Validate_Validate($sCaptchaValidateType, $sValue, array('name' => $sName))) {
            $aErrors = $this->Validate_GetErrors();
            $this->Viewer_AssignAjax('errors', array('captcha' => array(reset($aErrors))));
        }
    }

    /**
     * Голосование
     */
    protected function EventVoteUser()
    {
        /**
         * Получаем значение из реквеста (GET или POST параметр)
         */
        $iValue = getRequestStr('value');
        /**
         * Если значение не -1 и не 1, то выводим ошибку
         */
        if (!in_array($iValue, array(-1, 1))) {
            /**
             * Если значение конфига sys.debug.action_error = true, то выведем отладочную информацию о том, где произошла ошибка
             */
            return $this->EventErrorDebug();
        }
        /**
         * Здесь логика по голосованию
         */
        $iRating = rand(1, 100) + $iValue;
        /**
         * Выводим всплывающее сообщение об успешном голосовании
         */
        $this->Message_AddNoticeSingle('Голосование прошло успешно');
        /**
         * Возвращаем в ответе новый рейтинг
         */
        $this->Viewer_AssignAjax('iRating', $iRating);
    }
    
    public function EventVerifyRecaptcha() {
        $this->Viewer_SetResponseAjax('json');
        
        $oValidate = Engine::GetEntity('ModuleValidate_EntityValidatorCaptchaRecaptcha');
        $oValidate->msg = "Не верный код Recaptcha";
        
        if(($sResult = $oValidate->validate(getRequest('token'))) === true){
            $this->Viewer_AssignAjax('success', true);
        }else{
            $this->Message_AddError($sResult);
        }
    }
}