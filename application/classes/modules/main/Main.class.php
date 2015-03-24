<?php

class ModuleMain extends Module
{

    /**
     * Инициализация
     */
    public function Init()
    {

    }

    /**
     * Отправка тестового письма
     *
     * @param string $sMail
     */
    public function SendSimple($sMail)
    {
        $this->Notify_Send(
            $sMail,
            'simple.tpl',
            'Тестовое письмо',
            array()
        );
    }
}