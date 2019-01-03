<?php

class HookMenuProfile extends Hook {
    
    /**
     * Регистрируем хуки
     */
    public function RegisterHook() {
        $this->AddHook('menu_before_prepare', 'Menu');
    }

    public function Menu($aParams) { 
        
        if($aParams['menu']->getName() != 'profile'){
            return false;
        }
        
        if(!$oUser = $this->User_GetUserByLogin(Router::GetActionEvent())){
            return false;
        }
        
        if(!$oUserCurrent = $this->User_GetUserCurrent()){
            return false;
        }
        
        if($oUserCurrent->getId() != $oUser->getId()){
            return false;
        }
         
        
        $aParams['activeItem'] = Router::GetParam(0)?Router::GetParam(0):'profile';
        
        $aParams['menu']->prependChild(Engine::GetEntity("ModuleMenu_EntityItem", [
            'name' => 'profile',
            'title' => 'user.userbar.nav.profile',
            'url' => $oUser->getLogin()
        ]))->appendChild(Engine::GetEntity("ModuleMenu_EntityItem", [
            'name' => 'responses',
            'title' => 'user.userbar.nav.responses',
            'url' => $oUser->getLogin().'/responses',
            'count' => $this->Talk_GetCountFromResponseByFilter([
                'state in' => ['publish', 'arbitrage'], 
                'target_id' => $oUser->getId()])
        ]))->appendChild(Engine::GetEntity("ModuleMenu_EntityItem", [
            'name' => 'proposals',
            'title' => 'user.userbar.nav.proposals',
            'url' => $oUser->getLogin().'/proposals',
            'count' => $this->Talk_GetCountFromMessageByFilter([
                'type' => 'proposal', 
                'target_id' => $oUser->getId()])
        ]))->appendChild(Engine::GetEntity("ModuleMenu_EntityItem", [
            'name' => 'my-responses',
            'title' => 'user.userbar.nav.responsed',
            'url' => $oUser->getLogin().'/my-responses',
            'count' => $this->Talk_GetCountFromMessageByFilter([
                'type' => 'response', 
                'user_id' => $oUserCurrent->getId()])
        ]))->appendChild(Engine::GetEntity("ModuleMenu_EntityItem", [
            'name' => 'my-proposals',
            'title' => 'user.userbar.nav.proposed',
            'url' => $oUser->getLogin().'/my-proposals',
            'count' => $this->Talk_GetCountFromMessageByFilter([
                'type' => 'proposal', 
                'user_id' => $oUserCurrent->getId()])
        ]))->appendChild(Engine::GetEntity("ModuleMenu_EntityItem", [
            'name' => 'arbitrage',
            'title' => 'user.userbar.nav.arbitrage',
            'url' => $oUser->getLogin().'/arbitrage',
            'count' => $this->Talk_GetCountFromMessageByFilter([
                'state' => 'arbitrage',
                'type' => 'response', 
                'target_id' => $oUser->getId()])
        ]));
        
        
    }
}