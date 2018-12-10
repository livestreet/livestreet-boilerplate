<?php


/**
 * Обработка Профиля, т.е. УРЛа вида /profile/
 *
 * @package actions
 * @since 1.0
 */
class ActionProfile extends Action
{

    protected $sMenuHeadItemSelect = 'index';

    /**
     * Инициализация
     *
     */
    public function Init()
    {
        //$this->SetDefaultEvent('index');
    }

    /**
     * Регистрация евентов
     *
     */
    protected function RegisterEvent()
    {
        //$this->AddEvent('index', 'EventIndex');
        $this->AddEventPreg('/^.+$/i', 'EventIndex');
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
        $this->SetTemplateAction('profile');
    }

    

    /**
     * Выполняется при завершении каждого эвента
     */
    public function EventShutdown()
    {
        $this->Viewer_Assign('sMenuHeadItemSelect', $this->sMenuHeadItemSelect);
    }


}