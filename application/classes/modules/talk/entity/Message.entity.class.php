<?php


/**
 * Description of EntityVote
 *
 * @author oleg
 */
class ModuleTalk_EntityMessage extends EntityORM{
    
    protected $aValidateRules = [];
    
    protected $sType = null;


    public function __construct($aParam = false)
    {
        parent::__construct($aParam);
        
        $this->aValidateRules =  array(
            array(
                'user_id', 
                'exist_user'
            ),
            array(
                'text', 
                'string', 
                'max' => 200, 
                'min' => 10, 
                'allowEmpty' => false,
                'msg' => $this->Lang_Get('talk.'.$this->getType().'.form.text.error_validate', ['min' => 10, 'max' => 200])
            ),
            array(
                'text', 
                'double_text'
            )
        );
        
        if($this->getType() == 'proposal'){
            $this->aValidateRules[] = array(
                'target_type', 
                'string'
            );
            $this->aValidateRules[] = array(
                'target_id', 
                'exist_user'
            );
        }
        
        if($this->getType() == 'answer' or $this->getType() == 'arbitrage'){
            $this->aValidateRules[] = array(
                'target_id,target_type', 
                'exist_message'
            );
        }
        
        if($this->getType() == 'response'){
            $this->aValidateRules[] = array(
                'target_type', 
                'string'
            );
            $this->aValidateRules[] = array(
                'target_id', 
                'exist_user'
            );
            $this->aValidateRules[] = array(
                'rating', 
                'number', 
                'allowEmpty' => false,
                'msg' => $this->Lang_Get('talk.response.form.stars.error_validate')
            );
        }
    }
    
    protected $aRelations = array(
        'user' => array(self::RELATION_TYPE_BELONGS_TO, 'ModuleUser_EntityUser', 'user_id'),
        'answers' => array(self::RELATION_TYPE_HAS_MANY, 'ModuleTalk_EntityMessage', 'target_id'),
        'target_user' => array(self::RELATION_TYPE_BELONGS_TO, 'ModuleUser_EntityUser', 'target_id'),
        'response'  => array(self::RELATION_TYPE_BELONGS_TO, 'ModuleTalk_EntityMessage', 'target_id', ['type' => 'response']),
    );
    
    public function ValidateDoubleText($sValue) {
        $sParseText = $this->Text_Parser($sValue);
        
        if($this->Talk_GetMessageByFilter([
            'type'  => $this->getType(),
            'text'  => $sParseText,
            'target_id' => $this->getTargetId(),
            'user_id' => $this->getUserId()
        ])){
            return $this->Lang_Get('talk.'.$this->getType().'.notice.error_double_text');
        }
        $this->setText( $sParseText );
        
        return true;
    }
    
    public function ValidateExistUser($sValue) {
        if(!$this->User_GetUserById($sValue)){
            return $this->Lang_Get('common.error.error');
        }
        return true;
    }
    
    
    public function ValidateExistMessage($sValue) {
        if(!$this->Talk_GetMessageByFilter([
            'id'  => $this->getTargetId(),
            'type'  => $this->getTargetType()
        ])){
            return $this->Lang_Get('common.error.error');
        }
        return true;
    }
    
    public function getDateCreateFormat() {
        $date = new DateTime($this->getDateCreate());
        return $date->format('d F');
    }
    
    public function getMedia() {
        if(is_array(parent::getMedia()) and count(parent::getMedia())){
            return parent::getMedia();
        }
        
        return $this->Media_GetMediaByTarget($this->getType(), $this->getId());
    }
    
    public function afterDelete() {
        /*
         * Удалить потомков
         */
        $aChildrens = $this->Talk_GetMessageItemsByFilter([
            'target_type' => $this->getType(),
            'target_id'     => $this->getId()
        ]);
        
        foreach ($aChildrens as $oChildren) {
            $oChildren->Delete();
        }
        
        /*
         * Удалить медиа
         */        
        $this->Media_RemoveTargetByTypeAndId($this->getType(), $this->getId());
    }
    
    public function afterSave() {
        parent::afterSave();
        
        if($this->getType() == 'arbitrage' and ($oResponse = $this->getResponse())){
            $oResponse->setState('arbitrage');
            $oResponse->Save();
        }
        
        if($this->getType() == 'response' and $this->getState() == 'publish'){
            $this->Rating_Vote($this->getUserId(), $this->getTargetType(), $this->getTargetId(), $this->getRating());
        }
    }
}
