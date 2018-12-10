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
            'title' => 'user.profile.nav.profile',
            'url' => $oUser->getProfileUrl()
        ]));
    }
}