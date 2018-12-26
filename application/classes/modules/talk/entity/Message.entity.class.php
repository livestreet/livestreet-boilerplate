<?php


/**
 * Description of EntityVote
 *
 * @author oleg
 */
class ModuleTalk_EntityMessage extends EntityORM{
    
    protected $aValidateRules = array(
        array('text', 'string', 'max' => 200, 'min' => 1, 'allowEmpty' => false)
        
    );
}
