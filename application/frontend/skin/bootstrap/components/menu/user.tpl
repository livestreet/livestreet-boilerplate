{**
 * Меню пользователя
 *
 * 
 *}
 
{$params.name = 'user'}  
{$params.url = $oUserCurrent->getUserWebPath()}
{$params.offset = "0,10"}

{if $oUserCurrent->getIsAdmin()}
    {$params.items[] = [ text => $aLang.admin.title, url => {router page="admin"}]}  
{/if}


{component 'bs-nav' 
    bmods="fill"
    classes=""
    items = [
        [ 
            name => 'items',  
            classes => "", 
            text => "<img class='rounded-circle mr-1' src='{$oUserCurrent->getProfileAvatar()}' style='width:25px;' alt='{$oUserCurrent->getLogin()}'>{$oUserCurrent->getLogin()}",
            menu => $params 
        ],
        
        [ 'text' => $aLang.auth.logout,  'url' => "{router page='auth'}logout/?security_ls_key={$LIVESTREET_SECURITY_KEY}" ]
    ]
}


        