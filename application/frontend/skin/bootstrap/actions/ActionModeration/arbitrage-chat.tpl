{**
 * Арбитраж
 *}
{extends 'layouts/layout.base.tpl'}


{block 'layout_page_title'}
    <h2 class="page-header">{$aLang.moderation.arbitrage.title}</h2>
{/block}
                    
{block 'layout_content'}
    {component "arbitrage.response-chat" entity=$oResponse}
    
    {foreach $oResponse->getArbitrages() as $oArbitrage}
        {component "arbitrage" entity=$oArbitrage}
    {/foreach}

    <div class="d-flex justify-content-end">
        {component "bs-nav" items=[
            [ 
                text => $aLang.moderation.arbitrage.actions.publish,
                url => '#',
                classes => 'text-success',
                attributes => [
                    'data-param-id' => $oResponse->getId(),
                    'data-ajax-btn' => true,
                    'data-confirm'  => "true",
                    'data-confirm-message'  => $aLang.moderation.arbitrage.notice.confirm_publish,
                    'data-url'  => {router page="moderation/arbitrage/ajax-publish"},
                    'data-param-redirect' => {router page="moderation/arbitrage"}
                ]
            ],
            [ 
                text => $aLang.moderation.arbitrage.actions.delete,
                url => '#',
                classes => 'text-danger',
                attributes => [
                    'data-param-id' => $oResponse->getId(),
                    'data-ajax-btn' => true,
                    'data-confirm'  => "true",
                    'data-confirm-message'  => $aLang.moderation.arbitrage.notice.confirm_delete,
                    'data-url'  => {router page="moderation/arbitrage/ajax-delete"},
                    'data-param-redirect' => {router page="moderation/arbitrage"}
                ]
            ]
        ]}
    </div>
    
    {component "arbitrage.chat-form" 
        url         = {router page='moderation/arbitrage/create-answer'}
        oArbitrage  = Engine::GetEntity('Talk_Arbitrage')
        redirect    = Router::GetPathWebCurrent()
        target_id   = $oResponse->getId() 
        target_type = 'response'}
{/block}
