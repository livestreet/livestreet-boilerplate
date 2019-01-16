{**
 * Тестовая страница
 *}
{extends 'layouts/layout.base.tpl'}

{block 'layout_content'}
    <u>{$oUserProfile->getLogin()}</u><br>
    <h2>{$oUserProfile->getName()}</h2>
    
    
    <div class="row my-3 text-muted">
        <div class="col-md-4">{$oUserProfile->getSite()}</div>
        <div class="col-md-4">{$oUserProfile->getPhone()}</div>
        <div class="col-md-4">{$oUserProfile->getAddress()}</div>
    </div>
        
    {component 'bs-text' text=$oUserProfile->getAbout()}
    
    {component "rating" classes="mt-4" oUser=$oUserProfile}
    
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