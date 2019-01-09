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
    
    public function afterSave() {
        
        
        if($this->_getOriginalDataOne('state') != 'publish' and $this->getState('publish')){
            $this->Notify_Send(
                $this->getUser(),
                'proposal_new.tpl',
                $this->Lang_Get('emails.proposal_new.subject'),
                ['oProposal' => $this], null, true
            );
        }
        
        parent::afterSave();
    }
    
    public function afterDelete() {
        $this->Notify_Send(
            $this->getUser(),
            'proposal_deleted.tpl',
            $this->Lang_Get('emails.proposal_deleted.subject'),
            ['oProposal' => $this], null, true
        );
    }
    
}
