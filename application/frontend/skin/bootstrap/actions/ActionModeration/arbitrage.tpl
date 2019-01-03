{**
 * Арбитраж
 *}
{extends 'layouts/layout.base.tpl'}


{block 'layout_page_title'}
    <h2 class="page-header">{$aLang.moderation.arbitrage.title}</h2>
{/block}
                    
{block 'layout_content'}
    <div class="d-flex justify-content-end">
        {component "bs-button" 
            text = $aLang.moderation.btn_view.text
            attributes = [
                'data-toggle'=>"collapse", 'data-target'=>"#responseCollapse", 'aria-expanded'=>"false", 'aria-controls'=>"responseCollapse"
        ]}
    </div>
    <div class="row mt-3">
        <div class="col-1">{$aLang.moderation.responses.table_row.number}</div>
        <div class="col">{$aLang.moderation.responses.table_row.from}</div>
        <div class="col d-none d-sm-block">{$aLang.moderation.responses.table_row.to}</div>
        <div class="col d-none d-xl-block">{$aLang.moderation.responses.table_row.rating}</div>
        <div class="col-2 col-lg"></div>
    </div>

    {component "ajax.list" 
        url     = {router page="moderation/arbitrage/ajax-responses"} 
        limit   = Config::Get('moderation.talk.page_count')
        counterSelector="[data-count-arbitrage]"}
{/block}
