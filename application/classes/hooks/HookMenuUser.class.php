<?php

/**
 * Регистрация основных хуков
 *
 * @package hooks
 * @since 1.0
 */
class HookMenuUser extends Hook {
    /**
     * Регистрируем хуки
     */
    public function RegisterHook() {
        $this->AddHook('engine_init_complete', 'Menu');
    }

    public function Menu($aParams) { 
        if(!$this->User_IsAuthorization()){
            return false;
        }
        
        if(!$oUser = $this->User_GetUserCurrent()){
            return false;
        }
        
        $oMenu = $this->Menu_Get('user');
        
        $oMenu->prependChild(Engine::GetEntity("ModuleMenu_EntityItem", [
            'name' => 'profile',
            'title' => 'user.userbar.nav.profile',
            'url' => $oUser->getLogin()
        ]))->appendChild(Engine::GetEntity("ModuleMenu_EntityItem", [
            'name' => 'settings',
            'title' => 'user.userbar.nav.settings',
            'url' => $oUser->getLogin().'/settings'
        ]));
        
        if($oUser->isAdministrator() or $this->Rbac_IsAllow('moderation')){
        
            $oMenu->appendChild(Engine::GetEntity("ModuleMenu_EntityItem", [
                'name' => 'moderation',
                'title' => 'user.userbar.nav.moderation',
                'url' => 'moderation'
            ]));
        }
    }
    
}