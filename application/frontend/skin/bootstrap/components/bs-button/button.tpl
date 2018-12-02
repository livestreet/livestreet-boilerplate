{**
 * Кнопка
 *
 * @param mixed   $text             Массив либо строка с текстом уведомления. Массив должен быть в формате: `[ [ title, msg ], ... ]`
 * @param string  $bmods="success"  Список модификторов основного блока (через пробел)
 * @param string  $bg="light"       Модификтор фона
 * @param string  $classes          Список классов основного блока (через пробел)
 * @param array   $attributes       Список атрибутов основного блока
 *}{strip}
 


{component_define_params params=[ 'text', 'url', 'active', 'disabled' , 'bmods', 'bg', 'classes', 'attributes', 
    'type', 'value', 'tag', 'com', 'popover', 'badge' ]}

{* Название компонента *}
{$component = $com|default:"btn"}
{$tag = $tag|default:"button"}

{block 'button_options'}{/block}

{block 'button_content'}{strip}
    {if $url}
        <a class="{$component} {cmods name=$component mods=$bmods delimiter="-"} {bs_popover popover=$popover} {$classes}" 
           {cattr list=$attributes} {if $disabled}aria-disabled="true"{/if} href="{$url}" role="button">{$text}</a>
    {else}
        {if $tag != "input"}
            <{$tag} type="{$type|default:"button"}" class="{$component} {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {bs_popover popover=$popover}
                {cattr list=$attributes}>
                {$text}
                {if $badge}
                    {if is_array($badge)}
                        {component "bs-badge" prrams=$badge}
                    {else}
                        {component "bs-badge" text=$badge bmods="primary"}
                    {/if}                    
                {/if}
            </{$tag}>
        {else}
            <input class="{$component} {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {bs_popover popover=$popover} 
                {cattr list=$attributes} type="{$type|default:"button"}" value="{$value}">
        {/if}
    {/if}    
{/strip}{/block}{/strip}