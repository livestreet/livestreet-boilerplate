<?php


/**
 * Description of EntityVote
 *
 * @author oleg
 */
class ModuleTalk_EntityArbitrage extends ModuleTalk_EntityMessage{
    
    public function __construct($aParam = false)
    {
        
        $this->setType('arbitrage');
        
        $this->aRelations['response']  = array(self::RELATION_TYPE_BELONGS_TO, 'ModuleTalk_EntityResponse', 'target_id');
        
        parent::__construct($aParam);
        
        $this->aValidateRules[] = array(
            'target_id,target_type', 
            'exist_message',
            'on' => ['create']
        );
        $this->aValidateRules[] = array(
            'target_id', 
            'number',
            'on' => ['create']
        );
        $this->aValidateRules[] = array(
            'target_type', 
            'string',
            'on' => ['create']
        );
        
        
    }
    
    public function getUrl() {
        $oResponse = $this->getResponse();
        $oUser = $oResponse->getTargetUser();
        return $oUser->getProfileUrl(). '/arbitrage/' . $oResponse->getId();
    }
  
}
