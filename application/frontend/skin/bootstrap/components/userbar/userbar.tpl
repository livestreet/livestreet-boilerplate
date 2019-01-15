{**
 * Юзербар
 *}
 
{component "bs-form.text" 
    attributes  = ['data-ajax-search' => true, 'data-url' => {router page="ajax/search-users"}, 'style' => 'max-width:250px;']
    placeholder = $aLang.search.text
    classesGroup= "mb-0 w-25"}


{if $oUserCurrent}
    {insert name='block' block='menu' params=[ 'name' => "user", "activeItem" => $sMenuUserItemSelect ]}

{else}
    {if !in_array(Router::GetActionEvent(), ["login", "register"])}

        {$items = [
            [   
                icon       => [ icon => "sign-in-alt", display => "s", classes => "d-md-none d-inline"],
                'text'      => "<span class='d-none d-md-block'>{$aLang.auth.login.title}</span>",        
                attributes  => [ "data-toggle"=>"modal-tab", "data-target"=>"#nav-tab-authlogin"], 
                'url'       => "{router page='auth/login'}"
            ],
            [ 
                icon        => [ icon => "user-plus", display => "s", classes => "d-md-none d-inline"],
                'text'      => "<span class='d-none d-md-block'>{$aLang.auth.registration.title}</span>", 
                attributes  => [ "data-toggle"=>"modal-tab", "data-target"=>"#nav-tab-authregister"], 
                'url'       => "{router page='auth/register'}" 
            ]
        ]}
        
        {component "bs-nav" 
            attributes = [ "data-toggle"=>"modal", "data-target"=>"#modalAuth"]
            bmods="fill" 
            classes="justufy-content-center" 
            hook="userbar" 
            activeItem=$sMenuHeadItemSelect 
            items = $items}
    {/if}
{/if}
    
   
