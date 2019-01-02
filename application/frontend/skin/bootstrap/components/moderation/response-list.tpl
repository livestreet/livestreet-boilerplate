{**
 * Отзывы
 *}

{component_define_params params=[ 'items']}

{if !$items}
    {component "blankslate" classes="mt-3" text=$aLang.moderation.responses.blankslate.text}
{/if}


{foreach $items as $item}

    {component "moderation.response-item" entity=$item}
    
{/foreach}

