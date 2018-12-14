<?php

/**
 * Регистрация основных хуков
 *
 * @package hooks
 * @since 1.0
 */
class HookRecaptcha extends Hook {
	/**
	 * Регистрируем хуки
	 */
	public function RegisterHook() {
            $this->AddHook('action_event_auth_before','RecaptchaPrepend');
	}
	public function RecaptchaPrepend() {
            /**
             * Добавляем директорию плаинов для Smarty
             */
            $this->Viewer_AppendScript("https://www.google.com/recaptcha/api.js?render="
                .Config::Get('module.validate.recaptcha.site_key'));
            
	
	}


}