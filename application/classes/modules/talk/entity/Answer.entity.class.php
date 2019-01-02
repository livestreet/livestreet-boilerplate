<?php


/**
 * Description of EntityVote
 *
 * @author oleg
 */
class ModuleTalk_EntityAnswer extends ModuleTalk_EntityMessage{
    
   
    public function __construct($aParam = false)
    {
        parent::__construct($aParam);
        
        $this->aValidateRules[] = array(
            'target_id,target_type', 
            'exist_message',
            'on' => ['']
        );        
        
        $this->setType('answer');
        
        $this->aRelations['response']  = array(self::RELATION_TYPE_BELONGS_TO, 'ModuleTalk_EntityResponse', 'target_id');
        
    }   
    
}
