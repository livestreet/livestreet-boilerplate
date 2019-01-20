{**
 * Тестовая страница
 *}
{extends 'layouts/layout.base.tpl'}

{block 'layout_content'}
    <u>{$oUserProfile->getLogin()}</u><br>
    <h2>{$oUserProfile->getName()}</h2>
    
    {if $oUserProfile->isRole('company')}
        {if $oUserProfile->getSite() or $oUserProfile->getPhone() or $oUserProfile->getAddress()}
            <div class="ml-1 my-3 text-muted">
                {if $oUserProfile->getSite()}
                    <span class="mr-3">{component "bs-icon" icon="link" display="s"} {$oUserProfile->getSite()}</span>
                {/if}
                {if $oUserProfile->getPhone()}
                    <span class="mr-3">{component "bs-icon" icon="phone" display="s"} {$oUserProfile->getPhone()}</span>
                {/if}
                {if $oUserProfile->getAddress()}
                    <span class="mr-3">{component "bs-icon" icon="map-marker-alt" display="s"} {$oUserProfile->getAddress()}</span>
                {/if}

            </div>
        {/if}
    {/if}   
    
    {if $oUserProfile->getAbout()}
        {component 'bs-text' text=$oUserProfile->getAbout()}
    {/if}

    {component "rating" classes="mt-3" oUser=$oUserProfile}
    
    <div class="row mt-3">
        <div class="col-12">
            <b class="ml-3">{$iCountResponses}</b> {pluralize {lang "user.profile.counts.responses"} count=$iCountResponses}
            <b class="ml-3">{$iCountAnswers}</b> {pluralize {lang "user.profile.counts.answers"} count={$iCountAnswers}}
            <b class="ml-3">{$iCountProposals}</b> {pluralize {lang "user.profile.counts.proposals"} count=$iCountProposals}
        </div>
    </div>
    
    {component "bs-nav" activeItem=$sMenuHeadItemSelect classes = "border-top mt-2" items = [
        [
            name        => "index",
            url         => {router page="{$oUserProfile->getLogin()}"}, 
            text        => $aLang.user.profile.nav.all, 
            classes     => "border-top"
        ],
        [
            name        => "responses",
            url         => {router page="{$oUserProfile->getLogin()}/responses"}, 
            text        => $aLang.user.profile.nav.responses_votes, 
            classes     => "border-top"
        ],
        [
            name        => "proposals",
            url         => {router page="{$oUserProfile->getLogin()}/proposals"}, 
            text        => $aLang.user.profile.nav.proposals, 
            classes     => "border-top"
        ]
    ]}
    <div class="mt-5">
        {block name="profile_content"}

        {/block}
    </div>
{/block}

{block "layout_modals" prepend}
    
    {if ($oUserCurrent and $oUserCurrent->getId() != $oUserProfile->getId()) or (!$oUserCurrent and Config::Get('module.user.user_guest'))}
        {component "response.modal" url={router page='ajax/talk/edit-response'}}
        {component "proposal.modal"}
    {/if}
    
    {component "confirm-company.modal"}
        
{/block}