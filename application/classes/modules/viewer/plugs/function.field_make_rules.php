<?php
/*
 * LiveStreet CMS
 * Copyright © 2013 OOO "ЛС-СОФТ"
 *
 * ------------------------------------------------------
 *
 * Official site: www.livestreetcms.com
 * Contact e-mail: office@livestreetcms.com
 *
 * GNU General Public License, version 2:
 * http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
 *
 * ------------------------------------------------------
 *
 * @link http://www.livestreetcms.com
 * @copyright 2013 OOO "ЛС-СОФТ"
 * @author Maxim Mzhelskiy <rus.engine@gmail.com>
 *
 */

/**
 * Конвертирует PHP правила валидации в JS
 *
 * @param array $params
 * @param Smarty $smarty
 * @return string
 */
function smarty_function_field_make_rules($params, &$smarty)
{
    $aParamsReq = array('entity', 'field');
    foreach ($aParamsReq as $sParam) {
        if (!array_key_exists($sParam, $params)) {
            trigger_error("json: missing '{$sParam}' parameter", E_USER_WARNING);
            return;
        }
    }
    $aResult = array();
    $sScenario = isset($params['scenario']) ? $params['scenario'] : '';
    $sField = $params['field'];
    $oEntity = $params['entity'];
    if(!$oEntity){
        return;
    }
    if (!($oEntity instanceof Entity)) {
        $oEntity = Engine::GetEntity($oEntity);
    }

    $aEntityRules = $oEntity->_getValidateRules();
    foreach ($aEntityRules as $aEntityRule) {
        $oValidator = $oEntity->Validate_CreateValidator($aEntityRule[1], $oEntity, $aEntityRule[0],
            array_slice($aEntityRule, 2));
        if (in_array($sField, $oValidator->fields) and (!$sScenario or isset($oValidator->on[$sScenario]))) {
            $sType = $oValidator->getTypeValidator();
            /**
             * Конвертация строкового валидатора
             */
            if ($sType == 'string') {
                if (!is_null($oValidator->max)) {
                    $aResult['maxlength'] = $oValidator->max;
                }
                if (!is_null($oValidator->min)) {
                    $aResult['minlength'] = $oValidator->min;
                } 
            }
            /**
             * Конвертация числового валидатора
             */
            if ($sType == 'number') {
                $aResult['type'] = 'number';
                
                if (!is_null($oValidator->max)) {
                    $aResult['max'] = $oValidator->max;
                }
                if (!is_null($oValidator->min)) {
                    $aResult['min'] = $oValidator->min;
                }
            }
            
            if ($sType == 'url') {
                $aResult['type'] = 'url';
                
            }
            
            if ( !$oValidator->allowEmpty) {
                $aResult['required'] = true;
            }
            
            if ($sType != 'inline' ) {
                
                if($oValidator->msg){
                    $smarty->assign('msg', $oValidator->Lang_Get($oValidator->msg));
                }else{
                    $oValidator->allowEmpty = false;
                    $msg = $oValidator->validate('');
                    $msg = str_replace("%%field%%", $oValidator->label, $msg);
                    $smarty->assign('msg', $msg);

                }
                
                if(in_array($sType, ['email', 'password', 'number', 'url'])){
                    $smarty->assign('typeRule', $sType);
                }
                
            }            
            
        }
    }

    if (!empty($params['assign'])) {
        $smarty->assign($params['assign'], $aResult);
    } else {
        $sResult = '';
        foreach ($aResult as $key => $value) {
            $sResult .= $key;
            if(is_bool($value)){
                $sResult .= ' ';
                continue;
            }
            $sResult .= '="'.$value.'" ';
        }
        return $sResult;
    }
}