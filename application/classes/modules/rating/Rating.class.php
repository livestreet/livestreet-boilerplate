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
        return $this->oMapper->getRatingStatTarget($sTargetType, $iTargetId);
        //SELECT vote, COUNT(id) FROM `prefix_rating_vote` WHERE target_type='user' and target_id=1 GROUP BY vote
    }
}