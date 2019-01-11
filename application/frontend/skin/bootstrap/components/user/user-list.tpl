{**
 * Информация о производительности движка
 *}

{component_define_params params=[ 'items' ]}

<div class="p-2">
{foreach $items as $oUser name="users"}
    {if !$smarty.foreach.users.first}
        {component "user" oUser=$oUser classes="mt-2"}
    {else}
        {component "user" oUser=$oUser}
    {/if}
    
{/foreach}
</div>