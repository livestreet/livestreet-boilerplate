{**
 * Тулбар
 * Кнопка перехода в админку
 *}

{if $oUserCurrent && $oUserCurrent->isAdministrator()}
    {component 'toolbar.item'
        icon='cog'
        url={router 'admin'}
        attributes=[ 'title' => {lang 'admin.title'} ]
        mods='admin'}
{/if}