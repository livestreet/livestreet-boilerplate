{**
 * Меню пользователя
 *
 * 
 *}
 
{$params.name = 'user'}  
{$params.text = "<img alt='avatar' class='rounded' src='{$oUserCurrent->getProfileAvatarPath(24)}'/> {$oUserCurrent->getDisplayName()}"}
{$params.url = $oUserCurrent->getUserWebPath()}
{$params.offset = "0,10"}

{component 'bs-nav' 
    bmods="fill"
    classes=""
    items = [
        [ 
            name => 'items',  
            classes => "", 
            text => "<img alt='avatar' class='rounded' src='{$oUserCurrent->getProfileAvatarPath(24)}'/> {$oUserCurrent->getDisplayName()}",
            menu => $params 
        ],
        
        [ 'text' => $aLang.auth.logout,  'url' => "{router page='auth'}logout/?security_ls_key={$LIVESTREET_SECURITY_KEY}" ]
    ]
}


        