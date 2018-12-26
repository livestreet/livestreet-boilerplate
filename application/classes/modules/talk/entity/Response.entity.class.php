<?php


/**
 * Description of EntityVote
 *
 * @author oleg
 */
class ModuleTalk_EntityResponse extends EntityORM{
    
    protected $aValidateRules = array(
        array(
            'text', 
            'string', 
            'max' => 200, 
            'min' => 10, 
            'allowEmpty' => false,
            'msg' => 'talk.response.form.text.error_validate'
        ),
        array(
            'rating', 
            'boolean', 
            'allowEmpty' => false,
            'msg' => 'talk.response.form.stars.error_validate'
        )
        
    );
}
