<?php

/**
 * Description of ActionProfile_EventSettings
 *
 * @author oleg
 */
class ActionProfile_EventProfile extends Event {
    
       
    /**
     * Главная страница
     *
     */
    public function EventIndex()
    {
       
        /**
         * Устанавливаем шаблон вывода
         */
        $this->SetTemplateAction('profile');
    }
    
}
