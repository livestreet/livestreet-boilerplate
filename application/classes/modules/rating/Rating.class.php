<?php

class ModuleRating extends ModuleORM
{
    
    protected $oMapper = null;
    /**
     * Инициализация
     *
     */
    public function Init()
    {
        parent::Init();
        $this->oMapper = Engine::GetMapper(__CLASS__);
    }

    public function Vote($iUserId, $sTargetType, $iTargetId, $iVote, $iFromId){
        
        $oVote = Engine::GetEntity('Rating_Vote');
        $oVote->setUserId($iUserId);
        $oVote->setTargetType($sTargetType);
        $oVote->setTargetId($iTargetId);
        $oVote->setVote($iVote);
        $oVote->setFromId($iFromId);
        
        if(!$oVote->_Validate()){
            return $oVote->_getValidateErrors();
        }
        
        return $oVote->Save();
    }
    
    public function GetRatingUser($iUserId) {
        return $this->GetRatingTarget('user', $iUserId);
    }
    
    public function GetRatingTarget($sTargetType, $iTargetId) {
        $iSum = $this->GetSumVoteFromVoteByFilter([
            'target_type'   => $sTargetType,
            'target_id'     => $iTargetId
        ]);
        
        $iCount = $this->GetCountVoteTarget($sTargetType, $iTargetId);
        
        return $iCount?($iSum/$iCount):0;
    }
    
    public function GetCountVoteTarget($sTargetType, $iTargetId) {
        return $this->GetCountFromVoteByFilter([
            'target_type'   => $sTargetType,
            'target_id'     => $iTargetId
        ]);
    }
    
    public function GetRatingStatTarget($sTargetType, $iTargetId) {
        $aResult =  $this->oMapper->getRatingStatTarget($sTargetType, $iTargetId);
        
        $iCount = array_sum($aResult);
        
        $aStat = [];
        $iMaxStars = Config::Get('module.rating.max_rating');
        for($i=1 ; $i<=$iMaxStars; $i++){
            $aStat[$i] = isset($aResult[$i])?round($aResult[$i]/($iCount/100)):0;
        }
        
        return $aStat;
    }
}