<?php

/**
 * Регистрация основных хуков
 *
 * @package hooks
 * @since 1.0
 */
class HookMenuModeration extends Hook {
    /**
     * Регистрируем хуки
     */
    
    public function RegisterHook() {
        $this->AddHook('menu_before_prepare', 'Menu');
    }

    public function Menu($aParams) { 
        
        if($aParams['menu']->getName() != 'moderation'){
            return false;
        }
        
        $oMenu = $aParams['menu'];
        
        $oMenu->prependChild(Engine::GetEntity("ModuleMenu_EntityItem", [
            'name' => 'moderation',
            'title' => 'user.userbar.nav.moderation',
            'count' => $this->Talk_GetCountFromResponseByFilter(['state' => 'moderate']),
            'url'   => 'moderation/responses'
        ]))->appendChild(Engine::GetEntity("ModuleMenu_EntityItem", [
            'name' => 'arbitrage',
            'title' => 'moderation.menu.arbitrage',
            'count' => $this->Talk_GetCountFromResponseByFilter([ 'state in' => ['arbitrage', 'chat']]),
            'url'   => 'moderation/arbitrage'
        ]));
        
    }
    
}