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
    
    {component "bs-nav" classes = "border-top mt-2" items = [
        [
            active      => true,
            url         => '', 
            text        => $aLang.user.profile.nav.all, 
            classes     => "border-top"
        ],
        [
            url         => '', 
            text        => $aLang.user.profile.nav.responses_votes, 
            classes     => "border-top"
        ],
        [
            url         => '', 
            text        => $aLang.user.profile.nav.proposals, 
            classes     => "border-top"
        ]
    ]}
{/block}

{block "layout_modals" prepend}
    {component "response.modal"}
    {component "propose.modal"}
    
{/block}