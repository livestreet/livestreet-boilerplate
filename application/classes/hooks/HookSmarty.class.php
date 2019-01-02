<?php


/**
 * Регистрация основных хуков
 *
 * @package hooks
 * @since 1.0
 */
class HookSmarty extends Hook {
	/**
	 * Регистрируем хуки
	 */
	public function RegisterHook() {
		$this->AddHook('viewer_init_assign','SmartyConfig');
	}
	/**
	 * Обработка хука старте экшенов. Выполняется один раз в отличии от хука "init_action"
	 */
	public function SmartyConfig() {
            /**
             * Добавляем директорию плаинов для Smarty
             */
            $this->Viewer_GetSmartyObject()->addPluginsDir(Config::Get('path.application.server').'/classes/modules/viewer/plugs');
	
	}


}