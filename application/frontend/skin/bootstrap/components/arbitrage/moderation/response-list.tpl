{**
 * Отзывы
 *}

{component_define_params params=[ 'items']}

{if !$items}
    {component "blankslate" classes="mt-3" text=$aLang.moderation.arbitrage.blankslate.text}
{/if}


{foreach $items as $item}

    {component "arbitrage.response-item" entity=$item}
    
{/foreach}

