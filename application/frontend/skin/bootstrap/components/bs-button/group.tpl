{**
 * Группа кнопок
 *
 * @param string  $classes        Список классов основного блока (через пробел)
 * @param array   $attributes     Список атрибутов основного блока
 * @param array   $items          Массив параметров кнопок
 * @param string  $bmods          Моды через пробел
 *}
{$component="btn-group"}

{component_define_params params=[ 'items', 'classes', 'attributes', 'bmods', 'bg' ]}

{block 'button_group_options'}{/block}

{block 'button_group_content'}{strip}
    <div class="btn-group {$classes} {bmods bmods=$bmods}" {cattr list=$attributes} role="group" >
        {foreach $items as $item}
            {if is_array($item)}
                {component 'bs-button' params=$item}
            {else}
                {$item}
            {/if} 
        {/foreach}
    </div>
{/strip}{/block}