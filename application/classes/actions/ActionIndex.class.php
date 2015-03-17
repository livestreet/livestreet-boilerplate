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
 * Обработка главной страницы, т.е. УРЛа вида /index/
 *
 * @package actions
 * @since 1.0
 */
class ActionIndex extends Action
{

    protected $sMenuHeadItemSelect = 'index';

    /**
     * Инициализация
     *
     */
    public function Init()
    {
        $this->SetDefaultEvent('index');
    }

    /**
     * Регистрация евентов
     *
     */
    protected function RegisterEvent()
    {
        $this->AddEvent('index', 'EventIndex');
        $this->AddEventPreg('/^page-num-(\d+)$/i', 'EventPageNum');
    }


    /**********************************************************************************
     ************************ РЕАЛИЗАЦИЯ ЭКШЕНА ***************************************
     **********************************************************************************
     */

    /**
     * Главная страница
     *
     */
    protected function EventIndex()
    {
        /**
         * Устанавливаем шаблон вывода
         */
        $this->SetTemplateAction('index');
    }

    /**
     * Тестовая страница
     *
     */
    protected function EventPageNum()
    {
        /**
         * Получаем значение номера из результатов обработки регулярного выражения к строке евента
         */
        $iNum = $this->GetEventMatch(1);
        /**
         * Загружаем переменную в шаблон
         */
        $this->Viewer_Assign('iNum', $iNum);
        /**
         * Устанавливаем TITLE страницы
         */
        $this->Viewer_AddHtmlTitle('Это тестовая страница');
        /**
         * Устанавливаем текущий пункт главного меню
         */
        $this->sMenuHeadItemSelect = 'page';
        /**
         * Устанавливаем шаблон вывода
         */
        $this->SetTemplateAction('page');
    }

    /**
     * Выполняется при завершении каждого эвента
     */
    public function EventShutdown()
    {
        $this->Viewer_Assign('sMenuHeadItemSelect', $this->sMenuHeadItemSelect);
    }


}