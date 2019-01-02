<?php


/**
 * Description of EntityVote
 *
 * @author oleg
 */
class ModuleTalk_EntityArbitrage extends EntityORM{
    
    public function __construct($aParam = false)
    {
        parent::__construct($aParam);
        
        $this->aValidateRules[] = array(
            'target_id,target_type', 
            'exist_message',
            'on' => ['']
        );
        
        $this->setType('arbitrage');
        
        $this->aRelations['response']  = array(self::RELATION_TYPE_BELONGS_TO, 'ModuleTalk_EntityResponse', 'target_id');
    }
    
    
    public function afterSave() {
        parent::afterSave();
        
        if($oResponse = $this->getResponse()){
            $oResponse->setState('arbitrage');
            $oResponse->Save();
        }
    }
}
