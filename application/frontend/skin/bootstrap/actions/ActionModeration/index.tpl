{**
 * Все
 *}
{extends './profile.tpl'}

{block name="profile_content"}
    
    {capture name="paging"}
        {component 'bs-pagination' 
            classes = "mt-3"
            total   = $aPaging['iCountPage'] 
            padding = 2
            showPager=true
            current= $aPaging['iCurrentPage']  
            url="{$aPaging['sBaseUrl']}/page__page__" }
    {/capture}
    
    {if !$results}
        {component 'blankslate' text=$aLang.user.profile.notices.all_blankslate}
    {/if}
    
    {if $oUserCurrent and $oUserCurrent->getId() == $oUserProfile->getId()}
        {$answered = true}
    {/if}

    
    {foreach $results as $item}
        {component "{$item->getType()}" 
            redirect    = {Router::GetPathWebCurrent()}  
            entity      = $item 
            answered    = $answered 
            arbitrage   = $answered}
    {/foreach}
    
    {$smarty.capture.paging}

{/block}
