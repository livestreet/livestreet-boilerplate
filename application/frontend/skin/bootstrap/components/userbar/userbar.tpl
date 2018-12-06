{**
 * Юзербар
 *}

{if $oUserCurrent}
    {insert name='block' block='menu' params=[ 'name' => "user", "activeItem" => $sMenuUserItemSelect ]}

{else}
    {$items = [
        [   
            'text' => $aLang.auth.login.title,        
            attributes => [ "data-toggle"=>"modal-tab", "data-target"=>"#nav-tab-authlogin"], 
            'url' => "{router page='auth/login'}"
        ],
        [ 
            'text' => $aLang.auth.registration.title, 
            attributes => [ "data-toggle"=>"modal-tab", "data-target"=>"#nav-tab-authregister"], 
            'url' => "{router page='auth/register'}" 
        ]
    ]}
    {component "bs-nav" 
        attributes = [ "data-toggle"=>"modal", "data-target"=>"#modalAuth"]
        bmods="fill" 
        classes="navbar-nav mr-auto" 
        hook="userbar" 
        activeItem=$sMenuHeadItemSelect 
        items = $items}
{/if}
    
   
