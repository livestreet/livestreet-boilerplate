<?php

/**
 * Description of EventViladate
 *
 * @author oleg
 */
class ActionAjax_EventValidate extends Event{
    
    public function EventValidate() {
        
        if(!$sEntity = getRequest('entity')){
            return $this->EventErrorDebug();
        }
        
        if(!$sField = getRequest('field')){
            return $this->EventErrorDebug();
        }
        
        if(!$sValue = getRequest('value')){
            return $this->EventErrorDebug();
        }       
        
        $oEntity = Engine::GetEntity($sEntity);
        
        $oEntity->_setValidateScenario(getRequest('scenario', ''));
        
        $oEntity->_setData([$sField => $sValue]); 
        
        if (!$oEntity->_Validate([$sField], true)) {
            /**
             * Получаем ошибки
             */
            $this->Viewer_AssignAjax('bStateError', 1);
            $this->Viewer_AssignAjax('error', $oEntity->_getValidateError($sField));
            return;
        }
        
        $this->Viewer_AssignAjax('bStateError', 0);
        
    }
}
