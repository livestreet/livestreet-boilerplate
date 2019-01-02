<?php


/**
 * Description of EntityVote
 *
 * @author oleg
 */
class ModuleTalk_EntityResponse extends ModuleTalk_EntityMessage{
    
    
    public function __construct($aParam = false)
    {
        parent::__construct($aParam);
        
        $this->aValidateRules[] = array(
            'target_type', 
            'string',
            'on' => ['create']
        );
        $this->aValidateRules[] = array(
            'target_id', 
            'exist_user',
            'on' => ['create']
        );
        $this->aValidateRules[] = array(
            'rating', 
            'number', 
            'allowEmpty' => false,
            'msg' => $this->Lang_Get('talk.response.form.stars.error_validate'),
            'on' => ['create', '']
        );
        
        $this->aRelations['answers'] = array(self::RELATION_TYPE_HAS_MANY, 'ModuleTalk_EntityAnswer', 'target_id');
        
        $this->setType('response');
    }
    
    
    public function afterSave() {
        parent::afterSave();
        
        $this->Rating_Vote($this->getUserId(), $this->getTargetType(), $this->getTargetId(), $this->getRating());
    }
}
