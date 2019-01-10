{**
 * Главная
 *}
{extends 'layouts/layout.base.tpl'}

{block 'layout_page_title' }
    {$aLang.search.people.title}
{/block}

{block 'layout_content'}
    {foreach $aUsers as $oUser}
        {component "user.item" oUser=$oUser}
    {/foreach}

    {component 'bs-pagination' 
            total   = $aPaging['iCountPage'] 
            padding = 2
            showPager=true
            classes = "mt-3"
            current= $aPaging['iCurrentPage']  
            url="{$aPaging['sBaseUrl']}/page__page__" }
{/block}