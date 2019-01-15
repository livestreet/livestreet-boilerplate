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
            'on' => ['create','', 'create_anoname']

        );
        $this->aValidateRules[] = array(
            'target_id', 
            'exist_user',
            'on' => ['create','', 'create_anoname']
        );
        
        
    }
    
    
    public function afterDelete() {
        parent::afterDelete();
        
        $this->Notify_Send(
            $this->getUser(),
            'proposal_deleted.tpl',
            $this->Lang_Get('emails.proposal_deleted.subject'),
            ['oProposal' => $this], null, true
        );
    }
    
}
