<?php


/**
 * Description of EntityVote
 *
 * @author oleg
 */
class ModuleTalk_EntityProposal extends EntityORM{
    
    public function __construct($aParam = false)
    {
        parent::__construct($aParam);
        
        $this->aValidateRules[] = array(
            'target_type', 
            'string',
            'on' => ['']

        );
        $this->aValidateRules[] = array(
            'target_id', 
            'exist_user',
            'on' => ['']
        );
        
    }
    
}
