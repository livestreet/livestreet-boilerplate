<?php

/**
 * Регистрация основных хуков
 *
 * @package hooks
 * @since 1.0
 */
class HookRewriteProfile extends Hook {
    /**
     * Регистрируем хуки
     */
    public function RegisterHook() {
        $this->AddHook('engine_init_complete', 'Menu');
    }

    public function Menu($aParams) { 
        $aPages = Config::Get('router.page');
//        print_r($aPages);
//        foreach ($aPages as $sPage) {
//            
//        }
        Config::Set('router.uri', ['/^((?!admin(\/.+?)?$|auth(\/.+?)?$|error(\/.+?)?$|index(\/.+?)?$|ajax(\/.+?)?$).+)*$/i' => 'profile/\\1']);
    }
}