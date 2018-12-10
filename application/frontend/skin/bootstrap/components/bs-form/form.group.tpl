{**
 * Элемент формы
 *
 * @param string  $bmods="success"  Список модификторов основного блока (через пробел)
 * @param string  $bg="light"       Модификтор фона
 * @param string  $classes          Список классов основного блока (через пробел)
 * @param array   $attributes       Список атрибутов основного блока
 * 
 *}

{component_define_params params=[ 'bmods', 'bg', 'classes', 'attributes', 'content', 'component', 'popover',  'componentGroup']}

{if $custom}
    {$classes = "{$classes} custom-{$type}"}
    {$component = {$componentGroup|default:"custom-control"}}
{else}
    {$component = {$componentGroup|default:"form-group"}}
{/if}

{block 'form_group_options'}{/block}

{block 'form_group_content'}
    <div class="{$component} {cmods name=$component mods=$bmods delimiter="-"} {$classes}" 
         {if $popover}{component "bs-popover" params=$popover} {/if} {cattr list=$attributes}>
        {if is_array($content)}
            {foreach $content as $item}
                {$item}
            {/foreach}
        {else}
            {$content}
        {/if}        
    </div>
{/block}

