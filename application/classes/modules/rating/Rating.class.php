<?php

class ModuleRating extends ModuleORM
{
    /**
     * Инициализация
     *
     */
    public function Init()
    {
        parent::Init();
    }

    public function Vote($iUserId, $sTargetType, $iTargetId, $iVote){
        
        $oVote = Engine::GetEntity('Rating_Vote');
        $oVote->setUserId($iUserId);
        $oVote->setTargetType($sTargetType);
        $oVote->setTargetId($iTargetId);
        $oVote->setVote($iVote);
        
        if(!$oVote->_Validate()){
            return $oVote->_getValidateErrors();
        }
        
        return $oVote->Save();
    }
}