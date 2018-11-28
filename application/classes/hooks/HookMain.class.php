<?php
/*-------------------------------------------------------
*
*   LiveStreet Engine Social Networking
*   Copyright © 2008 Mzhelskiy Maxim
*
*--------------------------------------------------------
*
*   Official site: www.livestreet.ru
*   Contact e-mail: rus.engine@gmail.com
*
*   GNU General Public License, version 2:
*   http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
*
---------------------------------------------------------
*/

/**
 * Регистрация основных хуков
 *
 * @package hooks
 * @since 1.0
 */
class HookMain extends Hook {
	/**
	 * Регистрируем хуки
	 */
	public function RegisterHook() {
		$this->AddHook('start_action','StartAction');
	}
	/**
	 * Обработка хука старте экшенов. Выполняется один раз в отличии от хука "init_action"
	 */
	public function StartAction() {
		/**
		 * Загружаем в шаблон текущего пользователя
		 */
		$this->Viewer_Assign('oUserCurrent',$this->User_GetUserCurrent());
		/**
		 * Загружаем js и текстовки в шаблон
		 */
		$this->LoadDefaultJsVarAndLang();
	}

	/**
	 * Загрузка необходимых переменных и текстовок в шаблон
	 */
	public function LoadDefaultJsVarAndLang()
	{
		/**
		 * Загружаем JS переменные
		 */
		$this->Viewer_AssignJs(
			array(
				'recaptcha.site_key'    => Config::Get('module.validate.recaptcha.site_key'),
			)
		);

		/**
		 * Загрузка языковых текстовок
		 */
		$this->Lang_AddLangJs(array(
			//'validate.tags.count'
		));
	}
}