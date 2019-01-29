{**
 * Отзывы
 *}
{extends 'layouts/layout.base.tpl'}


{block 'layout_page_title'}
    <h2 class="page-header">{$aLang.moderation.profiles.title}</h2>
{/block}
                    
{block 'layout_content'}
    
    {component "bs-button" 
        bmods   = "primary"
        text    = $aLang.moderation.profiles.actions.add
        url     = {router page="moderation/profile-edit"}
    }

    
    {foreach $aProfiles as $oProfile}
        {component "moderation.profile-item" 
            oProfile      = $oProfile}
    {/foreach}
    
    {component 'bs-pagination' 
        total   = $aPaging['iCountPage'] 
        padding = 2
        showPager=true
        classes = "mt-3"
        current= $aPaging['iCurrentPage']  
        url="{$aPaging['sBaseUrl']}/page__page__" }
{/block}