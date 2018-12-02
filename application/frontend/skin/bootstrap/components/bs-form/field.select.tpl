{**
 * Select
 *
 * @param string  $readonly          Список классов основного блока (через пробел)
 * 
 *}
 
{extends "component@bs-form.field"}

{component_define_params params=[ 'disabled', 'items', 'selected']}

{block name="field_options"}
    {if $custom}
        {$component = "custom-select"}
        {$type = ""}
    {/if}
    {if $disabled}
        {$attributes.disabled = true}
    {/if}
    
    {if $size}
        {$classes ="{$classes} {$component}-{$size}"}
    {/if}
{/block}

{block name="field_input"}
    <select class="{$component} {cmods name=$component mods=$bmods delimiter="-"} {$classes}" {cattr list=$attributes}>
        {foreach $items as $item}
            <option value="{$item.value}"{if $item.value == $selected}selected{/if}>{$item.text}</option>
        {/foreach}
    </select>
{/block}
    
{block name="out_content"}
    {component "bs-form.group" 
        custom=$customfalse 
        classes=$classesGroup 
        bmods=$bmodsGroup 
        componentGroup=$componentGroup 
        content=$smarty.capture.content}
{/block}


