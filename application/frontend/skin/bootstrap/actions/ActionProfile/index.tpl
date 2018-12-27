{**
 * Все
 *}
{extends './profile.tpl'}

{block name="profile_content"}
    
    {foreach $results as $item}
        {component "{$item->getType()}" text=$item->getText()}
    {/foreach}

{/block}
