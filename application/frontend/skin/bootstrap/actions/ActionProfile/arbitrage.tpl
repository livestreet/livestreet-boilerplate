{**
 * Отзывы
 *}
{extends 'layouts/layout.base.tpl'}

{block 'layout_content'}
    {capture name="paging"}
        {component 'bs-pagination' 
            total   = $aPaging['iCountPage'] 
            padding = 2
            showPager=true
            classes = "mt-3"
            current= $aPaging['iCurrentPage']  
            url="{$aPaging['sBaseUrl']}/page__page__" }
    {/capture}
 
    {if !$results}
        {component 'blankslate' text=$aLang.user.profile.notices.arbitrage_blankslate}
    {/if}

    {foreach $results as $response}
        {component "response.arbitrage" 
            entity      = $response 
            deleted     = true 
            redirect    = {Router::GetPathWebCurrent()} }
    {/foreach}
    
    {$smarty.capture.paging}

{/block}
