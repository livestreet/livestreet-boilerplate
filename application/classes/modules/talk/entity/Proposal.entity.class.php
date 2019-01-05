<?php


/**
 * Description of EntityVote
 *
 * @author oleg
 */
class ModuleTalk_EntityProposal extends ModuleTalk_EntityMessage{
    
    public function __construct($aParam = false)
    {
        $this->setType('proposal');
        
        parent::__construct($aParam);
        
        $this->aValidateRules[] = array(
            'target_type', 
            'string',
            'on' => ['create','']

        );
        $this->aValidateRules[] = array(
            'target_id', 
            'exist_user',
            'on' => ['']
        );
        
        
    }
    
}
