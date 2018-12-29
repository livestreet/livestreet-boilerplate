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
        {component 'blankslate' text=$aLang.user.profile.notices.response_blankslate}
    {/if}

    {foreach $results as $response}
        {component "response" 
            entity      = $response 
            targetUser  = true 
            deleted     = true 
            redirect    = {Router::GetPathWebCurrent()} }
    {/foreach}
    
    {$smarty.capture.paging}

{/block}
