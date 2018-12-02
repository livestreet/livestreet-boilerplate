{**
 * Элемент карточки
 *
 * @param string  $bmods="success"  Список модификторов основного блока (через пробел)
 * @param string  $bg="light"       Модификтор фона
 * @param string  $classes          Список классов основного блока (через пробел)
 * @param string  $type             Тип элемента карточки
 * @param string  $text             Модификтор текста
 * @param array   $attributes       Список атрибутов основного блока
 * @param string  $position         Позиция в блоке (card-img-top)
 *}

 {* Название компонента *}
{$component = "card"}

{component_define_params params=[ 'bmods', 'bg', 'classes', 'text', 'attributes', 'content', 'type', 'position' ]}

{$tag = "div"}

{if $type == "title" }
    {$tag = "h5"}
{/if}
{if $type == "img" }
    {$tag = "img"}
{/if}
{if $type == "text" }
    {$tag = "p"}
{/if}

<{$tag} class="{$component}{if $type}-{$type}{/if}{if $position}-{$position}{/if} {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes}>
{if $type != "img"}
    {if is_array($content)}
        {foreach $content as $params}
            {if is_array($params)}
                {component "bs-card" params=$params}
            {else}
                {$params}
            {/if}            
        {/foreach}
    {else}
        {$content}
    {/if} 
</{$tag}>
{/if}