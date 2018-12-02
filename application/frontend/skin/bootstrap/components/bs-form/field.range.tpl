{**
 * Диапазон
 *
 * @param string  $disabled          Отключено
 * 
 *}
 
{extends "component@bs-form.field"}

{component_define_params params=[ 'disabled', 'min', 'max']}

{block name="field_options"}
    {$classes = ""}
    {$bmods = "{$bmods} range"}

    {if $custom}
        {$classesGroup = "custom-range"}
        {$component = "custom"}
    {/if}

    {if $min}
        {$attributes.min = $min}
    {/if}

    {if $max}
        {$attributes.max = $max}
    {/if}
{/block}

{block name="field_input"}
    <input type="range" class="{cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes} {if $disabled}disabled{/if}>
{/block}
    


