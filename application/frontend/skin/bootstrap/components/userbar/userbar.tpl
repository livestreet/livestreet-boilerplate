{**
 * Юзербар
 *}

    {if $oUserCurrent}
        {$createMenu = []}

        {foreach $LS->Topic_GetTopicTypes() as $type}
            {$createMenu[] = [ 'name' => $type->getCode(), 'text' => $type->getName(), 'url' => $type->getUrlForAdd() ]}
        {/foreach}

        {$createMenu[] = [ 'name' => 'blog', 'text' => {lang 'modal_create.items.blog'}, 'url' => {router page='blog/add'} ]}
        {$createMenu[] = [ 'name' => 'talk', 'text' => {lang 'modal_create.items.talk'}, 'url' => {router page='talk/add'} ]}
        {$createMenu[] = [ 'name' => 'drafts', 'text' => {lang 'topic.drafts'}, 'url' => "{router page='content/drafts'}", count => $iUserCurrentCountTopicDraft ]}

        
        {component 'bs-nav' 
            bmods="fill"
            classes=""
            items = [
                [ name => 'items',  classes => "",
                    menu => [
                        name => 'user',  
                        text => "<img alt='avatar' class='rounded' src='{$oUserCurrent->getProfileAvatarPath(24)}'/> {$oUserCurrent->getDisplayName()}", 
                        url => $oUserCurrent->getUserWebPath(),
                        offset => "0,10",
                        items => [
                            [ 'name' => 'whois',      'text' => {lang name='user.profile.nav.info'},         'url' => "{$oUserCurrent->getUserWebPath()}" ],
                            [ 'name' => 'wall',       'text' => {lang name='user.profile.nav.wall'},         'url' => "{$oUserCurrent->getUserWebPath()}wall/", 'badge' => $iUserCurrentCountWall ],
                            [ 'name' => 'created',    'text' => {lang name='user.profile.nav.publications'}, 'url' => "{$oUserCurrent->getUserWebPath()}created/topics/", 'badge' => $iUserCurrentCountCreated ],
                            [ 'name' => 'favourites', 'text' => {lang name='user.profile.nav.favourite'},    'url' => "{$oUserCurrent->getUserWebPath()}favourites/topics/", 'badge' => $iUserCurrentCountFavourite ],
                            [ 'name' => 'friends',    'text' => {lang name='user.profile.nav.friends'},      'url' => "{$oUserCurrent->getUserWebPath()}friends/", 'badge' => $iUserCurrentCountFriends ],
                            [ 'name' => 'activity',   'text' => {lang name='user.profile.nav.activity'},     'url' => "{$oUserCurrent->getUserWebPath()}stream/" ],
                            [ 'name' => 'talk',       'text' => {lang name='user.profile.nav.messages'},     'url' => "{router page='talk'}", 'badge' => $iUserCurrentCountTalkNew ],
                            [ 'name' => 'settings',   'text' => {lang name='user.profile.nav.settings'},     'url' => "{router page='settings'}" ],
                            [ 'name' => 'admin',      'text' => {lang name='admin.title'},                   'url' => "{router page='admin'}", 'is_enabled' => $oUserCurrent && $oUserCurrent->isAdministrator() ]
                        ]
                    ] 
                ],
                [ name => 'create', 
                    menu => [
                        offset => "-40,10",
                        text => "<div class='d-none d-sm-inline'>{$aLang.common.create}</div><span class='glyphicon glyphicon-plus d-inline d-sm-none'>+</span>",
                        items=>$createMenu
                    ]
                ],
                [ 'text' => $aLang.auth.logout,  'url' => "{router page='auth'}logout/?security_ls_key={$LIVESTREET_SECURITY_KEY}" ]
            ]
        }
        
    {else}
        {$items = [
            [ 'text' => $aLang.auth.login.title,        attributes => ["data-toggle"=>"modal", "data-target"=>"#modalLogin"],       'url' => {router page='auth/login'} ],
            [ 'text' => $aLang.auth.registration.title, 'classes' => 'js-modal-toggle-registration', 'url' => {router page='auth/register'} ]
        ]}
        {component "bs-nav" bmods="fill" classes="navbar-nav mr-auto" hook="userbar" activeItem=$sMenuHeadItemSelect items = $items}
    {/if}
        
    
   
