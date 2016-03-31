{**
 * Юзербар
 *}

<div class="ls-userbar">
    <div class="ls-userbar-inner ls-clearfix" style="min-width: {Config::Get('view.grid.fluid_min_width')}; max-width: {Config::Get('view.grid.fluid_max_width')};">
        {if ! Config::Get( 'view.layout_show_banner' )}
            <h1 class="ls-userbar-logo">
                <a href="{router page='/'}">{Config::Get('view.name')}</a>
            </h1>
        {/if}

        <nav class="ls-userbar-nav">
            {if $oUserCurrent}
                {$items = [
                    [
                        'text'       => "{$oUserCurrent->getDisplayName()}",
                        'url'        => "{$oUserCurrent->getUrl()}",
                        'classes'    => 'nav-item--userbar-username',
                        'menu'       => [
                            [ 'name' => 'profile',      'text' => 'Профиль',         'url' => "{$oUserCurrent->getUrl()}" ],
                            [ 'name' => 'profile.other',       'text' => 'Другое',         'url' => "{$oUserCurrent->getUrl()}", 'count' => 33 ],
                            [ 'name' => 'admin',      'text' => {lang name='admin.title'},                   'url' => "{router page='admin'}", 'is_enabled' => $oUserCurrent->isAdmin() ]
                        ]
                    ],
                    [ 'text' => $aLang.auth.logout,  'url' => "{router page='auth/logout'}?security_ls_key={$LIVESTREET_SECURITY_KEY}" ]
                ]}
            {else}
                {$items = [
                    [ 'text' => $aLang.auth.login.title,        'classes' => 'js-modal-toggle-login',        'url' => {router page='auth/login'} ],
                    [ 'text' => $aLang.auth.registration.title, 'classes' => 'js-modal-toggle-registration', 'url' => {router page='auth/register'} ]
                ]}
            {/if}

            {component 'nav' name='userbar' activeItem=$sMenuHeadItemSelect mods='userbar' items=$items}
        </nav>
    </div>
</div>