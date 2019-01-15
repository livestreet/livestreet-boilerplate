<?php


/**
 * Description of EntityVote
 *
 * @author oleg
 */
class ModuleTalk_EntityResponse extends ModuleTalk_EntityMessage{
    
    
    public function __construct($aParam = false)
    {
        
        
        $this->aRelations['answers'] = array(
            self::RELATION_TYPE_HAS_MANY, 
            'ModuleTalk_EntityAnswer', 
            'target_id', 
            ['target_type' => 'response']
        );
        $this->aRelations['arbitrage'] = array(
            self::RELATION_TYPE_HAS_ONE, 
            'ModuleTalk_EntityArbitrage', 
            'target_id',
            ['#order' => ['date_create' => 'asc']]
        );
        
        $this->aRelations['arbitrages'] = array(
            self::RELATION_TYPE_HAS_MANY, 
            'ModuleTalk_EntityArbitrage', 
            'target_id',
            ['#order' => ['date_create' => 'asc']]
        );
        
        $this->setType('response');
        
        parent::__construct($aParam);
        
        $this->aValidateRules[] = array(
            'target_type', 
            'string',
            'on' => ['create', 'create_anoname', '']
        );
        $this->aValidateRules[] = array(
            'target_id', 
            'exist_user',
            'on' => ['create', 'create_anoname', '']
        );
        $this->aValidateRules[] = array(
            'rating', 
            'number', 
            'allowEmpty' => false,
            'msg' => $this->Lang_Get('talk.response.form.stars.error_validate'),
            'on' => ['create', '', 'create_anoname']
        );        
        
        
    }
    
     public function afterDelete() {
         
        parent::afterDelete();
        
        /*
         * Удалить оценку
         */
        $this->deleteVote();
    }
    
    public function deleteVote() {
        $this->Rating_DeleteVoteItemsByFilter( ['from_id' => $this->getId()]);
    }
    
}
