<?php


/**
 * Description of EntityVote
 *
 * @author oleg
 */
class ModuleTalk_EntityResponse extends EntityORM{
    
    protected $aValidateRules = [];
    
    public function __construct() {
        $this->aValidateRules =  array(
            array(
                'user_id', 
                'exist_user'
            ),
            array(
                'target_id', 
                'exist_user'
            ),
            array(
                'text', 
                'string', 
                'max' => 200, 
                'min' => 10, 
                'allowEmpty' => false,
                'msg' => $this->Lang_Get('talk.response.form.text.error_validate', ['min' => 10, 'max' => 200])
            ),
            array(
                'text', 
                'double_text'
            ),
            array(
                'rating', 
                'number', 
                'allowEmpty' => false,
                'msg' => $this->Lang_Get('talk.response.form.stars.error_validate')
            )

        );
    }
    
    public function ValidateDoubleText($sValue) {
        $sParseText = $this->Text_Parser($sValue);
        
        if($this->Talk_GetResponseByFilter([
            'text' => $sParseText,
            'target_id' => $this->getTargetId(),
            'user_id' => $this->getUserId()
        ])){
            return $this->Lang_Get('talk.response.notice.error_double_text');
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
    
    
    public function getType() {
        return 'response';
    }
}
