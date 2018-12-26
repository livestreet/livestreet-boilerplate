<?php

function smarty_function_count_modifer($params, &$smarty)
{
    $sCount = $params['count'];
    
    if($sCount > 1000){
        $sCount = round($sCount/1000, 1) . "K";
    }
    
    if($sCount > 1000000){
        $sCount = round($sCount/1000000,1) . "M";
    }    
    
    if (!empty($params['assign'])) {
        $smarty->assign($params['assign'], $sCount);
    }
    return $sCount;
}