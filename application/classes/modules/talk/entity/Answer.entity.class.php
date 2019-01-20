<?php


/**
 * Description of EntityVote
 *
 * @author oleg
 */
class ModuleTalk_EntityAnswer extends ModuleTalk_EntityMessage{
    
   
    public function __construct($aParam = false)
    {
        $this->setType('answer');
        
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
    
   
}
