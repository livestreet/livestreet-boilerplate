{**
 * Отзывы
 *}
{extends 'layouts/layout.base.tpl'}


{block 'layout_page_title'}
    <h2 class="page-header">{$aLang.moderation.responses_deleted.title}</h2>
{/block}
                    
{block 'layout_content'}
    <div class="row">
        <div class="col-sm-8">
            <form action="{router page="moderation/responses-all"}" class="form-inline">
                <div class="d-flex m-1">
                    {component "bs-form.group"
                        componentGroup = "input-group"
                        content   =  [
                            {component 'bs-form.select'
                                name = "how"
                                selected = $_aRequest.how
                                items = [
                                    [text => $aLang.moderation.responses_all.form.from, value => "from"],
                                    [text => $aLang.moderation.responses_all.form.to, value => 'to']
                            ]},
                            {component 'bs-form.text' 
                                name    = "login"
                                value = $_aRequest.login
                                attributes = ['data-autocomplete' => true, "autocomplete"=>"off"]
                                placeholder = $aLang.moderation.responses_all.form.login.placeholder}
                    ]}
                </div>
                <div class="d-flex m-1"> 
                    {component "bs-form.text" 
                        name="text" 
                        classes="d-inline-block" 
                        value = $_aRequest.text 
                        placeholder = $aLang.moderation.responses_all.form.text}
                    {component "bs-button"  classes="d-inline-block ml-2" bmods="primary" type="submit" text=$aLang.moderation.responses_all.form.submit}
                </div>
                                
            </form>
        </div>
        <div class="col-sm-4 py-1">
            {component "bs-button" 
                text = $aLang.moderation.btn_view.text
                attributes = [
                    'data-toggle'=>"collapse", 'data-target'=>"#responseCollapse", 'aria-expanded'=>"false", 'aria-controls'=>"responseCollapse"
            ]}
        </div>
    
    </div>
    <div class="row mt-3">
        <div class="col-1">{$aLang.moderation.responses.table_row.number}</div>
        <div class="col">{$aLang.moderation.responses.table_row.from}</div>
        <div class="col d-none d-sm-block">{$aLang.moderation.responses.table_row.to}</div>
        <div class="col d-none d-xl-block">{$aLang.moderation.responses.table_row.rating}</div>
        <div class="col-2 col-lg"></div>
    </div>

    {capture name="paging"}
        {component 'bs-pagination' 
            total   = $aPaging['iCountPage'] 
            padding = 2
            showPager=true
            classes = "mt-3"
            current= $aPaging['iCurrentPage']  
            url="{$aPaging['sBaseUrl']}/page__page__" }
    {/capture}
 
    {if !$aResponses}
        {component 'blankslate' text=$aLang.moderation.responses_all.blankslate.text}
    {/if}

    {foreach $aResponses as $response}
        {component "moderation.response-item" 
            entity      = $response}
    {/foreach}
    
    {$smarty.capture.paging}


{/block}
