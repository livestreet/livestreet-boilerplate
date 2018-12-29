{**
 * Предложения
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
        {component 'blankslate' text=$aLang.user.profile.notices.proposal_blankslate}
    {/if}
    
    {if $oUserCurrent and $oUserCurrent->getId() == $oUserProfile->getId()}
        {$answered = true}
    {/if}

    {foreach $results as $proposal}
        {component "proposal" 
            entity      = $proposal 
            redirect    = {Router::GetPathWebCurrent()} 
            targetUser  = true 
            deleted     = true }
    {/foreach}
    
    {$smarty.capture.paging}

{/block}
