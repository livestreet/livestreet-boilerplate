{**
 * list-group
 *
 * @param array  $items
 * @param string  $bmods="success"  Список модификторов основного блока (через пробел)
 * @param string  $bg="light"       Модификтор фона
 * @param string  $classes          Список классов основного блока (через пробел)
 * @param array   $attributes       Список атрибутов основного блока
 * 
 *}
{$component="list-group"}

{component_define_params params=[ 'items','bmods', 'classes', 'attributes', 'count', 'content', 'disabled', 'active']}

{block 'list_options'}{/block}

{block 'list_content'}{strip}
    <ul class="{$component} {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes}>
        {foreach $items as $item}
            {if is_array($item)}
                {if $item.count}
                    {$item.classes = "{$item.classes} d-flex justify-content-between align-items-center"}
                {/if}
                {if $item.active}
                    {$item.classes = "{$item.classes} active"}
                {/if}
                {if $item.disabled}
                    {$item.classes = "{$item.classes} disabled"}
                {/if}

                <{$item.tag|default:"a"} class="list-group-item {cmods name="list-group-item" mods=$item.bmods delimiter="-"} {$item.classes}" 
                    href="{$item.url}">{$item.text}
                    {if $item.count}
                        <span class="badge badge-primary badge-pill">{$item.count}</span>
                    {/if}
                    {if $content}
                        {$content}
                    {/if}
                </{$item.tag|default:"a"}>
            {else}
                {$item}
            {/if}
        {/foreach}
    </ul>
{/strip}{/block}

