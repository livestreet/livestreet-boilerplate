{**
 * Тестовая страница
 *}
{extends 'layouts/layout.base.tpl'}

{block 'layout_content'}
    <u>{$oUserProfile->getLogin()}</u><br>
    <h2>{$oUserProfile->getName()}</h2>
    <p class="lead">{$oUserProfile->getAbout()}</p>
    
    {component "rating" classes="mt-4" oUser=$oUserProfile}
    
    <div class="row mt-3">
        <div class="col-12">
            <b class="ml-3">23</b> {pluralize {lang "user.profile.counts.responses"} count=23}
            <b class="ml-3">1</b> {pluralize {lang "user.profile.counts.answers"} count=1}
            <b class="ml-3">3</b> {pluralize {lang "user.profile.counts.proposals"} count=3}
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
    
    {block name="profile_content"}

    {/block}

{/block}

{block "layout_modals" prepend}
    {component "response.modal"}
    {component "proposal.modal"}
    
{/block}