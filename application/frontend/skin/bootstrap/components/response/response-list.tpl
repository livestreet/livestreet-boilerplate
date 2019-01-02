{**
 * Отзывы
 *}

{component_define_params params=[ 'items']}

{foreach $items as $item}
    {component "response" entity=$item}
{/foreach}

