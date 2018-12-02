{**
 * Форма
 *
 * @param string  $bmods="success"  Список модификторов основного блока (через пробел)
 * @param string  $bg="light"       Модификтор фона
 * @param string  $classes          Список классов основного блока (через пробел)
 * @param array   $attributes       Список атрибутов основного блока
 * 
 *}

{$component = "form"}
{component_define_params params=[ 'bmods', 'bg', 'classes', 'attributes', 'action', 'name', 'id', 'method', 'content', 'items', 'validate']}

{$attributes.enctype = "multipart/form-data"}
{if $action}
    {$attributes.action = $action}
{/if}
{if $name}
    {$attributes.name = $name}
{/if}
{if $validate}
    {$classes = "{$classes} was-validated"}
{/if}
{if $id}
    {$attributes.id = $id}
{/if}
{if $method}
    {$attributes.method = $method}
{/if}
{if $enctype}
    {$attributes.enctype = $enctype}
{/if}

{block 'form_options'}{/block}

{block 'form_content'}{strip}
    <form class="{$component} {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes}>
        {foreach $items as $item}
            {if is_array($item)}
                {if $item.type}
                    {component "bs-form.{$item.type}" params=$item}
                {else}
                    {component "bs-form.group" params=$item}
                {/if}                
            {else}
                {$item}
            {/if}
        {/foreach}
        {$content}
    </form>
{/strip}{/block}

