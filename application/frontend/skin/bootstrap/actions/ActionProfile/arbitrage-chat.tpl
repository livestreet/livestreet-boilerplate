{**
 * Арбитраж
 *}
{extends 'layouts/layout.base.tpl'}


                    
{block 'layout_content'}
    {component "arbitrage.response-chat" entity=$oResponse}
    
    {foreach $oResponse->getArbitrages() as $oArbitrage}
        {component "arbitrage" entity=$oArbitrage}
    {/foreach}

    
    {component "arbitrage.chat-form" 
        url         = {router page='ajax/talk/create-arbitrage-chat'}
        oArbitrage  = Engine::GetEntity('Talk_Arbitrage')
        redirect    = Router::GetPathWebCurrent()
        target_id   = $oResponse->getId() 
        target_type = 'response'}
{/block}
