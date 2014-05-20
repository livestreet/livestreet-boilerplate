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
 * Экшен обработки ajax запросов
 * Ответ отдает в JSON фомате
 *
 * @package actions
 * @since 1.0
 */
class ActionAjax extends Action {
	/**
	 * Инициализация
	 */
	public function Init() {
		/**
		 * Устанавливаем формат ответа
		 */
		$this->Viewer_SetResponseAjax('json');
	}
	/**
	 * Регистрация евентов
	 */
	protected function RegisterEvent() {
		$this->AddEventPreg('/^vote$/i','/^user$/','EventVoteUser');
	}


	/**********************************************************************************
	 ************************ РЕАЛИЗАЦИЯ ЭКШЕНА ***************************************
	 **********************************************************************************
	 */

	/**
	 * Голосование
	 */
	protected function EventVoteUser() {
		/**
		 * Получаем значение из реквеста (GET или POST параметр)
		 */
		$iValue=getRequestStr('value');
		/**
		 * Если значение не -1 и не 1, то выводим ошибку
		 */
		if (!in_array($iValue,array(-1,1))) {
			/**
			 * Если значение конфига sys.debug.action_error = true, то выведем отладочную информацию о том, где произошла ошибка
			 */
			return $this->EventErrorDebug();
		}
		/**
		 * Здесь логика по голосованию
		 */
		$iRating=rand(1,100)+$iValue;
		/**
		 * Выводим всплывающее сообщение об успешном голосовании
		 */
		$this->Message_AddNoticeSingle('Голосование прошло успешно');
		/**
		 * Возвращаем в ответе новый рейтинг
		 */
		$this->Viewer_AssignAjax('iRating',$iRating);
	}
}