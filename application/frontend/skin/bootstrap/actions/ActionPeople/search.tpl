{**
 * Главная
 *}
{extends 'layouts/layout.base.tpl'}

{block 'layout_page_title' }
    {$aLang.search.people.title}
{/block}

{block 'layout_content'}
    <div class="mt-5">
        {foreach $aUsers as $oUser}
            {component "user.item" oUser=$oUser}
        {/foreach}
        
        {if !$aUsers}
            {component "blankslate" text=$aLang.search.people.blankslate.text}
        {/if}

    </div>
    {component 'bs-pagination' 
            total   = $aPaging['iCountPage'] 
            padding = 2
            showPager=true
            classes = "mt-3"
            current= $aPaging['iCurrentPage']  
            url="{$aPaging['sBaseUrl']}/page__page__" }
{/block}