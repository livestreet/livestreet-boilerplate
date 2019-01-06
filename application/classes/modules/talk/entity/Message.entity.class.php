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
        
        
        $this->aValidateRules[] =   array(
            'user_id', 
            'exist_user',
            'on' => ['create', '']
        );
        $this->aValidateRules[] = array(
            'user_name', 
            'string',
            'on' => ['create' ]
        );
        $this->aValidateRules[] =    array(
            'text', 
            'string', 
            'max' => 200, 
            'min' => 10, 
            'allowEmpty' => false,
            'msg' => $this->Lang_Get('talk.response.form.text.error_validate', ['min' => 10, 'max' => 200]),
            'on' => ['']
        );
        $this->aValidateRules[] =    array(
            'text', 
            'double_text',
            'on' => ['create']
        );
        
        
        
    }
    
    public function getUser() {
        
        if($this->getUserId() == 0){
            return Engine::GetEntity('User_User', [
                'name' => $this->getUserName(),
                'login' => 'guest',
                'id' => 0
            ]);
        }
        
        return parent::getUser();
    }
    
    protected $aRelations = array(
        'user' => array(self::RELATION_TYPE_BELONGS_TO, 'ModuleUser_EntityUser', 'user_id'),
        'target_user' => array(self::RELATION_TYPE_BELONGS_TO, 'ModuleUser_EntityUser', 'target_id'),
        'answers' => array(self::RELATION_TYPE_HAS_MANY, 'ModuleTalk_EntityAnswer', 'target_id', ['target_type' => 'response'])
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
        if((int)$sValue === 0 ){
            return true;
        }
        if(!$this->User_GetUserById($sValue)){
            return $this->Lang_Get('common.error.error').' user not found';
        }
        return true;
    }
    
    
    public function ValidateExistMessage($sValue) {
        if(!$this->Talk_GetMessageByFilter([
            'id'  => $this->getTargetId(),
            'type'  => $this->getTargetType()
        ])){
            return $this->Lang_Get('common.error.error').' '.$this->getTargetType().' not found';
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
        
        /*
         * Удалить оценку
         */
        $this->deleteVote();
    }
    
    public function deleteVote() {
        $this->Rating_DeleteVoteItemsByFilter(['target_type' => 'user', 'target_id' => $this->getTargetId()]);
    }
    
}
